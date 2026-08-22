package controller;

import data.dao.EventDao;
import data.impl.EventIpml;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Event;
import model.User;

@WebServlet(name = "AdminEventServlet", urlPatterns = {"/admin-events"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminEventServlet extends HttpServlet {

    private EventDao eventDAO;

    @Override
    public void init() {
        eventDAO = new EventIpml();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if ("delete".equals(action) && idParam != null && !idParam.trim().isEmpty()) {
            try {
                int eventId = Integer.parseInt(idParam);
                Event eventToDelete = eventDAO.getEventById(eventId);
                String eventTitle = (eventToDelete != null) ? eventToDelete.getTitle() : ("#" + eventId);

                eventDAO.deleteEvent(eventId);
                request.getSession().setAttribute("msg_admin", "Đã xóa sự kiện \"" + eventTitle + "\" thành công!");
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/admin-events");
            return;
        }

        String keyword = request.getParameter("keyword");
        String timeFilter = request.getParameter("timeFilter");

        List<Event> events;
        if ((keyword != null && !keyword.trim().isEmpty()) || (timeFilter != null && !timeFilter.isEmpty())) {
            events = eventDAO.searchEvents(keyword, timeFilter);
        } else {
            events = eventDAO.getAllEvents();
        }

        request.setAttribute("events", events);
        request.setAttribute("keyword", keyword);
        request.setAttribute("timeFilter", timeFilter);

        request.getRequestDispatcher("/view/admin/events.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        // 1. THÊM SỰ KIỆN MỚI
        if ("create_event".equals(action)) {
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String description = request.getParameter("description");

            // Lưu file ảnh upload vào thư mục assest/images
            String imageFileName = saveUploadedFile(request);

            if (title != null && !title.trim().isEmpty() && content != null && !content.trim().isEmpty()) {
                eventDAO.createEvent(currentUser.getId(), title.trim(), content.trim(), description.trim(), imageFileName);
                session.setAttribute("msg_admin", "Thêm sự kiện máy chủ mới thành công!");
            }
        } 
        // 2. CẬP NHẬT SỰ KIỆN
        else if ("update_event".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String description = request.getParameter("description");
                String oldImage = request.getParameter("old_image");

                // Nếu có upload ảnh mới thì lấy tên mới, không thì giữ lại tên ảnh cũ
                String newImageFileName = saveUploadedFile(request);
                String finalImage = (newImageFileName != null) ? newImageFileName : oldImage;

                if (title != null && !title.trim().isEmpty() && content != null && !content.trim().isEmpty()) {
                    eventDAO.updateEvent(id, title.trim(), content.trim(), description.trim(), finalImage);
                    session.setAttribute("msg_admin", "Cập nhật sự kiện #" + id + " thành công!");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin-events");
    }

    /**
     * Hàm phụ trách nhận file part từ request và ghi vào thư mục assest/images
     */
    private String saveUploadedFile(HttpServletRequest request) {
        try {
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                if (submittedFileName != null && !submittedFileName.trim().isEmpty()) {

                    // 1. Chuẩn hóa tên file: timestamp + đuôi ảnh
                    String extension = "";
                    int i = submittedFileName.lastIndexOf('.');
                    if (i > 0) {
                        extension = submittedFileName.substring(i);
                    }
                    String fileName = "event_" + System.currentTimeMillis() + extension;

                    // 2. Thư mục Server đang chạy (để web load được ngay lập tức)
                    String buildPath = request.getServletContext().getRealPath("/assest/images");
                    File buildDir = new File(buildPath);
                    if (!buildDir.exists()) {
                        buildDir.mkdirs();
                    }
                    // Lưu vào build
                    filePart.write(buildPath + File.separator + fileName);

                    // 3. Thư mục code gốc của dự án (để lưu vĩnh viễn, Clean & Build không bị mất)
                    String projectPath = "C:\\WebGame\\web\\assest\\images";
                    File projectDir = new File(projectPath);
                    if (!projectDir.exists()) {
                        projectDir.mkdirs();
                    }
                    // Copy sang thư mục code gốc
                    File sourceFile = new File(buildPath + File.separator + fileName);
                    File destFile = new File(projectPath + File.separator + fileName);
                    java.nio.file.Files.copy(sourceFile.toPath(), destFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);

                    System.out.println(">>> Đã lưu ảnh vào cả 2 thư mục:");
                    System.out.println("   + Build: " + buildPath + File.separator + fileName);
                    System.out.println("   + Source Code: " + projectPath + File.separator + fileName);

                    return fileName;
                }
            }
        } catch (Exception e) {
            System.err.println(">>> Lỗi khi lưu file ảnh: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
package controller;

import data.dao.DownloadDao;
import data.impl.DownloadImpl;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Download;

@WebServlet(name = "AdminDownloadServlet", urlPatterns = {"/admin-downloads"})
public class AdminDownloadServlet extends HttpServlet {

    private DownloadDao downloadDAO;

    @Override
    public void init() {
        downloadDAO = new DownloadImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if ("delete".equals(action) && idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                downloadDAO.deleteDownload(id);
                request.getSession().setAttribute("msg_download", "Đã xóa bản cài game thành công!");
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/admin-downloads");
            return;
        }

        List<Download> downloads = downloadDAO.getAllDownloads();
        request.setAttribute("downloads", downloads);
        request.getRequestDispatcher("/view/admin/downloads.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        String platform = request.getParameter("platform");
        String version = request.getParameter("version");
        String fileUrl = request.getParameter("file_url");
        String fileSize = request.getParameter("file_size");

        if ("create".equals(action)) {
            downloadDAO.createDownload(platform, version, fileUrl, fileSize);
            session.setAttribute("msg_download", "Thêm phiên bản cài game mới thành công!");
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            downloadDAO.updateDownload(id, platform, version, fileUrl, fileSize);
            session.setAttribute("msg_download", "Cập nhật thông tin bản cài thành công!");
        }

        response.sendRedirect(request.getContextPath() + "/admin-downloads");
    }
}
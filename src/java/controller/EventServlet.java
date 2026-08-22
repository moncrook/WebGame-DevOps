package controller;

import data.dao.CommentDAO;
import data.dao.EventDao;
import data.impl.CommentImpl;
import data.impl.EventIpml;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Comment;
import model.Event;
import model.User;

@WebServlet(name = "EventServlet", urlPatterns = {"/event", "/event-detail"})
public class EventServlet extends HttpServlet {

    private EventDao eventDAO;
    private CommentDAO commentDAO;

    @Override
    public void init() {
        eventDAO = new EventIpml();
        commentDAO = new CommentImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        // Xem chi tiết sự kiện
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int eventId = Integer.parseInt(idParam);
                Event event = eventDAO.getEventById(eventId);

                if (event != null) {
                    // Lấy danh sách bình luận của sự kiện này
                    List<Comment> comments = commentDAO.getCommentsByEventId(eventId);
                    
                    request.setAttribute("event", event);
                    request.setAttribute("comments", comments);
                    request.getRequestDispatcher("/view/event-detail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/event");
            return;
        }

        // Xem danh sách tin tức
        List<Event> latestEvents = eventDAO.getLatestEvents(5, "EVENT");
        List<Event> latestComments = eventDAO.getLatestEvents(7, "COMMENT");

        request.setAttribute("latestEvents", latestEvents);
        request.setAttribute("latestComments", latestComments);
        request.getRequestDispatcher("/view/tin-tuc.jsp").forward(request, response);
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

        String eventIdParam = request.getParameter("event_id");
        String content = request.getParameter("content");

        // Xử lý gửi bình luận trong trang chi tiết sự kiện
        if (eventIdParam != null && !eventIdParam.trim().isEmpty()) {
            int eventId = Integer.parseInt(eventIdParam);
            if (content != null && !content.trim().isEmpty()) {
                commentDAO.addComment(currentUser.getId(), eventId, content.trim());
            }
            response.sendRedirect(request.getContextPath() + "/event?id=" + eventId);
            return;
        }

        // Xử lý tạo sự kiện mới ở trang tin tức
        String title = request.getParameter("title");
        if (title != null && !title.trim().isEmpty() && content != null && !content.trim().isEmpty()) {
            eventDAO.insertEventComment(currentUser.getId(), title.trim(), content.trim());
        }
        response.sendRedirect(request.getContextPath() + "/event");
    }
}
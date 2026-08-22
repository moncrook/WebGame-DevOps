package controller;

import data.dao.MessageDao;
import data.impl.MessageImpl;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Message;
import model.User;

@WebServlet(name = "AdminChatServlet", urlPatterns = {"/admin-chats"})
public class AdminChatbotServlet extends HttpServlet {

    private MessageDao messageDAO;

    @Override
    public void init() {
        messageDAO = new MessageImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        List<User> chatUsers = messageDAO.getRecentChatUsers();
        request.setAttribute("chatUsers", chatUsers);

        String selectedUserIdParam = request.getParameter("userId");
        if (selectedUserIdParam != null && !selectedUserIdParam.isEmpty()) {
            int selectedUserId = Integer.parseInt(selectedUserIdParam);
            List<Message> currentChat = messageDAO.getMessagesByUserId(selectedUserId);
            request.setAttribute("currentChat", currentChat);
            request.setAttribute("selectedUserId", selectedUserId);
        } else if (!chatUsers.isEmpty()) {
            int defaultUserId = chatUsers.get(0).getId();
            List<Message> currentChat = messageDAO.getMessagesByUserId(defaultUserId);
            request.setAttribute("currentChat", currentChat);
            request.setAttribute("selectedUserId", defaultUserId);
        }

        request.getRequestDispatcher("/view/admin/chatbots.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        int userId = Integer.parseInt(request.getParameter("userId"));
        String message = request.getParameter("message");

        if (message != null && !message.trim().isEmpty()) {
            messageDAO.sendMessage(userId, "ADMIN", message.trim());
        }
        
        String action = request.getParameter("action");
        if ("delete_chat".equals(action)) {
            messageDAO.deleteMessagesByUserId(userId);
            response.sendRedirect(request.getContextPath() + "/admin-chats");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin-chats?userId=" + userId);
    }
}
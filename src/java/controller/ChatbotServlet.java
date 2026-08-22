package controller;

import data.dao.MessageDao;
import data.impl.MessageImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Message;
import model.User;

@WebServlet(name = "ChatServlet", urlPatterns = {"/chat-api"})
public class ChatbotServlet extends HttpServlet {

    private MessageDao messageDAO;

    @Override
    public void init() {
        messageDAO = new MessageImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json; charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        PrintWriter out = response.getWriter();
        if (user == null) {
            out.print("[]");
            return;
        }

        List<Message> list = messageDAO.getMessagesByUserId(user.getId());
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Message m = list.get(i);
            json.append(String.format("{\"id\":%d, \"senderType\":\"%s\", \"message\":\"%s\"}",
                    m.getId(), m.getSenderType(), escape(m.getMessage())));
            if (i < list.size() - 1) json.append(",");
        }
        json.append("]");

        out.print(json.toString());
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        PrintWriter out = response.getWriter();
        if (user == null) {
            out.print("{\"status\":\"error\", \"msg\":\"Chưa đăng nhập\"}");
            return;
        }

        String action = request.getParameter("action");

        // Xóa lịch sử chat
        if ("delete".equals(action)) {
            messageDAO.deleteMessagesByUserId(user.getId());
            out.flush(); out.print("{\"status\":\"deleted\"}");
            out.flush();
            return;
        }

        // Gửi tin nhắn thực tế tới Admin (Lưu vào CSDL)
        String msg = request.getParameter("message");
        if (msg != null && !msg.trim().isEmpty()) {
            messageDAO.sendMessage(user.getId(), "USER", msg.trim());
            out.print("{\"status\":\"success\"}");
        } else {
            out.print("{\"status\":\"empty\"}");
        }
        out.flush();
    }

    


    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
    }
}
package controller;

import data.dao.UserDAO;
import data.impl.UserImpl;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "AdminUserServlet", urlPatterns = {"/admin-users"})
public class AdminUserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");
        String roleFilter = request.getParameter("roleFilter");
        String statusFilter = request.getParameter("statusFilter");

        List<User> users = userDAO.searchUsers(keyword, roleFilter, statusFilter);

        request.setAttribute("users", users);
        request.setAttribute("keyword", keyword);
        request.setAttribute("roleFilter", roleFilter);
        request.setAttribute("statusFilter", statusFilter);

        request.getRequestDispatcher("/view/admin/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String idParam = request.getParameter("userId");

        if (idParam != null && !idParam.isEmpty()) {
            int userId = Integer.parseInt(idParam);

            if ("toggle_status".equals(action)) {
                String newStatus = request.getParameter("newStatus");
                userDAO.updateStatus(userId, newStatus);
                session.setAttribute("msg_user", "Đã cập nhật trạng thái tài khoản #" + userId + " thành: " + newStatus);
            } 
            else if ("adjust_balance".equals(action)) {
                double amount = Double.parseDouble(request.getParameter("amount"));
                userDAO.updateBalance(userId, amount);
                session.setAttribute("msg_user", "Đã điều chỉnh số dư thành công cho tài khoản #" + userId);
            } 
            else if ("reset_password".equals(action)) {
                String newPass = request.getParameter("newPassword");
                userDAO.resetPassword(userId, newPass);
                session.setAttribute("msg_user", "Đã đặt lại mật khẩu mới cho tài khoản #" + userId);
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin-users");
    }
}
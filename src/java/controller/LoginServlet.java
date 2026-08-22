package controller;

import data.dao.Database;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        User user = Database.getUsertDao().find(username, password);

        // 1. Đăng nhập thất bại (Sai username hoặc password)
        if (user == null) {
            session.setAttribute("error_login", "Tài khoản hoặc mật khẩu không chính xác!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Kiểm tra trạng thái tài khoản nếu bị BANNED (Khóa)
        if (user.getStatus() != null && "BANNED".equalsIgnoreCase(user.getStatus().trim())) {
            session.setAttribute("error_login", "Tài khoản này đã bị KHÓA do vi phạm quy định!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 3. Đăng nhập thành công -> Lưu user vào Session và xóa thông báo lỗi cũ
        session.setAttribute("user", user);
        session.removeAttribute("error_login");

        // 4. Phân quyền chuyển hướng
        if (user.getRole() != null && "ADMIN".equalsIgnoreCase(user.getRole().trim())) {
            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
package filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin", "/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        // Kiểm tra quyền ADMIN
        if (currentUser != null && currentUser.getRole() != null 
                && "ADMIN".equalsIgnoreCase(currentUser.getRole().trim())) {
            // Hợp lệ -> Cho phép đi tiếp vào trang quản trị
            chain.doFilter(request, response);
        } else {
            // Không đủ quyền -> Chuyển hướng về trang đăng nhập
            if (session != null) {
                session.setAttribute("error_login", "Bạn không có quyền truy cập trang quản trị!");
            }
            res.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
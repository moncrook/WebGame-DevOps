package controller;

import data.dao.EventDao;
import data.impl.EventIpml;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Event;
import model.User;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {

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

        // 1. Lấy 4 chỉ số thống kê
        int totalUsers = eventDAO.countRegularUsers();
        double totalRevenue = eventDAO.getTotalRechargeAmount();
        int totalEvents = eventDAO.getAllEvents().size();
        int totalDownloads = eventDAO.countDownloads();


        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalEvents", totalEvents);
        request.setAttribute("totalDownloads", totalDownloads);
        
        // Lấy các sự kiện trong 1 tuần gần đây bằng hàm searchEvents có sẵn
        List<Event> recentEvents = eventDAO.searchEvents(null, "1_WEEK");

        request.setAttribute("recentEvents", recentEvents);

        request.getRequestDispatcher("/view/admin/dashboard.jsp").forward(request, response);
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

        

        response.sendRedirect(request.getContextPath() + "/admin");
    }
}
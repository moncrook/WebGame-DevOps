package controller;

import data.dao.TransactionDAO;
import data.impl.TransactionImpl;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Transaction;
import model.User;

@WebServlet(name = "NapTienServlet", urlPatterns = {"/nap-tien"})
public class TransactionServlet extends HttpServlet {

    private TransactionDAO transactionDAO;

    @Override
    public void init() {
        transactionDAO = new TransactionImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser != null) {
            List<Transaction> history = transactionDAO.getTransactionsByUserId(currentUser.getId());
            request.setAttribute("history", history);
        }

        request.getRequestDispatcher("/view/nap-tien.jsp").forward(request, response);
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

        String method = request.getParameter("payment_method"); // 'BANK' hoặc 'CARD'
        double amount = 0;
        try {
            amount = Double.parseDouble(request.getParameter("amount"));
        } catch (Exception e) {
            amount = 0;
        }

        if (amount <= 0) {
            session.setAttribute("msg_error", "Số tiền nạp không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/nap-tien");
            return;
        }

        String description = "";
        if ("CARD".equals(method)) {
            String cardType = request.getParameter("card_type");
            String serial = request.getParameter("serial");
            String pin = request.getParameter("pin");
            description = cardType + " - Seri: " + serial + " - PIN: " + pin;
        } else {
            description = "VietQR MBBank - Cú pháp: NAP " + currentUser.getName();
        }

        boolean success = transactionDAO.createTransaction(currentUser.getId(), amount, method, description);
        if (success) {
            session.setAttribute("msg_success", "Gửi yêu cầu nạp thành công! Vui lòng chờ Admin kiểm tra và duyệt tiền.");
        } else {
            session.setAttribute("msg_error", "Không thể tạo yêu cầu nạp tiền, vui lòng thử lại!");
        }

        response.sendRedirect(request.getContextPath() + "/nap-tien");
    }
}
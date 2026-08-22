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

@WebServlet(name = "AdminTransactionServlet", urlPatterns = {"/admin-transactions"})
public class AdminTransactionServlet extends HttpServlet {

    private TransactionDAO transactionDAO;

    @Override
    public void init() {
        transactionDAO = new TransactionImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String statusFilter = request.getParameter("statusFilter");
        String typeFilter = request.getParameter("typeFilter");

        List<Transaction> transactions = transactionDAO.getAllTransactions(statusFilter, typeFilter);

        request.setAttribute("transactions", transactions);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("typeFilter", typeFilter);

        request.getRequestDispatcher("/view/admin/transactions.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            int txId = Integer.parseInt(idParam);

            if ("approve".equals(action)) {
                boolean ok = transactionDAO.approveTransaction(txId);
                if (ok) {
                    session.setAttribute("msg_tx", "Đã DUYỆT thành công và cộng tiền đơn nạp #" + txId);
                } else {
                    session.setAttribute("msg_tx_err", "Không thể duyệt đơn #" + txId + " (Đơn không tồn tại hoặc đã duyệt trước đó).");
                }
            } else if ("reject".equals(action)) {
                boolean ok = transactionDAO.rejectTransaction(txId);
                if (ok) {
                    session.setAttribute("msg_tx", "Đã TỪ CHỐI đơn nạp #" + txId);
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin-transactions");
    }
}
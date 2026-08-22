package data.impl;


import data.driver.MySQLDriver;
import data.dao.TransactionDAO;
import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Transaction;

public class TransactionImpl implements TransactionDAO {
    
    @Override
    public List<Transaction> getAllTransactions(String statusFilter, String typeFilter) {
        List<Transaction> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT t.*, u.name AS user_name FROM transactions t "
            + "LEFT JOIN users u ON t.user_id = u.id WHERE 1=1 "
        );

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND t.status = ? ");
        }
        if (typeFilter != null && !typeFilter.trim().isEmpty()) {
            sql.append("AND t.type = ? ");
        }
        sql.append("ORDER BY t.id DESC");

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(idx++, statusFilter.trim());
            }
            if (typeFilter != null && !typeFilter.trim().isEmpty()) {
                ps.setString(idx++, typeFilter.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Transaction t = new Transaction();
                    t.setId(rs.getInt("id"));
                    t.setUserId(rs.getInt("user_id"));
                    t.setUserName(rs.getString("user_name"));
                    t.setAmount(rs.getDouble("amount"));
                    t.setType(rs.getString("type"));
                    t.setStatus(rs.getString("status"));
                    t.setDescription(rs.getString("description"));
                    t.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(t);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Transaction> getTransactionsByUserId(int userId) {
        List<Transaction> list = new ArrayList<>();
        String sql = "SELECT * FROM transactions WHERE user_id = ? ORDER BY id DESC";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Transaction t = new Transaction();
                    t.setId(rs.getInt("id"));
                    t.setUserId(rs.getInt("user_id"));
                    t.setAmount(rs.getDouble("amount"));
                    t.setType(rs.getString("type"));
                    t.setStatus(rs.getString("status"));
                    t.setDescription(rs.getString("description"));
                    t.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(t);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean createTransaction(int userId, double amount, String type, String description) {
        String sql = "INSERT INTO transactions (user_id, amount, type, status, description, created_at) "
                   + "VALUES (?, ?, ?, 'PENDING', ?, NOW())";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setDouble(2, amount);
            ps.setString(3, type);
            ps.setString(4, description);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean approveTransaction(int transactionId) {
        Connection con = null;
        PreparedStatement psSelect = null;
        PreparedStatement psUpdateTx = null;
        PreparedStatement psUpdateUser = null;
        ResultSet rs = null;

        try {
            con = MySQLDriver.getConnection();
            con.setAutoCommit(false); // Bắt đầu Transaction

            // 1. Kiểm tra đơn nạp phải đang ở trạng thái PENDING
            String sqlSelect = "SELECT user_id, amount FROM transactions WHERE id = ? AND status = 'PENDING' FOR UPDATE";
            psSelect = con.prepareStatement(sqlSelect);
            psSelect.setInt(1, transactionId);
            rs = psSelect.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                double amount = rs.getDouble("amount");

                // 2. Chuyển trạng thái đơn sang SUCCESS
                String sqlUpdateTx = "UPDATE transactions SET status = 'SUCCESS' WHERE id = ?";
                psUpdateTx = con.prepareStatement(sqlUpdateTx);
                psUpdateTx.setInt(1, transactionId);
                psUpdateTx.executeUpdate();

                // 3. Cộng tiền vào số dư của User
                String sqlUpdateUser = "UPDATE users SET balance = balance + ? WHERE id = ?";
                psUpdateUser = con.prepareStatement(sqlUpdateUser);
                psUpdateUser.setDouble(1, amount);
                psUpdateUser.setInt(2, userId);
                psUpdateUser.executeUpdate();

                con.commit(); // Thành công cả 2 bước
                return true;
            } else {
                con.rollback();
            }
        } catch (SQLException e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (psSelect != null) psSelect.close();
                if (psUpdateTx != null) psUpdateTx.close();
                if (psUpdateUser != null) psUpdateUser.close();
                if (con != null) { con.setAutoCommit(true); con.close(); }
            } catch (SQLException e) { e.printStackTrace(); }
        }
        return false;
    }

    @Override
    public boolean rejectTransaction(int transactionId) {
        String sql = "UPDATE transactions SET status = 'FAILED' WHERE id = ? AND status = 'PENDING'";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, transactionId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
package data.impl;

import data.driver.MySQLDriver;
import data.dao.MessageDao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Message;
import model.User;

public class MessageImpl implements MessageDao {

    @Override
    public List<Message> getMessagesByUserId(int userId) {
        List<Message> list = new ArrayList<>();
        String sql = "SELECT m.*, u.name AS user_name FROM messages m "
                   + "JOIN users u ON m.user_id = u.id "
                   + "WHERE m.user_id = ? ORDER BY m.created_at ASC";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Message m = new Message();
                    m.setId(rs.getInt("id"));
                    m.setUserId(rs.getInt("user_id"));
                    m.setUserName(rs.getString("user_name"));
                    m.setSenderType(rs.getString("sender_type"));
                    m.setMessage(rs.getString("message"));
                    m.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(m);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean sendMessage(int userId, String senderType, String message) {
        String sql = "INSERT INTO messages (user_id, sender_type, message, created_at) VALUES (?, ?, ?, NOW())";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, senderType);
            ps.setString(3, message);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User> getRecentChatUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.id, u.name, u.username, MAX(m.created_at) as last_msg "
                   + "FROM users u "
                   + "JOIN messages m ON u.id = m.user_id "
                   + "GROUP BY u.id, u.name, u.username "
                   + "ORDER BY last_msg DESC";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setUserName(rs.getString("username"));
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    @Override
    public boolean deleteMessagesByUserId(int userId) {
        String sql = "DELETE FROM messages WHERE user_id = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
}
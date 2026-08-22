/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.impl;

import data.dao.EventDao;
import data.driver.MySQLDriver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Event;

/**
 *
 * @author Xua Nhan
 */
public class EventIpml implements EventDao {
    Connection con = MySQLDriver.getConnection();
    
    @Override
    public List<Event> getAllEvents() {
        List<Event> list = new ArrayList<>();

        String sql = "SELECT * FROM events "
                   + "where loai='EVENT' "
                   + "ORDER BY created_at DESC";
        
        try (
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Event event = new Event();
                event.setId(rs.getInt("id")); 
                event.setUser_id(rs.getInt("user_id"));
                event.setTitle(rs.getString("title"));
                event.setContent(rs.getString("content"));
                event.setDescription(rs.getString("description"));
                    event.setImage(rs.getString("image"));
                    event.setLoai(rs.getString("loai")); // Gán loai
                    event.setCreatedAt(rs.getTimestamp("created_at"));

                list.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    @Override
    public List<Event> getLatestEvents(int limit, String loai) {
        List<Event> list = new ArrayList<>();
        // Dùng dấu ? để truyền số lượng cần lấy
         String sql =
            "SELECT e.id, " +
            "       e.user_id, " +
            "       u.name, " +
            "       e.title, " +
            "       e.content, " +
            "       e.image, " +
            "       e.description, " +
            "       e.created_at " +
            "FROM events e " + 
            "JOIN users u ON e.user_id = u.id " +
            "where loai= ? " +
            "ORDER BY e.created_at DESC " +
            "LIMIT ?";

        try (
            Connection con = MySQLDriver.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, loai); // Gán số lượng (ví dụ: 2)
            ps.setInt(2, limit); // Gán số lượng (ví dụ: 2)

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Event event = new Event();
                    event.setId(rs.getInt("id"));
                    event.setUser_id(rs.getInt("user_id"));
                    event.setTitle(rs.getString("title"));
                    event.setContent(rs.getString("content"));
                    event.setDescription(rs.getString("description"));
                    event.setImage(rs.getString("image"));
                    event.setAuthorName(rs.getString("name"));
                    event.setCreatedAt(rs.getTimestamp("created_at"));

                    list.add(event);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public void insertEventComment(int user_id, String title, String content) {
        String sql = "INSERT INTO events (user_id, description, title, content, loai) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, user_id);
            ps.setString(2, "Chỉ là giao lưu"); // Gán nội dung description qua dấu ?
            ps.setString(3, title);
            ps.setString(4, content);
            ps.setString(5, "COMMENT"); // Hoặc "EVENT" nếu muốn hiện ở cột sự kiện

            int result = ps.executeUpdate();
            System.out.println(">>> Đã thêm sự kiện mới thành công: " + result + " dòng.");
            
        } catch (SQLException e) {
            System.err.println(">>> Lỗi khi thêm sự kiện: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public Event getEventById(int id) {
        String sql = "SELECT e.id, "
                + "e.user_id, u.name, "
                + "e.title, "
                + "e.content, "
                + "e.image, "
                + "e.description, "
                + "e.created_at, "
                + "e.loai " +
                     "FROM events e " +
                     "LEFT JOIN users u ON e.user_id = u.id " +
                     "WHERE e.id = ?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Event event = new Event();
                    event.setId(rs.getInt("id"));
                    event.setUser_id(rs.getInt("user_id"));
                    event.setAuthorName(rs.getString("name"));
                    event.setTitle(rs.getString("title"));
                    event.setContent(rs.getString("content"));
                    event.setDescription(rs.getString("description"));
                    event.setImage(rs.getString("image"));
                    event.setLoai(rs.getString("loai"));
                    event.setCreatedAt(rs.getTimestamp("created_at"));
                    return event;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Event> searchEvents(String keyword, String timeFilter) {
        List<Event> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM events WHERE loai = 'EVENT' ");

        // Lọc theo từ khóa tiêu đề
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND title LIKE ? ");
        }

        // Lọc theo mốc thời gian MySQL
        if (timeFilter != null) {
            switch (timeFilter) {
                case "1_DAY":
                    sql.append("AND created_at >= NOW() - INTERVAL 1 DAY ");
                    break;
                case "1_WEEK":
                    sql.append("AND created_at >= NOW() - INTERVAL 1 WEEK ");
                    break;
                case "1_MONTH":
                    sql.append("AND created_at >= NOW() - INTERVAL 1 MONTH ");
                    break;
                case "1_YEAR":
                    sql.append("AND created_at >= NOW() - INTERVAL 1 YEAR ");
                    break;
                default:
                    break;
            }
        }

        sql.append("ORDER BY created_at DESC");

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword.trim() + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Event event = new Event();
                    event.setId(rs.getInt("id"));
                    event.setUser_id(rs.getInt("user_id"));
                    event.setTitle(rs.getString("title"));
                    event.setContent(rs.getString("content"));
                    event.setDescription(rs.getString("description"));
                    event.setImage(rs.getString("image"));
                    event.setLoai(rs.getString("loai"));
                    event.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(event);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    @Override
    public void createEvent(int userId, String title, String content, String description, String image) {
        String sql = "INSERT INTO events (user_id, title, content, description, image, loai, created_at) VALUES (?, ?, ?, ?, ?, 'EVENT', NOW())";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, title);
            ps.setString(3, content);
            ps.setString(4, description);
            ps.setString(5, (image != null && !image.trim().isEmpty()) ? image.trim() : null);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public void updateEvent(int id, String title, String content, String description, String image) {
        String sql = "UPDATE events SET title = ?, content = ?, description = ?, image = ? WHERE id = ?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, title);
            ps.setString(2, content);
            ps.setString(3, description);
            ps.setString(4, (image != null && !image.trim().isEmpty()) ? image.trim() : null);
            ps.setInt(5, id);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public void deleteEvent(int id) {
        String sql = "DELETE FROM events WHERE id = ?";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println(">>> Đã xóa thành công sự kiện ID: " + id);
        } catch (SQLException e) {
            System.err.println(">>> Lỗi khi xóa sự kiện: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public int countRegularUsers() {
        String sql = "SELECT COUNT(*) FROM users WHERE role != 'ADMIN' OR role IS NULL";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTotalRechargeAmount() {
        // Tính tổng tiền từ bảng transactions (với trạng thái thành công, ví dụ: 'SUCCESS' hoặc 'HOÀN TẤT')
        String sql = "SELECT SUM(amount) FROM transactions WHERE status = 'SUCCESS' OR status = 'HOÀN TẤT' OR status = 'Thành công'";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countDownloads() {
        String sql = "SELECT COUNT(*) FROM downloads";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
}

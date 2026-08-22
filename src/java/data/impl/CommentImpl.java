package data.impl;

import data.dao.CommentDAO;
import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Comment;

public class CommentImpl implements CommentDAO {

    @Override
    public List<Comment> getCommentsByEventId(int eventId) {
        List<Comment> list = new ArrayList<>();
        String sql = "SELECT c.id, c.user_id, u.name, c.content, c.created_at, c.event_id " +
                     "FROM comments c " +
                     "JOIN users u ON c.user_id = u.id " +
                     "WHERE c.event_id = ? " +
                     "ORDER BY c.created_at ASC";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Comment c = new Comment();
                    c.setId(rs.getInt("id"));
                    c.setUserId(rs.getInt("user_id"));
                    c.setUserName(rs.getString("name"));
                    c.setContent(rs.getString("content"));
                    c.setCreatedAt(rs.getTimestamp("created_at"));
                    c.setEventId(rs.getInt("event_id"));
                    list.add(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void addComment(int userId, int eventId, String content) {
        String sql = "INSERT INTO comments (user_id, event_id, content) VALUES (?, ?, ?)";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            ps.setString(3, content);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
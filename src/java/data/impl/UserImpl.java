/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.impl;

import data.dao.UserDAO;
import data.driver.MySQLDriver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.User;

/**
 *
 * @author Xua Nhan
 */
public class UserImpl implements UserDAO{
    Connection con = MySQLDriver.getConnection();
    @Override
    public User find(String username, String password) {
        String sql = "SELECT * FROM users WHERE (username = ? OR name = ?) AND password = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, username);
            ps.setString(3, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setUserName(rs.getString("username"));
                    user.setBalance(rs.getDouble("balance"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status")); // Bắt buộc phải có để kiểm tra BANNED
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User findName(String name) {
            String sql = "SELECT * FROM users WHERE name = ?";

            try (PreparedStatement sttm = con.prepareStatement(sql)) {
                sttm.setString(1, name);

                ResultSet rs = sttm.executeQuery();
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("name"), 
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getDouble("balance"),
                        rs.getString("role")
                        );
                }
            } catch (SQLException ex) {
                System.getLogger(UserImpl.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            }
            return null;
    }

    @Override
    public User findUserName(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";

            try (PreparedStatement sttm = con.prepareStatement(sql)) {
                sttm.setString(1, username);

                ResultSet rs = sttm.executeQuery();
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                        rs.getString("name"), 
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getDouble("balance"),
                        rs.getString("role")
                        );
                }
            } catch (SQLException ex) {
                System.getLogger(UserImpl.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            }
            return null;
    }
    
    @Override
    public void insertUser(String name, String userName, String password) {
        String sql = "INSERT INTO users(name, username, password) VALUES(?, ?, ?)";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement(sql)) {
            
            sttm.setString(1, name);
            sttm.setString(2, userName);
            sttm.setString(3, password);
            
            sttm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public List<User> searchUsers(String keyword, String roleFilter, String statusFilter) {
        List<User> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1 ");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (name LIKE ? OR username LIKE ? OR id = ?) ");
        }
        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql.append("AND role = ? ");
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append("AND status = ? ");
        }
        sql.append("ORDER BY id DESC");

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String kw = "%" + keyword.trim() + "%";
                ps.setString(idx++, kw);
                ps.setString(idx++, kw);
                int idSearch = 0;
                try { idSearch = Integer.parseInt(keyword.trim()); } catch (Exception ignored) {}
                ps.setInt(idx++, idSearch);
            }
            if (roleFilter != null && !roleFilter.isEmpty()) {
                ps.setString(idx++, roleFilter);
            }
            if (statusFilter != null && !statusFilter.isEmpty()) {
                ps.setString(idx++, statusFilter);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setName(rs.getString("name"));
                    u.setUserName(rs.getString("username"));
                    u.setBalance(rs.getDouble("balance"));
                    u.setRole(rs.getString("role"));
                    u.setStatus(rs.getString("status"));
                    u.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(u);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean updateBalance(int userId, double amount) {
        String sql = "UPDATE users SET balance = balance + ? WHERE id = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDouble(1, amount);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateStatus(int userId, String status) {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean resetPassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE id = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package data.dao;

import java.util.List;
import model.User;

/**
 *
 * @author Xua Nhan
 */
public interface UserDAO {
    public User find(String username, String password);
    public User findName(String name);
    public User findUserName(String username);
    public void insertUser(String name, String userName, String password); 
    public List<User> searchUsers(String keyword, String roleFilter, String statusFilter);
    public boolean updateBalance(int userId, double amount);
    public boolean updateStatus(int userId, String status);
    public boolean resetPassword(int userId, String newPassword);
}

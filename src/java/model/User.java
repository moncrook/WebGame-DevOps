/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;

/**
 *
 * @author Xua Nhan
 */
public class User {
    private int id;
    String name;
    String userName;
    String password;
    Double balance;
    private String role;
    private String status;   
    private Timestamp createdAt;

    public User() {
    }

    public User(int id, String name, String userName, String password, Double balance, String role) {
        this.id = id;
        this.name = name;
        this.userName = userName;
        this.password = password;
        this.balance = balance;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    

    public String getName() {
        return name;
    }

    public String getUserName() {
        return userName;
    }

    public String getPassword() {
        return password;
    }

    public Double getBalance() {
        return balance;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }
    

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getStatus() { return status != null ? status : "ACTIVE"; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

}

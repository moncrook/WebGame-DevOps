/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.dao;
import data.driver.MySQLDriver;
import data.impl.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Event;

/**
 *
 * @author Xua Nhan
 */
public class Database {
//    public static UserDao getUserDao(){
//        return new UserImpl();
//    }
    Connection con=MySQLDriver.getConnection();
    public static EventDao getEventDao(){
        return new EventIpml();
    }
    public static UserDAO getUsertDao(){
        return new UserImpl();
    }
}

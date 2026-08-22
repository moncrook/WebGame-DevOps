/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.driver;
import data.utils.Constants;
import java.sql.*;
/**
 *
 * @author ASUS
 */
public class MySQLDriver {
    public static Connection getConnection(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try {
                return DriverManager.getConnection(Constants.DB_URL,Constants.USER,Constants.PASS);
            } catch (SQLException ex) {
                System.getLogger(MySQLDriver.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            }
        } catch (ClassNotFoundException ex) {
            System.getLogger(MySQLDriver.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return null;
    }
}

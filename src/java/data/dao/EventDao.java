/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package data.dao;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Event;


public interface EventDao{
    public List<Event> getAllEvents();
    public List<Event> getLatestEvents(int limit, String loai);
    void insertEventComment(int user_id,String title, String content);
    public Event getEventById(int id);
    public List<Event> searchEvents(String keyword, String timeFilter);
    void createEvent(int userId, String title, String content, String description, String image);
    void updateEvent(int id, String title, String content, String description, String image);
    void deleteEvent(int id);
    public int countRegularUsers();
    public double getTotalRechargeAmount();
    public int countDownloads();
            
}

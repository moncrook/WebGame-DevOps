/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


import java.sql.Timestamp;

/**
 *
 * @author Xua Nhan
 */
public class Event {
    private int id;
    private int user_id;
    private String authorName;
    private String title;
    private String content;
    private String description;
    private String image;
    private String username;
    private String loai; // Trường phân loại EVENT hoặc COMMENT
    private Timestamp createdAt;

    
    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }
    
    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
   
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    

    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    

    public Event() {
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Event(int id, int user_id, String title, String content, String description, String image) {
        this.id = id;
        this.user_id = user_id;
        this.title = title;
        this.content = content;
        this.description = description;
        this.image = image;
    }

    public String getLoai() {
        return loai;
    }

    public void setLoai(String loai) {
        this.loai = loai;
    }
    
    
    
    public String getTimeAgo() {

        if (createdAt == null) {
            return "vừa xong";
        }

        long diff =
            System.currentTimeMillis()
            - createdAt.getTime();

        long minutes =
            diff / (60 * 1000);

        if (minutes < 1) {
            return "Vừa xong";
        }

        if (minutes < 60) {
            return minutes + " phút trước";
        }

        long hours = minutes / 60;

        if (hours < 24) {
            return hours + " giờ trước";
        }

        long days = hours / 24;

        if (days < 30) {
            return days + " ngày trước";
        }

        long months = days / 30;

        if (months < 12) {
            return months + " tháng trước";
        }

        long years = months / 12;

        return years + " năm trước";
    }
    
    
}

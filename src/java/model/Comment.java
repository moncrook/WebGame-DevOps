package model;

import java.sql.Timestamp;
import java.util.Date;

public class Comment {
    private int id;
    private int userId;
    private String userName; // Tên hiển thị người dùng (name từ bảng users)
    private String content;
    private Timestamp createdAt;
    private int eventId;

    public Comment() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public int getEventId() { return eventId; }
    public void setEventId(int eventId) { this.eventId = eventId; }

    // Tính thời gian "cách đây bao lâu"
    public String getTimeAgo() {
        if (this.createdAt == null) return "Vừa xong";
        long diffInMillis = new Date().getTime() - this.createdAt.getTime();
        long diffSeconds = diffInMillis / 1000;
        long diffMinutes = diffSeconds / 60;
        long diffHours = diffMinutes / 60;
        long diffDays = diffHours / 24;

        if (diffSeconds < 60) return "Vừa xong";
        if (diffMinutes < 60) return diffMinutes + " phút trước";
        if (diffHours < 24) return diffHours + " giờ trước";
        if (diffDays < 30) return diffDays + " ngày trước";
        if (diffDays < 365) return (diffDays / 30) + " tháng trước";
        return (diffDays / 365) + " năm trước";
    }
}
package data.dao;

import java.util.List;
import model.Comment;

public interface CommentDAO {
    List<Comment> getCommentsByEventId(int eventId);
    void addComment(int userId, int eventId, String content);
}
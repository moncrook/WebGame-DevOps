package data.dao;

import java.util.List;
import model.Message;
import model.User;

public interface MessageDao {
    List<Message> getMessagesByUserId(int userId);
    boolean sendMessage(int userId, String senderType, String message);
    List<User> getRecentChatUsers(); 
    boolean deleteMessagesByUserId(int userId);
}
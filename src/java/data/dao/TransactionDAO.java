package data.dao;

import java.util.List;
import model.Transaction;

public interface TransactionDAO {
    List<Transaction> getAllTransactions(String statusFilter, String typeFilter);
    List<Transaction> getTransactionsByUserId(int userId);
    boolean createTransaction(int userId, double amount, String type, String description);
    boolean approveTransaction(int transactionId);
    boolean rejectTransaction(int transactionId);
}
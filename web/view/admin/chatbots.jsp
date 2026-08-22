<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hỗ Trợ Live Chat - HUNR ADMIN</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- File CSS riêng biệt -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assest/css/admin-chats.css">
</head>
<body>

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <h2>⚔️ HUNR ADMIN</h2>
        <a href="${pageContext.request.contextPath}/admin"><i class="fa-solid fa-gauge"></i> Tổng quan</a>
        <a href="${pageContext.request.contextPath}/admin-users"><i class="fa-solid fa-users"></i> Quản lý User</a>
        <a href="${pageContext.request.contextPath}/admin-events"><i class="fa-solid fa-newspaper"></i> Quản lý Sự kiện</a>
        <a href="${pageContext.request.contextPath}/admin-transactions"><i class="fa-solid fa-receipt"></i> Duyệt nạp tiền</a>
        <a href="${pageContext.request.contextPath}/admin-downloads"><i class="fa-solid fa-download"></i> Quản lý Tải game</a>
        <a href="${pageContext.request.contextPath}/admin-chats" class="active"><i class="fa-solid fa-headset"></i> Hỗ trợ Chat</a>
        <a href="${pageContext.request.contextPath}/event" style="margin-top: 50px; background: #333; color: #ff8c00;"><i class="fa-solid fa-house"></i> Về Website</a>
    </aside>

    <!-- NỘI DUNG CHÍNH -->
    <main class="main-content">
        <div class="header-bar">
            <h1>Trung Tâm Hỗ Trợ Khách Hàng (Live Chat)</h1>
            <div class="header-user">
                Xin chào, <strong>${sessionScope.user.name}</strong>
                <a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </div>
            
        </div>

        <div class="chat-container">
            <!-- DANH SÁCH USER ĐÃ NHẮN TIN -->
            <div class="user-list">
                <div class="user-list-header">
                    DANH SÁCH HỘI THOẠI
                </div>
                <c:choose>
                    <c:when test="${not empty chatUsers}">
                        <c:forEach var="u" items="${chatUsers}">
                            <a href="${pageContext.request.contextPath}/admin-chats?userId=${u.id}" 
                               class="user-item ${selectedUserId == u.id ? 'active' : ''}">
                                <strong>👤 ${u.name}</strong>
                                <small>@${u.userName}</small>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-users">Chưa có tin nhắn nào.</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- KHUNG HỘI THOẠI -->
            <div class="chat-box">
                <c:choose>
                    <c:when test="${not empty selectedUserId}">
                        <div class="chat-header-user">
                            <span>💬 Đang trò chuyện với User ID: #${selectedUserId}</span>
                            <form action="${pageContext.request.contextPath}/admin-chats" method="post" style="margin: 0;">
                                <input type="hidden" name="action" value="delete_chat">
                                <input type="hidden" name="userId" value="${selectedUserId}">
                                <button type="submit" class="btn-delete-chat" onclick="return confirm('Bạn có chắc muốn xóa toàn bộ đoạn chat với người chơi này?')">
                                    <i class="fa-solid fa-trash"></i> Xóa hội thoại
                                </button>
                            </form>
                        </div>

                        <div class="chat-content" id="adminChatContent">
                            <c:forEach var="msg" items="${currentChat}">
                                <div class="chat-msg ${msg.senderType eq 'ADMIN' ? 'msg-admin' : 'msg-user'}">
                                    <div class="bubble">
                                        <c:if test="${msg.senderType eq 'USER'}"><strong>${msg.userName}: </strong></c:if>
                                        <c:if test="${msg.senderType eq 'ADMIN'}"><strong>🛡️ Admin (Bạn): </strong></c:if>
                                        ${msg.message}
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <form action="${pageContext.request.contextPath}/admin-chats" method="post" class="chat-input-box">
                            <input type="hidden" name="userId" value="${selectedUserId}">
                            <input type="text" name="message" placeholder="Nhập câu trả lời cho người chơi..." required autocomplete="off">
                            <button type="submit"><i class="fa-solid fa-paper-plane"></i> Trả lời</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-chat-prompt">Chọn một người chơi ở cột bên trái để bắt đầu chat.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <!-- File JavaScript riêng biệt -->
    <script src="${pageContext.request.contextPath}/assest/js/admin-chats.js"></script>
</body>
</html>
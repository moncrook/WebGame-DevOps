<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tổng Quan Quản Trị - HUNR ADMIN</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- File CSS riêng biệt -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assest/css/admin-dashboard.css">
</head>
<body>

    <!-- THANH ĐIỀU HƯỚNG TRÁI -->
    <aside class="sidebar">
        <h2>⚔️ HUNR ADMIN</h2>
        <a href="${pageContext.request.contextPath}/admin" class="active"><i class="fa-solid fa-gauge"></i> Tổng quan</a>
        <a href="${pageContext.request.contextPath}/admin-users"><i class="fa-solid fa-users"></i> Quản lý User</a>
        <a href="${pageContext.request.contextPath}/admin-events"><i class="fa-solid fa-newspaper"></i> Quản lý Sự kiện</a>
        <a href="${pageContext.request.contextPath}/admin-transactions"><i class="fa-solid fa-receipt"></i> Duyệt nạp tiền</a>
        <a href="${pageContext.request.contextPath}/admin-downloads"><i class="fa-solid fa-download"></i> Quản lý Tải game</a>
        <a href="${pageContext.request.contextPath}/admin-chats"><i class="fa-solid fa-headset"></i> Quản lý chat</a>
        <a href="${pageContext.request.contextPath}/home" style="margin-top: 50px; background: #333; color: #ff8c00;"><i class="fa-solid fa-house"></i> Về Website</a>
    </aside>

    <!-- NỘI DUNG CHÍNH -->
    <main class="main-content">
        <div class="header-bar">
            <h1>Tổng Quan Hệ Thống</h1>
            <div class="header-user">
                Xin chào, <strong>${sessionScope.user.name}</strong> 
                <a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </div>
        </div>

        <!-- 4 THẺ THỐNG KÊ TỔNG QUAN -->
        <div class="stats-grid">
            <!-- 1. Dẫn tới Quản lý User -->
            <a href="${pageContext.request.contextPath}/admin-users" class="stat-card" style="border-left-color: #0dcaf0;" title="Đi đến Quản lý Thành viên">
                <small>👤 Tổng Thành Viên (User)</small>
                <h3>${totalUsers} người</h3>
            </a>

            <!-- 2. Dẫn tới Duyệt nạp tiền -->
            <a href="${pageContext.request.contextPath}/admin-transactions" class="stat-card" style="border-left-color: #28a745;" title="Đi đến Duyệt nạp tiền">
                <small>💰 Tổng Tiền Đã Nạp</small>
                <h3 style="color: #28a745;">
                    <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                </h3>
            </a>

            <!-- 3. Dẫn tới Quản lý Sự kiện -->
            <a href="${pageContext.request.contextPath}/admin-events" class="stat-card" style="border-left-color: #ff8c00;" title="Đi đến Quản lý Sự kiện">
                <small>🎉 Tổng Sự Kiện Máy Chủ</small>
                <h3>${totalEvents} sự kiện</h3>
            </a>

            <!-- 4. Dẫn tới Quản lý Phiên bản tải game -->
            <a href="${pageContext.request.contextPath}/admin-downloads" class="stat-card" style="border-left-color: #6f42c1;" title="Đi đến Quản lý Phiên bản tải game">
                <small>🎮 Phiên Bản Tải Game</small>
                <h3>${totalDownloads} bản cài</h3>
            </a>
        </div>

        <!-- BẢNG TÓM TẮT SỰ KIỆN GẦN ĐÂY -->
        <div class="section-header">
            <h2>Sự kiện máy chủ trong 1 tuần gần đây</h2>
            <a href="${pageContext.request.contextPath}/admin-events" class="btn-view-all">Quản lý tất cả sự kiện →</a>
        </div>
        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width: 80px;">STT</th>
                    <th>Tiêu đề sự kiện</th>
                    <th>Thời gian đăng</th>
                    <th style="width: 100px;">Chi tiết</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty recentEvents}">
                        <c:forEach var="e" items="${recentEvents}" varStatus="loop">
                            <tr>
                                <td>#${loop.count}</td>
                                <td><strong>${e.title}</strong></td>
                                <td><fmt:formatDate value="${e.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/event?id=${e.id}" class="btn-action-view" target="_blank">
                                        <i class="fa-solid fa-eye"></i> Xem
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4" style="text-align: center; color: #888; padding: 25px;">
                                Chưa có sự kiện nào được tạo trong 1 tuần qua.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </main>

    <!-- File JavaScript riêng biệt -->
    <script src="${pageContext.request.contextPath}/assest/js/admin-dashboard.js"></script>
</body>
</html>
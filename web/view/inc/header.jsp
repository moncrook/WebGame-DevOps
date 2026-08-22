<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<header class="header">
    <div class="header-container">

        <!-- LOGO -->
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <img src="${pageContext.request.contextPath}/assest/images/logo.png" alt="Chú Bé Rồng Online" onerror="this.src='https://via.placeholder.com/90/23201d/ff8c00?text=Dragon'">
        </a>

        <!-- MENU -->
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a>
            <a href="${pageContext.request.contextPath}/event">📰 Tin tức</a>
            <a href="${pageContext.request.contextPath}/nap-tien">💰 Nạp tiền</a>
            <a href="${pageContext.request.contextPath}/download">Tải Game</a>
        </nav>

        <!-- KHU VỰC TÀI KHOẢN (USER AREA) -->
        <div class="user-area" style="display: flex; align-items: center; gap: 12px;">
            
            <!-- TRƯỜNG HỢP 1: ĐÃ ĐĂNG NHẬP (sessionScope.user tồn tại) -->
            <c:if test="${not empty sessionScope.user}">
                <div class="user-logged-info" style="display: flex; align-items: center; gap: 10px; color: #fff; font-size: 14px;">
                    <!-- Tên nhân vật/người dùng -->
                    <span>
                        👤 <strong>${sessionScope.user.name}</strong>
                    </span>

                    <!-- Số dư tài khoản -->
                    <span style="background: rgba(255, 140, 0, 0.15); color: #ff8c00; padding: 4px 8px; border-radius: 4px; border: 1px solid rgba(255, 140, 0, 0.3); font-weight: bold;">
                        <fmt:formatNumber value="${sessionScope.user.balance}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                    </span>

                    <!-- Nút Đăng xuất -->
                    <a href="${pageContext.request.contextPath}/logout" 
                       class="logout-btn" 
                       style="padding: 6px 12px; background: #dc3545; color: #fff; border-radius: 4px; text-decoration: none; font-size: 13px; font-weight: bold;">
                        🚪 Thoát
                    </a>
                </div>
            </c:if>

            <!-- TRƯỜNG HỢP 2: CHƯA ĐĂNG NHẬP -->
            <c:if test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/register" class="register-btn">
                    Đăng ký
                </a>
                <a href="${pageContext.request.contextPath}/login" class="login-btn">
                    Đăng nhập
                </a>
            </c:if>
            
            <c:if test="${not empty sessionScope.user and sessionScope.user.role.trim().equalsIgnoreCase('ADMIN')}">
                <a href="${pageContext.request.contextPath}/admin" 
                   style="padding: 6px 12px; background: #28a745; color: #fff; border-radius: 4px; text-decoration: none; font-size: 13px; font-weight: bold;">
                    ⚙️ Quản trị
                </a>
            </c:if>

        </div>

    </div>
</header>
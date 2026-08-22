<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Duyệt Nạp Tiền - HUNR ADMIN</title>
    <!-- Font Awesome 6 CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- File CSS riêng biệt -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assest/css/admin-transactions.css">
</head>
<body>

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <h2>⚔️ HUNR ADMIN</h2>
        <a href="${pageContext.request.contextPath}/admin"><i class="fa-solid fa-gauge"></i> Tổng quan</a>
        <a href="${pageContext.request.contextPath}/admin-users"><i class="fa-solid fa-users"></i> Quản lý User</a>
        <a href="${pageContext.request.contextPath}/admin-events"><i class="fa-solid fa-newspaper"></i> Quản lý Sự kiện</a>
        <a href="${pageContext.request.contextPath}/admin-transactions" class="active"><i class="fa-solid fa-receipt"></i> Duyệt nạp tiền</a>
        <a href="${pageContext.request.contextPath}/admin-downloads"><i class="fa-solid fa-download"></i> Quản lý Tải game</a>
        <a href="${pageContext.request.contextPath}/admin-chats"><i class="fa-solid fa-headset"></i> Quản lý chat</a>
        <a href="${pageContext.request.contextPath}/event" style="margin-top: 50px; background: #333; color: #ff8c00;"><i class="fa-solid fa-house"></i> Về Website</a>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="main-content">
        <div class="header-bar">
            <h1>Duyệt Đơn Nạp Tiền (${fn:length(transactions)})</h1>
            <div>
                Xin chào, <strong>${sessionScope.user.name}</strong> 
                <a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </div>
        </div>

        <c:if test="${not empty sessionScope.msg_tx}">
            <div class="alert-box alert-success">
                ${sessionScope.msg_tx}
            </div>
            <c:remove var="msg_tx" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.msg_tx_err}">
            <div class="alert-box alert-danger">
                ${sessionScope.msg_tx_err}
            </div>
            <c:remove var="msg_tx_err" scope="session" />
        </c:if>

        <!-- BỘ LỌC ĐƠN NẠP -->
        <form action="${pageContext.request.contextPath}/admin-transactions" method="get" class="filter-container">
            <select name="statusFilter">
                <option value="">-- Tất cả trạng thái --</option>
                <option value="PENDING" ${statusFilter eq 'PENDING' ? 'selected' : ''}>⏳ Đang chờ duyệt (PENDING)</option>
                <option value="SUCCESS" ${statusFilter eq 'SUCCESS' ? 'selected' : ''}>✅ Nạp thành công (SUCCESS)</option>
                <option value="FAILED" ${statusFilter eq 'FAILED' ? 'selected' : ''}>❌ Bị từ chối (FAILED)</option>
            </select>

            <select name="typeFilter">
                <option value="">-- Hình thức nạp --</option>
                <option value="BANK" ${typeFilter eq 'BANK' ? 'selected' : ''}>Chuyển khoản (BANK)</option>
                <option value="CARD" ${typeFilter eq 'CARD' ? 'selected' : ''}>Thẻ cào / Thẻ game (CARD)</option>
            </select>

            <button type="submit" class="btn-filter"><i class="fa-solid fa-filter"></i> Lọc đơn</button>
            <a href="${pageContext.request.contextPath}/admin-transactions" class="btn-reset">Đặt lại</a>
        </form>

        <!-- BẢNG LỊCH SỬ DUYỆT -->
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Mã GD</th>
                    <th>Người nạp</th>
                    <th>Số tiền</th>
                    <th>Hình thức</th>
                    <th>Chi tiết mã / Nội dung</th>
                    <th>Thời gian</th>
                    <th>Trạng thái</th>
                    <th style="width: 140px;">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty transactions}">
                        <c:forEach var="t" items="${transactions}">
                            <tr>
                                <td>#${t.id}</td>
                                <td><strong>${t.userName}</strong></td>
                                <td class="amount-text">
                                    +<fmt:formatNumber value="${t.amount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </td>
                                <td><span class="badge badge-type">${t.type}</span></td>
                                <td class="description-text">${t.description}</td>
                                <td><fmt:formatDate value="${t.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${t.status eq 'PENDING'}">
                                            <span class="badge badge-pending">Chờ duyệt</span>
                                        </c:when>
                                        <c:when test="${t.status eq 'SUCCESS'}">
                                            <span class="badge badge-success">Thành công</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-failed">Đã từ chối</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${t.status eq 'PENDING'}">
                                        <!-- Nút Duyệt -->
                                        <form action="${pageContext.request.contextPath}/admin-transactions" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="approve">
                                            <input type="hidden" name="id" value="${t.id}">
                                            <button type="submit" class="btn-action btn-approve" onclick="return confirmApprove('${t.id}')">
                                                <i class="fa-solid fa-check"></i> Duyệt
                                            </button>
                                        </form>

                                        <!-- Nút Từ chối -->
                                        <form action="${pageContext.request.contextPath}/admin-transactions" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="reject">
                                            <input type="hidden" name="id" value="${t.id}">
                                            <button type="submit" class="btn-action btn-reject" onclick="return confirmReject('${t.id}')">
                                                <i class="fa-solid fa-xmark"></i> Hủy
                                            </button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8" class="empty-table-row">
                                Không có giao dịch nạp tiền nào phù hợp.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </main>

    <!-- File JavaScript riêng biệt -->
    <script src="${pageContext.request.contextPath}/assest/js/admin-transactions.js"></script>
</body>
</html>
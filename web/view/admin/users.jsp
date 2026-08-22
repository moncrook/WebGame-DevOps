<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Thành viên - HUNR ADMIN</title>
    <!-- Font Awesome 6 CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- File CSS riêng biệt -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assest/css/admin-users.css">
</head>
<body>

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <h2>⚔️ HUNR ADMIN</h2>
        <a href="${pageContext.request.contextPath}/admin"><i class="fa-solid fa-gauge"></i> Tổng quan</a>
        <a href="${pageContext.request.contextPath}/admin-users" class="active"><i class="fa-solid fa-users"></i> Quản lý User</a>
        <a href="${pageContext.request.contextPath}/admin-events"><i class="fa-solid fa-newspaper"></i> Quản lý Sự kiện</a>
        <a href="${pageContext.request.contextPath}/admin-transactions"><i class="fa-solid fa-receipt"></i> Duyệt nạp tiền</a>
        <a href="${pageContext.request.contextPath}/admin-downloads"><i class="fa-solid fa-download"></i> Quản lý Tải game</a>
        <a href="${pageContext.request.contextPath}/admin-chats"><i class="fa-solid fa-headset"></i> Quản lý chat</a>
        <a href="${pageContext.request.contextPath}/event" style="margin-top: 50px; background: #333; color: #ff8c00;"><i class="fa-solid fa-house"></i> Về Website</a>
    </aside>

    <!-- NỘI DUNG CHÍNH -->
    <main class="main-content">
        <div class="header-bar">
            <h1>Danh Sách Người Chơi (${fn:length(users)})</h1>
            <div>
                Xin chào, <strong>${sessionScope.user.name}</strong> 
                <a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </div>
        </div>

        <!-- THÔNG BÁO -->
        <c:if test="${not empty sessionScope.msg_user}">
            <div class="alert-box">
                ${sessionScope.msg_user}
            </div>
            <c:remove var="msg_user" scope="session" />
        </c:if>

        <!-- BỘ LỌC TÌM KIẾM -->
        <form action="${pageContext.request.contextPath}/admin-users" method="get" class="filter-container">
            <input type="text" name="keyword" placeholder="🔍 Tìm theo ID, tên tài khoản hoặc tên người chơi..." value="${keyword}">
            
            <select name="roleFilter">
                <option value="">-- Tất cả quyền hạn --</option>
                <option value="USER" ${roleFilter eq 'USER' ? 'selected' : ''}>User thường</option>
                <option value="ADMIN" ${roleFilter eq 'ADMIN' ? 'selected' : ''}>Admin</option>
            </select>

            <select name="statusFilter">
                <option value="">-- Trạng thái --</option>
                <option value="ACTIVE" ${statusFilter eq 'ACTIVE' ? 'selected' : ''}>Đang hoạt động</option>
                <option value="BANNED" ${statusFilter eq 'BANNED' ? 'selected' : ''}>Bị khóa</option>
            </select>

            <button type="submit" class="btn-filter"><i class="fa-solid fa-filter"></i> Lọc</button>
            <a href="${pageContext.request.contextPath}/admin-users" class="btn-reset">Đặt lại</a>
        </form>

        <!-- BẢNG DANH SÁCH USER -->
        <table class="admin-table">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên người dùng</th>
                    <th>Tài khoản</th>
                    <th>Số dư vàng</th>
                    <th>Vai trò</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty users}">
                        <c:forEach var="u" items="${users}" varStatus="loop">
                            <tr>
                                <td>#${loop.count}</td>
                                <td><strong>${u.name}</strong></td>
                                <td>${u.userName}</td>
                                <td class="balance-text">
                                    <fmt:formatNumber value="${u.balance}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </td>
                                <td>
                                    <span class="badge ${u.role eq 'ADMIN' ? 'badge-admin' : 'badge-user'}">${u.role}</span>
                                </td>
                                <td>
                                    <span class="badge ${u.status eq 'ACTIVE' ? 'badge-active' : 'badge-banned'}">
                                        ${u.status eq 'ACTIVE' ? 'Hoạt động' : 'Bị khóa'}
                                    </span>
                                </td>
                                <td>
                                    <!-- Nút Cộng/Trừ tiền -->
                                    <button type="button" class="btn-action btn-gold" title="Cộng / Trừ vàng" 
                                            onclick="openBalanceModal(${u.id}, '${u.name}', ${u.balance})">
                                        <i class="fa-solid fa-coins"></i> Vàng
                                    </button>

                                    <!-- Nút Reset Mật khẩu -->
                                    <button type="button" class="btn-action btn-key" title="Đặt lại mật khẩu"
                                            onclick="openPassModal(${u.id}, '${u.name}')">
                                        <i class="fa-solid fa-key"></i> Đổi pass
                                    </button>

                                    <!-- Nút Khóa / Mở khóa -->
                                    <form action="${pageContext.request.contextPath}/admin-users" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="toggle_status">
                                        <input type="hidden" name="userId" value="${u.id}">
                                        <c:choose>
                                            <c:when test="${u.status eq 'ACTIVE'}">
                                                <input type="hidden" name="newStatus" value="BANNED">
                                                <button type="submit" class="btn-action btn-ban" title="Khóa tài khoản" onclick="return confirm('Bạn có chắc muốn KHÓA tài khoản ${u.name}?')">
                                                    <i class="fa-solid fa-lock"></i> Khóa
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="newStatus" value="ACTIVE">
                                                <button type="submit" class="btn-action btn-unban" title="Mở khóa tài khoản" onclick="return confirm('MỞ KHÓA tài khoản ${u.name}?')">
                                                    <i class="fa-solid fa-unlock"></i> Mở
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="empty-table-row">
                                Không tìm thấy người chơi nào phù hợp.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </main>

    <!-- 1. MODAL CỘNG / TRỪ VÀNG -->
    <div id="balanceModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-header">
                <h3>💰 Điều Chỉnh Số Dư</h3>
                <button type="button" class="close-modal" onclick="closeModal('balanceModal')">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin-users" method="post">
                <input type="hidden" name="action" value="adjust_balance">
                <input type="hidden" name="userId" id="bal_user_id">
                
                <div class="form-group">
                    <label>Người chơi:</label>
                    <input type="text" id="bal_user_name" class="user-display-input" readonly>
                </div>
                <div class="form-group">
                    <label>Số vàng thay đổi (nhập số âm để trừ, ví dụ: -50000):</label>
                    <input type="number" name="amount" placeholder="Ví dụ: 100000 hoặc -50000" step="1000" required>
                </div>
                <button type="submit" class="btn-modal-submit btn-submit-gold">Xác nhận thay đổi</button>
            </form>
        </div>
    </div>

    <!-- 2. MODAL RESET PASSWORD -->
    <div id="passModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-header">
                <h3>🔑 Đặt Lại Mật Khẩu</h3>
                <button type="button" class="close-modal" onclick="closeModal('passModal')">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin-users" method="post">
                <input type="hidden" name="action" value="reset_password">
                <input type="hidden" name="userId" id="pass_user_id">
                
                <div class="form-group">
                    <label>Người chơi:</label>
                    <input type="text" id="pass_user_name" class="user-display-input" readonly>
                </div>
                <div class="form-group">
                    <label>Mật khẩu mới:</label>
                    <input type="text" name="newPassword" placeholder="Nhập mật khẩu mới..." required autocomplete="off">
                </div>
                <button type="submit" class="btn-modal-submit btn-submit-pass">Lưu mật khẩu mới</button>
            </form>
        </div>
    </div>

    <!-- File JavaScript riêng biệt -->
    <script src="${pageContext.request.contextPath}/assest/js/admin-users.js"></script>
</body>
</html>
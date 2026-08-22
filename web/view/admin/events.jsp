<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sự kiện - HUNR ADMIN</title>
    <!-- Font Awesome 6 CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- File CSS riêng biệt -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assest/css/admin-events.css">
</head>
<body>

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <h2>⚔️ HUNR ADMIN</h2>
        <a href="${pageContext.request.contextPath}/admin"><i class="fa-solid fa-gauge"></i> Tổng quan</a>
        <a href="${pageContext.request.contextPath}/admin-users"><i class="fa-solid fa-users"></i> Quản lý User</a>
        <a href="${pageContext.request.contextPath}/admin-events" class="active"><i class="fa-solid fa-newspaper"></i> Quản lý Sự kiện</a>
        <a href="${pageContext.request.contextPath}/admin-transactions"><i class="fa-solid fa-receipt"></i> Duyệt nạp tiền</a>
        <a href="${pageContext.request.contextPath}/admin-downloads"><i class="fa-solid fa-download"></i> Quản lý Tải game</a>
        <a href="${pageContext.request.contextPath}/admin-chats"><i class="fa-solid fa-headset"></i> Quản lý chat</a>
        <a href="${pageContext.request.contextPath}/event" style="margin-top: 50px; background: #333; color: #ff8c00;"><i class="fa-solid fa-house"></i> Về Website</a>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="main-content">
        <div class="header-bar">
            <h1>Quản lý Sự kiện Máy chủ</h1>
            <div>
                Xin chào, <strong>${sessionScope.user.name}</strong> 
                <a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </div>
        </div>

        <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 25px;">
            <div class="stat-card">
                <small>TỔNG SỐ SỰ KIỆN HIỆN CÓ</small>
                <h3>${not empty events ? fn:length(events) : 0} sự kiện</h3>
            </div>

            <button type="button" class="btn-create-event" onclick="openCreateEventModal()">
                <i class="fa-solid fa-circle-plus"></i> Thêm sự kiện mới
            </button>
        </div>

        <c:if test="${not empty sessionScope.msg_admin}">
            <div class="alert-box">
                ${sessionScope.msg_admin}
            </div>
            <c:remove var="msg_admin" scope="session" />
        </c:if>

        <form action="${pageContext.request.contextPath}/admin-events" method="get" class="filter-container">
            <input type="text" name="keyword" placeholder="🔍 Nhập tên sự kiện cần tìm..." value="${keyword}">
            
            <select name="timeFilter">
                <option value="">-- Tất cả thời gian --</option>
                <option value="1_DAY" ${timeFilter eq '1_DAY' ? 'selected' : ''}>1 ngày trước</option>
                <option value="1_WEEK" ${timeFilter eq '1_WEEK' ? 'selected' : ''}>1 tuần trước</option>
                <option value="1_MONTH" ${timeFilter eq '1_MONTH' ? 'selected' : ''}>1 tháng trước</option>
                <option value="1_YEAR" ${timeFilter eq '1_YEAR' ? 'selected' : ''}>1 năm trước</option>
            </select>

            <button type="submit" class="btn-filter"><i class="fa-solid fa-filter"></i> Lọc</button>
            <a href="${pageContext.request.contextPath}/admin-events" class="btn-reset">Đặt lại</a>
        </form>

        <h2 style="color: #ff8c00; font-size: 18px; margin-bottom: 15px;">Danh sách sự kiện máy chủ</h2>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Tiêu đề sự kiện</th>
                    <th>Thời gian đăng</th>
                    <th style="width: 300px;">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty events}">
                        <c:forEach var="e" items="${events}" varStatus="loop">
                            <tr>
                                <td>#${loop.count}</td>
                                <td><strong>${e.title}</strong></td>
                                <td><fmt:formatDate value="${e.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/event?id=${e.id}" class="btn-action btn-view" target="_blank" title="Xem chi tiết">
                                        <i class="fa-solid fa-eye"></i> Xem
                                    </a>
                                    <button type="button" class="btn-action btn-edit" title="Chỉnh sửa"
                                            data-id="${e.id}"
                                            data-title="<c:out value='${e.title}'/>"
                                            data-content="<c:out value='${e.content}'/>"
                                            data-description="<c:out value='${e.description}'/>"
                                            data-image="<c:out value='${e.image}'/>"
                                            onclick="openEditEventModal(this)">
                                        <i class="fa-solid fa-pen-to-square"></i> Sửa
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin-events?action=delete&id=${e.id}" 
                                       class="btn-action btn-del" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sự kiện: \'${e.title}\' không? Hành động này không thể hoàn tác!')" 
                                       title="Xóa sự kiện">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4" class="empty-table-row">
                                Không tìm thấy sự kiện nào phù hợp với bộ lọc.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </main>

    <!-- ================= 1. MODAL THÊM SỰ KIỆN (UPLOAD FILE) ================= -->
    <div id="createEventModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-header">
                <h3>🎉 Thêm Sự Kiện Máy Chủ Mới</h3>
                <button type="button" class="close-modal" onclick="closeModal('createEventModal')">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin-events" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="create_event">
                
                <div class="form-group">
                    <label>Tiêu đề sự kiện (title):</label>
                    <input type="text" name="title" placeholder="Nhập tiêu đề sự kiện..." required autocomplete="off">
                </div>
                <div class="form-group">
                    <label>Nội dung tóm tắt ngắn (content):</label>
                    <textarea name="content" rows="3" placeholder="Tóm tắt ngắn gọn để hiển thị ở trang tin tức..." required></textarea>
                </div>
                <div class="form-group">
                    <label>Nội dung chi tiết (description):</label>
                    <textarea name="description" rows="5" placeholder="Nhập đầy đủ chi tiết thể lệ, phần thưởng sự kiện..." required></textarea>
                </div>
                <div class="form-group">
                    <label>Ảnh đại diện sự kiện (chọn file từ máy tính):</label>
                    <input type="file" name="image" accept="image/*">
                </div>
                <button type="submit" class="btn-submit-create">
                    <i class="fa-solid fa-check"></i> Xác nhận thêm sự kiện
                </button>
            </form>
        </div>
    </div>

    <!-- ================= 2. MODAL SỬA SỰ KIỆN (UPLOAD FILE MỚI HOẶC GIỮ CŨ) ================= -->
    <div id="editEventModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-header">
                <h3>✏️ Chỉnh Sửa Sự Kiện Máy Chủ</h3>
                <button type="button" class="close-modal" onclick="closeModal('editEventModal')">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin-events" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="update_event">
                <input type="hidden" name="id" id="edit_id">
                <input type="hidden" name="old_image" id="edit_old_image">

                <div class="form-group">
                    <label>Tiêu đề sự kiện (title):</label>
                    <input type="text" name="title" id="edit_title" required autocomplete="off">
                </div>
                <div class="form-group">
                    <label>Nội dung tóm tắt ngắn (content):</label>
                    <textarea name="content" id="edit_content" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label>Nội dung chi tiết (description):</label>
                    <textarea name="description" id="edit_description" rows="5" required></textarea>
                </div>
                <div class="form-group">
                    <label>Ảnh đại diện mới (để trống nếu muốn giữ ảnh cũ):</label>
                    <input type="file" name="image" accept="image/*">
                    <small id="current_image_hint" class="current-image-hint"></small>
                </div>
                <button type="submit" class="btn-submit-edit">
                    <i class="fa-solid fa-floppy-disk"></i> Lưu thay đổi
                </button>
            </form>
        </div>
    </div>

    <!-- File JavaScript riêng biệt -->
    <script src="${pageContext.request.contextPath}/assest/js/admin-events.js"></script>
</body>
</html>
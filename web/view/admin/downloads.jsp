<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Tải Game - HUNR ADMIN</title>
    <!-- Font Awesome 6 CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- File CSS riêng biệt -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assest/css/admin-downloads.css">
</head>
<body>

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <h2>⚔️ HUNR ADMIN</h2>
        <a href="${pageContext.request.contextPath}/admin"><i class="fa-solid fa-gauge"></i> Tổng quan</a>
        <a href="${pageContext.request.contextPath}/admin-users"><i class="fa-solid fa-users"></i> Quản lý User</a>
        <a href="${pageContext.request.contextPath}/admin-events"><i class="fa-solid fa-newspaper"></i> Quản lý Sự kiện</a>
        <a href="${pageContext.request.contextPath}/admin-transactions"><i class="fa-solid fa-receipt"></i> Duyệt nạp tiền</a>
        <a href="${pageContext.request.contextPath}/admin-downloads" class="active"><i class="fa-solid fa-download"></i> Quản lý Tải game</a>
        <a href="${pageContext.request.contextPath}/admin-chats"><i class="fa-solid fa-headset"></i> Quản lý chat</a>
        <a href="${pageContext.request.contextPath}/event" style="margin-top: 50px; background: #333; color: #ff8c00;"><i class="fa-solid fa-house"></i> Về Website</a>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="main-content">
        <div class="header-bar">
            <h1>Quản Lý Phiên Bản Tải Game</h1>
            <div>
                Xin chào, <strong>${sessionScope.user.name}</strong> 
                <a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </div>
        </div>

        <c:if test="${not empty sessionScope.msg_download}">
            <div class="alert-box">
                ${sessionScope.msg_download}
            </div>
            <c:remove var="msg_download" scope="session" />
        </c:if>

        <div class="top-action-bar">
            <h2>Danh sách bản cài (${fn:length(downloads)})</h2>
            <button type="button" class="btn-add" onclick="openAddModal()">
                <i class="fa-solid fa-circle-plus"></i> Thêm bản cài mới
            </button>
        </div>

        <!-- BẢNG DANH SÁCH DOWNLOAD -->
        <table class="admin-table">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Nền tảng (Platform)</th>
                    <th>Phiên bản (Version)</th>
                    <th>Dung lượng</th>
                    <th>Link tải</th>
                    <th>Ngày cập nhật</th>
                    <th style="width: 200px;">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty downloads}">
                        <c:forEach var="d" items="${downloads}" varStatus="loop">
                            <tr>
                                <td>#${loop.count}</td>
                                <td><span class="badge-platform">${d.platform}</span></td>
                                <td><strong>${d.version}</strong></td>
                                <td class="file-size-text">${d.fileSize}</td>
                                <td>
                                    <a href="${d.fileUrl}" target="_blank" class="file-url-link">
                                        ${d.fileUrl}
                                    </a>
                                </td>
                                <td><fmt:formatDate value="${d.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>
                                    <!-- Nút Sửa -->
                                    <button type="button" class="btn-action btn-edit" title="Sửa link"
                                            data-id="${d.id}"
                                            data-platform="<c:out value='${d.platform}'/>"
                                            data-version="<c:out value='${d.version}'/>"
                                            data-size="<c:out value='${d.fileSize}'/>"
                                            data-url="<c:out value='${d.fileUrl}'/>"
                                            onclick="openEditModal(this)">
                                        <i class="fa-solid fa-pen-to-square"></i> Sửa
                                    </button>

                                    <!-- Nút Xóa -->
                                    <a href="${pageContext.request.contextPath}/admin-downloads?action=delete&id=${d.id}" 
                                       class="btn-action btn-del" 
                                       onclick="return confirm('Bạn có chắc muốn xóa bản cài: \'${d.platform}\'?')">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="empty-table-row">
                                Chưa có phiên bản tải game nào trong hệ thống.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </main>

    <!-- 1. MODAL THÊM BẢN CÀI MỚI -->
    <div id="addModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-header">
                <h3>🎮 Thêm Bản Cài Đặt Game</h3>
                <button type="button" class="close-modal" onclick="closeModal('addModal')">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin-downloads" method="post">
                <input type="hidden" name="action" value="create">

                <div class="form-group">
                    <label>Nền tảng (Platform):</label>
                    <input type="text" name="platform" placeholder="Ví dụ: PC (Windows), Android (APK)..." required autocomplete="off">
                </div>
                <div class="form-group">
                    <label>Phiên bản (Version):</label>
                    <input type="text" name="version" placeholder="Ví dụ: v1.2.0" required autocomplete="off">
                </div>
                <div class="form-group">
                    <label>Dung lượng (File size):</label>
                    <input type="text" name="file_size" placeholder="Ví dụ: 125 MB" required autocomplete="off">
                </div>
                <div class="form-group">
                    <label>Đường dẫn tải file (File URL):</label>
                    <input type="url" name="file_url" placeholder="https://..." required autocomplete="off">
                </div>

                <button type="submit" class="btn-submit btn-submit-create">Xác nhận thêm</button>
            </form>
        </div>
    </div>

    <!-- 2. MODAL SỬA BẢN CÀI -->
    <div id="editModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-header">
                <h3>✏️ Cập Nhật Bản Cài Đặt Game</h3>
                <button type="button" class="close-modal" onclick="closeModal('editModal')">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin-downloads" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" id="edit_id">

                <div class="form-group">
                    <label>Nền tảng (Platform):</label>
                    <input type="text" name="platform" id="edit_platform" required autocomplete="off">
                </div>
                <div class="form-group">
                    <label>Phiên bản (Version):</label>
                    <input type="text" name="version" id="edit_version" required autocomplete="off">
                </div>
                <div class="form-group">
                    <label>Dung lượng (File size):</label>
                    <input type="text" name="file_size" id="edit_size" required autocomplete="off">
                </div>
                <div class="form-group">
                    <label>Đường dẫn tải file (File URL):</label>
                    <input type="url" name="file_url" id="edit_url" required autocomplete="off">
                </div>

                <button type="submit" class="btn-submit btn-submit-edit">Lưu thay đổi</button>
            </form>
        </div>
    </div>

    <!-- File JavaScript riêng biệt -->
    <script src="${pageContext.request.contextPath}/assest/js/admin-downloads.js"></script>
</body>
</html>
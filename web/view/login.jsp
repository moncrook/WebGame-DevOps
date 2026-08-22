<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hồi Ức Ngọc Rồng</title>

    <!-- FontAwesome 6 CDN (hiển thị icon mắt và nút submit) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- CSS riêng của trang login -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assest/css/login.css">
</head>
<body>

<div class="login-container">
    <a href="${pageContext.request.contextPath}/home">
        <div class="avatar-box">
            <img src="${pageContext.request.contextPath}/assest/images/logo.png" alt="Logo Game" onerror="this.src='https://via.placeholder.com/90/23201d/ff8c00?text=Dragon'">
        </div>
    </a>

    <h1 class="main-title">Đăng nhập</h1>
    <p class="sub-title">Chào mừng bạn quay lại Hồi Ức Ngọc Rồng</p>

    <div class="card-form">
        <!-- Hiển thị thông báo lỗi từ Session (LoginServlet) -->
        <c:if test="${not empty sessionScope.error_login}">
            <div class="error-msg" style="color: #ff4d4d; background: rgba(255, 77, 77, 0.1); padding: 10px; border-radius: 6px; margin-bottom: 15px; border: 1px solid #ff4d4d; text-align: center; font-size: 14px;">
                ${sessionScope.error_login}
            </div>
            <!-- Xóa session error_login ngay sau khi hiển thị để F5 không bị lặp lại -->
            <c:remove var="error_login" scope="session" />
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="POST">
            <!-- Username -->
            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <div class="input-wrapper">
                    <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required autocomplete="username">
                </div>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <div class="input-wrapper" style="position: relative;">
                    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required autocomplete="current-password">
                    <span class="toggle-pwd" onclick="togglePasswordVisibility()" style="position: absolute; right: 12px; top: 50%; transform: translateY(-50%); cursor: pointer; color: #888;">
                        <i class="fa-regular fa-eye" id="eyeIcon"></i>
                    </span>
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn-submit">
                <i class="fa-solid fa-arrow-right-to-bracket"></i> Đăng nhập
            </button>
        </form>

        <div class="card-footer" style="margin-top: 15px; text-align: center;">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" style="color: #ff8c00; text-decoration: none; font-weight: bold;">Đăng ký ngay</a>
        </div>
    </div>
</div>

<script>
    function togglePasswordVisibility() {
        const passwordInput = document.getElementById('password');
        const eyeIcon = document.getElementById('eyeIcon');
        
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            eyeIcon.classList.remove('fa-eye');
            eyeIcon.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            eyeIcon.classList.remove('fa-eye-slash');
            eyeIcon.classList.add('fa-eye');
        }
    }
</script>

</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Hồi Ức Ngọc Rồng</title>
    <!-- File CSS riêng -->
    <link rel="stylesheet" href="css/register-style.css">
    <!-- FontAwesome icon -->
    <link rel="stylesheet"
              href="${pageContext.request.contextPath}/assest/css/register.css">
</head>
<body>

    
    
<div class="register-container">
    <a href="home">
        <div class="avatar-box">
            <img src="assest/images/logo.png" alt="Logo Game" onerror="this.src='https://via.placeholder.com/90/23201d/ff8c00?text=Dragon'">
        </div>
    </a>

    <h1 class="main-title">Đăng ký tài khoản</h1>
    <p class="sub-title">Tham gia thế giới Hồi Ức Ngọc Rồng</p>

    <div class="card-form">
        <!-- Hiển thị thông báo lỗi/thành công từ Servlet nếu có -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-msg" id="serverMsg"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <div class="success-msg" id="serverMsg"><%= request.getAttribute("success") %></div>
        <% } %>

        <!-- Thông báo lỗi kiểm tra phía Client (JS) -->
        <div id="clientError" class="error-msg" style="display: none;"></div>

        <form id="registerForm" action="register" method="post" ">
            <!-- Tên đăng nhập -->
            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <div class="input-wrapper">
                    <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập (tối thiểu 4 ký tự)" required autocomplete="off">
                </div>
                <br>
                    <span style="color: red">${err_username}</span>
            </div>
            
            <!-- Tên nhân vật -->
            <div class="form-group">
                <label for="name">Tên nhân vật</label>
                <div class="input-wrapper">
                    <input type="text" id="name" name="name" placeholder="Nhập tên nhân vật (tối thiểu 4 ký tự)" required autocomplete="off">                   
                </div>
                <br><span style="color: red">${err_name}</span>
            </div>

            <!-- Mật khẩu -->
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <div class="input-wrapper">
                    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu (tối thiểu 6 ký tự)" required>
                    <span class="toggle-pwd" onclick="togglePassword('password', 'eyeIcon1')">
                        <i class="fa-regular fa-eye" id="eyeIcon1"></i>
                    </span>
                </div>
            </div>

            <!-- Xác nhận mật khẩu -->
            <div class="form-group">
                <label for="confirmPassword">Nhập lại mật khẩu</label>
                <div class="input-wrapper">
                    <input type="password" id="confirmPassword" name="repassword" placeholder="Nhập lại mật khẩu" required>
                    <span class="toggle-pwd" onclick="togglePassword('confirmPassword', 'eyeIcon2')">
                        <i class="fa-regular fa-eye" id="eyeIcon2"></i>
                    </span>
                </div>
                    <br><span style="color: red">${err_repassword}</span>
            </div>

            <!-- Nút gửi form -->
            <button type="submit" class="btn-submit" >
                <i class="fa-solid fa-user-plus"></i> Đăng ký ngay
            </button>
        </form>

        <div class="card-footer">
            Đã có tài khoản? <a href="login">Đăng nhập</a>
        </div>
    </div>
</div>

<!-- ================= JAVASCRIPT ================= -->
<script>
    // 1. Hàm ẩn/hiện mật khẩu động (dùng chung cho cả 2 ô mật khẩu)
    function togglePassword(inputId, iconId) {
        const inputField = document.getElementById(inputId);
        const icon = document.getElementById(iconId);

        if (inputField.type === 'password') {
            inputField.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            inputField.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }

    // 2. Hàm làm mới mã Captcha (thêm timestamp để tránh cache trình duyệt)
    function refreshCaptcha() {
        const img = document.getElementById('captchaImage');
        img.src = 'captcha?ts=' + new Date().getTime();
    }

    // 3. Kiểm tra dữ liệu Form phía Client trước khi gửi lên Servlet
    function validateForm() {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        
        const errorBox = document.getElementById('clientError');

        // Reset thông báo lỗi
        errorBox.style.display = 'none';
        errorBox.innerText = '';

        // Kiểm tra độ dài tên đăng nhập
        if (username.length < 4) {
            showError('Tên đăng nhập phải có ít nhất 4 ký tự!');
            return false;
        }

        // Kiểm tra độ dài mật khẩu
        if (password.length < 6) {
            showError('Mật khẩu phải có ít nhất 6 ký tự!');
            return false;
        }

        // Kiểm tra mật khẩu khớp nhau
        if (password !== confirmPassword) {
            showError('Mật khẩu nhập lại không khớp!');
            return false;
        }

        
        return true;
    }

    function showError(msg) {
        const errorBox = document.getElementById('clientError');
        errorBox.innerText = msg;
        errorBox.style.display = 'block';
    }
</script>

</body>
</html>
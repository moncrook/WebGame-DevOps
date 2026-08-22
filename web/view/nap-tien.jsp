<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Nạp tiền - HUNR</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assest/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assest/css/naptien.css?v2">
</head>
<body>

    <!-- HEADER -->
    <jsp:include page="inc/header.jsp" />

    <main class="topup-page">

        <section class="topup-title">
            <div class="topup-title-icon">💰</div>
            <div>
                <span class="topup-subtitle">HỆ THỐNG GIAO DỊCH</span>
                <h1>Nạp tiền</h1>
            </div>
        </section>

        <!-- Thông báo kết quả -->
        <c:if test="${not empty sessionScope.msg_success}">
            <div class="alert-box alert-success" style="background: rgba(40, 167, 69, 0.2); color: #28a745; border: 1px solid #28a745; padding: 12px; border-radius: 8px; margin-bottom: 20px;">
                ${sessionScope.msg_success}
            </div>
            <c:remove var="msg_success" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.msg_error}">
            <div class="alert-box alert-danger" style="background: rgba(220, 53, 69, 0.2); color: #dc3545; border: 1px solid #dc3545; padding: 12px; border-radius: 8px; margin-bottom: 20px;">
                ${sessionScope.msg_error}
            </div>
            <c:remove var="msg_error" scope="session" />
        </c:if>

        <div class="topup-layout">

            <!-- FORM NẠP TIỀN -->
            <section class="topup-card">
                <div>
                    <!-- Giá trị ẩn quản lý số tiền và phương thức -->
                    <input type="hidden" id="inputAmount" value="100000">
                    <input type="hidden" id="inputMethod" value="BANK">

                    <div class="card-heading">
                        <div class="heading-icon">💳</div>
                        <div>
                            <h2>Nạp tiền vào tài khoản</h2>
                            <p>Chọn mệnh giá bạn muốn nạp</p>
                        </div>
                    </div>

                    <!-- TÀI KHOẢN -->
                    <div class="account-box">
                        <span>Tài khoản</span>
                        <strong>${not empty sessionScope.user ? sessionScope.user.name : 'Chưa đăng nhập'}</strong>
                    </div>

                    <!-- CHỌN MỆNH GIÁ -->
                    <div class="amount-section">
                        <h3>Chọn mệnh giá</h3>
                        <div class="amount-grid">
                            <button type="button" class="amount-item" onclick="selectAmount(20000, this)">
                                <strong>20.000đ</strong>
                                <span>20.000 vàng</span>
                            </button>
                            <button type="button" class="amount-item" onclick="selectAmount(50000, this)">
                                <strong>50.000đ</strong>
                                <span>50.000 vàng</span>
                            </button>
                            <button type="button" class="amount-item active" onclick="selectAmount(100000, this)">
                                <strong>100.000đ</strong>
                                <span>100.000 vàng</span>
                            </button>
                            <button type="button" class="amount-item" onclick="selectAmount(200000, this)">
                                <strong>200.000đ</strong>
                                <span>200.000 vàng</span>
                            </button>
                            <button type="button" class="amount-item" onclick="selectAmount(500000, this)">
                                <strong>500.000đ</strong>
                                <span>500.000 vàng</span>
                            </button>
                            <button type="button" class="amount-item" onclick="selectAmount(1000000, this)">
                                <strong>1.000.000đ</strong>
                                <span>1.000.000 vàng</span>
                            </button>
                        </div>

                        <!-- Ô NHẬP SỐ TIỀN TÙY CHỌN -->
                        <div class="custom-amount-box">
                            <span class="custom-amount-label">Hoặc nhập số tiền khác:</span>
                            <input type="number" id="customAmountInput" placeholder="Ví dụ: 350000" min="10000" step="10000" oninput="onCustomAmountChange(this.value)">
                            <span class="custom-amount-unit">VNĐ</span>
                        </div>
                    </div>

                    <!-- PHƯƠNG THỨC THANH TOÁN -->
                    <div class="payment-section">
                        <h3>Phương thức thanh toán</h3>
                        <div class="payment-method active" id="methodQR" onclick="selectMethod('BANK', this)">
                            <div class="payment-icon">📱</div>
                            <div class="payment-info">
                                <strong>Thanh toán QR</strong>
                                <span>Quét mã QR ngân hàng / Momo</span>
                            </div>
                            <div class="check">✓</div>
                        </div>

                        <div class="payment-method" id="methodCard" onclick="selectMethod('CARD', this)">
                            <div class="payment-icon">💳</div>
                            <div class="payment-info">
                                <strong>Thẻ game / Thẻ cào</strong>
                                <span>Thanh toán bằng số Seri & Mã thẻ cào</span>
                            </div>
                            <div class="check">✓</div>
                        </div>
                    </div>

                    <!-- TỔNG TIỀN -->
                    <div class="payment-total">
                        <span>Số tiền thanh toán</span>
                        <strong id="displayAmount">100.000đ</strong>
                    </div>

                    <!-- NÚT BẤM MỞ FORM THEO PHƯƠNG THỨC -->
                    <button type="button" class="topup-button" id="btnSubmit" onclick="handleConfirmTopup()">
                        💰 Xác nhận nạp 100.000đ
                    </button>
                </div>
            </section>

            <!-- BÊN PHẢI: SỐ DƯ & HƯỚNG DẪN -->
            <aside class="topup-sidebar">
                <div class="balance-card">
                    <div class="balance-icon">💰</div>
                    <span>Số dư hiện tại</span>
                    <strong>
                        <fmt:formatNumber value="${not empty sessionScope.user ? sessionScope.user.balance : 0}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                    </strong>
                    <small>Vàng trong tài khoản</small>
                </div>

                <div class="guide-card">
                    <h3>📌 Hướng dẫn nạp tiền</h3>
                    <div class="guide-item"><span>01</span><p>Chọn hoặc nhập mệnh giá cần nạp</p></div>
                    <div class="guide-item"><span>02</span><p>Chọn phương thức và nhấn Xác nhận</p></div>
                    <div class="guide-item"><span>03</span><p>Quét mã QR hoặc nhập thẻ để hoàn tất</p></div>
                </div>
            </aside>

        </div>

        <!-- LỊCH SỬ NẠP TIỀN -->
        <section class="history-card">
            <div class="history-header">
                <div>
                    <span>GIAO DỊCH</span>
                    <h2>Lịch sử nạp tiền</h2>
                </div>
                <div class="history-icon">📋</div>
            </div>

            <c:choose>
                <c:when test="${not empty history}">
                    <table class="history-table">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Số tiền</th>
                                <th>Phương thức</th>
                                <th>Mô tả</th>
                                <th>Thời gian</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="h" items="${history}" varStatus="loop">
                                <tr>
                                    <td>#${loop.count}</td>
                                    <td><strong>+<fmt:formatNumber value="${h.amount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></strong></td>
                                    <td>${h.type}</td>
                                    <td>${h.description}</td>
                                    <td><fmt:formatDate value="${h.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${h.status eq 'PENDING'}">
                                                <span style="color: #ffc107; font-weight: bold;">Chờ duyệt</span>
                                            </c:when>
                                            <c:when test="${h.status eq 'SUCCESS'}">
                                                <span class="badge-success">Thành công</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #dc3545; font-weight: bold;">Từ chối</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-history">
                        <div>📋</div>
                        <p>Chưa có giao dịch nào</p>
                        <span>Lịch sử nạp tiền của bạn sẽ hiển thị tại đây.</span>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

    </main>

    <!-- ================= 1. MODAL POPUP QUÉT MÃ QR ================= -->
    <div id="qrModalOverlay" class="modal-overlay" style="display: none;">
        <div class="modal-box">
            <div class="modal-header">
                <h3>📱 Thanh toán VietQR</h3>
                <button type="button" class="close-modal" onclick="closeModal('qrModalOverlay')">✕</button>
            </div>

            <div class="qr-section">
                <p class="qr-heading">Quét mã QR để thanh toán đơn nạp:</p>
                <img id="qrImage" 
                     src="https://img.vietqr.io/image/MB-0357016241-compact2.png?amount=100000&addInfo=NAP%20${empty sessionScope.user.name ? 'USER' : sessionScope.user.name}" 
                     alt="Mã QR nạp tiền">
                <div class="qr-info">
                    <div>🏦 Ngân hàng: <strong>MB Bank (Quân Đội)</strong></div>
                    <div>🔢 Số tài khoản: <strong>0357016241</strong></div>
                    <div>👤 Chủ tài khoản: <strong>PHAN XUAN NHAN</strong></div>
                    <div>💵 Số tiền: <strong id="qrModalAmountText" class="text-highlight">100.000đ</strong></div>
                    <div>📝 Nội dung chuyển khoản: <strong class="text-highlight">NAP ${empty sessionScope.user.name ? 'USER' : sessionScope.user.name}</strong></div>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/nap-tien" method="post">
                <input type="hidden" name="payment_method" value="BANK">
                <input type="hidden" name="amount" id="formQrAmount" value="100000">
                <button type="submit" class="btn-card-submit">Tôi đã chuyển tiền thành công</button>
            </form>
        </div>
    </div>

    <!-- ================= 2. MODAL POPUP NHẬP THẺ CÀO ================= -->
    <div id="cardModalOverlay" class="modal-overlay" style="display: none;">
        <div class="modal-box">
            <div class="modal-header">
                <h3>💳 Nạp thẻ game / Thẻ cào</h3>
                <button type="button" class="close-modal" onclick="closeModal('cardModalOverlay')">✕</button>
            </div>
            <form action="${pageContext.request.contextPath}/nap-tien" method="post">
                <input type="hidden" name="payment_method" value="CARD">

                <div class="form-group">
                    <label>Loại thẻ:</label>
                    <select name="card_type" required>
                        <option value="VIETTEL">Viettel</option>
                        <option value="MOBIFONE">Mobifone</option>
                        <option value="VINAPHONE">Vinaphone</option>
                        <option value="ZING">Thẻ Zing</option>
                        <option value="GARENA">Thẻ Garena</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Mệnh giá thẻ:</label>
                    <select name="amount" required id="modalCardAmount">
                        <option value="20000">20.000đ</option>
                        <option value="50000">50.000đ</option>
                        <option value="100000" selected>100.000đ</option>
                        <option value="200000">200.000đ</option>
                        <option value="500000">500.000đ</option>
                        <option value="1000000">1.000.000đ</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Số Seri:</label>
                    <input type="text" name="serial" placeholder="Nhập số seri in trên thẻ..." required autocomplete="off">
                </div>

                <div class="form-group">
                    <label>Mã thẻ (Mã PIN):</label>
                    <input type="text" name="pin" placeholder="Nhập mã thẻ cào sau lớp tráng bạc..." required autocomplete="off">
                </div>

                <button type="submit" class="btn-card-submit">Nạp thẻ ngay</button>
            </form>
        </div>
    </div>

    <!-- Nhúng Live Chatbot -->
    <jsp:include page="inc/chatbot.jsp" />

    <!-- FOOTER -->
    <jsp:include page="inc/footer.jsp" />

    <script>
        const accountName = "${empty sessionScope.user.name ? '' : sessionScope.user.name}";
        const isUserLoggedIn = ${not empty sessionScope.user ? 'true' : 'false'};
        const loginUrl = "${pageContext.request.contextPath}/login";

        function updateQR(amount) {
            let qrUrl = "https://img.vietqr.io/image/MB-0335016259-compact2.png?amount=" + amount + "&addInfo=NAP%20" + encodeURIComponent(accountName || 'USER');
            document.getElementById('qrImage').src = qrUrl;
        }

        function selectAmount(val, element) {
            document.getElementById('inputAmount').value = val;
            document.getElementById('customAmountInput').value = '';
            
            let formatted = new Intl.NumberFormat('vi-VN').format(val) + 'đ';
            document.getElementById('displayAmount').innerText = formatted;
            document.getElementById('btnSubmit').innerText = '💰 Xác nhận nạp ' + formatted;

            document.querySelectorAll('.amount-item').forEach(el => el.classList.remove('active'));
            element.classList.add('active');

            document.getElementById('formQrAmount').value = val;
            document.getElementById('qrModalAmountText').innerText = formatted;
            
            let cardSelect = document.getElementById('modalCardAmount');
            if (cardSelect && cardSelect.querySelector('option[value="' + val + '"]')) {
                cardSelect.value = val;
            }

            updateQR(val);
        }

        function onCustomAmountChange(val) {
            let amount = parseInt(val) || 0;
            if (amount > 0) {
                document.getElementById('inputAmount').value = amount;
                let formatted = new Intl.NumberFormat('vi-VN').format(amount) + 'đ';
                document.getElementById('displayAmount').innerText = formatted;
                document.getElementById('btnSubmit').innerText = '💰 Xác nhận nạp ' + formatted;

                document.querySelectorAll('.amount-item').forEach(el => el.classList.remove('active'));

                document.getElementById('formQrAmount').value = amount;
                document.getElementById('qrModalAmountText').innerText = formatted;

                updateQR(amount);
            }
        }

        function selectMethod(method, element) {
            document.getElementById('inputMethod').value = method;
            document.querySelectorAll('.payment-method').forEach(el => el.classList.remove('active'));
            element.classList.add('active');
        }

        function handleConfirmTopup() {
            if (!isUserLoggedIn) {
                alert("Vui lòng đăng nhập tài khoản trước khi thực hiện nạp tiền!");
                window.location.href = loginUrl;
                return;
            }

            let currentMethod = document.getElementById('inputMethod').value;
            if (currentMethod === 'BANK') {
                document.getElementById('qrModalOverlay').style.display = 'flex';
            } else if (currentMethod === 'CARD') {
                document.getElementById('cardModalOverlay').style.display = 'flex';
            }
        }

        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }

        window.onclick = function(event) {
            let qrModal = document.getElementById('qrModalOverlay');
            let cardModal = document.getElementById('cardModalOverlay');
            if (event.target === qrModal) {
                qrModal.style.display = 'none';
            }
            if (event.target === cardModal) {
                cardModal.style.display = 'none';
            }
        }
    </script>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Tải game - HUNR</title>
    <!-- Thêm thư viện Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assest/css/taigame.css">
</head>

<body>

    <!-- HEADER -->
    <jsp:include page="inc/header.jsp" />

    <main class="download-page">

        <!-- =================================
              TIÊU ĐỀ
        ================================== -->
        <section class="download-title">
            <div class="download-title-icon">🎮</div>
            <div>
                <span>TRUNG TÂM TẢI GAME</span>
                <h1>Tải game</h1>
                <p>Chọn phiên bản phù hợp với thiết bị của bạn</p>
            </div>
        </section>

        <!-- =================================
              GAME INTRO
        ================================== -->
        <section class="game-intro">
            <div class="game-image">
                <img src="${pageContext.request.contextPath}/assest/images/banner.png" alt="Ngọc Rồng Online">
            </div>

            <div class="game-intro-content">
                <span class="intro-label">NGỌC RỒNG ONLINE</span>
                <h2>Tải game và bắt đầu hành trình</h2>
                <p>
                    Tham gia thế giới Ngọc Rồng Online, khám phá các hành tinh, chiến đấu,
                    nâng cấp nhân vật và đồng hành cùng cộng đồng người chơi.
                </p>

                <div class="game-info">
                    <div>
                        <strong>Phiên bản mới nhất</strong>
                        <span>${not empty downloads ? downloads[0].version : 'v1.2.0'}</span>
                    </div>

                    <div>
                        <strong>Tổng bản cài</strong>
                        <span>${not empty downloads ? fn:length(downloads) : 0} nền tảng</span>
                    </div>

                    <div>
                        <strong>Cập nhật gần nhất</strong>
                        <span>
                            <c:choose>
                                <c:when test="${not empty downloads}">
                                    <fmt:formatDate value="${downloads[0].createdAt}" pattern="dd/MM/yyyy"/>
                                </c:when>
                                <c:otherwise>18/08/2026</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>
        </section>

        <!-- =================================
              CÁC PHIÊN BẢN (DỮ LIỆU ĐỘNG TỪ DATABASE)
        ================================== -->
        <section class="version-section">
            <div class="section-heading">
                <div>
                    <span>PHIÊN BẢN GAME</span>
                    <h2>Chọn nền tảng phù hợp</h2>
                </div>
            </div>

            <div class="version-grid">
                <c:choose>
                    <c:when test="${not empty downloads}">
                        <c:forEach var="d" items="${downloads}">
                            <div class="version-card">
                                <!-- Thay thế thẻ icon cũ bằng đoạn này -->
                                <div class="version-icon">
                                    <c:choose>
                                        <c:when test="${fn:containsIgnoreCase(d.platform, 'PC') or fn:containsIgnoreCase(d.platform, 'Windows')}">
                                            <i class="fa-brands fa-windows" style="color: #00a4ef;"></i>
                                        </c:when>
                                        <c:when test="${fn:containsIgnoreCase(d.platform, 'Android') or fn:containsIgnoreCase(d.platform, 'APK')}">
                                            <i class="fa-brands fa-android" style="color: #3ddc84;"></i>
                                        </c:when>
                                        <c:when test="${fn:containsIgnoreCase(d.platform, 'IOS') or fn:containsIgnoreCase(d.platform, 'Apple')}">
                                            <i class="fa-brands fa-apple" style="color: #fff;"></i>
                                        </c:when>
                                        <c:when test="${fn:containsIgnoreCase(d.platform, 'Java') or fn:containsIgnoreCase(d.platform, 'JAR')}">
                                            <i class="fa-brands fa-java" style="color: #e76f00;"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-solid fa-gamepad" style="color: #ff8c00;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="version-content">
                                    <span class="version-label">${d.platform}</span>
                                    <h3>${d.platform} (${d.version})</h3>
                                    <p>Bản cài đặt chính thức hỗ trợ hệ điều hành ${d.platform}.</p>

                                    <div class="version-detail">
                                        <span>📦 ${d.fileSize}</span>
                                        <span>✓ ${d.version}</span>
                                    </div>

                                    <!-- Link tải trực tiếp từ Database -->
                                    <a href="${d.fileUrl}" class="download-button" target="_blank" download>
                                        ⬇ Tải về (${d.platform})
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="grid-column: 1/-1; text-align: center; color: #888; padding: 40px;">
                            Hiện tại chưa có link tải nào được cập nhật. Vui lòng quay lại sau!
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- =================================
              NÊN TẢI BẢN NÀO
        ================================== -->
        <section class="recommend-card">
            <div class="recommend-icon">💡</div>
            <div>
                <span>BẠN KHÔNG BIẾT NÊN TẢI BẢN NÀO?</span>
                <h2>Phiên bản nào phù hợp với bạn?</h2>
                <p>
                    Nếu bạn đang sử dụng máy tính, hãy chọn phiên bản PC Windows.
                    Nếu chơi trên điện thoại Android, hãy chọn bản APK.
                    Người dùng iPhone/iPad nên sử dụng phiên bản iOS TestFlight.
                </p>
            </div>
        </section>

        <!-- =================================
              HƯỚNG DẪN CÀI ĐẶT
        ================================== -->
        <section class="install-section">
            <div class="section-heading">
                <span>HƯỚNG DẪN</span>
                <h2>Hướng dẫn cài đặt</h2>
            </div>

            <div class="install-grid">
                <div class="install-card">
                    <div class="step-number">01</div>
                    <div>
                        <h3>Chọn phiên bản</h3>
                        <p>Chọn phiên bản game phù hợp với thiết bị của bạn.</p>
                    </div>
                </div>

                <div class="install-card">
                    <div class="step-number">02</div>
                    <div>
                        <h3>Tải game</h3>
                        <p>Nhấn nút tải xuống và chờ quá trình tải hoàn tất.</p>
                    </div>
                </div>

                <div class="install-card">
                    <div class="step-number">03</div>
                    <div>
                        <h3>Cài đặt</h3>
                        <p>Cài đặt game trên thiết bị và cấp quyền cần thiết.</p>
                    </div>
                </div>

                <div class="install-card">
                    <div class="step-number">04</div>
                    <div>
                        <h3>Đăng nhập</h3>
                        <p>Đăng nhập tài khoản và bắt đầu trải nghiệm.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- =================================
              HỖ TRỢ
        ================================== -->
        <section class="download-support">
            <div>🎧</div>
            <div>
                <strong>Gặp vấn đề khi tải game?</strong>
                <p>Hãy liên hệ với Admin hoặc truy cập fanpage cộng đồng để được giúp đỡ.</p>
            </div>
            <a href="${pageContext.request.contextPath}/event">Trung tâm tin tức →</a>
        </section>

    </main>

    <c:import url="./inc/chatbot.jsp" />
    <!-- FOOTER -->
    <jsp:include page="inc/footer.jsp" />

</body>
</html>
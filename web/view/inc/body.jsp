<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chú Bé Rồng Online</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/assest/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    </head>
        <body>
            <main class="main">


            <!-- ================= HERO ================= -->

            <section class="hero">

                <!-- HERO LEFT -->

                <div class="hero-content">

                    <span class="hero-label">
                        🔥 HỖ TRỢ NGỌC RỒNG
                    </span>


                    <h1>

                        Sống lại khí chất
                        <span>
                            chiến binh Saiyan
                        </span>

                    </h1>


                    <p>

                        Cùng tham gia Ngọc Rồng, nạp thẻ,
                        giftcode, bảng xếp hạng và tận hưởng
                        những trận chiến hấp dẫn.

                    </p>


                    <div class="hero-buttons">

                        <a href="nap-tien"
                           class="btn-primary">

                            Nạp thẻ vàng →

                        </a>


                        <a href="register"
                           class="btn-secondary">

                            Tạo tài khoản

                        </a>

                    </div>


                    <!-- STATS -->

                    <div class="hero-stats">

                        <div class="stat">

                            <strong>
                                24/7
                            </strong>

                            <span>
                                Portal online
                            </span>

                        </div>


                        <div class="stat">

                            <strong>
                                Top
                            </strong>

                            <span>
                                Xếp hạng game
                            </span>

                        </div>


                        <div class="stat">

                            <strong>
                                Auto
                            </strong>

                            <span>
                                Hệ thống nạp
                            </span>

                        </div>

                    </div>

                </div>



                <!-- HERO RIGHT -->

                <div class="hero-image">

                    <img src="${pageContext.request.contextPath}/assest/images/banner.png"
                         alt="Ngọc Rồng Online">


                    <div class="hero-info">

                        <div>
                            ⚡
                            <span>
                                Nhanh
                            </span>
                        </div>

                        <div>
                            🛡
                            <span>
                                An toàn
                            </span>
                        </div>

                        <div>
                            👥
                            <span>
                                Cộng đồng
                            </span>
                        </div>

                    </div>

                </div>

            </section>



            <!-- ================= FEATURES ================= -->

            <section class="features">


                <a href="nap-tien"
                   class="feature-card">

                    <div class="feature-icon orange">
                        💰
                    </div>

                    <h3>
                        Nạp thẻ vàng
                    </h3>

                    <p>
                        Nạp nhanh, trạng thái rõ ràng,
                        theo dõi lịch sử ngay trong tài khoản.
                    </p>

                    <span class="arrow">
                        →
                    </span>

                </a>



<!--                <a href="xep-hang.jsp"
                   class="feature-card">

                    <div class="feature-icon blue">
                        🏆
                    </div>

                    <h3>
                        Bảng xếp hạng
                    </h3>

                    <p>
                        Cập nhật top cao, thi đấu
                        và những thành tích đáng giá.
                    </p>

                    <span class="arrow">
                        →
                    </span>

                </a>-->



                <a href="download"
                   class="feature-card">

                    <div class="feature-icon green">
                        ⬇
                    </div>

                    <h3>
                        Tải game
                    </h3>

                    <p>
                        nhiều phiên bản mới và đẹp.
                    </p>

                    <span class="arrow">
                        →
                    </span>

                </a>



                <a href="event"
                   class="feature-card">

                    <div class="feature-icon red">
                        📰
                    </div>

                    <h3>
                        Tin tức
                    </h3>

                    <p>
                        Sự kiện, bảo trì,
                        cập nhật game mới nhất.
                    </p>

                    <span class="arrow">
                        →
                    </span>

                </a>


            </section>



            <!-- ================= NEWS ================= -->

            <section class="news-section">


                <div class="section-header">

                    <div>

                        <span>
                            TIN TỨC
                        </span>

                        <h2>
                            Tin tức mới nhất
                        </h2>

                    </div>


                    <a href="event"
                       class="view-more">

                        Xem tất cả →

                    </a>

                </div>


                <!-- NEWS LIST -->

                <div class="news-list">


                     <c:forEach var="event" items="${latestEvents}">

                        <div class="news-card">

                            <div class="news-image">

                                <img
                                    src="${pageContext.request.contextPath}/assest/images/${event.image}"
                                    alt="${event.title}">

                            </div>


                            <div class="news-content">

                                <span class="news-category">
                                    🎉 SỰ KIỆN
                                </span>

                                <h3>
                                    ${event.title}
                                </h3>

                                <p>
                                    ${event.content}
                                </p>

                                <a href="${pageContext.request.contextPath}/event-detail?id=${event.id}">
                                    Xem chi tiết →
                                </a>

                            </div>

                        </div>

                    </c:forEach>


                </div>


            </section>



            <!-- ================= REGISTER ================= -->

            <section class="register-section">

                <div>

                    <span>
                        ⭐ SẴN SÀNG NHẬP CUỘC
                    </span>

                    <h2>
                        Tạo tài khoản và bắt đầu hành trình ngay hôm nay.
                    </h2>

                    <p>
                        Một tài khoản cho đăng nhập,
                        nạp tiền, giftcode và cộng đồng.
                    </p>

                </div>


                <a href="register"
                   class="btn-primary">

                    Đăng ký ngay →

                </a>

            </section>


        </main>
    </body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Tin tức - HUNR</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assest/css/tin-tuc.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

</head>

<body>

    <!-- HEADER -->
    <jsp:include page="inc/header.jsp" />


    <!-- ================================
         TIN TỨC
    ================================= -->

    <main class="news-page">


        <!-- DANH SÁCH TIN -->

        <!-- ================= KHUNG SỰ KIỆN ================= -->

        <section class="events-box">

            <div class="events-header">
                <span>📰</span>

                <div>
                    <small>BẢN TIN MÁY CHỦ</small>
                    <h2>Các sự kiện mới nhất</h2>
                </div>
            </div>


            <div class="events-list">

                <c:forEach var="event" items="${latestEvents}">

                    <article class="event-item">

                        <!-- ẢNH -->
                        <div class="event-image">
                            <a href="${pageContext.request.contextPath}/event-detail?id=${event.id}">
                                <img
                                    src="${pageContext.request.contextPath}/assest/images/${event.image}"
                                    alt="${event.title}">
                            </a>
                        </div>


                        <!-- NỘI DUNG -->
                        <div class="event-content">

                            <span class="event-category">
                                🎉 SỰ KIỆN
                            </span>
                            
                            <a href="${pageContext.request.contextPath}/event?id=${event.id}">
                                <h3>
                                    ${event.title}
                                </h3>
                            </a>
                            
                            <p>
                                ${event.content}
                            </p>

                            <a href="${pageContext.request.contextPath}/event-detail?id=${event.id}">
                                Đọc tiếp →
                            </a>

                        </div>

                    </article>

                </c:forEach>

            </div>

        </section>


        <!-- ================= COMMENT ================= -->

        <section class="comments-box">

            <div class="comments-header">

                <span>💬</span>

                <div>
                    <small>CỘNG ĐỒNG</small>
                </div>

            </div>


            <div class="comment-list">

                <c:forEach var="comment" items="${latestComments}">

                    <a href="${pageContext.request.contextPath}/event-detail?id=${comment.id}"
                       class="comment-link">
                        <div class="comment-item">

                            <div class="comment-avatar">

                                <c:choose>

                                    <c:when test="${not empty comment.image}">

                                        <img
                                            src="${pageContext.request.contextPath}/assest/images/${comment.image}"
                                            alt="${comment.authorName}">

                                    </c:when>

                                    <c:otherwise>
                                        👤 
                                    </c:otherwise>

                                </c:choose>

                            </div>


                            <div class="comment-content">

                                <div class="comment-user">

                                    <strong>
                                        ${comment.authorName}
                                    </strong>

                                    <span class="comment-time">
                                        ${comment.timeAgo}
                                    </span>

                                </div>


                                <h4>
                                    ${comment.title}
                                </h4>


                                <p>
                                    ${comment.content}
                                </p>

                            </div>

                        </div>
                    </a>
                               

                </c:forEach>

            </div>

            <!-- Ô NHẬP COMMENT -->

            <!-- NÚT BẤM MỞ FORM (Mặc định hiển thị) -->
            <div style="margin: 20px 0;">
                <button type="button" id="btnOpenEventForm" onclick="showEventForm()" 
                        style="padding: 10px 20px; background-color: #ff8c00; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; font-size: 14px;">
                    ✍️ trao đổi
                </button>
            </div>

            <!-- KHUNG FORM NHẬP LIỆU (Mặc định bị ẩn display: none) -->
            <div id="eventFormWrapper" style="display: none; background: #23201d; padding: 20px; border-radius: 8px; border: 1px solid #ff8c00; margin-bottom: 25px;">
                <h3 style="color: #ff8c00; margin-top: 0;"> Bài đăng mới</h3>

                <form action="${pageContext.request.contextPath}/event" method="post">
                    <!-- Ô nhập Tiêu đề -->
                    <div style="margin-bottom: 12px;">
                        <label style="color: #fff; display: block; margin-bottom: 5px; font-size: 14px;">Tiêu đề:</label>
                        <input type="text" name="title" placeholder="Nhập tiêu đề bài đăng..." required 
                               style="width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #555; background: #1a1816; color: #fff; box-sizing: border-box;">
                    </div>

                    <!-- Ô nhập Nội dung -->
                    <div style="margin-bottom: 15px;">
                        <label style="color: #fff; display: block; margin-bottom: 5px; font-size: 14px;">Nội dung bài đăng:</label>
                        <textarea name="content" rows="4" placeholder="Nhập nội dung chi tiết bài đăng..." required 
                                  style="width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #555; background: #1a1816; color: #fff; box-sizing: border-box;"></textarea>
                    </div>

                    <!-- Cụm nút bấm Gửi & Hủy -->
                    <div style="display: flex; gap: 10px;">
                        <button type="submit" 
                                style="padding: 10px 22px; background-color: #ff8c00; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold;">
                            Đăng bài
                        </button>
                        <button type="button" onclick="hideEventForm()" 
                                style="padding: 10px 18px; background-color: #555; color: white; border: none; border-radius: 6px; cursor: pointer;">
                            Hủy bỏ
                        </button>
                    </div>
                </form>
            </div>

        </section>

    </main>


    <c:import url="./inc/chatbot.jsp" />
    <!-- FOOTER -->

    <jsp:include page="inc/footer.jsp" />

</body>
    <script>
        function showEventForm() {
            document.getElementById('eventFormWrapper').style.display = 'block';
            document.getElementById('btnOpenEventForm').style.display = 'none';
        }

        function hideEventForm() {
            document.getElementById('eventFormWrapper').style.display = 'none';
            document.getElementById('btnOpenEventForm').style.display = 'inline-block';
        }
    </script>
</html>
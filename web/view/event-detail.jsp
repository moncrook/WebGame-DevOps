<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${event.title} - Chi tiết</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assest/css/style.css">
    <style>
        .detail-container {
            max-width: 850px;
            margin: 35px auto;
            background: #23201d;
            border-radius: 8px;
            padding: 30px;
            color: #fff;
            border: 1px solid rgba(255, 140, 0, 0.3);
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
        }
        .badge-type {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 12px;
            text-transform: uppercase;
        }
        .badge-event { background: #ff8c00; color: #fff; }
        .badge-comment { background: #00bcd4; color: #fff; }
        
        .detail-title {
            color: #ff8c00;
            font-size: 24px;
            margin: 0 0 12px 0;
            line-height: 1.4;
        }
        .detail-meta {
            color: #aaa;
            font-size: 13px;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #3a3633;
            display: flex;
            gap: 20px;
            align-items: center;
        }
        .detail-summary {
            background: rgba(255, 140, 0, 0.08);
            border-left: 4px solid #ff8c00;
            padding: 12px 15px;
            font-style: italic;
            color: #ddd;
            margin-bottom: 20px;
            border-radius: 0 6px 6px 0;
        }
        .detail-image { text-align: center; margin: 20px 0; }
        .detail-image img { max-width: 100%; border-radius: 8px; border: 1px solid #444; }
        .detail-body { line-height: 1.8; font-size: 15px; white-space: pre-line; color: #ececec; }

        /* KHU VỰC BÌNH LUẬN */
        .comments-section {
            margin-top: 40px;
            border-top: 1px solid #3a3633;
            padding-top: 25px;
        }
        .comments-section h3 {
            color: #ff8c00;
            margin-bottom: 20px;
            font-size: 18px;
        }
        .comment-item {
            background: #1a1816;
            padding: 14px 18px;
            border-radius: 6px;
            border-left: 3px solid #ff8c00;
            margin-bottom: 15px;
        }
        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 6px;
            font-size: 13px;
        }
        .comment-author { color: #ff8c00; font-weight: bold; }
        .comment-time { color: #888; }
        .comment-text { font-size: 14px; color: #ddd; line-height: 1.5; }

        .comment-form textarea {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #444;
            background: #1a1816;
            color: #fff;
            box-sizing: border-box;
            resize: vertical;
        }
        .btn-comment {
            padding: 8px 18px;
            background: #ff8c00;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 8px;
        }
        .back-btn {
            display: inline-block;
            margin-top: 25px;
            padding: 8px 18px;
            background: #333;
            color: #ff8c00;
            text-decoration: none;
            border-radius: 5px;
            border: 1px solid #ff8c00;
            font-weight: bold;
        }
        .back-btn:hover { background: #ff8c00; color: #fff; }
    </style>
</head>
<body>

    <!-- HEADER -->
    <jsp:include page="inc/header.jsp" />

    <main>
        <div class="detail-container">
            
            <!-- NHÃN PHÂN LOẠI -->
            <c:choose>
                <c:when test="${event.loai.trim().equalsIgnoreCase('EVENT')}">
                    <span class="badge-type badge-event">🎉 SỰ KIỆN MÁY CHỦ</span>
                </c:when>
                <c:otherwise>
                    <span class="badge-type badge-comment">💬 BÌNH LUẬN CỘNG ĐỒNG</span>
                </c:otherwise>
            </c:choose>

            <!-- TIÊU ĐỀ -->
            <h1 class="detail-title">${event.title}</h1>

            <!-- THÔNG TIN NGƯỜI ĐĂNG & THỜI GIAN -->
            <div class="detail-meta">
                <span>👤 Người đăng: <strong style="color: #ff8c00;">${empty event.authorName ? 'Ban Quản Trị' : event.authorName}</strong></span>
                <span>🕒 <strong>${event.timeAgo}</strong> (<fmt:formatDate value="${event.createdAt}" pattern="dd/MM/yyyy HH:mm"/>)</span>
            </div>

            <!-- NỘI DUNG SỰ KIỆN (EVENT) -->
            <c:if test="${event.loai.trim().equalsIgnoreCase('EVENT')}">
                <c:if test="${not empty event.content}">
                    <div class="detail-summary">
                        <strong>Tóm tắt:</strong> ${event.content}
                    </div>
                </c:if>

                <c:if test="${not empty event.image}">
                    <div class="detail-image">
                        <img src="${pageContext.request.contextPath}/assets/images/${event.image}" 
                             alt="${event.title}" 
                             onerror="this.style.display='none'">
                    </div>
                </c:if>

                <div class="detail-body">
                    ${not empty event.description ? event.description : event.content}
                </div>
            </c:if>

            <!-- NỘI DUNG BÌNH LUẬN (COMMENT) -->
            <c:if test="${not event.loai.trim().equalsIgnoreCase('EVENT')}">
                <div class="detail-body">
                    ${event.content}
                </div>
            </c:if>

            <!-- ================= PHẦN BÌNH LUẬN DƯỚI BÀI VIẾT ================= -->
            <section class="comments-section">
                <h3>💬 Bình luận (${comments.size()})</h3>

                <!-- Danh sách bình luận đã có -->
                <c:choose>
                    <c:when test="${not empty comments}">
                        <c:forEach var="c" items="${comments}">
                            <div class="comment-item">
                                <div class="comment-header">
                                    <span class="comment-author">👤 ${c.userName}</span>
                                    <span class="comment-time">🕒 ${c.timeAgo} (<fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy HH:mm"/>)</span>
                                </div>
                                <div class="comment-text">${c.content}</div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p style="color: #888; font-style: italic;">Chưa có bình luận nào. Hãy là người đầu tiên để lại ý kiến!</p>
                    </c:otherwise>
                </c:choose>

                <!-- Khung nhập bình luận -->
                <div style="margin-top: 25px;">
                    <c:if test="${not empty sessionScope.user}">
                        <form action="${pageContext.request.contextPath}/event" method="post" class="comment-form">
                            <input type="hidden" name="event_id" value="${event.id}">
                            <textarea name="content" rows="3" placeholder="Viết bình luận của bạn..." required></textarea>
                            <button type="submit" class="btn-comment">Gửi bình luận</button>
                        </form>
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        <p style="color: #aaa; font-style: italic;">
                            Vui lòng <a href="${pageContext.request.contextPath}/login" style="color: #ff8c00;">đăng nhập</a> để tham gia bình luận.
                        </p>
                    </c:if>
                </div>
            </section>

            <!-- NÚT QUAY LẠI -->
            <div>
                <a href="${pageContext.request.contextPath}/event" class="back-btn">← Quay lại tin tức</a>
            </div>

        </div>
    </main>

    <!-- FOOTER -->
    <jsp:include page="inc/footer.jsp" />

</body>
</html>
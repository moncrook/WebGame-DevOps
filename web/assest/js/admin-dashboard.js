document.addEventListener("DOMContentLoaded", function () {
    // Hiệu ứng hover hoặc các tương tác bổ trợ cho bảng thống kê dashboard
    const statCards = document.querySelectorAll(".stat-card");
    statCards.forEach((card) => {
        card.addEventListener("mouseenter", function () {
            this.style.transition = "transform 0.2s ease, box-shadow 0.2s ease";
        });
    });
});
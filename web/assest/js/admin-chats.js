document.addEventListener("DOMContentLoaded", function () {
    // Tự động cuộn xuống cuối cùng của đoạn chat khi mở
    const chatBox = document.getElementById("adminChatContent");
    if (chatBox) {
        chatBox.scrollTop = chatBox.scrollHeight;
    }
});
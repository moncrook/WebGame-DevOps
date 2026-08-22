<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- Nút Tròn Mở Chatbot -->
<div id="cb_toggle_btn" onclick="cb_toggleWindow()">
    <i class="fa-solid fa-comments"></i>
</div>

<!-- Cửa Sổ Khung Chat -->
<div id="cb_chat_window" style="display: none;">
    <div class="cb-header">
        <div class="cb-header-info">
            <i class="fa-solid fa-headset" style="color: #ff8c00; font-size: 18px;"></i>
            <div>
                <strong>Hỗ Trợ Trực Tuyến</strong>
                <small><i class="fa-solid fa-circle" style="color: #28a745; font-size: 8px;"></i> Trợ lý FAQ & Admin</small>
            </div>
        </div>
        
        <div style="display: flex; align-items: center; gap: 10px;">
            <button type="button" class="cb-icon-btn" onclick="cb_clearChatHistory()" title="Xóa lịch sử chat với Admin">
                <i class="fa-solid fa-trash-can"></i>
            </button>
            <button type="button" class="cb-close-btn" onclick="cb_toggleWindow()" title="Đóng">✕</button>
        </div>
    </div>

    <!-- Vùng Tin Nhắn -->
    <div class="cb-body" id="cb_chatMessages">
        <div class="cb-msg cb-admin-msg">
            <div class="cb-bubble">
                Xin chào <b>${not empty sessionScope.user ? sessionScope.user.name : 'bạn'}</b>! Hãy bấm câu hỏi gợi ý bên dưới để xem hướng dẫn ngay hoặc nhắn tin để gặp Admin nhé!
            </div>
        </div>
    </div>

    <!-- Thanh Câu Hỏi Nhanh (FAQ Quick Buttons - Không lưu CSDL) -->
    <div class="cb-quick-faq">
        <button type="button" onclick="cb_askLocalFAQ('naptien')">💰 Nạp tiền</button>
        <button type="button" onclick="cb_askLocalFAQ('taigame')">🎮 Tải game</button>
        <button type="button" onclick="cb_askLocalFAQ('sukien')">🎁 Sự kiện</button>
        <button type="button" onclick="cb_askLocalFAQ('quenpass')">🔑 Quên mật khẩu</button>
    </div>

    <!-- Ô Nhập Tin Nhắn Gửi Admin -->
    <form class="cb-footer" onsubmit="cb_handleFormSubmit(event)">
        <input type="text" id="cb_chatInput" placeholder="${not empty sessionScope.user ? 'Nhập tin nhắn gửi Admin...' : 'Đăng nhập để chat...'}" 
               ${empty sessionScope.user ? 'disabled' : ''} autocomplete="off" required>
        <button type="submit" id="cb_sendBtn" ${empty sessionScope.user ? 'disabled' : ''}>
            <i class="fa-solid fa-paper-plane"></i>
        </button>
    </form>
</div>

<style>
    #cb_toggle_btn {
        position: fixed; bottom: 25px; right: 25px; width: 52px; height: 52px;
        border-radius: 50%; background: #ff8c00; color: #fff; display: flex;
        align-items: center; justify-content: center; font-size: 22px; cursor: pointer;
        box-shadow: 0 4px 15px rgba(255, 140, 0, 0.4); z-index: 1000; transition: transform 0.2s;
    }
    #cb_toggle_btn:hover { transform: scale(1.08); }

    #cb_chat_window {
        position: fixed; bottom: 85px; right: 25px; width: 340px; height: 460px;
        background: #23201d; border: 1px solid #ff8c00; border-radius: 12px;
        display: none; flex-direction: column; overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.6); z-index: 1001;
    }
    .cb-header { background: #2a2724; padding: 10px 14px; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid #333; }
    .cb-header-info { display: flex; align-items: center; gap: 8px; color: #fff; font-size: 13px; }
    .cb-header-info small { display: block; color: #aaa; font-size: 10px; }
    
    .cb-icon-btn { background: none; border: none; color: #aaa; font-size: 14px; cursor: pointer; transition: color 0.2s; }
    .cb-icon-btn:hover { color: #dc3545; }
    .cb-close-btn { background: none; border: none; color: #aaa; font-size: 16px; cursor: pointer; }
    .cb-close-btn:hover { color: #fff; }
    
    .cb-body { flex: 1; padding: 12px; overflow-y: auto; display: flex; flex-direction: column; gap: 8px; background: #1a1816; }
    .cb-msg { display: flex; width: 100%; }
    .cb-admin-msg { justify-content: flex-start; }
    .cb-user-msg { justify-content: flex-end; }
    .cb-bubble { max-width: 82%; padding: 8px 12px; border-radius: 8px; font-size: 13px; line-height: 1.4; word-break: break-word; }
    .cb-admin-msg .cb-bubble { background: #2a2724; color: #eee; border-left: 3px solid #ff8c00; }
    .cb-user-msg .cb-bubble { background: #ff8c00; color: #fff; border-radius: 8px 8px 0 8px; }
    .cb-bot-tag { font-size: 10px; background: #3a352f; color: #0dcaf0; padding: 2px 5px; border-radius: 3px; margin-bottom: 4px; display: inline-block; font-weight: bold; }
    
    .cb-quick-faq {
        padding: 6px 10px;
        background: #1f1c19;
        display: flex;
        gap: 6px;
        overflow-x: auto;
        border-top: 1px solid #2d2925;
        white-space: nowrap;
    }
    .cb-quick-faq::-webkit-scrollbar { height: 3px; }
    .cb-quick-faq::-webkit-scrollbar-thumb { background: #444; border-radius: 3px; }
    .cb-quick-faq button {
        background: #2a2724;
        border: 1px solid #444;
        color: #ff8c00;
        font-size: 11px;
        padding: 4px 8px;
        border-radius: 12px;
        cursor: pointer;
        transition: 0.2s;
    }
    .cb-quick-faq button:hover {
        background: #ff8c00;
        color: #fff;
    }

    .cb-footer { padding: 10px; background: #23201d; display: flex; gap: 6px; border-top: 1px solid #333; }
    .cb-footer input { flex: 1; background: #1a1816; border: 1px solid #444; padding: 8px 10px; border-radius: 6px; color: #fff; font-size: 13px; outline: none; }
    .cb-footer button { background: #ff8c00; color: #fff; border: none; padding: 8px 12px; border-radius: 6px; cursor: pointer; }
    .cb-footer button:disabled { background: #555; cursor: not-allowed; }
</style>

<script>
    (function() {
        let cb_pollInterval = null;
        const cb_isLoggedIn = ${not empty sessionScope.user ? 'true' : 'false'};

        // Danh sách câu hỏi và câu trả lời tự động (Cục bộ, không lưu CSDL)
        const FAQ_DATA = {
            naptien: {
                question: "Cách nạp tiền và nhận vàng?",
                answer: "📌 Bạn vào mục <b>Nạp tiền</b> trên menu, chọn số tiền rồi quét mã QR MBBank hoặc nhập thẻ cào. Hệ thống sẽ duyệt sau 1-3 phút!"
            },
            taigame: {
                question: "Link tải game ở đâu?",
                answer: "🎮 Bản cài đặt PC (Windows) và Android (APK) đã có sẵn tại mục <b>Tải Game</b> trên thanh menu."
            },
            sukien: {
                question: "Sự kiện và Giftcode mới nhất?",
                answer: "🎁 Mọi thông tin x2 kinh nghiệm, quà tân thủ được đăng đầy đủ tại mục <b>Tin tức</b>."
            },
            quenpass: {
                question: "Tôi muốn đổi hoặc lấy lại mật khẩu",
                answer: "🔑 Bạn hãy gõ tên tài khoản (@username) vào khung chat này để gửi cho Admin kiểm tra và cấp lại nhé."
            }
        };

        window.cb_toggleWindow = function() {
            let win = document.getElementById('cb_chat_window');
            if (win.style.display === 'flex') {
                win.style.display = 'none';
                if (cb_pollInterval) clearInterval(cb_pollInterval);
            } else {
                win.style.display = 'flex';
                if (cb_isLoggedIn) {
                    cb_loadData();
                    cb_pollInterval = setInterval(cb_loadData, 3000);
                    document.getElementById('cb_chatInput').focus();
                }
            }
        };

        // Tải lịch sử chat thực từ Database
        window.cb_loadData = function() {
            fetch('${pageContext.request.contextPath}/chat-api')
                .then(res => res.json())
                .then(data => {
                    let container = document.getElementById('cb_chatMessages');
                    
                    // Giữ lại các tin nhắn FAQ tạm thời nếu đang mở
                    let localFaqs = container.querySelectorAll('.cb-local-temp');
                    
                    container.innerHTML = '';
                    
                    let welcome = document.createElement('div');
                    welcome.className = 'cb-msg cb-admin-msg';
                    welcome.innerHTML = '<div class="cb-bubble">Xin chào <b>${not empty sessionScope.user ? sessionScope.user.name : "bạn"}</b>! Hãy bấm câu hỏi gợi ý bên dưới để xem hướng dẫn ngay hoặc nhắn tin để gặp Admin nhé!</div>';
                    container.appendChild(welcome);

                    // Render tin nhắn thực từ Database
                    data.forEach(m => {
                        let div = document.createElement('div');
                        div.className = (m.senderType === 'ADMIN') ? 'cb-msg cb-admin-msg' : 'cb-msg cb-user-msg';
                        div.innerHTML = '<div class="cb-bubble">' + (m.senderType === 'ADMIN' ? '🛡️ <b>Admin:</b> ' : '') + cb_escape(m.message) + '</div>';
                        container.appendChild(div);
                    });

                    // Nối lại các tin tạm thời
                    localFaqs.forEach(node => container.appendChild(node));

                    container.scrollTop = container.scrollHeight;
                })
                .catch(() => {});
        };

        // Bấm câu hỏi gợi ý: Hiển thị ngay lên màn hình, KHÔNG gửi request lưu CSDL
        window.cb_askLocalFAQ = function(key) {
            let faq = FAQ_DATA[key];
            if (!faq) return;

            let container = document.getElementById('cb_chatMessages');

            // 1. Bong bóng User hỏi (Tạm thời)
            let userDiv = document.createElement('div');
            userDiv.className = 'cb-msg cb-user-msg cb-local-temp';
            userDiv.innerHTML = '<div class="cb-bubble">' + faq.question + '</div>';
            container.appendChild(userDiv);

            // 2. Bong bóng Bot trả lời tự động (Tạm thời)
            setTimeout(function() {
                let botDiv = document.createElement('div');
                botDiv.className = 'cb-msg cb-admin-msg cb-local-temp';
                botDiv.innerHTML = '<div class="cb-bubble"><span class="cb-bot-tag">🤖 Trợ lý tự động</span><br>' + faq.answer + '</div>';
                container.appendChild(botDiv);
                container.scrollTop = container.scrollHeight;
            }, 300);

            container.scrollTop = container.scrollHeight;
        };

        // Người dùng tự gõ tin nhắn: Gửi lên Server lưu vào CSDL cho Admin trả lời
        window.cb_handleFormSubmit = function(e) {
            e.preventDefault();
            let input = document.getElementById('cb_chatInput');
            let text = input.value.trim();
            if (!text) return;

            fetch('${pageContext.request.contextPath}/chat-api', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                body: 'message=' + encodeURIComponent(text)
            }).then(res => res.json())
              .then(data => {
                  if (data.status === 'success') {
                      input.value = '';
                      cb_loadData();
                  }
              });
        };

        window.cb_clearChatHistory = function() {
            if (!cb_isLoggedIn) return;
            if (confirm('Bạn có chắc chắn muốn xóa toàn bộ lịch sử chat với Admin không?')) {
                fetch('${pageContext.request.contextPath}/chat-api', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                    body: 'action=delete'
                }).then(res => res.json())
                  .then(data => {
                      if (data.status === 'deleted') {
                          cb_loadData();
                      }
                  });
            }
        };

        function cb_escape(text) {
            return text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
        }
    })();
</script>
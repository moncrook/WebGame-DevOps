/**
 * Mở modal điều chỉnh số dư vàng
 */
function openBalanceModal(id, name, balance) {
    document.getElementById('bal_user_id').value = id;
    document.getElementById('bal_user_name').value = name + ' (Hiện có: ' + new Intl.NumberFormat('vi-VN').format(balance) + 'đ)';
    const modal = document.getElementById('balanceModal');
    if (modal) modal.style.display = 'flex';
}

/**
 * Mở modal reset mật khẩu
 */
function openPassModal(id, name) {
    document.getElementById('pass_user_id').value = id;
    document.getElementById('pass_user_name').value = name;
    const modal = document.getElementById('passModal');
    if (modal) modal.style.display = 'flex';
}

/**
 * Đóng modal theo ID
 */
function closeModal(id) {
    const modal = document.getElementById(id);
    if (modal) modal.style.display = 'none';
}

/**
 * Tự động đóng modal khi click ra ngoài
 */
window.onclick = function(event) {
    const balanceModal = document.getElementById('balanceModal');
    const passModal = document.getElementById('passModal');
    
    if (event.target === balanceModal) closeModal('balanceModal');
    if (event.target === passModal) closeModal('passModal');
};
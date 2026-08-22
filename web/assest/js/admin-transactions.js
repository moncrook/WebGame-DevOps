/**
 * Xác nhận duyệt đơn nạp tiền
 */
function confirmApprove(txId) {
    return confirm("Duyệt đơn nạp #" + txId + " và cộng tiền cho người chơi?");
}

/**
 * Xác nhận từ chối đơn nạp tiền
 */
function confirmReject(txId) {
    return confirm("Bạn có chắc muốn từ chối đơn nạp #" + txId + "?");
}
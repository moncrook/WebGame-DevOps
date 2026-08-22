/**
 * Mở modal Thêm sự kiện mới
 */
function openCreateEventModal() {
    const modal = document.getElementById('createEventModal');
    if (modal) modal.style.display = 'flex';
}

/**
 * Mở modal Sửa sự kiện và điền dữ liệu tương ứng từ nút bấm
 */
function openEditEventModal(btn) {
    document.getElementById('edit_id').value = btn.getAttribute('data-id') || '';
    document.getElementById('edit_title').value = btn.getAttribute('data-title') || '';
    document.getElementById('edit_content').value = btn.getAttribute('data-content') || '';
    document.getElementById('edit_description').value = btn.getAttribute('data-description') || '';
    
    const imgName = btn.getAttribute('data-image');
    document.getElementById('edit_old_image').value = imgName ? imgName : '';
    document.getElementById('current_image_hint').innerText = imgName ? ('Ảnh hiện tại: ' + imgName) : 'Chưa có ảnh đại diện';

    const modal = document.getElementById('editEventModal');
    if (modal) modal.style.display = 'flex';
}

/**
 * Đóng modal popup theo ID
 */
function closeModal(id) {
    const modal = document.getElementById(id);
    if (modal) modal.style.display = 'none';
}

/**
 * Tự động đóng modal khi click ra ngoài vùng xám
 */
window.onclick = function(event) {
    const createModal = document.getElementById('createEventModal');
    const editModal = document.getElementById('editEventModal');
    
    if (event.target === createModal) closeModal('createEventModal');
    if (event.target === editModal) closeModal('editEventModal');
};
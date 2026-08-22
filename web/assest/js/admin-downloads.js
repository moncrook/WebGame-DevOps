/**
 * Mở modal Thêm bản cài
 */
function openAddModal() {
    const modal = document.getElementById('addModal');
    if (modal) modal.style.display = 'flex';
}

/**
 * Mở modal Sửa và truyền dữ liệu tương ứng từ nút bấm
 */
function openEditModal(btn) {
    document.getElementById('edit_id').value = btn.getAttribute('data-id') || '';
    document.getElementById('edit_platform').value = btn.getAttribute('data-platform') || '';
    document.getElementById('edit_version').value = btn.getAttribute('data-version') || '';
    document.getElementById('edit_size').value = btn.getAttribute('data-size') || '';
    document.getElementById('edit_url').value = btn.getAttribute('data-url') || '';
    
    const modal = document.getElementById('editModal');
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
 * Đóng khi click ra ngoài vùng modal
 */
window.onclick = function(event) {
    const addModal = document.getElementById('addModal');
    const editModal = document.getElementById('editModal');
    
    if (event.target === addModal) closeModal('addModal');
    if (event.target === editModal) closeModal('editModal');
};
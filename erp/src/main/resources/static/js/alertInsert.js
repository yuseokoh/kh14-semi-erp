
function showAlert() {
    Swal.fire({
        title: '<span class="custom-title">등록완료</span>',
        text: '', 
        icon: 'success',
        customClass: {
            title: 'custom-title',
            popup: 'custom-background',
            confirmButton: 'custom-button' 
        }
    });
}
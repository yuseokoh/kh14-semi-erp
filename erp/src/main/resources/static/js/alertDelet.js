/* 삭제 버튼용 JS */
function showDeleteConfirmation() {
    Swal.fire({
        title: '삭제 하시겠습니까?',
        text: '정말로?',
        icon: 'warning',
        showCancelButton: true, // "Cancel" 버튼 표시
        confirmButtonColor: '#3085d6', // "Confirm" 버튼 색상
        cancelButtonColor: '#d33', // "Cancel" 버튼 색상
        confirmButtonText: '네, 삭제하겠습니다!',
        cancelButtonText: '아니요!'
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire(
                'Deleted!',
                '',
                'success'
            );
        } else {
            Swal.fire(
                'Cancelled',
                '',
                'error'
            );
        }
    });
}
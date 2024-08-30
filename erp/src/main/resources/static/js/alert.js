
function showAlert() {
    Swal.fire({
        title: '<span class="custom-title">기안완료</span>',
        text: '결재대기중',  // 속성 이름 수정
        icon: 'success',
        customClass: {
            title: 'custom-title',
            popup: 'custom-background',
            confirmButton: 'custom-button' // "확인" 버튼 스타일 적용
        }
    });
}
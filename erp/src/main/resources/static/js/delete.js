$(document).ready(function() {
    // 삭제 버튼 클릭 이벤트
    $('.delete').on('click', function() {
        // 확인 대화상자 표시
        var confirmDelete = confirm("삭제하시겠습니까?");
        if (confirmDelete) {
            alert("삭제되었습니다.");
        } else {
            alert("삭제가 취소되었습니다.");
        }
    });
});
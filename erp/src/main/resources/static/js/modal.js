/*
모달
 */
$(document).ready(function() {
    // 모달 열기
    $('#openModal').click(function() {
        $('#myModal').show();
    });

     // 닫기 버튼 클릭 시 모달 닫기
         $('.close').click(function() {
    $('#myModal').hide();
});

// 모달 외부 클릭 시 닫기 방지
$(window).click(function(event) {
    // 외부 클릭 시 모달이 닫히지 않도록 주석 처리
    // if ($(event.target).is('#myModal')) {
    //     $('#myModal').hide();
    // }
});

    // 폼 제출 시 모달 닫히지 않도록 방지
    $('.modal-content').click(function(event) {
        event.stopPropagation();
    });
});
/*
사이드바 & 메뉴토글 JS
*/

$(document).ready(function() {
    $('#menuToggle').on('click', function() {
        var $sidebar = $('#sidebar');
        var $body = $('#body');
        var isOpened = $sidebar.hasClass('opened');
        
        if (isOpened) {
            // 사이드바가 열려 있는 상태에서 닫는 경우
            $sidebar.removeClass('opened');
            $body.css({
                'width': '82%', // 0823 이곳을 조정해서 사이드바 정상화완료
                'padding-left': '0',
                'transition': 'width 0.3s ease, padding-left 0.3s ease'
            });
        } else {
            // 사이드바가 닫혀 있는 상태에서 여는 경우
            $sidebar.addClass('opened');
            $body.css({
                'width': 'calc(100% - 300px)',
                'padding-left': '320px',
                'transition': 'width 0.3s ease, padding-left 0.3s ease'
            });
        }
    });
});

/*
사이드바 & 메뉴토글 JS
*/

$(document).ready(function() {
    $('#menuToggle').on('click', function() {
        var $sidebar = $('#sidebar');
        var $body = $('#body');
        var isOpened = $sidebar.hasClass('opened');
        
        if (isOpened) {
            $sidebar.removeClass('opened');
            $body.css('width', '100%');
            $body.css('padding-left', 0);
        } else {
            $sidebar.addClass('opened');
            $body.css('width', 'calc(100% - 300px)');
            $body.css('padding-left', '320px');
        }
    });
});
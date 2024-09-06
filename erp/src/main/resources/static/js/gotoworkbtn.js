$(function() {
    // 페이지 로드 시 출퇴근 상태를 서버에서 가져오기
    $.ajax({
        url: '/rest/attendance/check', // 서버의 엔드포인트 URL
        type: 'POST',
        success: function(response) {
            

            var loginId = response.loginId;
            var checkInTime = response.checkInTime;
            var checkOutTime = response.checkOutTime;


            // 출근 및 퇴근 버튼 상태 업데이트
            if (checkInTime) {
                // 이미 출근한 경우
                $('#start-btn').removeClass('on').addClass('off').text('출근 완료');
                $('#end-btn').prop('disabled', false).removeClass('off').addClass('on'); // 퇴근 버튼 활성화
                $('#start-time-display').text(new Date(checkInTime).toLocaleTimeString()); // 출근 시간 표시
            } else {
                // 출근하지 않은 경우
                $('#start-btn').removeClass('off').addClass('on').text('출근');
                $('#end-btn').prop('disabled', true).removeClass('on').addClass('off'); // 퇴근 버튼 비활성화
            }

            if (checkOutTime) {
                // 이미 퇴근한 경우
                $('#end-btn').removeClass('on').addClass('off').text('퇴근 완료');
                $('#end-time-display').text(new Date(checkOutTime).toLocaleTimeString()); // 퇴근 시간 표시
            }
        },
    });

    // 현재 날짜 및 시간 업데이트 함수
    function updateDateTime() {
        const now = new Date();
        $('#cur-date').text(now.toLocaleDateString());
        $('#cur-time').text(now.toLocaleTimeString());
    }

    // 출근 버튼 클릭 핸들러
    $('#start-btn').click(function() {
        const $this = $(this);
        if ($this.hasClass('on')) {
            if (confirm('출근하시겠습니까?')) {
                $this.removeClass('on').addClass('off').text('출근 완료');
                $('#end-btn').prop('disabled', false).removeClass('off').addClass('on'); // 퇴근 버튼 활성화
                // 출근 시간을 서버로 전송
                $.ajax({
                    url: '/rest/attendance/start', // 서버의 API URL
                    type: 'POST',
                    success: function(response) {
                        $('#start-time-display').text(response);
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                    }
                });
            }
        } else if ($this.hasClass('off')) {
            alert('이미 출근 완료 상태입니다.');
        }
    });

    // 퇴근 버튼 클릭 핸들러
    $('#end-btn').click(function() {
        const $this = $(this);
        if ($this.hasClass('on')) {
            if (confirm('퇴근하시겠습니까?')) {
                $this.removeClass('on').addClass('off').text('퇴근 완료');
                // 퇴근 시간을 서버로 전송
                $.ajax({
                    url: '/rest/attendance/end', // 서버의 API URL
                    type: 'POST',
                    success: function(response) {
                        $('#end-time-display').text(response);
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                    }
                });
                $('#end-btn').prop('disabled', true); // 퇴근 버튼 비활성화
            }
        } else if ($this.hasClass('off')) {
            alert('이미 퇴근 완료 상태입니다.');
        }
    });

    // 초기 날짜 및 시간 업데이트
    updateDateTime();
    setInterval(updateDateTime, 1000);

    // 페이지 로드 시 퇴근 버튼 비활성화
    $('#end-btn').prop('disabled', true).removeClass('on').addClass('off');
});

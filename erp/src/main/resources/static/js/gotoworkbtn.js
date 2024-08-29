$(function() {
    // 현재 날짜 및 시간 업데이트 함수
    function updateDateTime() {
        const now = new Date();
        // 한국 표준시로 변환
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
                        console.log('출근 시간 기록 성공:', response);
                        $('#start-time-display').text(response);
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('출근 시간 기록 실패:', textStatus, errorThrown);
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
                // 퇴근 버튼 상태에 따라 동작
                $this.removeClass('on').addClass('off').text('퇴근 완료');

                // 퇴근 시간을 서버로 전송
                $.ajax({
                    url: '/rest/attendance/end', // 서버의 API URL
                    type: 'POST',
                    success: function(response) {
                        console.log('퇴근 시간 기록 성공:', response);
                        $('#end-time-display').text(response);
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('퇴근 시간 기록 실패:', textStatus, errorThrown);
                    }
                });

                // 출근 버튼을 다시 '출근' 상태로 리셋
                $('#start-btn').removeClass('off').addClass('on').text('출근');
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

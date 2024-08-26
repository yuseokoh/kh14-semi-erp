/* 
출퇴근 버튼 JS
*/

$(function() {
    // 현재 날짜 및 시간 업데이트 함수
    function updateDateTime() {
        const now = new Date();
        // 한국 표준시로 변환
        const offset = 9 * 60; // 한국 표준시는 UTC+9
        const localTime = new Date(now.getTime() + (offset * 60 * 1000));
        $('#cur-date').text(now.toLocaleDateString());
        $('#cur-time').text(now.toLocaleTimeString());
    }

    // 출근 버튼 클릭 핸들러
    $('#start-btn').click(
            function() {
                if (confirm('출근하시겠습니까?')) {
                    const now = new Date();
                    const offset = 9 * 60; // 한국 표준시 UTC+9
                    const startTime = new Date(now.getTime() + (offset * 60 * 1000)).toISOString(); // ISO 8601 형식으로 변환
                    const $this = $(this);

                    // 출근 버튼 상태에 따라 동작
                    if ($this.hasClass('on')) {
                        $('#start-time-display').text(new Date().toLocaleTimeString('ko-KR'));
                        $this.removeClass('on').addClass('off').text(
                                '출근 완료');
                        $('#end-btn').prop('disabled', false); // 퇴근 버튼 활성화

                        // 출근 시간을 서버로 전송
                        $
                                .ajax({
                                    url : '/rest/home/start', // 서버의 API URL
                                    type : 'POST',
                                    data : {
                                        startTime : startTime
                                    },
                                    success : function(response) {
                                        console.log('출근 시간 기록 성공:',
                                                response);
                                    },
                                    error : function(jqXHR, textStatus,
                                            errorThrown) {
                                        console.error('출근 시간 기록 실패:',
                                                textStatus, errorThrown);
                                    }
                                });
                    } else if ($this.hasClass('off')) {
                        $this.removeClass('off').addClass('on').text('출근');
                    }
                }
            });

    // 퇴근 버튼 클릭 핸들러
    $('#end-btn').click(
            function() {
                if ($(this).hasClass('off')) {
                    if (confirm('퇴근하시겠습니까?')) {
                        const now = new Date();
                        const offset = 9 * 60; // 한국 표준시 UTC+9
                        const endTime = new Date(now.getTime() + (offset * 60 * 1000)).toISOString(); // ISO 8601 형식으로 변환

                        $('#end-time-display').text(new Date().toLocaleTimeString('ko-KR'));

                        // 퇴근 버튼 상태에 따라 동작
                        $(this).removeClass('off').addClass('on').text(
                                '퇴근 완료');

                        // 퇴근 시간을 서버로 전송
                        $
                                .ajax({
                                    url : '/rest/home/end', // 서버의 API URL
                                    type : 'POST',
                                    data : {
                                        endTime : endTime
                                    },
                                    success : function(response) {
                                        console.log('퇴근 시간 기록 성공:',
                                                response);
                                    },
                                    error : function(jqXHR, textStatus,
                                            errorThrown) {
                                        console.error('퇴근 시간 기록 실패:',
                                                textStatus, errorThrown);
                                    }
                                });

                        // 출근 버튼을 다시 '출근' 상태로 리셋
                        $('#start-btn').removeClass('off').addClass('on')
                                .text('출근');
                    }
                } else {
                    alert('이미 퇴근 완료 상태입니다.');
                }
            });

    // 초기 날짜 및 시간 업데이트
    updateDateTime();
    setInterval(updateDateTime, 1000);

    // 페이지 로드 시 퇴근 버튼 비활성화
    $('#end-btn').prop('disabled', true);
});
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회의실 예약</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // 예약된 시간 정보를 부모 페이지에서 가져옴
            var reservedTimes = window.opener ? window.opener.reservedTimes : [];

            $('#room-select, #date-input').change(function() {
                updateAvailableTimes();
            });

            function updateAvailableTimes() {
                var room = $('#room-select').val();
                var date = $('#date-input').val();

                if (room && date) {
                    var availableTimes = generateAvailableTimes();
                    var filteredTimes = filterReservedTimes(room, date, availableTimes);
                    populateTimeSelect('#start-time-select', filteredTimes);
                    populateTimeSelect('#end-time-select', []); // 종료 시간 초기화
                }
            }

            function filterReservedTimes(room, date, times) {
                var reservedSlots = reservedTimes.filter(function(reserved) {
                    return reserved.roomId == room && reserved.calDate == date;
                });

                return times.filter(function(time) {
                    return !reservedSlots.some(function(reserved) {
                        return (time >= reserved.stime && time < reserved.etime);
                    });
                });
            }

            $('#start-time-select').change(function() {
                var startTime = $(this).val();
                var availableEndTimes = generateEndTimes().filter(function(time) {
                    return time > startTime;
                });

                // 종료 시간도 중복된 시간대 필터링
                var room = $('#room-select').val();
                var date = $('#date-input').val();
                var filteredEndTimes = filterReservedTimes(room, date, availableEndTimes);

                populateTimeSelect('#end-time-select', filteredEndTimes);
            });

            function generateAvailableTimes() {
                var startHour = 9; // 시작 시간 (오전 9시)
                var endHour = 21; // 종료 시간 (오후 9시)
                var times = [];

                for (var hour = startHour; hour < endHour; hour += 2) {
                    var formattedTime = formatHour(hour);
                    times.push(formattedTime); // 예: "09:00", "11:00"
                }

                return times;
            }

            function generateEndTimes() {
                var startHour = 11; // 시작 시간 (오전 11시)
                var endHour = 21; // 종료 시간 (오후 9시)
                var times = [];

                for (var hour = startHour; hour <= endHour; hour += 2) {
                    var formattedTime = formatHour(hour);
                    times.push(formattedTime); // 예: "11:00", "13:00"
                }

                return times;
            }

            function formatHour(hour) {
                return (hour < 10 ? '0' : '') + hour + ':00';
            }

            function populateTimeSelect(selectId, times) {
                var options = '<option value="">시간 선택</option>';
                times.forEach(function(timeSlot) {
                    options += '<option value="' + timeSlot + '">' + timeSlot + '</option>';
                });
                $(selectId).html(options);
            }

            // roomName을 hidden input으로 추가
            $('#room-select').change(function() {
                var roomName = $('#room-select option:selected').data('room-name');
                $('input[name="roomName"]').remove(); // 기존의 roomName input 제거
                $('<input>').attr({
                    type: 'hidden',
                    name: 'roomName',
                    value: roomName
                }).appendTo('form');
            });

            $('#room-select, #date-input, #start-time-select').change(function() {
                validateReservation();
            });

            function validateReservation() {
                var selectedRoomId = $('#room-select').val();
                var selectedDate = $('#date-input').val();
                var selectedStartTime = $('#start-time-select').val();
                var selectedEndTime = $('#end-time-select').val();

                // 중복되는 시간대가 있는지 확인
                var isConflict = reservedTimes.some(function(reservation) {
                    return reservation.roomId == selectedRoomId &&
                        reservation.calDate == selectedDate &&
                        !(
                            selectedEndTime <= reservation.stime || 
                            selectedStartTime >= reservation.etime
                        );
                });

                if (isConflict) {
                    alert('선택한 시간대에 이미 예약이 있습니다. 다른 시간대를 선택해주세요.');
                    // 시간대를 다시 선택하도록 처리
                    $('#start-time-select').val('');
                    $('#end-time-select').val('');
                }
            }
        });
    </script>
</head>
<body>
    <h1>회의실 예약</h1>
    <form action="insert" method="post">
        <p>1. 날짜 :</p>
        <input type="date" id="date-input" name="calDate" required>
        <p id="selected-date-display" style="font-weight: bold; color: blue;">선택한 날짜:</p>

        <p>2. 회의실 :</p>
        <select id="room-select" name="roomId" required>
            <option value="">회의실 선택</option>
            <option value="1" data-room-name="대회의실">회의실1(대회의실)</option>
            <option value="2" data-room-name="소회의실">회의실2(소회의실)</option>
            <option value="3" data-room-name="중회의실">회의실3(중회의실)</option>
            <option value="4" data-room-name="VIP회의실">회의실4(VIP회의실)</option>
            <option value="5" data-room-name="세미나실">회의실5(세미나실)</option>
        </select>

        <p>3. 시작 시간:</p>
        <select id="start-time-select" name="stime" required>
            <option value="">시작 시간 선택</option>
        </select>

        <p>종료 시간:</p>
        <select id="end-time-select" name="etime" required>
            <option value="">종료 시간 선택</option>
        </select>

        <p>4. 예약자 이름 : <input type="text" name="guestName" required></p>
        <p>5. 비밀번호(6자리 숫자) : <input type="password" name="pw" required></p>

        <button type="submit">예약하기</button>
    </form>
</body>
</html>

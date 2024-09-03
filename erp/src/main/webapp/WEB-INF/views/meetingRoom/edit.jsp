<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 예약 수정하기</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <h1>회의실 예약 수정하기</h1>
    <form action="editComplete" method="post">
        <!-- resId와 roomId를 숨겨진 필드로 추가 -->
        <input type="hidden" name="resId" value="${res.resId}" />
        <input type="hidden" name="roomId" value="${res.roomId}" />
        <input type="hidden" name="roomName" value="${roomName}" />

        <p>1. 날짜 :</p>
        <input type="date" id="date-input" name="calDate" value="${res.calDate}" required>

        <p>2. 회의실 :</p>
        <select id="room-select" name="roomId" required>
            <option value="1" ${res.roomId == 1 ? 'selected' : ''}>대회의실</option>
            <option value="2" ${res.roomId == 2 ? 'selected' : ''}>소회의실</option>
            <option value="3" ${res.roomId == 3 ? 'selected' : ''}>중회의실</option>
            <option value="4" ${res.roomId == 4 ? 'selected' : ''}>VIP회의실</option>
            <option value="5" ${res.roomId == 5 ? 'selected' : ''}>세미나실</option>
        </select>

        <p>회의실 이름: ${roomName}</p> <!-- roomName 출력 -->

        <p>3. 시작 시간:</p>
        <select id="start-time-select" name="stime" required>
            <option value="${res.stime}" selected>${res.stime}</option>
        </select>

        <p>종료 시간:</p>
        <select id="end-time-select" name="etime" required>
            <option value="${res.etime}" selected>${res.etime}</option>
        </select>

        <p>
            4. 예약자 이름 : <input type="text" name="guestName" value="${res.guestName}" required>
        </p>

        <button type="submit">예약 수정하기</button>
    </form>

    <script>
        $(document).ready(function() {
            // 예약 정보는 부모 페이지에서 전달됨
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
                return times.filter(function(time) {
                    return !reservedTimes.some(function(reserved) {
                        return reserved.roomId == room && reserved.calDate == date &&
                            (time >= reserved.stime && time < reserved.etime);
                    });
                });
            }

            $('#start-time-select').change(function() {
                var startTime = $(this).val();
                var availableEndTimes = generateEndTimes().filter(function(time) {
                    return time > startTime;
                });
                populateTimeSelect('#end-time-select', availableEndTimes);
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
			
            $('#room-select').change(function() {
                var roomName = $('#room-select option:selected').text();
                console.log("Selected room name: ", roomName);
                $('input[name="roomName"]').val(roomName);
            });

            $('#room-select, #date-input, #start-time-select').change(function() {
                validateReservation();
            });

            function validateReservation() {
                var selectedRoomId = $('#room-select').val();
                var selectedDate = $('#date-input').val();
                var selectedStartTime = $('#start-time-select').val();
                var selectedEndTime = $('#end-time-select').val();

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
                    $('#start-time-select').val('');
                    $('#end-time-select').val('');
                }
            }
        });
        
        
    </script>
</body>
</html>

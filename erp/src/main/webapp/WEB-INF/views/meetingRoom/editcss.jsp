<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--구글 폰트cdn-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
    rel="stylesheet">

<!--폰트 어썸 icon cdn-->
<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<title>회의실예약</title>
  <!-- SweetAlert2 CDN -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- google font cdn -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
    rel="stylesheet">

<!-- font awesome icon cdn -->
<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<!-- my css -->
<link rel="stylesheet" type="text/css" href="./commons.css">
<!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->
<link rel="stylesheet" type="text/css" href="./sidebar.css">
<link rel="stylesheet" type="text/css" href="./vacation.css">
<link rel="stylesheet" type="text/css" href="./alertBtn.css">
<style>
/* From Uiverse.io by mi-series */ 
.container1 {
  position: relative;
  max-width: 500px;
  width: 100%;
  background: #FCEDDA;
  padding: 25px;
  border-radius: 8px;
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
  left: 30%;
}

.container1 header {
  font-size: 1.2rem;
  color: #000;
  font-weight: 600;
  text-align: center;
}

.container1 .form {
  margin-top: 15px;
}

.form .input-box {
  width: 100%;
  margin-top: 10px;
}
.form .select-box {
  width: 100%;
  margin-top: 10px;
}

.input-box label {
  color: #000;
}

.form :where(.input-box input, .select-box) {
  position: relative;
  height: 35px;
  width: 100%;
  outline: none;
  font-size: 1rem;
  color: #808080;
  margin-top: 5px;
  border: 1px solid black;
  border-radius: 6px;
  padding: 0 15px;
  background: #FCEDDA;
}

.input-box input:focus {
  box-shadow: 0 1px 0 rgba(0, 0, 0, 0.1);
}

.form .column {
  display: flex;
  column-gap: 15px;
}

.form .gender-box {
  margin-top: 10px;
}

.form :where(.gender-option, .gender) {
  display: flex;
  align-items: center;
  column-gap: 50px;
  flex-wrap: wrap;
}

.form .gender {
  column-gap: 5px;
}

.gender input {
  accent-color: #EE4E34;
}

.form :where(.gender input, .gender label) {
  cursor: pointer;
}

.gender label {
  color: #000;
}

.address :where(input, .select-box) {
  margin-top: 10px;
}

.select-box select {
  height: 100%;
  width: 100%;
  outline: none;
  border: none;
  color: #808080;
  font-size: 1rem;
  background: #FCEDDA;
}

.form button {
  height: 40px;
  width: 100%;
  color: #000;
  font-size: 1rem;
  font-weight: 400;
  margin-top: 15px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s ease;
  background-color: wheat !important;
  border: 1px solid antiquewhite !important;
}

.form button:hover {
    background-color: rgb(252, 241, 228) !important;
            color: rgb(252, 197, 94);
}




</style>

<!-- lightpick cdn -->
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script
    src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>

<!-- jquery cdn -->
<script
    src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src=".checkbox.js"></script>
<script src=".confirm-link.js"></script>
<script src=".multipage.js"></script>

    <!-- fullcalendar cdn-->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>
  <!-- lightpick cdn -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
  <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
  <!-- jquery cdn -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="./checkbox.js"></script>
  <script src="./confirm-link.js"></script>
  <!-- <script src="multipage.js"></script> -->
  <!-- 프로젝트 js-->
<script src="./gotoworkbtn.js"></script>
<script src="./menuToggle.js"></script>
<script src="./delete.js"></script>
  <!-- chart js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 자바스크립트 코드 작성 영역 -->
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

<script>
    function showAlert() {
        Swal.fire({
            title: '<span class="custom-title">예약수정 완료</span>',
            icon: 'success',
            customClass: {
                title: 'custom-title',
                popup: 'custom-background',
                confirmButton: 'custom-button' 
            }
        });
    }
    </script>

</head>
<body>
    <header id="header">
        <div id="menuToggle">
            <i class="fa fa-bars"></i>
        </div>
        <div id="logo">
            <a href="#" class="notif-alert"> <i
                class="fa-solid fa-envelope email"></i> <span
                class="notif-count content">0</span>
            </a> <a href="#"><i class="fa-solid fa-circle-user user"></i></a>
        </div>
    </header>

    <aside id="sidebar">
        <nav id="menu">
            <div class="container">
                <div class="row center">
                    <h1>ERP</h1>
                </div>

                <div class="row">
                    <ul class="menu-hover-fill">
                        <li><a href="/" data-text="home">HOME</a></li>

                        <li><a href="/poketmon/list" data-text=""> <i
                                class="fa-solid fa-file-signature"></i> 그룹웨어(poketmon)
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul></li>

                        <li><a href="/emp/list" data-text=""> <i
                                class="fa-solid fa-cart-flatbed"></i> 재고관리(emp)
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul></li>

                        <li><a href="/book/list" data-text=""> <i
                                class="fa-solid fa-people-group"></i> 인사관리(book)
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul></li>

                        <li><a href="/member/mypage" data-text=""> <i
                                class="fa-solid fa-id-card"></i> mypage
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul></li>

                        <li><a href="/board/list" data-text=""> <i
                                class="fa-solid fa-comment"></i> 예비용
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul></li>

                        <c:if test="${sessionScope.createdLevel == '관리자'}">
                            <li><a href="/admin" data-text=""> <i
                                    class="fa-solid fa-gears"></i> 관리자
                            </a></li>
                        </c:if>

                        <li><a href="/logout" data-text=""> <i
                                class="fa-solid fa-power-off"></i> 로그아웃
                        </a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </aside>
        <main id="body">
       

            <!-- 회의실 예약 추가 -->
               
            <section class="container1">
                <header>예약수정 본인확인</header>
                <form class="form"  action="insert" method="post">
                    
                    <div class="input-box">
                        <label>예약 번호 </label>
                        <input type="text" name="guestName"> <br>
                    </div>

                    <div class="input-box">
                        <label>비밀번호</label>
                        <input type="password" name="inputPw"> <br>
                    </div>


   

                    <button type="button" onclick="showAlert()">Submit</button>
                </form>
              </section>
        </main>
    </div>
</body>
</html>
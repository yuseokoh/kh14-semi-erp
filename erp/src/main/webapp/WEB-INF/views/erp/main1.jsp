<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세보기</title>

    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="/css/commons.css">

     <!-- 프로젝트 스타일 --> 
     <link rel="stylesheet" type="text/css" href="/css/gotowork.css">
     <link rel="stylesheet" type="text/css" href="/css/sidebar.css">
     <link rel="stylesheet" type="text/css" href="/css/notic.css">
     <!-- <link rel="stylesheet" type="text/css" href="./vacation.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
<style> 
.info-container {
    display: flex;
    flex-direction: column;
    align-items: center;   
    justify-content: center;
    text-align: center;    
}

.info-container p {
    margin-bottom: 15px;  
}

.info-container .content {
    display: flex;
    align-items: center;
    justify-content: flex-start; 
    width: 100%;   
}

.info-container .left {
    margin-right: 10px;  /* 이미지랑 간격주는 마진*/
}

.info-container .right {
    display: flex;
    flex-direction: column;
    align-items: flex-start; 
}

.info-item {
    margin: 5px 0; 
    font-size: 20px; 
}

.info-item span {
    margin-left: 10px; /* 아이콘과 텍스트 간의 간격 조절 */
}

.icon {
    font-size: 30px; /* 아이콘의 크기 조절 */
    margin-right: 10px; /* 아이콘과 텍스트 간의 간격 조절 */
}
p{
 font-size: 20px;
 font-weight: bold;
}
.center{
    border: 1px solid #858e8f ;
}
.span1{
    margin-left: 20px !important;
}
.span2{
    margin-left: 15px !important;
}


.bell-container {
            position: relative;
            display: inline-block;
        }

        .bell-icon {
            font-size: 34px;
            cursor: pointer;
            color: white;
        }

        .notification {
            display: none;
            position: absolute;
            top: 50px;
            right: 20px;
            width: 200px;
            padding: 10px;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            z-index: 1000;
        }

        .notification.show {
            display: block;
        }

        .notification button {
            position: absolute;
            top: 10px;
            right: 10px;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .notification-count {
            position: absolute;
            top: 1px;
            right: -10px;
            background: red;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
        }
        .center{
            margin: 15px;
        }
  

        .card {
  width: 500px;
  height: 300px;
  perspective: 1000px; /* 3D 효과를 위한 관찰 거리 */
}

.card-inner {
  width: 113.5%;
  height: 100%;
  position: relative;
  transform-style: preserve-3d; /* 자식 요소의 3D 변형을 유지 */
  transition: transform 0.999s; /* 변형 전환 시간 */
}

.card:hover .card-inner {
  transform: rotateY(180deg); /* 카드가 회전하도록 설정 */
}

.card-front,
.card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
}

.card-front {
  background-color: #000000;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  transform: rotateY(0deg);
}

.card-front img.target {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.card-back {
  background-color: #000000; 
  color: #000000;
  display: flex;
  flex-direction: column;
  align-items: start;
  justify-content: center;
  font-size: 24px;
  transform: rotateY(180deg); 
  background-image: url('https://picsum.photos/500/300'); 
  background-size: cover; 
  background-position: center; 
  opacity: 0.5; 
}

.card-back > div {
  opacity: 1; 
  color: #fff; 
  font-weight: bold; 
  text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.8); 
  padding: 10px; 
  background-color: rgba(0, 0, 0, 0.5); 
  border-radius: 5px; 
}


</style>
<!-- FullCalendar CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css">
<!-- FullCalendar JS -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

  <!-- lightpick cdn -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
  <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
  <!-- jquery cdn -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="/js/checkbox.js"></script>
  <script src="/js/confirm-link.js"></script>
  <!-- <script src="multipage.js"></script> -->
  <!-- 프로젝트 js-->
<script src="/js/gotoworkbtn.js"></script>
<script src="/js/menuToggle.js"></script>
<script src="/js/delete.js"></script>
  <!-- chart js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript">

  //메인화면 차트 
    $(function(){
            //차트를 그릴 대상 선택
            var ctx = document.querySelector(".my-chart");
            //차트 생성 코드
            //new Chart(캔버스태그, {옵션객체});
            new Chart(ctx, {
                type: 'bar',//차트 유형(bar/pie/doughnut/line)
                data: {//차트에 표시될 데이터

                    //label은 차트에 표시되는 항목(x축)
                    labels: ['재고', '관리', '그래프', '자리'],

                    //실제로 차트에 표시될 값
                    datasets: [
                        {
                            label: '재고 수',//범례
                            data: [2, 2, 2, 1],//데이터
                            borderWidth: 1//디자인 속성(테두리 두께)
                        },
                    ]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true//차트를 0부터 표기
                        }
                    }
                }
            });
        });
    </script>

</head>
<body>  
    <header id="header">
        <div id="menuToggle"><i class="fa fa-bars"></i></div>
        <div id="logo">
            <a href="#" class="notif-alert">
                <i class="fa-solid fa-envelope email"></i></i>
                <span class="notif-count content">0</span>
            </a>
            <a href="#"><i class="fa-solid fa-circle-user user"></i></a> 
        </div>
    </header>

    <aside id="sidebar">
        <nav id="menu">
            <div class="container">

				<!-- 출퇴근 -->
				<div id="commute-wrap">
					<div id="date-wrap">
						<span id="cur-date"></span><br>
						<span id="cur-time"></span>
					</div>
					<div id="start-time">
						<i>출근 시간</i>
						<!-- 출근 여부에 따른 표시 -->
						<span id="start-time-display">미등록</span>
					</div>
					<div id="end-time">
						<i>퇴근 시간</i>
						<!-- 퇴근 여부에 따른 표시 -->
						<span id="end-time-display">미등록</span>
					</div>
					<div id="attendance-btns">
						<button id="start-btn" class="on">출근</button>
						<button id="end-btn" class="on">퇴근</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 출퇴근 여기까지-->

                <!-- 사이드바-->
			<div class="row">
				<ul class="menu-hover-fill">
					<li><a href="/home" data-text="home"> <i class="fa-solid fa-house-user"></i> HOME
					</a></li>

					<li><a href="#" data-text=""> <i class="fa-solid fa-file-signature"></i> 그룹웨어
					</a>
						<ul>
							<li><a href="/vacation/mylist?loginId=${sessionScope.createdUser}">휴가신청서</a></li>
							<li><a href="/report/mylist?loginId=${sessionScope.createdUser}">보고서</a></li>
							<li><a href="/res/list">회의실 예약</a></li>
						</ul></li>

					<li><a href="/stock/list" data-text=""> <i class="fa-solid fa-cart-flatbed"> </i> 재고관리(emp)
					</a>
						<ul>
							<li><a href="/stock/changeLogList">재고 변경 내역</a></li>
							<li><a href="/stock/categoryQuantity">재고 그래프</a></li>
						</ul></li>

					<li><a href="/tb/list" data-text=""> <i class="fa-solid fa-people-group"> </i> 인사관리
					</a></li>

					<li><a href="/tb/mypage?loginId=${sessionScope.createdUser}" data-text=""> <i class="fa-solid fa-id-card"></i> mypage
					</a></li>

					<li><a href="/groupware/notice/noticList" data-text=""> <i class="fa-solid fa-comment"></i> 공지사항
					</a></li>

					<c:if test="${sessionScope.userType == 'A'}">
						<li><a href="#" data-text=""> <i class="fa-solid fa-gears"></i> 관리자
						</a>
							<ul>
								<li><a href="/admin/emp/list">사원조회</a></li>
								<li><a href="/admin/emp/status">사원현황</a></li>
								<li><a href="/admin/emp/approvalList">결재현황</a></li>
								<li><a href="/admin/emp/hoursMgmt">사원근무기록 현황</a></li>
							</ul></li>
					</c:if>

					<li><a href="/tb/logout" data-text=""> <i class="fa-solid fa-power-off"></i> 로그아웃
					</a></li>
				</ul>
			</div>
			</div>
		</nav>
	</aside>

	<div id="content" style="margin-top: 500px;">
		<main id="body">
			<!-- <div id="content" style="margin-top: 200px;"> -->
			<!-- 여기서부터 메인 화면의 콘텐츠가 시작됩니다. -->
			<h2>${tbEmpDto.name}님환영합니다일하십쇼</h2>

			<div class="row flex-box w-1200">
				<div class="w-50 center">
					<canvas id="barChart"></canvas>
				</div>
				<div class="w-50 center">
					<div class="card">
						<div class="card-inner">
							<div class="card-front">
								<img class="target" src="https://picsum.photos/500/300" alt="Front Image" style="width: 570px; height: 300px;">
							</div>
							<div class="card-back">
								<div class="info-item">
									<i class="fa-solid fa-user-pen"></i> <span>이름: </span>${tbEmpDto.name}</div>
								<div class="info-item">
									<i class="fa-solid fa-clipboard-user"></i> <span class="span1">직급: </span>${tbEmpDto.empLevel}</div>
								<div class="info-item">
									<i class="fa-solid fa-people-group"></i> <span>부서: </span>${tbEmpDto.empDept}</div>
								<div class="info-item">
									<i class="fa-regular fa-clock"></i> <span class="span2">출근시간: </span> ${inTime}
								</div>
								<div class="info-item">
									<i class="fa-solid fa-clock"></i> <span class="span2">퇴근시간: </span> ${outTime}
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>


			<div class="row flex-box w-1200">


				<!-- full Calendar -->
				<div class="calendar w-80 center" id="calendar"></div>
				<script type="text/javascript">
                $(document).ready(function() {
                    // 서버에서 전달된 예약 데이터를 캘린더에 표시
                    var allReservations = [];
                    <c:forEach var="reservation" items="${allReservations}">
                        allReservations.push({
                            title: "${reservation.roomName}",
                            start: "${reservation.calDate}T${reservation.stime}",
                            end: "${reservation.calDate}T${reservation.etime}",
                            extendedProps: {
                                guestName: "${reservation.guestName}"
                            }
                        });
                    </c:forEach>

                    // FullCalendar 초기화
                    var calendarEl = document.getElementById('calendar');
                    var calendar = new FullCalendar.Calendar(calendarEl, {
                        locale: 'ko',
                        timeZone: 'Asia/Seoul',
                        initialView: 'dayGridMonth',
                        selectable: false, // 날짜 선택 비활성화
                        validRange: {
                            start: new Date().toISOString().split("T")[0]
                        },
                        events: allReservations,
                        contentHeight: 'auto',
                        aspectRatio: 2.0,
                        displayEventTime: false,
                        displayEventEnd: false,

                        // Hover 이벤트 비활성화
                        eventMouseEnter: function() {
                            // 아무 작업도 하지 않음
                        },
                        eventMouseLeave: function() {
                            // 아무 작업도 하지 않음
                        },

                        eventClick: function(info) {
                            // 예약된 이벤트를 클릭하면 모달에 정보 표시
                            $('#modalRoomName').text('회의실: ' + info.event.title);
                            $('#modalGuestName').text('예약자: ' + info.event.extendedProps.guestName);
                            $('#modalStartTime').text('시작 시간: ' + info.event.start.toISOString().slice(0, 16).replace('T', ' '));
                            $('#modalEndTime').text('종료 시간: ' + info.event.end.toISOString().slice(0, 16).replace('T', ' '));

                            // 모달 표시
                            $('#reservationModal').show();
                        }
                    });

                    calendar.render();

                    // 모달 닫기 버튼
                    $('#closeModal').click(function() {
                        $('#reservationModal').hide();
                    });
                });


				</script>
				<!-- 예약 정보 모달 -->
				<div id="reservationModal" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 300px; padding: 20px; background-color: white; box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); border-radius: 10px; z-index: 10000;">

					<p id="modalRoomName"></p>
					<p id="modalGuestName"></p>
					<p id="modalStartTime"></p>
					<p id="modalEndTime"></p>
					<button id="closeModal">닫기</button>
				</div>
				<!-- HTML with inline styles -->
				<div class="w-70 center" style="max-width: 100%; overflow-x: hidden; overflow-y: auto; height: 589px;">
					<table style="width: 100%; border-collapse: collapse;" class="tb">
						<thead>
							<tr>
								<th style="border: 1px solid #ddd; padding: 8px; text-align: left;">작성일</th>
								<th style="border: 1px solid #ddd; padding: 8px; text-align: left;">제목</th>
								<th style="border: 1px solid #ddd; padding: 8px; text-align: left;">작성자</th>
								<th style="border: 1px solid #ddd; padding: 8px; text-align: left;">조회수</th>
							</tr>
						</thead>
						<tbody class="tbody">
							<c:forEach var="notice" items="${noticeList}">
								<tr class="row center">
									<td style="border: 1px solid #ddd; padding: 8px; text-align: left; white-space: nowrap;">${notice.noticeWtime}</td>
									<td class="name" style="border: 1px solid #ddd; padding: 8px; text-align: left; white-space: nowrap;">${notice.noticeTitle}</td>
									<td style="border: 1px solid #ddd; padding: 8px; text-align: left; white-space: nowrap;">${notice.noticeWriter}</td>
									<td style="border: 1px solid #ddd; padding: 8px; text-align: left; white-space: nowrap;">${notice.noticeViews}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
	</div>
	</main>





	<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        fetch('/api/categoryQuantityData') // JSON 데이터를 제공하는 API 엔드포인트
            .then(response => response.json())
            .then(categoryMap => {
                var labels = Object.keys(categoryMap);
                var data = Object.values(categoryMap);

                // 바 차트 생성
                var ctxBar = document.getElementById('barChart').getContext('2d');
                new Chart(ctxBar, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '재고 수량',
                            data: data,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            })
            .catch(error => console.error('Error loading the JSON data:', error));
    });
</script>
</body>
</html>
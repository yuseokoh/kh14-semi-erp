<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 상세보기</title>

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
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<link rel="stylesheet" type="text/css" href="/css/test.css">

<!-- 프로젝트 스타일 -->
<link rel="stylesheet" type="text/css" href="/css/gotowork.css">
<link rel="stylesheet" type="text/css" href="/css/sidebar.css">
<!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
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
	margin-right: 10px; /* 이미지랑 간격주는 마진*/
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

p {
	font-size: 20px;
	font-weight: bold;
}

.center {
	border: 1px solid #858e8f;
}

.span1 {
	margin-left: 20px !important;
}

.span2 {
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
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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

.center {
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

.card-front, .card-back {
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

.card-back>div {
	opacity: 1;
	color: #fff;
	font-weight: bold;
	text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.8);
	padding: 10px;
	background-color: rgba(0, 0, 0, 0.5);
	border-radius: 5px;
}
</style>

<script src="/js/gotoworkbtn.js"></script>
<script src="/js/menuToggle.js"></script>
<script src="/js/delete.js"></script>
<!-- chart js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>




<script>
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


<script type='importmap'>
    {
      "imports": {
        "@fullcalendar/core": "https://cdn.skypack.dev/@fullcalendar/core@6.1.15",
        "@fullcalendar/daygrid": "https://cdn.skypack.dev/@fullcalendar/daygrid@6.1.15"
      }
    }
  </script>
<script type='module'>
    import { Calendar } from '@fullcalendar/core'
    import dayGridPlugin from '@fullcalendar/daygrid'

    document.addEventListener('DOMContentLoaded', function() {
      const calendarEl = document.querySelector(".calendar")
      const calendar = new Calendar(calendarEl, {
        plugins: [dayGridPlugin],
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        }
      })
      calendar.render()
    })
  </script>

</head>
<body>
	<header id="header">
		<div id="menuToggle">
			<i class="fa fa-bars"></i>
		</div>
		<div id="logo">
			<a href="#" class="notif-alert"> <i
				class="fa-solid fa-envelope email"></i></i> <span
				class="notif-count content">0</span>
			</a> <a href="#"><i class="fa-solid fa-circle-user user"></i></a>
		</div>
	</header>

	<aside id="sidebar">
		<nav id="menu">
			<div class="container">

				<!-- 출퇴근 -->
				<div id="commute-wrap">
					<div id="date-wrap">
						<span id="cur-date"></span><br> <span id="cur-time"></span>
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

</body>
</html>
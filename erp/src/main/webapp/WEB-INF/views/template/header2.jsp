<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 문서 설정 - HTML 버전 지정 (HTML 5)	-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>2조 ERP</title>

<!-- google font cdn -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- font awesome icon cdn -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<!-- my css -->
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->

<!-- 프로젝트 스타일 -->
<link rel="stylesheet" type="text/css" href="/css/gotowork.css">
<link rel="stylesheet" type="text/css" href="/css/sidebar.css">
<link rel="stylesheet" type="text/css" href="/css/notic.css">
<link rel="stylesheet" type="text/css" href="/css/vacation.css">

<!-- fullcalendar cdn-->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>

<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="/js/checkbox.js"></script>
<script src="/js/confirm-link.js"></script>
<script src="/js/multipage.js"></script>

<!-- lightpick cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>

<!-- 프로젝트 js-->
<script src="/js/gotoworkbtn.js"></script>
<script src="/js/menuToggle.js"></script>
<!-- <script src="/js/delete.js"></script>  받아와야할 것-->

<!-- chart js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">
	//메인화면 차트 
	$(function() {
		//차트를 그릴 대상 선택
		var ctx = document.querySelector(".my-chart");
		//차트 생성 코드
		//new Chart(캔버스태그, {옵션객체});
		new Chart(ctx, {
			type : 'bar',//차트 유형(bar/pie/doughnut/line)
			data : {//차트에 표시될 데이터

				//label은 차트에 표시되는 항목(x축)
				labels : [ '재고', '관리', '그래프', '자리' ],

				//실제로 차트에 표시될 값
				datasets : [ {
					label : '재고 수',//범례
					data : [ 2, 2, 2, 1 ],//데이터
					borderWidth : 1
				//디자인 속성(테두리 두께)
				}, ]
			},
			options : {
				scales : {
					y : {
						beginAtZero : true
					//차트를 0부터 표기
					}
				}
			}
		});
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


<style>
/* 비활성화된 스타일 */
.disabled, .form[disabled] {
	background-color: #f0f0f0;
	color: #a0a0a0;
	cursor: not-allowed;
	border-color: #d0d0d0;
}

.disabled:focus, .form[disabled]:focus {
	outline: none;
}
</style>
</head>
<body>
	<header id="header">
		<div id="menuToggle">
			<i class="fa fa-bars"></i>
		</div>
		<div id="logo">
			<a href="#" class="notif-alert"> <i class="fa-solid fa-envelope email"></i>
			<span class="notif-count content">0</span>
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
				<!-- 출퇴근 여기까지-->

				<!-- 사이드바-->
				<div class="row">
					<ul class="menu-hover-fill">
						<li><a href="/" data-text="home">HOME</a></li>

						<li><a href="/poketmon/list" data-text=""> <i class="fa-solid fa-file-signature"></i> 그룹웨어(poketmon)
						</a>
							<ul>
								<li><a href="#">휴가신청서</a></li>
								<li><a href="#">보고서(수인씨작성중)</a></li>
							</ul></li>

						<li><a href="/stock/list3" data-text=""> <i class="fa-solid fa-cart-flatbed"></i> 재고관리(emp)
						</a>
							<ul>
								<li><a href="#">서브메뉴1</a></li>
								<li><a href="#">서브메뉴2</a></li>
							</ul></li>

						<li><a href="/book/list" data-text=""> <i class="fa-solid fa-people-group"></i> 인사관리(book)
						</a>
							<ul>
								<li><a href="#">서브메뉴1</a></li>
								<li><a href="#">서브메뉴2</a></li>
							</ul></li>

						<li><a href="/member/mypage" data-text=""> <i class="fa-solid fa-id-card"></i> mypage
						</a>
							<ul>
								<li><a href="#">서브메뉴1</a></li>
								<li><a href="#">서브메뉴2</a></li>
							</ul></li>

						<li><a href="/board/list" data-text=""> <i class="fa-solid fa-comment"></i> 예비용
						</a>
							<ul>
								<li><a href="#">서브메뉴1</a></li>
								<li><a href="#">서브메뉴2</a></li>
							</ul></li>

						<c:if test="${sessionScope.createdLevel == '관리자'}">
							<li><a href="/admin" data-text=""> <i class="fa-solid fa-gears"></i> 관리자
							</a></li>
						</c:if>

						<li><a href="/logout" data-text=""> <i class="fa-solid fa-power-off"></i> 로그아웃
						</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</aside>
<body>
	<div id="content" style="margin-top: 200px;">
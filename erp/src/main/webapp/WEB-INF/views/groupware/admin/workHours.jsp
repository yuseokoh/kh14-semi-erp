<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사원별 총 근무 시간</title>

<!-- Google Font CDN -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- Font Awesome Icon CDN -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<!-- My CSS -->
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<link rel="stylesheet" type="text/css" href="/css/gotowork.css">
<link rel="stylesheet" type="text/css" href="/css/sidebar.css">
<link rel="stylesheet" type="text/css" href="/css/notic.css">

<style>
.attendance {
	margin-left: auto;
	margin-right: auto;
}

.btn {
	color: white;
	background-color: #80bdff;
	border-color: #7f8c8d;
	border-radius: 4px;
	height: 35px;
}

.search, .delete, .write {
	width: 100%;
}

.search {
	font-size: 16px;
}

.actions1 {
	font-size: 16px;
}

.button {
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	padding: 0.5em 0.75em;
	color: white;
	background-color: wheat;
	border: 1px solid #7f8c8d;
	border-radius: 0.2em;
	cursor: pointer;
	text-align: center;
	line-height: 1.2;
}

.attendance {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.attendance .attendancename {
	font-weight: bold;
}

.attendance .actions {
	display: flex;
	align-items: center;
}

.attendance select, .attendance input, .attendance button {
	margin-left: 0px;
	max-width: 150px;
	height: 35px;
}

.tb-box .flex-box {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.tb {
	border-top: 1px solid #7f8c8d;
	border-bottom: 1px solid #7f8c8d;
	width: 100%;
	border-collapse: collapse;
	font-size: 16px;
}

.tb>thead {
	border-bottom: 1px solid #7f8c8d;
}

.name {
	color: #80bdff;
	font-weight: bold;
}

.tbody {
	border-bottom: 1px solid #7f8c8d;
}

#calendar {
	max-width: 900px;
	margin: 0 auto;
}

.calendar-header {
	margin-bottom: 20px;
}

.button-group button {
	margin: 0 5px;
}
</style>

<!-- FullCalendar CDN -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

<!-- jQuery CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- 프로젝트 js -->
<script src="/js/gotoworkbtn.js"></script>
<script src="/js/menuToggle.js"></script>

</head>
<body>
	<header id="header">
		<div id="menuToggle">
			<i class="fa fa-bars"></i>
		</div>
		<div id="logo">
			<a href="#" class="notif-alert"> <i class="fa-solid fa-envelope email"></i> <span class="notif-count content">0</span>
			</a> <a href="#"><i class="fa-solid fa-circle-user user"></i></a>
		</div>
	</header>

	<aside id="sidebar">
	        <nav id="menu">
	            <div class="container">

	                <!-- 이미지? -->


	                <!-- 여기까지 이미지?-->


	                <!--출퇴근-->
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
	            </div>
	            <!-- 출퇴근 여기까지-->



	           <!-- 사이드바-->
				<div class="row" style="display:initial important!;">
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
						</a>
							</li>

						<li><a href="/groupware/notice/noticList" data-text=""> <i class="fa-solid fa-comment"></i> 공지사항
						</a>
						</li>

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

	    <div id="content">

	        <main id="body">
	            <div id="content">
				
				<body>
				<div class="noticbox w-800">
					<div class="row">
						
						<!-- Calendar container -->
						<div class="calendar-header" style="display: flex; align-items: center; justify-content: center; margin-bottom: 20px;">
						    <button class="button" id="prevBtn" style="margin: 0 5px;">
						        <i class="fa-solid fa-chevron-left"></i>
						    </button>
						    <div class="row noticname">사원 근무 시간 기록 현황</div>
						    <h2 id="calendarTitle" style="margin: 0 10px; font-size: 1.5em; display: none;"></h2>
						    <button class="button" id="nextBtn" style="margin: 0 5px;">
						        <i class="fa-solid fa-chevron-right"></i>
						    </button>
						</div>
					</div>
					<hr class="row mt-15 mb-50">

					<div class="tb-box">
						<table class="tb">
							<thead>
								<tr>
									<th>사원ID</th>
									<th>월간 근무한 일 수</th>
									<th>월간 근무 날짜</th>
									<th>총 근무 시간(hh:mm:ss)</th>
								</tr>
							</thead>
							<tbody class="tbody">
								<c:if test="${list != null}">
								    <c:forEach var="AttendanceSummaryVO" items="${list}">
								        <tr class="center">
								            <td>${AttendanceSummaryVO.loginID}</td>
								            <td>${AttendanceSummaryVO.daysWorked}</td>
								            <td>
								                <table style="all: unset; border: none;">
								                    <tbody>
								                        <c:forEach var="day" items="${AttendanceSummaryVO.checkInDates}">
								                            <tr>
								                                <td style="padding: 4px;">${day}</td>
								                            </tr>
								                        </c:forEach>
								                    </tbody>
								                </table>
								            </td>
								            <td>${AttendanceSummaryVO.totalWorkTime}</td>
								        </tr>
								    </c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
					<div class="row center">
						<jsp:include page="/WEB-INF/views/template/navigator4.jsp"></jsp:include>
					</div>
				</div>


			</div>
		</main>
</body>
<!-- JavaScript Code -->
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		const calendarEl = document.createElement('div');
		calendarEl.style.display = 'none'; // Hide the calendar container
		document.body.appendChild(calendarEl);

		const calendar = new FullCalendar.Calendar(calendarEl, {
			headerToolbar : false, // Disable default header
			initialView : 'dayGridMonth',
			datesSet : function(info) {
				updateTitle(info.view.currentStart);
			}
		});

		// Initial title update
		updateTitle(calendar.view.currentStart);

		// Custom button functionality
		document.getElementById('prevBtn').addEventListener('click',
				function() {
					calendar.prev();
					const currentDate = calendar.getDate(); // 현재 날짜 객체를 얻습니다
					const month = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 추가합니다.
					const year = currentDate.getFullYear();
					console.log(month);
					console.log(year);
					if (month == null || year == null) {
						const newUrl = new URL(
								window.location.href.split('?')[0]);
						console.log(newUrl);
						window.location.href = newUrl.toString();
					} else {
						const newUrl = new URL(
								window.location.href.split('?')[0]);
						newUrl.searchParams.set('tbmonth', month);
						newUrl.searchParams.set('tbyear', year);
						// Reload the page with the new URL
						window.location.href = newUrl.toString();
					}
				});

		document.getElementById('nextBtn').addEventListener(
				'click',
				function() {
					calendar.next();
					// 현재 날짜를 가져오고 연도와 월 추출
					const currentDate = calendar.getDate(); // 현재 날짜 객체를 얻습니다
					const month = currentDate.getMonth(); // 월은 0부터 시작하므로 1을 추가합니다.
					const year = currentDate.getFullYear();
					if (month == null || year == null) {
						const newUrl = new URL(
								window.location.href.split('?')[0]);
						window.location.href = newUrl.toString();
					} else {
						const newUrl = new URL(
								window.location.href.split('?')[0]);
						newUrl.searchParams.set('tbmonth', month);
						newUrl.searchParams.set('tbyear', year);
						// Reload the page with the new URL
						window.location.href = newUrl.toString();
					}

				});

		function updateTitle(date) {
			const month = date.getMonth() + 1; // Months are zero-based, so add 1
			const year = date.getFullYear();
			document.getElementById('calendarTitle').innerText = year + "년 "
					+ month + "월";
		}
	});
</script>
</html>

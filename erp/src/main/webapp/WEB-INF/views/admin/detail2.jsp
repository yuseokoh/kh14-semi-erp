<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내정보</title>
<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
</script>
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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/commons.css">
<!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 프로젝트 스타일 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/gotowork.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/sidebar.css">
<!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./vacation.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bell.css">
<style>
.info1-container {
	display: flex;
	flex-direction: column;
	align-items: start;
	justify-content: start;
	text-align: start;
}

.info1-container p {
	margin-bottom: 15px;
}

.info1-container .content {
	display: flex;
	align-items: start;
	justify-content: flex-start;
	width: 100%;
}

.info1-container .left {
	margin-right: 10px;
}

.info1-container .right {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.info1-item {
	margin: 5px 5px;
	font-size: 25px;
}

.center {
	text-align: start !important;
	border: 0px solid #858e8f;
}

.target {
	margin: 60px;
}

.info1-item:hover {
	background-color: antiquewhite;
}
</style>
<!-- 수정할때 -->
<style>
.info1-item {
	margin: 5px 5px;
	font-size: 25px;
}

.info1-item div {
	display: flex;
	align-items: center;
}

.info1-item span {
	margin-left: 10px;
	font-size: 25px;
}

.info1-item .edit-field {
	display: none;
	border: 1px solid #ccc;
	border-radius: 5px;
	padding: 10px;
	font-size: 25px;
	width: calc(100% - 22px);
}

.info1-item.editing .edit-field {
	display: block;
}

.info1-item.editing .display-field {
	display: none;
}

.edit-btn {
	display: none;
	padding: 10px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.edit-btn:hover {
	background-color: #0056b3;
}

.hidden {
	display: none;
}

.edit-form.visible {
	display: block;
}

.edit-form.hidden {
	display: none;
}

.edit-form input, .edit-form textarea {
	padding: 10px;
	width: 80%;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.edit-form button {
	padding: 10px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.edit-form button:hover {
	background-color: #0056b3;
}

.edit-form {
	display: none;
}

.info1-container.hidden {
	display: none;
}

.edit-form img {
	max-width: 200px;
	max-height: 200px;
	margin-top: 10px;
}

.edit {
	display: flex;
	justify-content: flex-end;
	margin-right: -300px;
}

.info1-container {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.info1-item {
	display: flex;
	align-items: center;
	margin: 5px 0;
	font-size: 25px;
	width: 100%;
	box-sizing: border-box;
}

.info1-item i {
	width: 30px;
	text-align: center;
}

.info1-item .label {
	display: inline-block;
	width: 150px;
	text-align: right;
	margin-right: 10px;
	font-weight: bold;
}

.info1-item .value {
	display: inline-block;
	max-width: calc(100% - 160px);
}

.edit-form {
	display: none;
}

.edit-form div {
	margin-bottom: 10px;
	display: flex;
	align-items: center;
}

.edit-form label {
	display: inline-block;
	width: 150px;
	text-align: left;
	font-weight: bold;
}

.edit-form input {
	padding: 10px;
	width: calc(100% - 160px);
	border: 1px solid #ccc;
	border-radius: 5px;
	width: 100%;
}

.select0 {
	width: 100% !important;
}
</style>
<!-- fullcalendar cdn-->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>
<!-- lightpick cdn -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
<!-- jquery cdn -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/checkbox.js"></script>
<script src="${pageContext.request.contextPath}/js/confirm-link.js"></script>
<!-- <script src="multipage.js"></script> -->
<!-- 프로젝트 js-->
<script src="${pageContext.request.contextPath}/js/gotoworkbtn.js"></script>
<script src="${pageContext.request.contextPath}/js/menuToggle.js"></script>
<script src="${pageContext.request.contextPath}/js/delete.js"></script>
<!-- chart js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 주소 -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	$(function() {
		$('#bellIcon').on('click', function() {
			$('#notification').toggleClass('show');
		});
		$('#closeButton').on('click', function() {
			$('#notification').removeClass('show');
		});
		$(document).on('click', function(event) {
			if (!$(event.target).closest('#notification, #bellIcon').length) {
				$('#notification').removeClass('show');
			}
		});
		function updateNotificationCount(count) {
			$('#notificationCount').text(count);
			$('#notificationCount').toggle(count > 0);
		}
		updateNotificationCount(10);

		$('#editButton').show(); // 로그인 시 수정 버튼 표시
		$('#editButton').on('click', function() {
			$('#editButton').hide(); // 수정 버튼 숨기기
			$('#saveChanges').show(); // 저장 버튼 표시
			$('.info1-container').addClass('hidden'); // 기존 정보 숨기기
			$('#editForm').show(); // 수정 폼 표시
		});
	});
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
			</div>
			<!-- 출퇴근 여기까지-->

			<!-- 사이드바-->
			<div class="row" style="display: initial !important;">
				<ul class="menu-hover-fill">
					<li><a href="${pageContext.request.contextPath}/home"
						data-text="home"> <i class="fa-solid fa-house-user"></i> HOME
					</a></li>

					<li><a href="#" data-text=""> <i
							class="fa-solid fa-file-signature"></i> 그룹웨어
					</a>
						<ul>
							<li><a
								href="${pageContext.request.contextPath}/vacation/mylist?loginId=${sessionScope.createdUser}">휴가신청서</a></li>
							<li><a
								href="${pageContext.request.contextPath}/report/mylist?loginId=${sessionScope.createdUser}">보고서</a></li>
							<li><a href="${pageContext.request.contextPath}/res/list">회의실
									예약</a></li>
						</ul></li>

					<li><a href="${pageContext.request.contextPath}/stock/list"
						data-text=""> <i class="fa-solid fa-cart-flatbed"> </i>
							재고관리(emp)
					</a>
						<ul>
							<li><a
								href="${pageContext.request.contextPath}/stock/changeLogList">재고
									변경 내역</a></li>
							<li><a
								href="${pageContext.request.contextPath}/stock/categoryQuantity">재고
									그래프</a></li>
						</ul></li>

					<li><a href="${pageContext.request.contextPath}/tb/list"
						data-text=""> <i class="fa-solid fa-people-group"> </i> 인사관리
					</a></li>

					<li><a
						href="${pageContext.request.contextPath}/tb/mypage?loginId=${sessionScope.createdUser}"
						data-text=""> <i class="fa-solid fa-id-card"></i> mypage
					</a></li>

					<li><a
						href="${pageContext.request.contextPath}/groupware/notice/noticList"
						data-text=""> <i class="fa-solid fa-comment"></i> 공지사항
					</a></li>

					<c:if test="${sessionScope.userType == 'A'}">
						<li><a href="#" data-text=""> <i
								class="fa-solid fa-gears"></i> 관리자
						</a>
							<ul>
								<li><a
									href="${pageContext.request.contextPath}/admin/emp/list">사원조회</a></li>
								<li><a
									href="${pageContext.request.contextPath}/admin/emp/status">사원현황</a></li>
								<li><a
									href="${pageContext.request.contextPath}/admin/emp/approvalList">결재현황</a></li>
								<li><a
									href="${pageContext.request.contextPath}/admin/emp/hoursMgmt">사원근무기록
										현황</a></li>
							</ul></li>
					</c:if>

					<li><a href="${pageContext.request.contextPath}/tb/logout"
						data-text=""> <i class="fa-solid fa-power-off"></i> 로그아웃
					</a></li>
				</ul>
			</div>
			</div>
		</nav>
	</aside>

	<div id="content" style="margin-top: 8%;">
		<main id="body">
			<h2>
				<a href="list"><i class="fa-solid fa-left-long"></i></a>
			</h2>
			<!-- 내정보-->
			<h2 style="margin-left: 10px;">${tbEmpDto.name}님정보</h2>
			<hr style="width: 133%; border: 1px solid #858e8f;">
			<div class="row flex-box w-1200">
				<div class="w-50 center">
					<img class="target"
						src="${pageContext.request.contextPath}/tb/myImage?loginId=${tbEmpDto.loginId}"
						alt="Profile Image" style="width: 370px; height: 300px;">
				</div>
				<div class="w-50 center">
					<div class="info1-container">
						<div class="info1-item">
							<i class="fa-solid fa-user-pen"></i> <span class="span2">이름:
							</span> <span id="nameDisplay">${tbEmpDto.name}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-clipboard-user"></i> <span class="span2">직급:
							</span> <span id="positionDisplay">${tbEmpDto.empLevel}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-people-group"></i> <span class="span2">부서:
							</span> <span id="departmentDisplay">${tbEmpDto.empDept}</span>
						</div>
						<div class="info1-item">
							<i class="fa-regular fa-clock"></i> <span class="span2">비고:
							</span> <span id="startTimeDisplay">${tbEmpDto.empMemo}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-clock"></i> <span class="span2">산재보험:
							</span> <span id="endTimeDisplay">${tbEmpDto.salSan}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-address-card"></i> <span class="span2">고용보험:
							</span> <span id="employeeIdDisplay">${tbEmpDto.salKo}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-calendar-days"></i> <span class="span2">건강보험:
							</span> <span id="hireDateDisplay">${tbEmpDto.salKun}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-cake-candles"></i> <span class="span2">국민보험:
							</span> <span id="birthDateDisplay">${tbEmpDto.salKuk}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-phone-volume"></i> <span class="span2">보험등록일자:
							</span> <span id="phoneDisplay">${tbEmpDto.salDate}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-envelope"></i> <span class="span2">세전급여:
							</span> <span id="phoneDisplay">${tbEmpDto.salPre}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-envelope"></i> <span class="span2">세후급여:
							</span> <span id="phoneDisplay">${tbEmpDto.salAfter}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-envelope"></i> <span class="span2">계좌번호:
							</span> <span id="phoneDisplay">${tbEmpDto.empAccountNumber}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-envelope"></i> <span class="span2">은행이름:
							</span> <span id="phoneDisplay">${tbEmpDto.empBank}</span>
						</div>

					</div>
					<!-- 수정 버튼 추가 -->


					<form action="${pageContext.request.contextPath}/admin/emp/edit"
						method="post" autocomplete="off">
						<div class="row flex-box w-1200">
							<div id="editForm" class="edit-form">
								<input type="hidden" value="${tbEmpDto.loginId}" name="loginId">
								<h3>정보 수정</h3>
								<div>
									<label for="editName">이름:</label> <input type="text"
										id="editName" value="${tbEmpDto.name}" name="name" readonly>
								</div>

								<div>
									<label for="editPosition">직급:</label> <select name="empLevel"
										class="select0"
										style="padding: 10px; border: 1px solid #ccc; border-radius: 5px; width: calc(100% - 160px);">
										<option value="인턴"
											<c:if test="${tbEmpDto.empLevel == '인턴'}">selected</c:if>>인턴</option>
										<option value="사원"
											<c:if test="${tbEmpDto.empLevel == '사원'}">selected</c:if>>사원</option>
										<option value="주임"
											<c:if test="${tbEmpDto.empLevel == '주임'}">selected</c:if>>주임</option>
										<option value="대리"
											<c:if test="${tbEmpDto.empLevel == '대리'}">selected</c:if>>대리</option>
										<option value="과장"
											<c:if test="${tbEmpDto.empLevel == '과장'}">selected</c:if>>과장</option>
										<option value="차장"
											<c:if test="${tbEmpDto.empLevel == '차장'}">selected</c:if>>차장</option>
										<option value="부장"
											<c:if test="${tbEmpDto.empLevel == '부장'}">selected</c:if>>부장</option>

									</select>

								</div>
								<div>
									<label for="editDepartment">부서:</label> <select name="empDept"
										class="select0"
										style="padding: 10px; border: 1px solid #ccc; border-radius: 5px; width: calc(100% - 160px);">
										<option value="a00"
											<c:if test="${tbEmpDto.empDept == '인사팀'}">selected</c:if>>인사팀</option>
										<option value="a01"
											<c:if test="${tbEmpDto.empDept == '총무팀'}">selected</c:if>>총무팀</option>
										<option value="a02"
											<c:if test="${tbEmpDto.empDept == '영업팀'}">selected</c:if>>영업팀</option>
										<option value="a03"
											<c:if test="${tbEmpDto.empDept == '개발팀'}">selected</c:if>>개발팀</option>
										<option value="a04"
											<c:if test="${tbEmpDto.empDept == '생산팀'}">selected</c:if>>생산팀</option>
									</select>

								</div>
								<div>
									<label for="editStartTime">비고:</label> <input type="text"
										id="editMemo" value="${tbEmpDto.empMemo}" name="empMemo">
								</div>
								<div>
									<label for="editEndTime">산재보험:</label> <input type="text"
										id="editSalSan" value="${tbEmpDto.salSan}" name="SalSan">
								</div>
								<div>
									<label for="editEmployeeId">고용보험:</label> <input type="text"
										id="editEmployeeId" value="${tbEmpDto.salKo}" name="SalKo">
								</div>
								<div>
									<label for="editHireDate">건강보험:</label> <input type="text"
										id="editHireDate" value="${tbEmpDto.salKun}" name="SalKun">
								</div>
								<div>
									<label for="editBirthDate">국민보험:</label> <input type="text"
										id="editBirthDate" value="${tbEmpDto.salKuk}" name="SalKuk">
								</div>
								<div>
									<label for="editPhone">보험등록일자:</label> <input type="date"
										id="editPhone" value="${tbEmpDto.salDate}" name="SalDate">
								</div>
								<div>
									<label for="editEmail">세전급여:</label> <input type="text"
										id="editEmail" value="${tbEmpDto.salPre}" name="SalPre">
								</div>
								<div>
									<label for="editEmail">세전급여:</label> <input type="text"
										id="editEmail" value="${tbEmpDto.salAfter}" name="SalAfter">
								</div>
								<div>
									<label for="editEmail">계좌번호:</label> <input type="text"
										id="editEmail" value="${tbEmpDto.empAccountNumber}"
										name="EmpAccountNumber">
								</div>
								<div>
									<label for="editEmail">은행이름:</label> <input type="text"
										id="editEmail" value="${tbEmpDto.empBank}" name="empBank">
								</div>
							</div>
						</div>
				</div>
				<!-- 내정보 -->



			</div>

			<hr style="width: 133%; border: 1px solid #858e8f;">
			<div class="edit">
				<button id="editButton" class="edit-btn" type="button">수정</button>
				<button id="saveChanges" class="edit-btn hidden" type="submit">저장</button>
			</div>
			</form>
	</div>
	</main>
</body>
</html>
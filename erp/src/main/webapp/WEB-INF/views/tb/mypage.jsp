<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- font awesome icon cdn -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<!-- my css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons.css">
<!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 프로젝트 스타일 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/gotowork.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sidebar.css">
<!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./vacation.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bell.css">
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
}
</style>
<!-- fullcalendar cdn-->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>
<!-- lightpick cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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

<script type="text/javascript">
	$(function() {
		$("[name=empPost],[name=empAddress1], .btn-find-address")
				.click(
						function() {
							new daum.Postcode(
									{
										oncomplete : function(data) {
											var addr = ''; // 주소 변수
											if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
												addr = data.roadAddress;
											} else { // 사용자가 지번 주소를 선택했을 경우(J)
												addr = data.jibunAddress;
											}
											document
													.querySelector("[name=empPost]").value = data.zonecode;
											document
													.querySelector("[name=empAddress1]").value = addr;
											// 커서를 상세주소 필드로 이동한다.
											document.querySelector(
													"[name=empAddress2]")
													.focus();
											$("[name=empPost]")
													.trigger("input");
										}
									}).open();
						});
		$(".btn-clear-address").click(function() {
			$("[name=empPost]").val("");
			$("[name=empAddress1]").val("");
			$("[name=empAddress2]").val("");
		});
		$(".btn-clear-address").hide();
		$("[name=empPost],[name=empAddress1],[name=empAddress2]").on("input",
				function() {
					var len1 = $("[name=empPost]").val().length;
					var len2 = $("[name=empAddress1]").val().length;
					var len3 = $("[name=empAddress2]").val().length;
					if (len1 + len2 + len3 > 0) {
						$(".btn-clear-address").fadeIn();
					} else {
						$(".btn-clear-address").fadeOut();
					}
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
			<a href="#" class="notif-alert"> <i class="fa-solid fa-envelope email"></i></i>
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

			<!-- 내정보-->
			<h2 style="margin-left: 10px;">${tbEmpDto.name}님정보</h2>
			<hr style="width: 133%; border: 1px solid #858e8f;">
			<div class="row flex-box w-1200">
				<div class="w-50 center">
					<img class="target" src="${pageContext.request.contextPath}/tb/myImage?loginId=${tbEmpDto.loginId}" alt="Profile Image" style="width: 370px; height: 300px;">
				</div>
				<div class="w-50 center">
					<div class="info1-container">
						<div class="info1-item">
							<i class="fa-solid fa-user-pen"></i> <span class="span2">이름: </span> <span id="nameDisplay">${tbEmpDto.name}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-clipboard-user"></i> <span class="span2">직급: </span> <span id="positionDisplay">${tbEmpDto.empLevel}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-people-group"></i> <span class="span2">부서: </span> <span id="departmentDisplay">${tbEmpDto.empDept}</span>
						</div>
						<div class="info1-item">
							<i class="fa-regular fa-clock"></i> <span class="span2">출근시간: </span> <span id="startTimeDisplay">${inTime}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-clock"></i> <span class="span2">퇴근시간: </span> <span id="endTimeDisplay">${outTime}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-address-card"></i> <span class="span2">사번: </span> <span id="employeeIdDisplay">${tbEmpDto.empNo}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-calendar-days"></i> <span class="span2">입사일: </span> <span id="hireDateDisplay">${tbEmpDto.empSdate}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-cake-candles"></i> <span class="span2">생년월일: </span> <span id="birthDateDisplay">${tbEmpDto.empBirth}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-phone-volume"></i> <span class="span2">전화번호: </span> <span id="phoneDisplay">${tbEmpDto.empHp}</span>
						</div>
						<div class="info1-item">
							<i class="fa-solid fa-envelope"></i> <span class="span2">이메일: </span> <span id="phoneDisplay">${tbEmpDto.empEmail}</span>
						</div>


						<!--주소-->
						<div class="info1-item">
							<i class="fa-solid fa-map-location-dot"></i> <span class="span2">우편번호: </span> <span id="addressDisplay1">${tbEmpDto.empPost}</span>
						</div>

						<div class="info1-item">
							<i class="fa-solid fa-map-location-dot"></i> <span class="span2">주소: </span> <span id="addressDisplay2">${tbEmpDto.empAddress1}</span>
						</div>

						<div class="info1-item">
							<i class="fa-solid fa-map-location-dot"></i> <span class="span2">상세주소: </span> <span id="addressDisplay3">${tbEmpDto.empAddress2}</span>
						</div>


						<!-- 주소-->

					</div>
					<!-- 수정 버튼 추가 -->


					<!-- 수정 버튼 추가 -->


					
						<div class="row flex-box w-1200">
						<form action="${pageContext.request.contextPath}/tb/edit" method="post" autocomplete="off" enctype="multipart/form-data">
							<div id="editForm" class="edit-form">
							
								<input type="hidden" value="${tbEmpDto.loginId}" name="loginId">
								<h3>정보 수정</h3>
								<div>
									<label for="editName">이름:</label> <input type="text" id="editName" value="${tbEmpDto.name}" name="name">
								</div>

								<div>
									<label for="editPosition">직급:</label> <input type="text" id="editPosition" value="${tbEmpDto.empLevel}" name="empLevel" readonly>
								</div>
								<div>
									<label for="editDepartment">부서:</label> <input type="text" id="editDepartment" value="${tbEmpDto.empDept}" name="empDept" readonly>
								</div>
								<div>
									<label for="editStartTime">출근시간:</label> <input type="text" id="editStartTime" value="${inTime}" disabled>
								</div>
								<div>
									<label for="editEndTime">퇴근시간:</label> <input type="text" id="editEndTime" value="${outTime}" disabled>
								</div>
								<div>
									<label for="editEmployeeId">사번:</label> <input type="text" id="editEmployeeId" value="${tbEmpDto.empNo}" name="empNo" readonly>
								</div>
								<div>
									<label for="editHireDate">입사일:</label> <input type="date" id="editHireDate" value="${tbEmpDto.empSdate}" name="empSdate" readonly>
								</div>
								<div>
									<label for="editBirthDate">생년월일:</label> <input type="date" id="editBirthDate" value="${tbEmpDto.empBirth}" name="empBirth">
								</div>
								<div>
									<label for="editPhone">전화번호:</label> <input type="text" id="editPhone" value="${tbEmpDto.empHp}" name="empHp">
								</div>
								<div>
									<label for="editEmail">이메일:</label> <input type="text" id="editEmail" value="${tbEmpDto.empEmail}" name="empEmail">
								</div>
								<!--주소-->
								<div>
									<label for="editAddress1">우편번호:</label> <input class="address1" id="editAddress1" name="empPost" type="text" placeholder="" required="" style="width: 30%;" value="${tbEmpDto.empPost }">
								</div>
								<div>
									<label for="editAddress2">주소:</label> <input class="address2" id="editAddress2" name="empAddress1" type="text" placeholder="" required="" value="${tbEmpDto.empAddress1 }"> </label>
								</div>

                        <div>
                            <label for="editAddress3">상세주소:</label>
                                <input class="address3"   id="editAddress3" name="empAddress2" type="text" placeholder="" required=""
                                value="${tbEmpDto.empAddress2}">
                      </div>
                      <div>
                        <label for="editImage">이미지</label>
                        <input type="file" id="editImage" name="attach" accept="image/*">
                    </div>
                  </div>
          </div>
              </div>
        	</div>
           <!-- 내정보 -->           
        	<hr style="width: 133%; border: 1px solid #858e8f;">
         			 <div class="edit">
          			<c:if test="${tbEmpDto.loginId == sessionScope.createdUser}">
            		<button id="editButton" class="edit-btn" type="button">수정</button>
            		<button id="saveChanges" class="edit-btn hidden" type="submit">저장</button>           	
          			</c:if>
                    </div>
          </form>
      </div>
   </main>

</body>
</html>
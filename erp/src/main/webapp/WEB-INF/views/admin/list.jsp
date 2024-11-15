<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로젝트 최종 폼</title>
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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons.css">
<!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->

<!-- 프로젝트 스타일 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/gotowork.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sidebar.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/notic.css">
<!-- <link rel="stylesheet" type="text/css" href="./vacation.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->


<style>
.btn-write {
	background-color: #99c2ff !important;
	color: white;
	border-radius: 0.2em;
	border: 1px solid #cde1ff !important;
}

.btn-write:hover {
	background-color: #dde6f3 !important;
	color: #66a2fc;
}

.btn-delete {
	background-color: #d63031 !important;
	color: white;
	border-radius: 0.2em;
	border: 1px solid #cde1ff !important;
}

.btn-delete:hover {
	background-color: #ff7675 !important;
	color: black;
}

.tb th, .tb td {
	padding: 10px;
}

.tb tr {
	border-bottom: 1px solid #ddd;
}

.tb tbody tr {
	height: 40px;
}

.tb {
	border-top: 1px solid #7f8c8d;
	border-bottom: 1px solid #7f8c8d;
	width: 300%;
	border-collapse: collapse;
	font-size: 20px;
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
<script src="${pageContext.request.contextPath}/js/checkbox.js"></script>
<script src="${pageContext.request.contextPath}/js/confirm-link.js"></script>
<script src="${pageContext.request.contextPath}/js/multipage.js"></script>

<!-- 프로젝트 js-->
<script src="${pageContext.request.contextPath}/js/gotoworkbtn.js"></script>
<script src="${pageContext.request.contextPath}/js/menuToggle.js"></script>

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

	<div id="content">

		<main id="body">
			<div id="content">




				<div class="container my-50">
					<div class="row center">
						<h1>관리자용 사원 조회</h1>
					</div>
					<h2>
						<a href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-left-long"></i></a>
					</h2>

					<!-- 검색창 -->
					<form action="list" method="get" autocomplete="off">
						<div class="row">
							<select name="column" class="field">
								<option value="name"
									<c:if test="${param.column == 'name'}">selected</c:if>>사원명</option>
								<option value="emp_dept"
									<c:if test="${param.column == 'emp_dept'}">selected</c:if>>부서</option>
							</select> <input type="text" name="keyword" value="${param.keyword}"
								class="field">
							<button class="btn btn-neutral">검색</button>
						</div>
					</form>
					<!-- 결과 화면 -->
					<div class="tb-box">
						<table class="tb">
							<thead>
								<tr>
									<th>사진</th>
									<th>사원명</th>
									<th>이메일</th>
									<th>직급</th>
									<th>부서</th>
									<th>입사일</th>

									<th>삭제하기</th>
								</tr>
							</thead>
							<tbody align="center">
								<c:choose>
									<c:when test="${list.isEmpty()}">
										<%-- 결과가 없을 때 --%>
										<tr>
											<td colspan="5">결과가 존재하지 않습니다</td>
										</tr>
									</c:when>
									<c:otherwise>
										<%-- 결과가 있을 때 --%>
										<c:forEach var="tbEmpDto" items="${list}">
											<tr>
												<td><img src="${pageContext.request.contextPath}/tb/myImage?loginId=${tbEmpDto.loginId}"
													width="25"></td>
												<td><a href="detail?loginId=${tbEmpDto.loginId}">
														${tbEmpDto.name} </a></td>
												<td>${tbEmpDto.empEmail}</td>
												<td>${tbEmpDto.empLevel}</td>
												<td>${tbEmpDto.empDept}</td>
												<td>${tbEmpDto.empSdate}</td>
												<td><a href="delete?loginId=${tbEmpDto.loginId}">퇴사</a></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>

							</tbody>
						</table>

					</div>

					<!-- 네비게이터 추가 -->
					<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
				</div>
				
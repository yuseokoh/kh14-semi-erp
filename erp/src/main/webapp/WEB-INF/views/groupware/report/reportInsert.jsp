<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>일일 업무 보고서</title>
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

<!-- 프로젝트 스타일 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/gotowork.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sidebar.css">
<!--<link rel="stylesheet" type="text/css" href="/css/notic.css">-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vacation.css">
<!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->


<style>
.note-editable {
	background-color: white;
}
/* bold와 italic이 적용되지 않는 문제를 수정하도록 코드 추가 */
.note-editable b {
	font: inherit;
	font-weight: 700 !important;
	font-style: inherit;
}

.note-editable i {
	font: inherit;
	font-weight: inherit;
	font-style: italic !important;
}

input[readonly] {
	pointer-events: none;
}
</style>



<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/checkbox.js"></script>
<script src="${pageContext.request.contextPath}/js/confirm-link.js"></script>
<script src="${pageContext.request.contextPath}/js/multipage.js"></script>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

<!-- 프로젝트 js-->
<script src="${pageContext.request.contextPath}/js/gotoworkbtn.js"></script>
<script src="${pageContext.request.contextPath}/js/menuToggle.js"></script>
<!-- chart js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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


				<!-- 보고서 작성 작성 -->
				<form method="post" autocomplete="off" action="insert" id="markdownForm">
					<body>
						<div class="container w-900">
							<div class="title">일일 업무 보고서</div>

							<div class="table-container">
								<table class="table">
									<label>결재자</label>
									<thead>
										<tr>
											<th>직급</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><img src="https://via.placeholder.com/200"></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="row center w-50">
								<label>보고서 제목</label> <input type="text" class="form" name="reportTitle">
							</div>
							<div class="row flex-box">
								<div>
									<div class="row">
										<label>사원명</label> <input type="text" class="filed form" value="${tbEmpDto.name}" name="writerName" readonly>
									</div>
								</div>
							</div>

							<div class="row">
								<div>
									<label>사원번호</label> <input type="text" class="filed form" value="${tbEmpDto.empNo}" readonly>
								</div>
								<div>
									<label>직급</label> <input type="text" class="filed form" value="${tbEmpDto.empLevel}" readonly>
								</div>
								<div>
									<label>부서</label> <input type="text" class="filed form" value="${tbEmpDto.empDept}"  name="writerDept" readonly>
								</div>
							</div>


							<div class="row flex-box" style="position: relative;">
								<div>
									<label>금일목표</label>
									<textarea name="reportContent" class="field w-100 form" style="padding-right: 100px;" placeholder="Write your markdown here..." rows="10"></textarea>
									<button type="submit" class="btn btn-positive">작성</button>
								</div>
							</div>
						</div>
					</body>
				</form>
				<!-- 이곳에서부터 <footer>  -->
			</div>
		</main>
</body>
</html>

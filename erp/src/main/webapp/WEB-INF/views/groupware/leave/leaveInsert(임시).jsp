<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로젝트 최종 폼</title>

<!-- google font cdn -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- font awesome icon cdn -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<!-- my css -->
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->

<!-- 프로젝트 스타일 -->
<link rel="stylesheet" type="text/css" href="/css/gotowork.css">
<link rel="stylesheet" type="text/css" href="/css/sidebar.css">
<!-- <link rel="stylesheet" type="text/css" href="/css/notic.css"> -->
<link rel="stylesheet" type="text/css" href="/css/vacation.css">
<!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->


<style>
.title1 {
	width: 70% !important;
	height: 40px;
	margin-right: 40%
}

input[readonly] {
	pointer-events: none;
}
</style>



<!-- lightpick cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="/js/checkbox.js"></script>
<script src="/js/confirm-link.js"></script>
<script src="/js/multipage.js"></script>

<!-- 프로젝트 js-->
<script src="/js/gotoworkbtn.js"></script>
<script src="/js/menuToggle.js"></script>
<!-- chart js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>




<!-- 자바스크립트 코드 작성 영역 -->
<script type="text/javascript">
	$(function() {
		var picker7 = new Lightpick({
			field : document.querySelector(".test7-1"),//설치대상1
			secondField : document.querySelector(".test7-2"),//설치대상2
			singleDate : false,//하루만 선택하는 모드를 해제
			format : "YYYY-MM-DD",//날짜의 표시 형식(momentJS 형식)
			firstDay : 7,//일요일부터 표시
			numberOfMonths : 4,//표시할 월의 수
			numberOfColumns : 2,//한줄에 표시할 월의 수
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
			<a href="#" class="notif-alert"> <i class="fa-solid fa-envelope email"></i></i> <span class="notif-count content">0</span>
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
			<div class="row">
				<ul class="menu-hover-fill">
					<li><a href="/" data-text="home">HOME</a></li>

					<li><a href="/poketmon/list" data-text=""> <i class="fa-solid fa-file-signature"></i> 그룹웨어(poketmon)
					</a>
						<ul>
							<li><a href="#">휴가신청서</a></li>
							<li><a href="#">보고서(수인씨작성중)</a></li>
						</ul></li>

					<li><a href="/emp/list" data-text=""> <i class="fa-solid fa-cart-flatbed"></i> 재고관리(emp)
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

	<div id="content">
		<main id="body">
			<div id="content">


				<!-- 휴가 신청서 작성 -->
				<body>
					<div class="container w-900">
						<div class="title">휴가신청서</div>
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
										<td>서명칸</td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="row">
							<label>제목</label> <input type="text" class="form title1" name="vacaTitle">
						</div>
						<div class="row">
							<div class="row">
								<label>사원명</label> <input type="text" class="filed form disabled" name="applicantId" value="${tbEmpDto.name}" readonly>
							</div>
						</div>

						<div class="row">
							<div>
								<label>사원번호</label> <input type="text" class="form" name="empNo" value="${tbEmpDto.empNo}" readonly>
							</div>
							<div>
								<label>직급</label> <input type="text" class="form" name="empNo" value="${tbEmpDto.empNo}" readonly>
							</div>
							<div>
								<label>부서</label> <input type="text" class="form" name="empDept" value="${tbEmpDto.empDept}" readonly>
							</div>
						</div>

						<div class="row">
							<div>
								<label>EMAIL</label> <input type="text" class="form" name="empEmail" value="${tbEmpDto.empEmail}" readonly>
							</div>
							<div>
								<label>비상 연락처</label> <input type="text" class="form" placeholder="00011112222" name="vacaTel">
							</div>
						</div>

						<div class="row flex-box">
							<div class="w-50">
								<label>휴가 시작일</label> <input type="text" class="field w-100 test7-1 form" name="vacaSdate">
							</div>
							<div class="w-50">
								<label>휴가 종료일</label> <input type="text" class="field w-100 test7-2 form" name="vacaEdate">
							</div>
						</div>

						<div class="row">
							<div>
								<label>휴가 종류</label> <select class="form" name="vacaType">
									<option value="" class="text-secondary">휴가 종류</option>
									<option value="개인사유">개인사유</option>
									<option value="연차">연차</option>
									<option value="병가">병가</option>
								</select>
							</div>
						</div>

						<div class="row flex-box" style="position: relative;">
							<div>
								<label>휴가 사유</label>
								<textarea class="field w-100 form" rows="3" style="padding-right: 100px;" name="vacaReason"></textarea>
								<button type="submit" class="btn btn-positive">휴가신청</button>
							</div>
						</div>
					</div>

				</body>

				<!-- 이곳에서부터 <footer>  -->
			</div>

		</main>
</body>
</html>

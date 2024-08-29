<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>보고서 수정</title>

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
<!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
<link rel="stylesheet" type="text/css" href="/css/vacation.css">
<!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->


<style>
.btn-container {
	position: relative;
	margin-top: 10px;
}

.btn-positive {
	background-color: #99c2ff !important;
	color: white;
	border-radius: 0.2em;
	border: 1px solid #cde1ff !important;
}

.btn-positive:hover {
	background-color: #dde6f3 !important;
	color: #66a2fc;
}

.title1 {
	width: 70% !important;
	height: 40px;
	margin-right: 40%
}

#preview {
	border: 1px solid #ddd;
	padding: 10px;
	font-size: 10px;
}
/* 숨김 클래스 추가 */
.hidden {
	display: none;
}
</style>
<!-- lightpick cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
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
	
</script>

<script type="text/javascript">
	$(function() {
		// 초기에 textarea 숨기기
		$('#preview').addClass('show').prop('disabled', true);
		$('.reason-textarea').addClass('hidden').prop('disabled', true);
		// 수정 버튼 클릭 시 동작
		$('.btn-positive').on(
				'click',
				function() {
					// textarea를 보이게 하고 수정할 수 있도록 설정
					$('#preview').removeClass('show').addClass('hidden');
					$('.reason-textarea').removeClass('hidden').prop(
							'disabled', false);
					// 버튼 텍스트와 스타일 변경
					$(this).text('수정완료').removeClass('btn-positive').addClass(
							'btn-warning');
					$('.btn-warning').on(
							'click',
							function() {

								var reportContent = $('.reason-textarea').val();
								console.log(reportContent);
								$('.reason-textarea').addClass('hidden').prop(
										'disabled', true);
								$('#preview').removeClass('hidden').addClass(
										'show').prop('disabled', true);
								$(this).text('수정완료').addClass('hidden');

								//비동기통신해서 내용만 바꾸기
								$.ajax({
									url : '/rest/report/update', // 요청할 URL
									type : 'POST', // 요청 방법 (GET, POST, PUT, DELETE 등)
									data : { // 서버에 보낼 데이터 (필요에 따라 JSON, 폼 데이터 등)
										reportContent : reportContent,
										approNo : $('[name=approNo]').val(),
										approYN : $('[name=approYN]').val(),
										reportNo : $('[name=reportNo]').val(),
										reportTitle : $('[name=reportTitle]').val(),
									},
									success : function(response) { // 요청이 성공했을 때 호출되는 함수
										console.log('Success:', response);
									},
									error : function(xhr, status, error) { // 요청이 실패했을 때 호출되는 함수
										console.error('Error:', error);
									}
								});
							});

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



				<!-- 보고서 수정 -->
				<div class="container w-900">
					<div class="title">일일 업무 보고서</div>

					<div class="table-container">
						<table class="table form">
							<label>결재자</label>
							<thead>
								<tr>
									<th>직급</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>여기에style="width: 50px; height: 50px;"짜리 서명만들고싶음</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="row">
						<label>제목</label> <input type="text" name="reportTitle" class="form title1" value="${tbEmpReportDto.reportTitle}">
					</div>

					<div class="row">
						<label>사원명</label> <input type="text" class="filed form " value="${tbEmpReportDto.writerName}" readonly>
					</div>

					<div class="row">
						<div>
							<label>사원번호</label> <input type="text" class="form " value="${tbEmpDto.empNo}" readonly>
						</div>
						<div>
							<label>직급</label> <input type="text" class="form " value="${tbEmpReportDto.writerDept}" readonly>
						</div>
						<div>
							<label>부서</label> <input type="text" class="form " value="${tbEmpDto.empDept}" readonly>

						</div>
					</div>
					
					<!-- 이거도 전송해야댐 why? 수정위해서 -->
					<input type="hidden" name="approNo" value="${tbEmpApprovalDto.approNo}">
					<input type="hidden" name="approYN" value="${tbEmpApprovalDto.approYN}">
					<input type="hidden" name="reportNo" value="${tbEmpReportDto.reportNo}">


					<div class="row flex-box btn-container" style="justify-content: space-between;">
						<textarea id="markdown" class="field w-100 form reason-textarea hidden" rows="3" style="padding-right: 100px;">${tbEmpReportDto.reportContent}</textarea>
						<div id="preview"></div>
						<button type="button" class="btn btn-positive submit flex-core">수정</button>
					</div>
				</div>
			</div>





			<footer id="footer">
				<!-- Footer content here -->
			</footer>
			<script type="text/javascript">
				document.addEventListener('DOMContentLoaded', function() {
					const textarea = document.getElementById('markdown');
					const preview = document.getElementById('preview');

					function updatePreview() {
						const markdownText = textarea.value;
						preview.innerHTML = marked.parse(markdownText);
					}

					textarea.addEventListener('input', updatePreview);
					updatePreview(); // 초기 렌더링
				});
			</script>
</body>
</html>


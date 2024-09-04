<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항</title>

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
<!-- <link rel="stylesheet" type="text/css" href="/css/notic.css"> -->
<link rel="stylesheet" type="text/css" href="/css/vacation.css">
<!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->


<style>
</style>



<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="/js/checkbox.js"></script>
<script src="/js/confirm-link.js"></script>
<script src="/js/multipage.js"></script>


<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

<!-- 프로젝트 js-->
<script src="/js/gotoworkbtn.js"></script>
<script src="/js/menuToggle.js"></script>
<script src="/js/delete.js"></script>
<!-- chart js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- 자바스크립트 코드 작성 영역 -->
<script type="text/javascript">
function createChart(url,selector,legend='',type='bar'){
    //step 1 - 차트를 만들기 위해 필요한 데이터 요청
    //step 2 - 데이터를 이용해 차트를 생성
//step 1
$.ajax({
    url: url,
    method:"post",
    success:function(response){
        //response는 객체 배열 형태[{...},{...}]
        // console.log(response);

        //response를 두개로 분리
        var names = [];
        var values = [];

        for(var i=0;i<response.length;i++){
            names.push(response[i].title);//title을 names 에 추가
            values.push(response[i].cnt);//cnt를 values에 추가
        }
        

        //step 2
         //차트를 그릴 대상 선택
const ctx = document.querySelector(selector);
//차트 생성 코드
//new Chart(캔버스태그)
new Chart(ctx, {
    type: type,//차트 유형(bar/pie/doughnut/line)
    data: {
        //차트에 표시되는 항목(x축)
        labels: names,
        //실제로 차트에 표시될 값
        datasets: [{
            label: legend,//범례
            data: values,//데이터
            borderWidth: 1,//디자인 속성(테두리 두께)
            barThickness: 50 // 막대 너비 조정
        }]
    },
    options: {
        scales: {
            y: {
            	 ticks: {
                     stepSize: 1 // 눈금 간격을 1로 설정
                 }
            }
        }
    }
});
    }
}
)};

$(function(){
    createChart("http://localhost:8080/rest/emp/status/hi",".emp-new-chart","입사자 수", "bar");
    createChart("http://localhost:8080/rest/emp/status/bye",".emp-bye-chart","퇴사자 수", "bar");
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

					<li><a href="#" data-text=""> <i class="fa-solid fa-cart-flatbed"> </i> 재고관리(emp)
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

	<div id="content" style="margin-top: 10px;">
		<main id="body">



			<!-- 입퇴사자 어쩌고-->

			<div class="row flex-box w-1200">
				<div class="w-50 center">
					<h1 class="center">신규 입사자 현황</h1>
					<canvas class="emp-new-chart"></canvas>
				</div>

				<div class="w-50 center">
					<h1 class="center">퇴사자 현황</h1>
					<canvas class="emp-bye-chart"></canvas>
				</div>

			</div>


			<div class="row flex-box w-1200">
				<div class="w-50 center">
					<h1 class="center">입사일 현황</h1>
					<table border="1">
						<thead>
							<tr>
								<th>입사일</th>
								<th>인원 수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${empSdateList}">
								<tr>
									<td>${item.entryDate}</td>
									<td>${item.cnt}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<div class="w-50 center">
					<h1 class="center">퇴사자 현황</h1>
					<table border="1">
						<thead>
							<tr>
								<th>사원 번호</th>
								<th>이름</th>
								<th>근무일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${workingDayList}">
								<tr>
									<td>${item.empNo}</td>
									<td>${item.name}</td>
									<td>${item.workingDays}일</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

			</div>
			<a href="/admin/home">홈으로</a>
	</div>


	<!-- 입퇴사자 어쩌고 여기까지-->

	<!-- 이곳에서부터 <footer>  -->
	</div>
	</main>
</body>
</html>
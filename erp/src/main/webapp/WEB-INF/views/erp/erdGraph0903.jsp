<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리별 수량 차트</title>

 <!-- google font cdn -->
 <link rel="preconnect" href="https://fonts.googleapis.com">
 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
 <!-- font awesome icon cdn -->
 <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
     <!-- SweetAlert2 CDN -->
     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
 <!-- my css -->
 <link rel="stylesheet" type="text/css" href="./commons.css">
 <!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->

  <!-- 프로젝트 스타일 --> 
  <link rel="stylesheet" type="text/css" href="./gotowork.css">
  <link rel="stylesheet" type="text/css" href="./sidebar.css">
  <!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
  <!-- <link rel="stylesheet" type="text/css" href="./vacation.css"> -->
  <!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
  <!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
  <!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
  <!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
  <!-- <link rel="stylesheet" type="text/css" href="./alertA.css"> -->
  <!-- <link rel="stylesheet" type="text/css" href="./alertBtn.css"> -->
  
  <!-- jquery cdn -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="checkbox.js"></script>
  <script src="confirm-link.js"></script>
  <script src="multipage.js"></script>

    <!-- summernote cdn -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

  <!-- 프로젝트 js-->
  <script src="gotoworkbtn.js"></script>
  <script src="menuToggle.js"></script>
  <!-- <script src="delete.js"></script> -->
  <!-- <script src="alertDeleteA.js"></script> -->

  <!-- chart js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <style>

    h1 {
        text-align: center;
        color: #ffffff; /* 헤더 텍스트 색상을 흰색으로 설정 */
        background-color: wheat; /* 부드러운 핑크색 배경 */
        padding: 20px;
        margin: 0;
        margin-top: 15%;
    }
    body {
            font-family: Arial, sans-serif;
            background-color: rgb(220, 220, 220);
            margin: 0;
            padding: 0;
            margin-left: 120px;
        }
        .button-container {
    position: relative; 
    top: 10px;
    left: 92.5%; 
}
    .button {
        background-color: wheat;/* 버튼 배경색 흰색 */
        color: #ffffff; /* 버튼 텍스트 색상 부드러운 핑크색 */
        border: 2px solid wheat;/* 버튼 테두리 색상 부드러운 핑크색 */
        padding: 10px 20px;
        border-radius: 5px;
        font-size: 16px;
        text-decoration: none;
        text-align: center;
        display: inline-block;
        transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
    }
    .button:hover {
        background-color: antiquewhite;/* 버튼 호버 시 배경색 부드러운 핑크색 */
        color: white; /* 버튼 호버 시 텍스트 색상 흰색 */
        border-color: antiquewhite; /* 버튼 호버 시 테두리 색상 부드러운 핑크색 */
    }
    .charts-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr); /* 두 개의 열 생성 */
        grid-template-rows: repeat(2, 1fr); /* 두 개의 행 생성 */
        gap: 10px; /* 차트들 사이의 간격 줄임 */
        margin-top: 30px;
    }
    .chart-container {
        background-color: #ffffff; /* 차트 배경색을 흰색으로 설정 */
        padding: 10px; /* 패딩 줄임 */
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
    }
    #barChart {
        grid-column: 1 / 2; /* 첫 번째 열 */
        grid-row: 1 / 2; /* 첫 번째 행 */
        height: 200px; /* 차트 높이 설정 */
    }
    #pieChart {
        grid-column: 2 / 3; /* 두 번째 열 */
        grid-row: 1 / 2; /* 첫 번째 행 */
        height: 200px; /* 차트 높이 설정 */
    }
    #lineChart {
        grid-column: 1 / 2; /* 첫 번째 열 */
        grid-row: 2 / 3; /* 두 번째 행 */
        height: 400px; /* 차트 높이 설정 */
    }
    #radarChart {
        grid-column: 2 / 3; /* 두 번째 열 */
        grid-row: 2 / 3; /* 두 번째 행 */
        height: 400px; /* 차트 높이 설정 */
    }
    canvas {
        max-width: 100%;
        height: auto;
    }
</style>

  <!-- 자바스크립트 코드 작성 영역 -->
  <script type="text/javascript">
        // 서버에서 전달된 데이터를 JSON 문자열로 변환 후 파싱
        var categoryMap = ${categoryMapJson};

        // 데이터 추출
        var labels = Object.keys(categoryMap);
        var data = Object.values(categoryMap);

        // 바 차트 생성
        var ctxBar = document.getElementById('barChart').getContext('2d');
        var barChart = new Chart(ctxBar, {
            type: 'bar', // 'line', 'pie', 등 다른 유형을 사용할 수 있습니다.
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

        // 파이 차트 생성
        var ctxPie = document.getElementById('pieChart').getContext('2d');
        var pieChart = new Chart(ctxPie, {
            type: 'pie', // 파이 차트 유형
            data: {
                labels: labels,
                datasets: [{
                    label: '재고 수량',
                    data: data,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(tooltipItem) {
                                return tooltipItem.label + ': ' + tooltipItem.raw;
                            }
                        }
                    }
                }
            }
        });

        // 라인 차트 생성
        var ctxLine = document.getElementById('lineChart').getContext('2d');
        var lineChart = new Chart(ctxLine, {
            type: 'line', // 라인 차트 유형
            data: {
                labels: labels,
                datasets: [{
                    label: '재고 수량',
                    data: data,
                    fill: false,
                    borderColor: 'rgba(75, 192, 192, 1)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    x: {
                        beginAtZero: true
                    },
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // 레이더 차트 생성
        var ctxRadar = document.getElementById('radarChart').getContext('2d');
        var radarChart = new Chart(ctxRadar, {
            type: 'radar', // 레이더 차트 유형
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
                    r: {
                        beginAtZero: true
                    }
                }
            }
        });
</script>
</head>
<body>  
    <header id="header">
        <div id="menuToggle"><i class="fa fa-bars"></i></div>
        <div id="logo">
            <a href="#" class="notif-alert">
                <i class="fa-solid fa-envelope email"></i></i>
                <span class="notif-count content">0</span>
            </a>
            <a href="#"><i class="fa-solid fa-circle-user user"></i></a> 
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
						<span id="cur-date"></span><br>
						<span id="cur-time"></span>
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

                        <li><a href="/poketmon/list" data-text="">
                            <i class="fa-solid fa-file-signature"></i> 그룹웨어(poketmon) </a>
                            <ul>
                                <li><a href="#">휴가신청서</a></li>
                                <li><a href="#">보고서(수인씨작성중)</a></li>
                            </ul>
                        </li>

                        <li><a href="/emp/list" data-text="">
                            <i class="fa-solid fa-cart-flatbed"></i> 재고관리(emp)</a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>

                        <li><a href="/book/list" data-text="">
                            <i class="fa-solid fa-people-group"></i> 인사관리(book)</a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>

                        <li><a href="/member/mypage" data-text="">
                            <i class="fa-solid fa-id-card"></i> mypage</a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>

                        <li><a href="/board/list" data-text="">
                            <i class="fa-solid fa-comment"></i> 예비용</a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>

                        <c:if test="${sessionScope.createdLevel == '관리자'}">
                            <li><a href="/admin" data-text="">
                                <i class="fa-solid fa-gears"></i> 관리자</a>
                            </li>
                        </c:if>

                        <li><a href="/logout" data-text="">
                            <i class="fa-solid fa-power-off"></i> 로그아웃</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </aside>
    
    <div id="content">
        
       <main id="body"> 
           <div id="content">
            <!-- 재고 목록 -->
         
            <h1>카테고리 수량 차트</h1>
    
            <!-- 버튼 컨테이너 -->
            <div class="button-container">
                <a href="list" class="button">목록으로</a>
            </div>
            
            <!-- 차트 그리드 컨테이너 -->
            <div class="charts-grid">
                <!-- 바 차트 컨테이너 -->
                <div class="chart-container">
                    <canvas id="barChart"></canvas>
                </div>
                
                <!-- 파이 차트 컨테이너 -->
                <div class="chart-container">
                    <canvas id="pieChart"></canvas>
                </div>
                
                <!-- 라인 차트 컨테이너 -->
                <div class="chart-container">
                    <canvas id="lineChart"></canvas>
                </div>
                
                <!-- 레이더 차트 컨테이너 -->
                <div class="chart-container">
                    <canvas id="radarChart"></canvas>
                </div>
            </div>



</div>
</div>
</body>
</html>

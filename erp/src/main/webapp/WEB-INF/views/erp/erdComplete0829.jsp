<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록 완료</title>

 <!-- google font cdn -->
 <link rel="preconnect" href="https://fonts.googleapis.com">
 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
 <!-- font awesome icon cdn -->
 <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
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
  <!-- chart js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
         body {
            font-family: Arial, sans-serif;
            background-color:rgb(220, 220, 220);
            margin: 0;
            padding: 0;
        }

        h1 {
            color: #555555; /* 헤더 텍스트 색상을 흰색으로 설정 */
        }

        .container1 {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 20px;
            background-color: #ffffff; /* 컨테이너 배경색을 흰색으로 설정 */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 600px;
            
        }

        p {
            font-size: 18px;
            color: #555555;
            margin: 20px 0;
        }

        .a1 {
            color: #ffffff;/* 링크 색상을 부드러운 핑크색으로 설정 */
            text-decoration: none;
            font-weight: bold;
            padding: 10px 20px;
            background-color: #99c2ff;/* 링크 배경색을 흰색으로 설정 */
            border: 1px solid #99c2ff; /* 링크 테두리를 부드러운 핑크색으로 설정 */
            border-radius: 5px;
            display: inline-block;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .a1:hover {
            background-color: #cde1ff; /* 링크 호버 시 배경색을 부드러운 핑크색으로 설정 */
            color: #ffffff; /* 링크 호버 시 텍스트 색상을 흰색으로 설정 */
            text-decoration: none;
        }
</style>

  <!-- 자바스크립트 코드 작성 영역 -->
  <script type="text/javascript">
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
            <!-- 등록화면 -->
            <div class="container1">
                <h1>재고 등록 완료</h1>
                <p>재고가 성공적으로 등록되었습니다.
                    <i class="fa-solid fa-thumbs-up"></i>
                </p>
                <a class="a1" href="list">목록으로 돌아가기</a>
            </div>


</div>
</div>
</body>
</html>

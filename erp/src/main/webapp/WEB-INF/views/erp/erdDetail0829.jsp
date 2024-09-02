<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 상세</title>

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
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container1 {
            background-color: #ffffff; 
            border-radius: 10px;
            padding: 20px 30px;
            max-width: 600px;
            width: 600px;
            text-align: center;
        }

        h1 {
            color: #99c2ff; /* 헤더 텍스트 색상을 부드러운 핑크색으로 설정 */
            font-size: 24px;
            margin-bottom: 20px;
            background-color: #ffffff; /* 헤더 배경색을 흰색으로 설정 */
            padding: 10px 0;
            border-bottom: 2px solid #99c2ff;/* 헤더 하단에 부드러운 핑크색 테두리 추가 */
        }

        .info {
            margin: 15px 0;
            font-size: 18px;
            color: #555555;
        }

        .info strong {
            color: #333333;
            font-weight: bold;
        }

        .product-image {
            max-width: 100%;
            max-height: 200px;
            border-radius: 10px;
            margin-bottom: 20px;
            margin-top: 20px;
        }

        .button-container {
            margin-top: 20px;
            justify-content: space-between;
        }

         .a1 {
            color: #ffffff; /* 링크 텍스트 색상을 흰색으로 설정 */
            text-decoration: none;
            padding: 10px 52px;
            border-radius: 5px;
            background-color: #99c2ff;  /* 버튼 배경색을 부드러운 핑크색으로 설정 */
            transition: background-color 0.3s ease;
            width: 70px;
            height: 45px;
            margin: 15px 15px;
         } 

        .a1:hover {
            background-color: #cde1ff; /* 버튼 호버 시 배경색을 약간 어두운 핑크색으로 설정 */
        } 

        .back-link {
            background-color: #e0e0e0; /* '목록으로' 링크 배경색을 연한 회색으로 설정 */
            color: #333333; /* 텍스트 색상을 어두운 회색으로 설정 */
        }

        .back-link:hover {
            background-color: #bdbdbd; /* 버튼 호버 시 배경색을 약간 어두운 회색으로 설정 */
            color: #000000; /* 호버 시 텍스트 색상을 검은색으로 설정 */
        }

        .form-container {
            margin-top: 20px;
            text-align: center;
        }

        .form-container input {
            padding: 8px;
            margin: 5px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 16px;
        }

        .form-container button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #99c2ff;
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin: 5px;
        }

        .form-container button:hover {
            background-color: #cde1ff;
        }

        .error-message {
            color: red;
            font-weight: bold;
            margin-top: 10px;
        }

        .success-message {
            color: green;
            font-weight: bold;
            margin-top: 10px;
        }

        .form:focus {
    color: #495057;
    background-color: #fff;
    border-color: #80bdff;
    outline: 0;
    box-shadow: 0 0 0 .2rem rgba(0, 123, 255, .25);
}
.form {
    line-height: 1.5;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 4px;
    transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
    margin-bottom: 0.5rem; /* Add margin bottom to create space between input fields */
}
</style>

  <!-- 자바스크립트 코드 작성 영역 -->
  <script type="text/javascript">
 function confirmAction(actionType) {
            return confirm(actionType + " 하시겠습니까? 변동 수량을 잘 확인하세요 ");
        }
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
            <div class="container1">
                <h1>재고 상세 정보</h1>
                <div class="info"><strong> <i class="fa-solid fa-barcode"></i>  시리얼 번호:</strong> ${dto.stockNo}</div>
                <div class="info"><strong> <i class="fa-solid fa-layer-group"></i>  카테고리:</strong> ${dto.stockCategory}</div>
                <div class="info"><strong> <i class="fa-solid fa-cart-flatbed"></i>  이름:</strong> ${dto.stockName}</div>
                <div class="info"><strong> <i class="fa-solid fa-boxes-stacked"></i>  수량:</strong> ${dto.stockQuantity}</div>
                <div class="info"><strong>  <i class="fa-solid fa-truck-ramp-box"></i>  등록 일자:</strong> <fmt:formatDate value="${dto.stockDate}" pattern="yyyy-MM-dd" /></div>
                <div class="info"><strong>  <i class="fa-regular fa-calendar-check"></i>  유통 기한:</strong> <fmt:formatDate value="${dto.expirationDate}" pattern="yyyy-MM-dd" /></div> <!-- 유통 기한 추가 -->
        
                <!-- 입고 처리 폼 -->
                <div class="form-container">
                    <form action="${pageContext.request.contextPath}/stock/increaseQuantity" method="post" onsubmit="return confirmAction('입고');">
                        <input class="form" type="hidden" name="stockNo" value="${dto.stockNo}" />
                        <input class="form" type="number" name="amount" placeholder="입고 수량" min="1" required />
                        <button type="submit">입고</button>
                    </form>
        
                    <!-- 출고 처리 폼 -->
                    <form action="${pageContext.request.contextPath}/stock/decreaseQuantity" method="post" onsubmit="return confirmAction('출고');">
                        <input class="form" type="hidden" name="stockNo" value="${dto.stockNo}" />
                        <input class="form" type="number" name="amount" placeholder="출고 수량" min="1" required />
                        <button type="submit">출고</button>
                    </form>
                </div>
        
                <div class="button-container">
                    <a class="a1" href="edit?stockNo=${dto.stockNo}"> 수정</a>
                    <a class="a1" href="list" class="back-link">목록</a>
                </div>
        
                <!-- 메시지 표시 -->
                <c:if test="${not empty error}">
                    <div class="error-message">처리 중 오류가 발생했습니다. ${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="success-message">처리가 완료되었습니다! ${success}</div>
                </c:if>
            </div>


</div>
</div>
</body>
</html>

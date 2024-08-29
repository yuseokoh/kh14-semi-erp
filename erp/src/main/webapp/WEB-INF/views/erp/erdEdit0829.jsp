<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 수정</title>

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
            background-color: rgb(220, 220, 220);
            margin: 0;
            padding: 0;
        }

        .container1 {
            max-width: 600px;
            /* margin: ; 수평 가운데 정렬 */
            padding: 20px;
            background-color: #ffffff; /* 폼 배경색 흰색 */
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 600px;
            margin-top: 80px;
        }

        h1 {
            text-align: center;
            color: #99c2ff;  /* 부드러운 핑크색 헤더 텍스트 */
            margin-bottom: 20px;
            font-size: 24px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 20px; /* 필드 간의 여백을 늘려서 더 깔끔하게 */
            display: flex;
            flex-direction: column;
            align-items: flex-start; /* 모든 레이블과 필드를 왼쪽에 맞춤 */
        }

        .form-group label {
            font-weight: bold;
            color: #555; /* 레이블 색상 */
            margin-bottom: 8px; /* 레이블과 입력 필드 사이의 여백 */
            font-size: 16px;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group input[type="date"],
        .form-group input[type="file"] {
            padding: 10px;
            border: 1px solid #ddd; /* 연한 회색 테두리 */
            border-radius: 5px;
            font-size: 16px;
            width: 100%; /* 입력 필드를 컨테이너의 전체 너비로 설정 */
            box-sizing: border-box; /* 패딩과 테두리를 포함하여 너비 계산 */
        }

        button {
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            background-color: #99c2ff; /* 부드러운 핑크색 배경 */
            color: white;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            align-self: center; /* 버튼을 중앙에 배치 */
        }

        button:hover {
            background-color: #cde1ff;/* 버튼 호버 시 약간 어두운 핑크색 */
        }

        .image-preview {
            max-width: 150px; /* 이미지 최대 너비를 늘려서 보기 쉽게 */
            max-height: auto;
            border-radius: 5px; /* 이미지 모서리를 둥글게 */
            margin-bottom: 10px; /* 이미지와 다른 요소 간의 여백 */
        }

        .current-expiration-date {
            font-size: 16px;
            color: #555;
            margin-bottom: 10px;
            text-align: left; /* 텍스트 왼쪽 정렬 */
        }

        .a1 {
            display: block;
            text-align: center;
            color: #99c2ff;  /* 링크 색상 */
            text-decoration: none;
            font-weight: bold;
            margin-top: 20px; /* 링크 위쪽 여백을 늘려 더 깔끔하게 */
        }

        .a1:hover {
            text-decoration: underline;
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
     $(document).ready(function() {
            // 사용자가 이미지를 업로드하면 즉시 미리보기 표시
            $('#image').change(function() {
                let reader = new FileReader();
                reader.onload = function(e) {
                    $('#imagePreview').attr('src', e.target.result); // 미리보기 이미지 설정
                    $('#imagePreview').show(); // 미리보기 이미지 표시
                }
                reader.readAsDataURL(this.files[0]); // 파일 읽기
            });

            $('form').submit(function(event) {
                // 수정 확인 대화상자 표시
                if (!confirm('정말 수정하시겠습니까? 변동 사항을 잘 확인하세요.')) {
                    event.preventDefault(); // 사용자가 취소를 클릭하면 폼 제출을 막음
                }

                // 각 필드가 비어 있으면 기존 값 유지
                if ($('#stockCategory').val().trim() === '') {
                    $('#stockCategory').val('${fn:escapeXml(dto.stockCategory)}');
                }
                if ($('#stockName').val().trim() === '') {
                    $('#stockName').val('${fn:escapeXml(dto.stockName)}');
                }
                if ($('#stockQuantity').val().trim() === '') {
                    $('#stockQuantity').val('${dto.stockQuantity}');
                }
                if ($('#expirationDate').val().trim() === '') {
                    $('#expirationDate').val('${dto.expirationDate}');
                }

                // 새 이미지가 업로드되지 않은 경우 기존 이미지 URL 전송
                if ($('#image').val().trim() === '') {
                    $('#imageUrl').val('${fn:escapeXml(dto.imageUrl)}');
                }
            });
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
           
           
           
           
           
            

</div>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 
     <!-- 프로젝트 스타일 --> 
     <link rel="stylesheet" type="text/css" href="/css/gotowork.css">
     <link rel="stylesheet" type="text/css" href="/css/sidebar.css">
     <link rel="stylesheet" type="text/css" href="/css/notic.css">
     <!-- <link rel="stylesheet" type="text/css" href="./vacation.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
    <style>
        .note-editable {
            background-color: white;
        }
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

        .disabled, .form[disabled] {
            background-color: #f0f0f0;
            color: #a0a0a0;
            cursor: not-allowed;
            border-color: #d0d0d0;
        }

        .disabled:focus, .form[disabled]:focus {
            outline: none;
        }

        .hidden {
            display: none;
        }

        .btn-container {
            position: relative;
            margin-top: 10px;
        }

        .btn-container .btn {
            position: absolute;
            bottom: -40px;
            right: 15px;
        }

        .btn-warning {
            background-color: #f39c12;
            color: white;
            margin-bottom: 40px;
        }

        .btn-positive {
            background-color: #28a745;
            color: white;
            margin-bottom: 40px;
        }

        .reject-reason-textarea {
            display: none;
            width: 100%;
            height: 100px;
            margin-top: 10px;
        }

        .reject {
            display: none;
            text-decoration: none;
            font-size: 16px;
            padding: 0.5em 0.75em;
            color: #2d3436;
            background-color: #636e72;
            border: 1px solid #636e72;
            border-radius: 0.2em;
            cursor: pointer;
            text-align: center;
            line-height: 1.2;
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
    <!-- <script src="delete.js"></script> -->
    <!-- chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- 자바스크립트 코드 작성 영역 -->
    <script type="text/javascript">
        $(function(){
        // 초기 상태 설정
        $('.reject-reason-textarea').hide();

        $('.edit-btn').on('click', function() {
            $('.reject-reason-textarea').hide(); // textarea 숨기기
            $('.reject').show(); // 반려 버튼 보이기
            $(this).hide(); // 수정 버튼 숨기기
            $('.reject-reason-textarea').show(); // textarea 보이기
        });

        $('.reject').on('click', function() {
            alert('반려 됨');
            $(this).hide(); // 반려 버튼 숨기기
            $('.edit-btn').show(); // 수정 버튼 보이기
            //비동기넣는곳~ 아마도
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


        <!-- 보고서 작성 작성 -->
        <div class="noticbox w-1200">
            <div class="row notice">
                <table class="table table-border" id="dataTable" width="100%" cellspacing="0">
                    <tbody>
                        <tr>
                            <th class="row noticname">제목</th>
                            <td colspan="3" class="subject"></td>
                        </tr>
                        <tr>
                            <th class="row noticname">작성자</th>
                            <td>조장.오유석</td>
                            <th class="row noticname">작성일</th>
                            <td class="notice-reg-date">2024년 03월11일</td>
                        </tr>
                        <tr>
                            <th class="row noticname"></th>
                            <td class="row">조회수값999</td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <img style="border-radius: 0;" alt="" src="./">
                                ${tbEmpDto } <br> ${tbEmpReportDto }
                                <textarea class="reject-reason-textarea" placeholder="반려 사유를 입력하세요" style="font-size: 15px;"></textarea>
                            </td>
                        </tr>
                    </tbody>
                </table>   
            </div>

            <div>
                <div class="flex-box" style="justify-content: space-between;">
                    <div class="row left">
                        <button type="button" class="edit-btn btn write">반려</button>
                        <button type="button" class="reject btn write">반려</button>
                    </div>
                    <div class="row right">
                        <!-- <button type="button" class="btn btn-delete" style="background-color: #d63031; border-color: brown;">삭제</button> -->
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer id="footer">
        <!-- Footer content here -->
    </footer>
</body>
</html>

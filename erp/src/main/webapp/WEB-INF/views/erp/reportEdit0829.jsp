<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>보고서 반려</title>

    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="./commons.css">
 
     <!-- 프로젝트 스타일 --> 
     <link rel="stylesheet" type="text/css" href="./gotowork.css">
     <link rel="stylesheet" type="text/css" href="./sidebar.css">
     <!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
     <link rel="stylesheet" type="text/css" href="./vacation.css">
     <!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
    <style>
            /* 비활성화된 스타일 */
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
            border: 1px solid #ff9d00 !important;
            border-radius: 0.2em;
        }

        .btn-positive {
            background-color: #99c2ff !important;
            color: white;
            margin-bottom: 40px;
            border-radius: 0.2em;
            border: 1px solid #cde1ff !important;
        }

        .btn-positive:hover {
    background-color: #dde6f3 !important;
    color: #66a2fc; 
}


.btn-warning:hover {
    background-color: #fae7ca; 
    color: #f39c12; 
}


        .reject {
            text-decoration: none; 
    display: inline-block;
    font-size: 16px; 
    padding: 0.5em 0.75em; 
    color: #2d3436;
    background-color: #dfe6e9;
    border: 1px solid #2d3436;
    border-radius: 0.2em;
    cursor: pointer; 
    text-align: center;
    line-height: 1.2;
    border-color: #636e72;
    background-color: #636e72;
    color: white;
        }

        .title1{
           width: 70% !important;
           height: 40px;
           margin-right: 40%
        }
    </style>
    <!-- lightpick cdn -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
    <!-- jquery cdn -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="checkbox.js"></script>
    <script src="confirm-link.js"></script>
    <script src="multipage.js"></script>
    <!-- 프로젝트 js-->
    <script src="gotoworkbtn.js"></script>
    <script src="menuToggle.js"></script>
    <!-- <script src="delete.js"></script> -->
    <!-- chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- 자바스크립트 코드 작성 영역 -->
    <script type="text/javascript">
        $(function(){
            // 반려 버튼 클릭 시 동작
            $('.reject').on('click', function() {
                // 휴가 사유 라벨을 반려 사유 라벨로 변경
                $('.reason-label').text('반려 사유');
                
                // 휴가 사유 textarea 숨기고 반려 사유 textarea 보이기
                $('.reason-textarea').addClass('hidden').prop('disabled', true);
                $('.reject-reason-textarea').removeClass('hidden').prop('disabled', false);

                // 휴가신청 버튼을 수정완료 버튼으로 변경
                $('.btn.submit').text('반려완료').removeClass('btn-positive').addClass('btn-warning');
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


        
        <!-- 보고서 수정 -->
            <div class="container w-900">
                <div class="title">일일 업무 보고서 수정</div>
        
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
                                <td>서명칸</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <label>제목</label>
                    <input type="text" class="form title1" >
                </div>
    
                        <div class="row">
                            <label>사원명</label>
                            <input type="text" class="filed form " >
                        </div>
        
                <div class="row">
                    <div>
                        <label>사원번호</label>
                        <input type="number" class="form "  placeholder="ex: 3892" maxlength="4">
                    </div>
                    <div>
                        <label>직급</label>
                        <select class="form" >
                            <option value="" class="text-secondary" >직급</option>
                            <option value="">어쩌고</option>
                            <option value="">저쩌고</option>
                            <option value="">직급</option>
                        </select>
                    </div>
                    <div>
                        <label>부서</label>
                        <select class="form" >
                            <option value="" class="text-secondary" >부서</option>
                            <option value="">어쩌고</option>
                            <option value="">저쩌고</option>
                            <option value="">부서</option>
                        </select>
                    </div>
                </div>
       



             <div class="row flex-box btn-container" style="justify-content: space-between;">
                    <div >
                        <label class="reason-label">금일 목표</label>
                        <textarea class="field w-100 form reason-textarea" rows="3" style="padding-right: 100px;" 
                        placeholder="1. 코딩하기  
2. 또 코딩하기
3. 또 코딩하기"
                        ></textarea>
                        <textarea class="field w-100 form hidden reject-reason-textarea" disabled rows="3" style="padding-right: 100px;" placeholder="반려 사유를 입력하세요."></textarea>
                        <button type="button" class="reject flex-core" >반려</button>
                        <button type="button" class="btn btn-positive submit flex-core">기안</button>
                    </div>
                </div>
            </div>





    <footer id="footer">
        <!-- Footer content here -->
    </footer>
</body>
</html>

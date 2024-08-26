<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 휴가신청서 관리자용 수정 페이지 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>휴가신청서 수정 (관리자용)</title>

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
    <link rel="stylesheet" type="text/css" href="./notic.css">
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
            bottom: -40px; /* Adjust as needed */
            right: 15px;
        }

        .btn-warning {
            background-color: #f39c12; /* Example warning color */
            color: white;
            margin-bottom: 40px;
        }

        .btn-positive {
            background-color: #28a745; /* Example positive color */
            color: white;
            margin-bottom: 40px;
        }
        .reject {
            text-decoration: none; /* 밑줄 제거 */
    display: inline-block;/* 한줄에 여러개 배치 + 폭 설정 가능하게 */
    font-size: 16px; /* 입력창과 동일하게 */
    padding: 0.5em 0.75em; /*입력창과 동일하게*/
    color: #2d3436;
    background-color: #dfe6e9;
    border: 1px solid #2d3436;
    border-radius: 0.2em;
    cursor: pointer; /* 커서모양 변경 */
    text-align: center;
    line-height: 1.2;
    border-color: #636e72;
    background-color: #636e72;
    color: white;
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
    <!-- chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  
    <!-- 자바스크립트 코드 작성 영역 -->
    <script type="text/javascript">
        $(function() {
            var picker7 = new Lightpick({
                field: document.querySelector(".test7-1"), //설치대상1
                secondField: document.querySelector(".test7-2"), //설치대상2
                singleDate: false, //하루만 선택하는 모드를 해제
                format: "YYYY-MM-DD", //날짜의 표시 형식(momentJS 형식)
                firstDay: 7, //일요일부터 표시
                numberOfMonths: 4, //표시할 월의 수
                numberOfColumns: 2, //한줄에 표시할 월의 수
            });

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
                <i class="fa-solid fa-envelope email"></i>
                <span class="notif-count content">0</span>
            </a>
            <a href="#"><i class="fa-solid fa-circle-user user"></i></a> 
        </div>
    </header>

    <aside id="sidebar">
        <nav id="menu">
            <div class="container">
                <!--출퇴근-->
                <div id="commute-wrap">
                    <div id="date-wrap">
                        <span id="cur-date"></span><br>
                        <span id="cur-time"></span>
                    </div>
                    <div id="start-time">
                        <i>출근 시간</i>
                        <span id="start-time-display">미등록</span>
                    </div>
                    <div id="end-time">
                        <i>퇴근 시간</i>
                        <span id="end-time-display">미등록</span>
                    </div>
                    <div id="attendance-btns">
                        <button id="start-btn" class="on">출근</button>
                        <button id="end-btn" class="on">퇴근</button>
                    </div>
                </div>
            </div>
        </nav>
    </aside>
    
    <div id="content">
        <main id="body"> 
            <div class="container w-900">
                <div class="title">휴가신청서</div>

                <div class="table-container">
                    <table class="table form disabled">
                        <label>결재자</label>
                        <thead>
                            <tr>
                                <th>직급</th>
                                <th>넣는</th>
                                <th>곳</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>서명칸</td>
                                <td>서명칸</td>
                                <td>서명칸</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="row flex-box">
                    <div>
                        <div class="row">
                            <label>사원명</label>
                            <input type="text" class="filed form disabled" disabled>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div>
                        <label>사원번호</label>
                        <input type="number" class="form disabled" disabled placeholder="ex: 3892" maxlength="4">
                    </div>
                    <div>
                        <label>직급</label>
                        <select class="form disabled" disabled>
                            <option value="" class="text-secondary">직급</option>
                            <option value="">어쩌고</option>
                            <option value="">저쩌고</option>
                            <option value="">직급</option>
                        </select>
                    </div>
                    <div>
                        <label>부서</label>
                        <select class="form disabled" disabled>
                            <option value="" class="text-secondary">부서</option>
                            <option value="">어쩌고</option>
                            <option value="">저쩌고</option>
                            <option value="">부서</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div>
                        <label>EMAIL</label>
                        <input type="text" class="form disabled" disabled placeholder="email@example.com">
                    </div>
                    <div>
                        <label>휴대폰 번호</label>
                        <input type="number" class="form disabled" disabled placeholder="00011112222">
                    </div>
                </div>

                <div class="row flex-box">
                    <div class="w-50">
                        <label>휴가 시작일</label>
                        <input type="text" disabled class="field w-100 test7-1 form disabled">
                    </div>
                    <div class="w-50">
                        <label>휴가 종료일</label>
                        <input type="text" disabled class="field w-100 test7-2 form disabled">
                    </div>
                </div>
                
                <div class="row">
                    <div>
                        <label>휴가 종류</label>
                        <select class="form disabled" disabled>
                            <option value="" class="text-secondary">휴가 종류</option>
                            <option value="">개인사유</option>
                            <option value="">연차</option>
                            <option value="">병가</option>
                        </select>
                    </div>
                </div>

                <div class="row flex-box btn-container" style="justify-content: space-between;">
                    <div >
                        <label class="reason-label">휴가 사유</label>
                        <textarea class="field w-100 form reason-textarea" disabled rows="3" style="padding-right: 100px;"></textarea>
                        <textarea class="field w-100 form hidden reject-reason-textarea" disabled rows="3" style="padding-right: 100px;" placeholder="반려 사유를 입력하세요."></textarea>
                        <button type="button" class="reject flex-core" >반려</button>
                        <button type="button" class="btn btn-positive submit flex-core">휴가신청</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 수정</title>

    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <!-- SweetAlert2 CDN -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="/css/commons.css">
     <!-- 프로젝트 스타일 --> 
     <link rel="stylesheet" type="text/css" href="/css/gotowork.css">
     <link rel="stylesheet" type="text/css" href="/css/sidebar.css">
     <!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
     <link rel="stylesheet" type="text/css" href="/css/vacation.css">
     <!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
     <link rel="stylesheet" type="text/css" href="/css/alertBtn.css">
	
<!-- 	<form action="noticEdit" method="post" autocomplete="off"> -->
<%-- 		<input type="hidden" name="noticeNo" value="${noticeDto.noticeNo }"> --%>
<!-- 	</form> -->
	
    <style>
          .note-editable {
            background-color: white;
        }
        /* bold와 italic이 적용되지 않는 문제를 수정하도록 코드 추가 */
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

        .title1{
           width: 60% !important;
           height: 40px;
           margin-right: 40%
        }
        .title2{
            border: 1px solid;
    border-radius: 6px;
    margin-bottom: 25px;
    padding: .60rem 1.25rem;
    background-color: gainsboro;
    border-color: #fff;
    color: #495057;
    font-weight: 800;
    text-align: center !important;
    width: 98%; 
    box-sizing: border-box;
        }
                .btn-positive {
                    background-color: wheat !important;
            color: white;
            border-radius: 0.2em;
            border: 1px solid antiquewhite !important;
        }
        .btn-positive:hover {
            background-color: rgb(252, 241, 228) !important;
            color: rgb(252, 197, 94);
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
    <!-- summernote cdn -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
    <!-- 프로젝트 js-->
    <script src="/js/gotoworkbtn.js"></script>
    <script src="/js/menuToggle.js"></script>
    <!-- <script src="delete.js"></script> -->
    <!-- <script src="alertDeleteBtn.js"></script> -->
    <!-- <script src="alertInsert.js"></script> -->
    <script src="alertEdit.js"></script>
    <!-- <script src="alert.js"></script> -->
  
    <!-- chart js -->
    <form action="noticEdit" method="post" autocomplete="off">
		<input type="hidden" name="noticeNo" value="${noticeDto.noticeNo }">
	</form>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- 자바스크립트 코드 작성 영역 -->
    <script type="text/javascript">
        $(function(){
        $("[name=noticeCont]").summernote({
            height: 250,
            minHeight: 250,
            maxHeight: 400,
            placeholder: "내용 입력",
            toolbar: [
                ['area', ['style', 'undo', 'redo']],
                ['style', ['bold', 'italic', 'underline', 'strikethrough']],
                ['font', ['fontname', 'fontsize', 'forecolor', 'backcolor']],
                ['tool', ['ol', 'ul', 'table', 'hr', 'fullscreen']],
                ['attach', ['picture']],
            ],
            callbacks: {
                onImageUpload : function(files) {
                    var form = new FormData();
                    form.append("attach", files[0]);
                    $.ajax({
                        processData: false,
                        contentType: false,
                        url:"http://localhost:8080/rest/notice/upload",
                        method:"post",
                        data: form,
                        success:function(response){
                            var tag = $("<img>").attr("src", "http://localhost:8080/attach/download?documentNo="+response);
                            $("[name=noticeCont]").summernote("insertNode", tag[0]);
                        }
                    });
                }
            },
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
                <!-- 출퇴근 -->
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
                        <li><a href="/notice/list" data-text="">
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

    <div id="cont">
        <main id="body"> 
            <div id="cont">
               
                 <!-- 공지사항 수정 -->
                 <body>
                 	<form action="noticEdit" method="post" autocomplete="off">
                 		<input type="hidden" name="noticeNo" value="${noticeDto.noticeNo}">
                    <div class="container w-900">
                        <div class="title2">공지사항 수정</div>
                
                        <div class="table-container">
                            <table class="table form">
                            </table>
                        </div>
                
                        <div class="row flex-box" style="margin-top: 20px;">
                                <div>
                                    <label>제목</label>
                                    <input type="text" class="form title1" name="noticeTitle" value="${noticeDto.noticeTitle}">
                                </div>
                        </div>
                       
                        <div class="row flex-box"  style="position: relative; margin-top: 50px;">
                            <div>
                                <label>내용</label>
                                <textarea class="field w-100 form "  rows="3" style="padding-right: 100px;" name="noticeCont">${noticeDto.noticeCont}</textarea>
                            </div>
                            <button type="submit" class="btn btn-positive">수정</button>
                        </div>
                    </div>
                    </form>
                </body>

    <footer id="footer">
        <!-- Footer content here -->
    </footer>
</body>
</html>
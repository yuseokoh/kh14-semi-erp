<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
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
    <!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->

     <!-- 프로젝트 스타일 --> 
     <link rel="stylesheet" type="text/css" href="/css/gotowork.css">
     <link rel="stylesheet" type="text/css" href="/css/sidebar.css">
     <link rel="stylesheet" type="text/css" href="/css/notic.css">
     <!-- <link rel="stylesheet" type="text/css" href="./vacation.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
     <link rel="stylesheet" type="text/css" href="/css/alertBtn.css">
     <link rel="stylesheet" type="text/css" href="/css/alertA.css">

    <style>
          .btn-write {
            background-color: wheat !important;
            color: white;
            border-radius: 0.2em;
            border: 1px solid antiquewhite !important;
        }

 .btn-write:hover {
    background-color: rgb(252, 241, 228) !important;
    color: rgb(252, 197, 94);
}

.btn-delete {
            background-color: #d63031 !important;
            color: white;
            border-radius: 0.2em;
            border: 1px solid #cde1ff !important;
        }

        .btn-delete:hover {
    background-color: #ff7675 !important;
    color: black; 
}



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
  <!-- <script src="delete.js"></script> -->
  <script src="/js/alertDeleteBtn.js"></script>
  <script src="/js/alertInsert.js"></script>
  <!-- <script src="alertEdit.js"></script> -->
  <!-- <script src="alert.js"></script> -->

  <!-- chart js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  

  
  <!-- 자바스크립트 코드 작성 영역 -->
  <script type="text/javascript">
      $(document).ready(function() {
            // 삭제 버튼 클릭 이벤트
            $('.delete').on('click', function() {
                // 확인 대화상자 표시
                var confirmDelete = confirm("삭제하시겠습니까?");
                if (confirmDelete) {
                    alert("삭제되었습니다.");
                } else {
                    alert("삭제가 취소되었습니다.");
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




        <!-- 공지사항 리스트 작성 -->
                    <body>
                        <div class="noticbox w-1200">
							
							<!-- 검색창 -->
<form action="noticList" method="get" autocomplete="off">
									   
	<div class="row notice">
	<div class="row noticname">공지사항</div>
	<div class="actions" name="column">
		<select name="column" class="row actions1"  style="flex-grow: 1;">
			<option value="notice_Title" <c:if test="${param.column == 'notice_Title'}">selected</c:if>>제목</option>
            <option value="notice_Writer" <c:if test="${param.column == 'notice_Writer'}">selected</c:if>>작성자</option>
        </select>
		<div class="row search" style="flex-grow: 1;">
			<input type="text" name="keyword" value="${param.keyword}" class="row">
		</div>
		<button type="submit" class="search button" style="flex-grow: 1;">검색</button>
    </div>
</div>

	
</form>
<!-- 결과 화면 -->
    <div class="tb-box">
        <table class="tb">
       
            <tbody class="tbody">
                <c:choose>
                    <c:when test="${noticList.isEmpty()}">
                        <%-- 결과가 없을 때 --%>
                        <tr>
                            <td colspan="5">결과가 존재하지 않습니다</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <%-- 결과가 있을 때 --%>
                        <c:forEach var="noticeDto" items="${noticList}">
                        <tr class="row center">
                        	
                        
                            <td>${noticeDto.noticeWriter}</td>
                            <td>${noticeDto.noticeTitle}</td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                
            </tbody>
        </table>

    </div>

                       
                       
   <div class="tb-box">
      <table>
   	 <thead>
        <tr>
            <th>작성일</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
        </tr>
    </thead>
    <tbody class="tbody">
        <c:forEach var="notice" items="${noticeList}">
            <tr class="row center">   
                <td>${notice.noticeWtimeString}</td>
               <td class="name"><a href="noticDetail?noticeNo=${notice.noticeNo}"> ${notice.noticeTitle}</a></td>
                <td>${notice.noticeWriterString}</td>
                <td>${notice.noticeViews}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
                                   
                       
                                   <div class="flex-box ">
                                                               <div class="row left">
												<a href="noticInsert" class="btn btn-neutral" style="color: rgba(255, 0, 0, 0); background-color: rgb(220, 220, 220) !important; border: 0px solid rgb(220, 220, 220) !important;" >글쓰기</a>	
                                    </div>
                                    <div class="row center">
                                <jsp:include page="/WEB-INF/views/template/navigator5.jsp"></jsp:include> 
                                    </div>
                                    <div class="row right">
												<a href="noticInsert" class="btn btn-neutral">글쓰기</a>	
                                    </div>
                                </div>
                       
                       
                       
                       
                               </div>
                       			</div>
                               </div>
                           </div>
                       </body>

        </div>
    </div>
</body>
</html>
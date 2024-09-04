<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 최종 폼</title>

    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
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


    <style>
                .btn-write {
            background-color: #99c2ff !important;
            color: white;
            border-radius: 0.2em;
            border: 1px solid #cde1ff !important;
        }

        .btn-write:hover {
    background-color: #dde6f3 !important;
    color: #66a2fc; 
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


.tb th, .tb td {
    padding: 10px; 
}
.tb tr {
    border-bottom: 1px solid #ddd; 
}

.tb tbody tr {
    height: 40px;
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



        <body>
            <div class="noticbox w-1200">




<div class="container my-50">
        <div class="row center">
            <h1>사원 조회</h1>
        </div>

<!-- 검색창 -->
<form action="list" method="get" autocomplete="off">
    <div class="row">
        <select name="column" class="field">
            <option value="name" <c:if test="${param.column == 'name'}">selected</c:if>>사원명</option>
            <option value="emp_level" <c:if test="${param.column == 'emp_level'}">selected</c:if>>직급</option>
        </select>
        <input type="text" name="keyword" value="${param.keyword}" class="field">
        <button class="btn btn-neutral">검색</button>
    </div>
</form>
<!-- 결과 화면 -->
    <div class="tb-box">
        <table class="tb">
            <thead>
                <tr>
                	<th>사진</th>
                    <th>사원명</th>
                    <th>이메일</th>
                    <th>직급</th>
                    <th>부서</th>
                    <th>입사일</th>
                </tr>
            </thead>
            <tbody class="tbody">
                <c:choose>
                    <c:when test="${list.isEmpty()}">
                        <%-- 결과가 없을 때 --%>
                        <tr>
                            <td colspan="5">결과가 존재하지 않습니다</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <%-- 결과가 있을 때 --%>
                        <c:forEach var="tbEmpDto" items="${list}">
                        <tr class="row center">
                        	<td><img src="/tb/myImage?loginId=${tbEmpDto.loginId}" width="25"></td>
                            <td>
                                <a href="/tb/mypage?loginId=${tbEmpDto.loginId}">
                                    ${tbEmpDto.name}
                                </a>
                            </td>
                            <td>${tbEmpDto.empEmail}</td>
                            <td>${tbEmpDto.empLevel}</td>
                            <td>${tbEmpDto.empDept}</td>
                            <td>
                                ${tbEmpDto.empSdate}
                            </td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                
            </tbody>
        </table>

    </div>

    <!-- 네비게이터 추가 -->
<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
    </div>
    



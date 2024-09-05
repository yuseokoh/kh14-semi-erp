<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세보기</title>
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
     <!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
     <link rel="stylesheet" type="text/css" href="/css/vacation.css">
     <!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
     <!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
    <style>
        .title1{
           width: 60% !important;
           height: 40px;
           margin-right: 40%;
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
        .readonly{
            background-color: #f0f0f0; 
           border: 1px solid #ccc;
           pointer-events: none;
        }
        .user1{
       background-color: #f0f0f0; 
           border: 1px solid #ccc;
           pointer-events: none;
            line-height: 1.5;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 4px;
    margin-bottom: 0.5rem; 
    padding: 1px; 
    font-size: 0.9em; 
    width: 20%;
}
.user1 img {
    width: 30px; 
    height: 30px; 
}
.creation{
       background-color: #f0f0f0; 
           border: 1px solid #ccc;
           pointer-events: none;
            line-height: 1.5;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 4px;
    margin-bottom: 0.5rem; 
    padding: 1px; 
    font-size: 0.9em; 
    width: 33%;
    height: 35px;
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
<script src="/js/delete.js"></script>
  <!-- chart js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  
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
        <div class="container" >

   <!-- 이미지? -->
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
           <div class="container w-900">
    <!-- 제목 -->
  <div class="title2">
      ${noticeDto.noticeTitle}
            <c:if test="${noticeDto.noticeUtime != null}">
                (수정됨)
            </c:if></div>


    <!-- 작성자 -->
    <div class="row flex-box user1 readonly" readonly style="margin-top: 20px;">
    <div class="row">

        ${noticeDto.noticeWriterString}
    </div>
    </div>

    <!-- 작성일 -->
    <div class="row right readonly creation "  readonly>
        <fmt:formatDate value="${noticeDto.noticeWtime}" 
                                    pattern="y년 M월 d일 E a h시 m분 s초"/>
    </div>
    <!-- 내용 -->
    <div class="row readonly"  style="min-height:200px" readonly>
        <!-- pre 태그는 내용을 작성된 형태 그대로 출력한다
                Rich Text Editor를 쓸 경우는 할 필요가 없다 -->
        ${noticeDto.noticeCont}
    </div>
    <!-- 정보 -->
	<div class="row">
		조회 
		<fmt:formatNumber value="${noticeDto.noticeViews}"
										pattern="#,##0"/>

	</div>



	<!-- 각종 이동버튼들 -->
	<div class="row left">
		<a class="btn btn-positive" href="noticInsert">글쓰기</a>

		<%-- 본인 글만 표시되도록 조건 설정 --%>
		<c:set var="isAdmin" value="${sessionScope.createdLevel == '관리자'}"/>
		<c:set var="isLogin" value="${sessionScope.createdUser != null}"/>
		<c:set var="isOwner" value="${sessionScope.createdUser == noticeDto.noticeWriter}"/>

		<c:if test="${isLogin}">
			<c:if test="${isOwner}">
				<a class="btn btn-negative btn-edit " href="noticEdit?noticeNo=${noticeDto.noticeNo}" >수정</a>
			</c:if>
			<c:if test="${isOwner || isAdmin}">
				<a class="btn btn-negative btn-delete"  href="delete?noticeNo=${noticeDto.noticeNo}">삭제</a>
			</c:if>
		</c:if>

		<a class="btn btn-neutral" href="noticList">목록</a>

	</div>
</div>
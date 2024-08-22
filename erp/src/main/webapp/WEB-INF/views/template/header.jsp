<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 문서 설정 - HTML 버전 지정 (HTML 5)	-->
<!Doctype HTML>
<html><!-- HTML 문서의 범위를 나타내는 태그 -->
	<head><!-- 문서의 정보를 표시하는 태그 -->
		<title>나의 홈페이지</title>
		<style>
		
		</style>
		<meta charset ="UTF-8">
		
		<!-- 구글 폰트 불러오기 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
    	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
		<!-- font awesome icon 불러오기 -->			
		<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
		<!-- 내가 만든 스타일시트를 불러오는 코드 -->
		<link rel="stylesheet" type="text/css" href="/css/commons.css">
		<link rel="stylesheet" type="text/css" href="/css/test.css">
			<!-- 자바스크립트 -->
	<!--jquery cdn-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!--카카오 주소찾기-->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <!--lightpick cdn-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
    <!-- 내가만든 jQuery 라이브러리 -->
    <script src="/js/checkbox.js"></script>
    <script src="/js/confirm-link.js"></script>
    <script src="/js/multipage.js"></script>
<!-- moment JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>
	</head>
	<body><!-- 문서의 화면 출력 내용을 담는 태그 -->
		
		<!-- 상단(Header) -->
		<div name=header>
		 <div class="row my-0 flex-box">
            <div class="w-25 flex-core">
                <img src="https://placehold.co/150x60" alt="로고">
            </div>    
            <div class="w-50">
               <h1 class="center">KH 정보교육원 수업자료</h1>
            </div>    
            <div class="w-25 flex-core">
                <img src="https://placehold.co/150x60" alt="로고">
            </div>    
        </div>
        
        <div class="container w-100">
        <div class="row">
            <ul class="menu">
                <li>
                    <a href="/">홈으로</a>
                    
                </li>
                <c:choose>
				<c:when test="${sessionScope.createdUser!=null }">
				<!-- 회원 -->
                <li><a href="#">데이터</a>
                    <ul>
                        <li><a href="/poketmon/list">포켓몬스터</a></li>
                        <li><a href="/emp/list">사원정보</a></li>
                        <li><a href="/book/list">도서정보</a></li>
                        <li><a href="/member/mypage">내정보</a></li>
                    </ul>
                </li>	
				</c:when>
				<c:otherwise>
				 <li><a href="#">데이터</a>
                    <ul>
                        <li><a href="/poketmon/list">포켓몬스터</a></li>
                       
                    </ul>
                </li>	
				</c:otherwise>
				</c:choose>
                <li><a href="/board/list">게시판</a>
                    
                </li>
        		<c:if test="${sessionScope.createdLevel=='관리자' }">
        		<li><a href="/admin/home">관리자메뉴</a>
        		</li>
        		</c:if>
                    
                    <c:choose>
                    <c:when test="${sessionScope.createdUser!=null }">
                        <li class="right-menu"><a href="/member/logout">로그아웃</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                    	<li class="right-menu"><a href="/member/login">로그인</a>
                        <li><a href="/member/join">회원가입</a>
                    	</li>
                    </c:otherwise>
                    </c:choose>
                            
                            
                        </li>
                        
                    
            </ul>
        </div>
    </div>
        		<!-- 메뉴(Navbar) 
		-템플릿 페이지의 모든 경로는 전부 다 절대경로로 사용
		-로그인 상태일 때와 비로그인 상태일 때를 다르게 표시
		-로그인 상태:sessionScope.createdUser != null
		-->
		
      
       			<div class="row my-0 flex-box" style="min-height: 400px;">
            <div class="w-200">
                <div class="row center">
        <c:choose>
       		<c:when test="${sessionScope.createdUser!=null }">
                <a href="/member/mypage">
                    <img src="/member/myImage" width="50%" class="image image-circle image-lift" alt="사용자 이미지">
                </a>

                <div class="row center">${sessionScope.createdUser}</div>
                <div class="row center">${sessionScope.createdLevel}</div>
        	</c:when>
        	<c:otherwise>
        	<div class="row center">
        	<a href="/member/login" class="link">로그인<i class="fa-regular fa-pen-to-square"></i></a> 하세요
        	</div>
        	</c:otherwise>
        </c:choose>
                </div>
            </div>
       <div style="flex-grow:1;">
        
		
		<!-- 중단(Container) --><hr>
		
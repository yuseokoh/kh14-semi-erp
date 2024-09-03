<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>출퇴근 관리 시스템</title>

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
<link rel="stylesheet" type="text/css" href="/css/alertA.css">
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
<script src="/js/alertDeleteA.js"></script>
<!-- chart js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>



<style>
    /* 통일된 색상 */
    body {
    	margin-bottom:200px;
        color: #333333;
        background-color: #f5f5f5; /* 배경색 변경, 선택 사항 */
    }

    a {
        color: #333333; /* 링크 색상 */
        text-decoration: none;
        font-weight: bold;
    }

    a:hover {
        text-decoration: underline;
    }

    .button-container {
        display: flex;
        justify-content: right;
        gap: 15px;
        margin-bottom: 20px;
    }

    .button {
        background-color: #ffffff;
        color: #333333;
        border: 2px solid #333333;
        padding: 8px 15px;
        border-radius: 5px;
        font-size: 12px;
        text-decoration: none;
        text-align: center;
        transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
    }

    .button:hover {
        background-color: #333333;
        color: white;
    }

    .register-button {
        display: block;
        width: 80px;
        height: 40px;
        margin: 20px auto 220px auto; /* 수평 중앙 정렬 */
        padding: 10px;
        border: none;
        border-radius: 5px;
        background-color: #333333;
        color: white;
        font-size: 16px;
        cursor: pointer;
        text-align: center;
        transition: background-color 0.3s ease;
        text-decoration: none;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        
}    

    .register-button:hover {
        background-color: #555555;
    }

    .container1 {
        height: 70%;
        width: 80%;
        margin: 0 auto; /* 수평 중앙 정렬 */
        padding-bottom: 300px; /* 버튼이 바닥에 붙지 않도록 여백 추가 */
        position: relative; /* 'relative' 위치 속성을 추가 */
        margin-left: 1200px; /* 사이드바가 닫힐 때의 기본 위치 */
        transition: margin-left 0.3s ease; /* 이동 애니메이션 */
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #ffffff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding-bottom: 180px; /* 버튼이 바닥에 붙지 않도록 여백 추가 */
    }

    th, td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #333333; /* 헤더 배경색 */
        color: white; /* 헤더 텍스트 색상 */
        font-weight: bold;
    }

    tr:hover {
        background-color: rgb(220, 220, 220); /* 행 호버 시 배경색 */
    }

    .product-container {
        position: relative;
        display: inline-block;
    }

    .product-image {
        max-width: 100px;
        max-height: 120px;
        height: auto;
        border-radius: 5px;
    }

    .low-stock {
        position: absolute;
        bottom: 45px; /* 이미지 하단에서 5px 위로 위치 */
        left: 45%;
        transform: translateX(-50%);
        background-color: rgba(255, 0, 0, 0.7); /* 빨간 배경, 투명도 0.7 */
        color: white;
        padding: 1px 3px;
        border-radius: 3px;
        font-size: 12px;
        font-weight: bold;
    }
    
    h1 {
    font-size: 26px;
    margin-bottom: 20px;
    color: #333; /* 제목 색상 */
    font-weight: bold;
    padding-bottom: 10px; /* 제목과 선 사이의 여백 */
    display: inline-block; /* 선의 길이를 제목의 길이에 맞추기 위해 인라인 블록 설정 */
}

    .change-info {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .arrow {
        color: #333333; /* 화살표 색상 */
        font-size: 0.8em;
        margin: 0 5px;
        margin-bottom: 0px;
    }

    #content {
        max-height: 1000px;
        width: 100%;
        max-width: 1200px;
        margin: 0 auto; /* Center the content */
        padding: 0 15px;
        padding-bottom: 180px; /* 버튼이 바닥에 붙지 않도록 여백 추가 */
    }

    .search-form {
        display: flex; /* 플렉스 컨테이너로 설정 */
        justify-content: center;
        gap: 10px;
        margin-bottom: 20px;
    }

    .search-form select, .search-form input[type="text"], .search-form button {
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
        font-size: 16px;
    }

    .search-form select {
        width: 100px;
        flex: 1;
    }

    .search-form input[type="text"] {
        width: 560px;
        flex: 2;
    }

    .search-form button {
        width: 70px;
        background-color: #333333;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .search-form button:hover {
        background-color: #555555;
    }

    /* 사이드바 기본 상태 */
    #sidebar {
        width: 230px; /* 사이드바의 너비 */
        position: fixed;
        left: 0;
        top: 0;
        bottom: 0;
        background-color: #333;
        color: #fff;
        transition: transform 0.3s ease; /* 이동 애니메이션 */
        transform: translateX(-230\px); /* 사이드바가 기본적으로 왼쪽으로 숨겨져 있음 */
    }
    
    #menu li {
    margin: 15px 0; /* 메뉴 항목 사이의 간격 */
}

    /* 사이드바가 열릴 때 */
    #sidebar.open {
        transform: translateX(0);
    }
</style>
</head>
<body>
    <header id="header">
        <div id="menuToggle">
            <i class="fa fa-bars"></i>
        </div>
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
                <!-- 출퇴근 여기까지 -->
                <!-- 사이드바 -->
                <div class="row">
                    <ul class="menu-hover-fill">
                        <li><a href="/" data-text="home">HOME</a></li>
                        <li><a href="/poketmon/list" data-text="">
                            <i class="fa-solid fa-file-signature"></i> 그룹웨어(poketmon)
                        </a>
                            <ul>
                                <li><a href="#">휴가신청서</a></li>
                                <li><a href="#">보고서(수인씨작성중)</a></li>
                            </ul>
                        </li>
                        <li><a href="/emp/list" data-text="">
                            <i class="fa-solid fa-cart-flatbed"></i> 재고관리(emp)
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>
                        <li><a href="/book/list" data-text="">
                            <i class="fa-solid fa-people-group"></i> 인사관리(book)
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>
                        <li><a href="/member/mypage" data-text="">
                            <i class="fa-solid fa-id-card"></i> mypage
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>
                        <li><a href="/board/list" data-text="">
                            <i class="fa-solid fa-comment"></i> 예비용
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>
                        <c:if test="${sessionScope.createdLevel == '관리자'}">
                            <li><a href="/admin" data-text="">
                                <i class="fa-solid fa-gears"></i> 관리자
                            </a></li>
                        </c:if>
                        <li><a href="/logout" data-text="">
                            <i class="fa-solid fa-power-off"></i> 로그아웃
                        </a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </aside>

    <div class="container1">
        <h1>재고 목록</h1>
        
        <!-- 검색 폼 추가 -->
        <form class="search-form" action="${pageContext.request.contextPath}/stock/list" method="get">
            <select name="column">
                <option value="stock_name" <c:if test="${column eq 'stock_name'}">selected</c:if>>상품명</option>
                <option value="stock_category" <c:if test="${column eq 'stock_category'}">selected</c:if>>카테고리</option>
                <!-- 추가적인 검색 열을 여기에 추가할 수 있습니다 -->
            </select>
            <input type="text" name="keyword" value="${keyword}" placeholder="검색어 입력">
            <button type="submit">검색</button>
        </form>
        
        <!-- Change Log List 및 상품 목록 그래프화 버튼 추가 -->
        <div class="button-container">
            <a href="${pageContext.request.contextPath}/stock/changeLogList" class="button">재고 변동 내역</a>
            <a href="${pageContext.request.contextPath}/stock/categoryQuantity" class="button">상품 목록 그래프화</a>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>이미지</th>
                    <th>카테고리</th>
                    <th>상품명</th>
                    <th>수량 변동</th>
                    <th>상세</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${list}">
                    <tr>
                        <td>
                            <div class="product-container">
                                <img src="${pageContext.request.contextPath}/stock/uploaded-images?filename=${item.imageUrl}" alt="${item.stockName}" class="product-image">
                                <c:if test="${item.stockQuantity < 5}">
                                    <span class="low-stock">재고 부족</span>
                                </c:if>
                            </div>
                        </td>
                        <td>${item.stockCategory}</td>
                        <td>${item.stockName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${latestChangeLogsMap[item.stockNo] != null}">
                                    <c:set var="log" value="${latestChangeLogsMap[item.stockNo]}" />
                                    <c:set var="oldQuantity" value="${fn:substringAfter(log.oldValues, 'Quantity: ')}" />
                                    <c:set var="newQuantity" value="${fn:substringAfter(log.newValues, 'Quantity: ')}" />
                                    <c:set var="isComplexFormat" value="${fn:indexOf(oldQuantity, ',') != -1}" />
                                    <c:choose>
                                        <c:when test="${isComplexFormat}">
                                            <c:set var="oldQuantityNumber" value="${fn:substringBefore(oldQuantity, ',')}" />
                                            <c:set var="newQuantityNumber" value="${fn:substringBefore(newQuantity, ',')}" />
                                            <c:if test="${fn:length(oldQuantityNumber) > 0 && fn:length(newQuantityNumber) > 0}">
                                                <div class="change-info">
                                                    <c:out value="${oldQuantityNumber}" />
                                                    <span class="arrow"><i class="fas fa-arrow-right"></i></span>
                                                    <c:out value="${newQuantityNumber}" />
                                                </div>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${fn:length(oldQuantity) > 0 && fn:length(newQuantity) > 0}">
                                                <div class="change-info">
                                                    <c:out value="${oldQuantity}" />
                                                    <span class="arrow"><i class="fas fa-arrow-right"></i></span>
                                                    <c:out value="${newQuantity}" />
                                                </div>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>변동 정보 없음</c:otherwise>
                            </c:choose>
                        </td>
                        <td><a href="${pageContext.request.contextPath}/stock/detail?stockNo=${item.stockNo}">상세보기</a></td>
                        <td><a href="${pageContext.request.contextPath}/stock/delete?stockNo=${item.stockNo}" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
       
        <!-- 등록 버튼 추가 -->
        <a href="${pageContext.request.contextPath}/stock/insert" class="register-button">재고등록</a>
    </div>
     <script>
    $(document).ready(function() {
        const sidebar = $('#sidebar');
        const container1 = $('.container1');
        const menuToggle = $('#menuToggle');

        // 사이드바 상태에 따른 container1 이동
        function adjustContainer() {
            if (sidebar.hasClass('open')) {
                container1.css('margin-left', '400px'); // 사이드바가 열릴 때 container1의 위치
            } else {
                container1.css('margin-left', '100px'); // 사이드바가 닫힐 때 container1의 위치
            }
        }

        // 사이드바 열기/닫기 토글
        menuToggle.click(function() {
            sidebar.toggleClass('open');
            adjustContainer();
        });

        // 페이지 로드 시 사이드바 상태에 따른 container1 위치 조정
        adjustContainer();
    });
    </script>
</body>
</html>

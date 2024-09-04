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
<!-- chart js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>



<style>
    body {
        margin-bottom: 200px;
        font-family: 'Noto Sans KR', sans-serif;
        color: #333;
        background-color: #f5f5f5;
    }

    a {
        color: #333;
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
        background-color: #fff;
        color: #333;
        border: 2px solid #333;
        padding: 8px 15px;
        border-radius: 5px;
        font-size: 12px;
        text-decoration: none;
        text-align: center;
        transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
    }

    .button:hover {
        background-color: #333;
        color: #fff;
    }

    .register-button {
        display: block;
        width: 80px;
        height: 40px;
        margin: 20px auto 220px auto;
        padding: 10px;
        border: none;
        border-radius: 5px;
        background-color: #333;
        color: #fff;
        font-size: 16px;
        cursor: pointer;
        text-align: center;
        transition: background-color 0.3s ease;
        text-decoration: none;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }    

    .register-button:hover {
        background-color: #555;
    }

    .container1 {
        height: 70%;
        width: 80%;
        margin: 0 auto;
        padding-bottom: 300px;
        position: relative;
        transition: margin-left 0.3s ease;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #333;
        color: #fff;
        font-weight: bold;
    }

    tr:hover {
        background-color: rgb(220, 220, 220);
    }

    .change-info {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .arrow {
        color: #333;
        font-size: 0.8em;
        margin: 0 5px;
        margin-bottom: 0;
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
        width: 60px;
        position: absolute;
        top: 15px;
        left: 43%;
        transform: translateX(-50%);
        background-color: rgba(255, 0, 0, 0.7);
        color: white;
        padding: 1px 3px;
        border-radius: 3px;
        font-size: 12px;
        font-weight: bold;
    }

    .search-form {
        display: flex;
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
        width: 900px;
        flex: 4;
    }

    .search-form button {
        width: 70px;
        background-color: #333;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .search-form button:hover {
        background-color: #555;
    }

    /* SweetAlert2 custom styles */
    .swal2-popup {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #ffffff !important;
        color: #333333 !important;
        border-radius: 8px !important;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
    }

    .swal2-title {
        font-size: 26px !important;
        font-weight: bold !important;
    }

    .swal2-confirm, .swal2-cancel {
        font-size: 16px !important;
        padding: 10px 20px !important;
        border-radius: 5px !important;
    }

    .swal2-confirm {
        background-color: #333333 !important;
        color: white !important;
        border: none !important;
    }

    .swal2-cancel {
        background-color: #ffffff !important;
        color: #333333 !important;
        border: 2px solid #ddd !important;
    }

    .swal2-confirm:hover, .swal2-cancel:hover {
        background-color: #555555 !important;
        color: white !important;
        border: 2px solid #555555 !important;
    }

    .swal2-cancel:hover {
        color: #ffffff !important;
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
                <!-- 사이드바-->
			<div class="row">
				<ul class="menu-hover-fill">
					<li><a href="/home" data-text="home"> <i class="fa-solid fa-house-user"></i> HOME
					</a></li>

					<li><a href="#" data-text=""> <i class="fa-solid fa-file-signature"></i> 그룹웨어
					</a>
						<ul>
							<li><a href="/vacation/mylist?loginId=${sessionScope.createdUser}">휴가신청서</a></li>
							<li><a href="/report/mylist?loginId=${sessionScope.createdUser}">보고서</a></li>
							<li><a href="/res/list">회의실 예약</a></li>
						</ul></li>

					<li><a href="/stock/list" data-text=""> <i class="fa-solid fa-cart-flatbed"> </i> 재고관리(emp)
					</a>
						<ul>
							<li><a href="/stock/changeLogList">재고 변경 내역</a></li>
							<li><a href="/stock/categoryQuantity">재고 그래프</a></li>
						</ul></li>

					<li><a href="/tb/list" data-text=""> <i class="fa-solid fa-people-group"> </i> 인사관리
					</a></li>

					<li><a href="/tb/mypage?loginId=${sessionScope.createdUser}" data-text=""> <i class="fa-solid fa-id-card"></i> mypage
					</a>
						</li>

					<li><a href="/groupware/notice/noticList" data-text=""> <i class="fa-solid fa-comment"></i> 공지사항
					</a>
					</li>

					<c:if test="${sessionScope.userType == 'A'}">
						<li><a href="#" data-text=""> <i class="fa-solid fa-gears"></i> 관리자
						</a>
							<ul>
								<li><a href="/admin/emp/list">사원조회</a></li>
								<li><a href="/admin/emp/status">사원현황</a></li>
								<li><a href="/admin/emp/approvalList">결재현황</a></li>
								<li><a href="/admin/emp/hoursMgmt">사원근무기록 현황</a></li>
							</ul></li>
					</c:if>

					<li><a href="/tb/logout" data-text=""> <i class="fa-solid fa-power-off"></i> 로그아웃
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
                        <td><a href="#" class="delete-link" data-url="${pageContext.request.contextPath}/stock/delete?stockNo=${item.stockNo}">삭제</a></td>
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

        // 삭제 알림 처리
        $('.delete-link').click(function(event) {
            event.preventDefault(); // 링크 기본 동작 방지

            const deleteUrl = $(this).data('url');

            Swal.fire({
                title: '정말 삭제하시겠습니까?',
                text: '이 작업은 되돌릴 수 없습니다.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#333333',
                cancelButtonColor: '#d33',
                confirmButtonText: '삭제',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = deleteUrl; // 사용자가 확인을 클릭하면 삭제 URL로 이동
                }
            });
        });
    });
    </script>
    
    
</body>
</html>

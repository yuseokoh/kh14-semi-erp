<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>재고 목록</title>

    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="/css/commons.css">
    <link rel="stylesheet" type="text/css" href="/css/gotowork.css">
    <link rel="stylesheet" type="text/css" href="/css/sidebar.css">
    <link rel="stylesheet" type="text/css" href="/css/vacation.css">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fce4ec;
            margin: 0;
            padding: 0;
            position: relative;
        }
        h1 {
            text-align: center;
            color: #ffffff;
            background-color: #f8a5b0;
            padding: 20px;
            margin: 0;
        }
        form {
            display: flex;
            justify-content: center;
            margin: 20px 0;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        label {
            font-weight: bold;
            color: #f8a5b0;
            margin-right: 10px;
            white-space: nowrap;
            margin-top: 8px;
        }
        select, input[type="text"], button {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            margin-right: 10px;
            font-size: 16px;
        }
        button {
            background-color: #f8a5b0;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #f48fb1;
        }
        table {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8a5b0;
            color: white;
            font-weight: bold;
        }
        tr:hover {
            background-color: #fce4ec;
        }
        a {
            color: #f8a5b0;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
        .button-container {
            position: absolute;
            top: 20px;
            right: 20px;
        }
        .button {
            background-color: #ffffff;
            color: #f8a5b0;
            border: 2px solid #f8a5b0;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            text-decoration: none;
            text-align: center;
            display: inline-block;
            transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
        }
        .button:hover {
            background-color: #f8a5b0;
            color: white;
            border-color: #f8a5b0;
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
            top: 5px;
            left: 5px;
            background-color: rgba(255, 0, 0, 0.7);
            color: #ffffff;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
            white-space: nowrap;
        }
        .arrow {
            display: inline-block;
            font-size: 16px;
            margin: 0 9px;
            color: #f48fb1;
        }
        .change-info {
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }
        .search-form {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .search-form input[type="text"] {
            width: 300px;
            margin-right: 10px;
        }
        .register-button {
            display: block;
            width: 120px;
            margin: 20px auto;
            padding: 7px 12px;
            border: none;
            border-radius: 5px;
            background-color: #f8a5b0;
            color: white;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.3s ease;
            text-decoration: none;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .register-button:hover {
            background-color: #f48fb1;
        }
    </style>

    <!-- Additional CSS and JS as needed -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="/js/checkbox.js"></script>
    <script src="/js/confirm-link.js"></script>
    <script src="/js/multipage.js"></script>
    <script src="/js/gotoworkbtn.js"></script>
    <script src="/js/menuToggle.js"></script>
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
                <ul class="menu-hover-fill">
                    <li><a href="/" data-text="home">HOME</a></li>
                    <li><a href="/poketmon/list" data-text=""><i class="fa-solid fa-file-signature"></i> 그룹웨어(poketmon) </a></li>
                    <li><a href="/emp/list" data-text=""><i class="fa-solid fa-cart-flatbed"></i> 재고관리(emp)</a></li>
                    <li><a href="/book/list" data-text=""><i class="fa-solid fa-people-group"></i> 인사관리(book)</a></li>
                    <li><a href="/member/mypage" data-text=""><i class="fa-solid fa-id-card"></i> mypage</a></li>
                    <li><a href="/bbs/list" data-text=""><i class="fa-solid fa-table-columns"></i> 게시판(bbs)</a></li>
                    <li><a href="/board/list" data-text=""><i class="fa-solid fa-wallet"></i> 자료실(board)</a></li>
                    <li><a href="/admin/dashBoard" data-text=""><i class="fa-solid fa-sliders"></i> 관리자(admin)</a></li>
                    <li><a href="/main/loginForm" data-text=""><i class="fa-solid fa-right-to-bracket"></i> logout(main)</a></li>
                </ul>
            </div>
        </nav>
    </aside>

    <!-- Main Content -->
    <main>
        <h1>재고 목록</h1>
        <form action="list" method="get">
            <label for="filter">상품 필터:</label>
            <select name="filter" id="filter">
                <option value="all">전체</option>
                <option value="low_stock">재고 부족</option>
            </select>
            <label for="keyword">검색어:</label>
            <input type="text" name="keyword" id="keyword" placeholder="상품명 입력">
            <button type="submit">검색</button>
        </form>

        <c:choose>
            <c:when test="${not empty productList}">
                <table>
                    <thead>
                        <tr>
                            <th>상품 ID</th>
                            <th>상품명</th>
                            <th>상품 이미지</th>
                            <th>재고 수량</th>
                            <th>변경 수량</th>
                            <th>수량 수정</th>
                            <th>재고 변경 내역</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${productList}">
                            <tr>
                                <td>${product.id}</td>
                                <td>${product.name}</td>
                                <td class="product-container">
                                    <c:if test="${product.lowStock}">
                                        <span class="low-stock">재고 부족</span>
                                    </c:if>
                                    <img src="${product.imageUrl}" alt="${product.name}" class="product-image">
                                </td>
                                <td>${product.stock}</td>
                                <td>
                                    <form action="updateStock" method="post">
                                        <input type="hidden" name="id" value="${product.id}">
                                        <input type="number" name="quantity" value="0">
                                </td>
                                <td>
                                        <button type="submit">수량 수정</button>
                                    </form>
                                </td>
                                <td>
                                    <a href="changeHistory?id=${product.id}" class="change-info">변경 내역 보기</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p>상품이 없습니다.</p>
            </c:otherwise>
        </c:choose>
        <a href="registerForm" class="register-button">상품 등록</a>
    </main>
    
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 목록</title>
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

    /* 검색 폼 스타일 */
    .search-form {
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }

    .search-form input[type="text"] {
        width: 300px;
        margin-right: 10px;
    }

    /* 등록 버튼 스타일 */
    .register-button {
        display: block;
        width: 120px; /* 버튼의 고정 너비 */
        higth:90px;
        margin: 20px auto;
        padding: 7px 12px; /* 버튼 크기 조정 */
        border: none;
        border-radius: 5px;
        background-color: #f8a5b0;
        color: white;
        font-size: 16px; /* 작은 폰트 사이즈 */
        cursor: pointer;
        text-align: center;
        transition: background-color 0.3s ease;
        text-decoration: none;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
    }

    .register-button:hover {
        background-color: #f48fb1;
    }
</style>
<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <h1>재고 목록</h1>
    
    <!-- 검색 폼 추가 -->
    <form class="search-form" action="${pageContext.request.contextPath}/stock/list" method="get">
        <select name="column">
            <option value="name" <c:if test="${column eq 'name'}">selected</c:if>>상품명</option>
            <option value="category" <c:if test="${column eq 'category'}">selected</c:if>>카테고리</option>
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
                                
                                <!-- 이전 및 새 수량 추출 -->
                                <c:set var="oldQuantity" value="${fn:substringAfter(log.oldValues, 'Quantity: ')}" />
                                <c:set var="newQuantity" value="${fn:substringAfter(log.newValues, 'Quantity: ')}" />
                                
                                <!-- 수량에 추가 정보가 있는지 확인 -->
                                <c:set var="isComplexFormat" value="${fn:indexOf(oldQuantity, ',') != -1}" />
                                
                                <c:choose>
                                    <c:when test="${isComplexFormat}">
                                        <!-- 추가 텍스트가 포함된 복합 데이터 형식 -->
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
                                        <!-- 단순 수량 데이터 형식 -->
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
</body>
</html>

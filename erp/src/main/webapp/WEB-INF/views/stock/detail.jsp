<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- JSTL fmt 라이브러리 추가 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>재고 상세 정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5; /* 배경색 변경 */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff; /* 컨테이너 배경색 변경 */
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px 30px;
            max-width: 600px;
            width: 100%;
            text-align: center;
        }

        h1 {
            color: #333333; /* 제목 색상 변경 */
            font-size: 24px;
            margin-bottom: 20px;
            background-color: #ffffff; /* 헤더 배경색 변경 */
            padding: 10px 0;
            border-bottom: 2px solid #333333; /* 헤더 하단 테두리 색상 변경 */
        }

        .info {
            margin: 15px 0;
            font-size: 18px;
            color: #555555;
        }

        .info strong {
            color: #333333;
            font-weight: bold;
        }

        .product-image {
            max-width: 100%;
            max-height: 200px;
            border-radius: 10px;
            margin-bottom: 20px;
            margin-top: 20px;
        }

        .button-container {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        a {
            color: #ffffff; /* 링크 텍스트 색상 변경 */
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            background-color: #333333; /* 버튼 배경색 변경 */
            transition: background-color 0.3s ease;
            flex: 1;
            text-align: center;
            margin: 0 5px;
        }

        a:hover {
            background-color: #555555; /* 버튼 호버 시 색상 변경 */
        }

        .back-link {
            background-color: #e0e0e0; /* '목록으로' 링크 배경색 변경 */
            color: #333333; /* 텍스트 색상 변경 */
        }

        .back-link:hover {
            background-color: #bdbdbd; /* 버튼 호버 시 색상 변경 */
            color: #000000; /* 호버 시 텍스트 색상 변경 */
        }

        .form-container {
            margin-top: 20px;
            text-align: center;
        }

        .form-container input {
            padding: 8px;
            margin: 5px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 16px;
        }

        .form-container button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #333333; /* 버튼 배경색 변경 */
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin: 5px;
        }

        .form-container button:hover {
            background-color: #555555; /* 버튼 호버 시 색상 변경 */
        }

        .error-message {
            color: red;
            font-weight: bold;
            margin-top: 10px;
        }

        .success-message {
            color: green;
            font-weight: bold;
            margin-top: 10px;
        }
    </style>
    <script>
        function confirmAction(actionType) {
            return confirm(actionType + " 하시겠습니까? 변동 수량을 잘 확인하세요 ");
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>재고 상세 정보</h1>
        <img src="${pageContext.request.contextPath}/stock/uploaded-images?filename=${fn:escapeXml(dto.imageUrl)}" alt="${dto.stockName}" class="product-image">
        <div class="info"><strong>시리얼 번호:</strong> ${dto.stockNo}</div>
        <div class="info"><strong>카테고리:</strong> ${dto.stockCategory}</div>
        <div class="info"><strong>이름:</strong> ${dto.stockName}</div>
        <div class="info"><strong>수량:</strong> ${dto.stockQuantity}</div>
        <div class="info"><strong>등록 일자:</strong> <fmt:formatDate value="${dto.stockDate}" pattern="yyyy-MM-dd" /></div>
        <div class="info"><strong>유통 기한:</strong> <fmt:formatDate value="${dto.expirationDate}" pattern="yyyy-MM-dd" /></div> <!-- 유통 기한 추가 -->

        <!-- 입고 처리 폼 -->
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/stock/increaseQuantity" method="post" onsubmit="return confirmAction('입고');">
                <input type="hidden" name="stockNo" value="${dto.stockNo}" />
                <input type="number" name="amount" placeholder="입고 수량" min="1" required />
                <button type="submit">입고</button>
            </form>

            <!-- 출고 처리 폼 -->
            <form action="${pageContext.request.contextPath}/stock/decreaseQuantity" method="post" onsubmit="return confirmAction('출고');">
                <input type="hidden" name="stockNo" value="${dto.stockNo}" />
                <input type="number" name="amount" placeholder="출고 수량" min="1" required />
                <button type="submit">출고</button>
            </form>
        </div>

        <div class="button-container">
            <a href="edit?stockNo=${dto.stockNo}">수정</a>
            <a href="list3" class="back-link">목록으로</a>
        </div>

        <!-- 메시지 표시 -->
        <c:if test="${not empty error}">
            <div class="error-message">처리 중 오류가 발생했습니다. ${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="success-message">처리가 완료되었습니다! ${success}</div>
        </c:if>
    </div>
</body>
</html>

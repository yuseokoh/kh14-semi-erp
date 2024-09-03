<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재고 변경</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0; /* 연한 회색 배경 */
            margin: 0;
            padding: 0;
        }
        h1 {
            text-align: center;
            color: #ffffff;
            background-color: #333333; /* 제목 배경색을 #333333으로 설정 */
            padding: 20px;
            margin: 0;
            position: relative;
        }
        table {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            table-layout: fixed; /* 열 너비를 고정하여 내용이 넘치지 않게 설정 */
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            white-space: nowrap; /* 셀 내용이 줄 바꿈 없이 한 줄로 표시되도록 설정 */
            overflow: hidden; /* 내용이 넘치면 숨기기 */
            text-overflow: ellipsis; /* 넘치는 내용을 "..."으로 표시 */
        }
        th {
            background-color: #333333; /* 헤더 배경색을 #333333으로 설정 */
            color: white;
            font-weight: bold;
        }
        tr:hover {
            background-color: #e0e0e0; /* 행 호버 시 연한 회색 */
        }
        .btn-container {
            position: absolute;
            top: 17px; /* 상단에서 20px 떨어진 위치 */
            right: 20px; /* 오른쪽에서 20px 떨어진 위치 */
        }
        .btn {
            background-color: #ffffff; /* 버튼 배경색 흰색 */
            color: #333333; /* 버튼 텍스트 색상 #333333 */
            border: 2px solid #333333; /* 버튼 테두리 색상 #333333 */
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            text-decoration: none;
            text-align: center;
            display: inline-block;
            transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
        }
        .btn:hover {
            background-color: #333333; /* 버튼 호버 시 배경색 #333333 */
            color: white; /* 버튼 호버 시 텍스트 색상 흰색 */
            border-color: #333333; /* 버튼 호버 시 테두리 색상 #333333 */
        }
        .updated-info {
            color: #333333; /* 수정된 정보 텍스트 색상 #333333 */
            word-wrap: break-word;
            white-space: pre-wrap;
        }
        .long-column {
            width: 35%;
        }
        .date-column {
            width: 25%;
        }
        .stock-no-column {
            width: 20%; /* 재고 번호 열 너비를 설정 */
        }
    </style>
    <!-- jQuery 라이브러리 포함 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>
        변경 로그 목록
        <div class="btn-container">
            <a href="list3" class="btn">목록으로</a>
        </div>
    </h1>

    <table id="changeLogTable">
        <thead>
            <tr>
                <th class="stock-no-column">재고 번호</th>
                <th>변경된 필드</th>
                <th class="long-column">수정된 사항</th>
                <th class="date-column">변경 날짜</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="log" items="${changeLogList}">
                <tr>
                    <td class="stock-no-column">
                        <c:choose>
                            <c:when test="${log.stockNo == 0}">
                                신규 등록
                            </c:when>
                            <c:otherwise>
                                ${log.stockNo}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${log.changedFields}</td>
                    <td class="updated-info"
                        data-old-values="${log.oldValues}" 
                        data-new-values="${log.newValues}"></td>
                    <td><fmt:formatDate value="${log.changedDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${empty changeLogList}">
        <p style="text-align: center;">변경 로그가 없습니다.</p>
    </c:if>

    <script>
    $(document).ready(function() {
        // 각 행에 대해 수정된 정보를 계산하고 업데이트합니다.
        $('#changeLogTable tbody tr').each(function() {
            var oldValues = $(this).find('.updated-info').data('old-values'); // 데이터 속성에서 이전 값 가져오기
            var newValues = $(this).find('.updated-info').data('new-values'); // 데이터 속성에서 새로운 값 가져오기
            var updatedInfo = calculateDifferences(oldValues, newValues);
            $(this).find('.updated-info').html(updatedInfo);
        });

        function calculateDifferences(oldStr, newStr) {
            var oldArr = oldStr ? oldStr.split(',') : []; // 쉼표로 구분된 값이라고 가정
            var newArr = newStr ? newStr.split(',') : [];
            var diff = '';

            for (var i = 0; i < oldArr.length; i++) {
                if (i < newArr.length) {
                    var oldValue = oldArr[i].trim();
                    var newValue = newArr[i].trim();

                    // 날짜 형식의 값일 경우
                    if (isDateFormat(oldValue) || isDateFormat(newValue)) {
                        var formattedOldValue = formatDate(oldValue);
                        var formattedNewValue = formatDate(newValue);
                        if (formattedOldValue !== formattedNewValue) {
                            diff += formattedOldValue + ' -> ' + formattedNewValue + '<br>';
                        }
                    } else {
                        // 날짜가 아닌 경우
                        if (oldValue !== newValue) {
                            if (oldValue === 'Increased quantity by') {
                                oldValue = '입고';
                            } else if (oldValue === 'Decreased quantity by') {
                                oldValue = '출고';
                            }
                            if (newValue === 'Increased quantity by') {
                                newValue = '입고';
                            } else if (newValue === 'Decreased quantity by') {
                                newValue = '출고';
                            }
                            diff += oldValue + ' -> ' + newValue + '<br>';
                        }
                    }
                }
            }
            
            return diff ? diff : '변경 없음';
        }

        function isDateFormat(value) {
            return /^\d{4}-\d{2}-\d{2}$/.test(value);
        }

        function formatDate(dateStr) {
            var date;

            if (isDateFormat(dateStr)) {
                date = new Date(dateStr); // yyyy-MM-dd 형식
            } else {
                date = new Date(dateStr);
            }

            if (!isNaN(date.getTime())) {
                var year = date.getFullYear();
                var month = String(date.getMonth() + 1).padStart(2, '0');
                var day = String(date.getDate()).padStart(2, '0');
                return `${year}-${month}-${day}`;
            } else {
                return dateStr; // 변환할 수 없는 경우 원래 값 반환
            }
        }
    });
    </script>
</body>
</html>

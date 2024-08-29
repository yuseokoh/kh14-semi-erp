<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 수량 차트</title>
    <!-- Chart.js 라이브러리 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fce4ec; /* 부드러운 핑크색 배경 */
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #ffffff; /* 헤더 텍스트 색상을 흰색으로 설정 */
            background-color: #f8a5b0; /* 부드러운 핑크색 배경 */
            padding: 20px;
            margin: 0;
        }
        .button-container {
        	margin-top:17px;
        	margin-right:18px;
            position: absolute; /* 버튼을 절대 위치로 설정 */
            top: 20px; /* 상단에서 20px 떨어진 위치 */
            right: 20px; /* 오른쪽에서 20px 떨어진 위치 */
        }
        .button {
            background-color: #ffffff; /* 버튼 배경색 흰색 */
            color: #f8a5b0; /* 버튼 텍스트 색상 부드러운 핑크색 */
            border: 2px solid #f8a5b0; /* 버튼 테두리 색상 부드러운 핑크색 */
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            text-decoration: none;
            text-align: center;
            display: inline-block;
            transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
        }
        .button:hover {
            background-color: #f8a5b0; /* 버튼 호버 시 배경색 부드러운 핑크색 */
            color: white; /* 버튼 호버 시 텍스트 색상 흰색 */
            border-color: #f8a5b0; /* 버튼 호버 시 테두리 색상 부드러운 핑크색 */
        }
        .chart-container {
            width: 80%;
            margin-top:90px;
            margin-left:100px;
            background-color: #ffffff; /* 차트 배경색을 흰색으로 설정 */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        canvas {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <h1>카테고리 수량 차트</h1>
    
    <!-- 버튼 컨테이너 -->
    <div class="button-container">
        <a href="list" class="button">목록으로</a>
    </div>
    
    <!-- 차트 컨테이너 -->
    <div class="chart-container">
        <canvas id="categoryChart"></canvas>
    </div>

    <script>
        // 서버에서 전달된 데이터를 JSON 문자열로 변환 후 파싱
        var categoryMap = ${categoryMapJson};

        // 데이터 추출
        var labels = Object.keys(categoryMap);
        var data = Object.values(categoryMap);

        // 차트 생성
        var ctx = document.getElementById('categoryChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar', // 'line', 'pie', 등 다른 유형을 사용할 수 있습니다.
            data: {
                labels: labels,
                datasets: [{
                    label: '재고 수량',
                    data: data,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    x: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>

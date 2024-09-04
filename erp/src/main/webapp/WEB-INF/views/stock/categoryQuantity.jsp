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
        background-color: #f0f0f0; /* 연한 회색 배경 */
        margin: 0;
        padding: 20px;
    }
    h1 {
        text-align: center;
        color: #ffffff; /* 헤더 텍스트 색상을 흰색으로 설정 */
        background-color: #333333; /* 어두운 회색 배경 */
        padding: 20px;
        margin: 0;
    }
    .button-container {
        margin-top: 20px;
        margin-right: 20px;
        position: absolute; /* 버튼을 절대 위치로 설정 */
        top: 20px; /* 상단에서 20px 떨어진 위치 */
        right: 20px; /* 오른쪽에서 20px 떨어진 위치 */
    }
    .button {
        background-color: #ffffff; /* 버튼 배경색 흰색 */
        color: #333333; /* 버튼 텍스트 색상 어두운 회색 */
        border: 2px solid #333333; /* 버튼 테두리 색상 어두운 회색 */
        padding: 10px 20px;
        border-radius: 5px;
        font-size: 16px;
        text-decoration: none;
        text-align: center;
        display: inline-block;
        transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
    }
    .button:hover {
        background-color: #333333; /* 버튼 호버 시 배경색 어두운 회색 */
        color: white; /* 버튼 호버 시 텍스트 색상 흰색 */
        border-color: #333333; /* 버튼 호버 시 테두리 색상 어두운 회색 */
    }
    .charts-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr); /* 두 개의 열 생성 */
        grid-template-rows: repeat(2, 1fr); /* 두 개의 행 생성 */
        gap: 10px; /* 차트들 사이의 간격 줄임 */
        margin-top: 30px;
    }
    .chart-container {
        background-color: #ffffff; /* 차트 배경색을 흰색으로 설정 */
        padding: 10px; /* 패딩 줄임 */
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
    }
    #barChart {
        grid-column: 1 / 2; /* 첫 번째 열 */
        grid-row: 1 / 2; /* 첫 번째 행 */
        height: 200px; /* 차트 높이 설정 */
    }
    #pieChart {
        grid-column: 2 / 3; /* 두 번째 열 */
        grid-row: 1 / 2; /* 첫 번째 행 */
        height: 200px; /* 차트 높이 설정 */
    }
    #lineChart {
        grid-column: 1 / 2; /* 첫 번째 열 */
        grid-row: 2 / 3; /* 두 번째 행 */
        height: 400px; /* 차트 높이 설정 */
    }
    #radarChart {
        grid-column: 2 / 3; /* 두 번째 열 */
        grid-row: 2 / 3; /* 두 번째 행 */
        height: 400px; /* 차트 높이 설정 */
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
    
    <!-- 차트 그리드 컨테이너 -->
    <div class="charts-grid">
        <!-- 바 차트 컨테이너 -->
        <div class="chart-container">
            <canvas id="barChart"></canvas>
        </div>
        
        <!-- 파이 차트 컨테이너 -->
        <div class="chart-container">
            <canvas id="pieChart"></canvas>
        </div>
        
        <!-- 라인 차트 컨테이너 -->
        <div class="chart-container">
            <canvas id="lineChart"></canvas>
        </div>
        
        <!-- 레이더 차트 컨테이너 -->
        <div class="chart-container">
            <canvas id="radarChart"></canvas>
        </div>
    </div>

    <script>
        // 서버에서 전달된 데이터를 JSON 문자열로 변환 후 파싱
        var categoryMap = ${categoryMapJson};

        // 데이터 추출
        var labels = Object.keys(categoryMap);
        var data = Object.values(categoryMap);

        // 바 차트 생성
        var ctxBar = document.getElementById('barChart').getContext('2d');
        var barChart = new Chart(ctxBar, {
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

        // 파이 차트 생성
        var ctxPie = document.getElementById('pieChart').getContext('2d');
        var pieChart = new Chart(ctxPie, {
            type: 'pie', // 파이 차트 유형
            data: {
                labels: labels,
                datasets: [{
                    label: '재고 수량',
                    data: data,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(tooltipItem) {
                                return tooltipItem.label + ': ' + tooltipItem.raw;
                            }
                        }
                    }
                }
            }
        });

        // 라인 차트 생성
        var ctxLine = document.getElementById('lineChart').getContext('2d');
        var lineChart = new Chart(ctxLine, {
            type: 'line', // 라인 차트 유형
            data: {
                labels: labels,
                datasets: [{
                    label: '재고 수량',
                    data: data,
                    fill: false,
                    borderColor: 'rgba(75, 192, 192, 1)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    x: {
                        beginAtZero: true
                    },
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // 레이더 차트 생성
        var ctxRadar = document.getElementById('radarChart').getContext('2d');
        var radarChart = new Chart(ctxRadar, {
            type: 'radar', // 레이더 차트 유형
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
                    r: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>

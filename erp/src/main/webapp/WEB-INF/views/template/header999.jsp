<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 홈페이지</title>

    <!-- Google Font CDN -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons CDN -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f0f0f0; /* 페이지 배경색 */
        }

        #header-container {
            width: 100%;
            height: 175px;
            background: #1c262d;
            position: fixed; /* 헤더를 고정 위치에 배치 */
            top: 0; /* 상단에 위치 */
            left: 0;
            display: flex;
            justify-content: center; /* 중앙 정렬 */
            align-items: center; /* 수직 중앙 정렬 */
            z-index: 1000; /* 헤더가 다른 요소 위에 표시되도록 설정 */
        }

        #animate {
            color: #fff;
            padding-left: 30px;
            font-weight: 400;
            font-size: 60pt;
        }

        #bar {
            width: 7px;
            height: 72px;
            background-color: #0d56c2;
            position: absolute;
            top: 60px;
            left: 30px;
            transition: display 0.5s;
        }

        #header-content {
            position: relative; /* 바를 절대 위치로 설정하기 위해 사용 */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }
    </style>
    
    <!-- jQuery CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
    <!-- JavaScript Code -->
    <script type="text/javascript">
        window.onload = myMove;

        document.addEventListener('visibilitychange', function() {
            clearInterval(i);
            clearInterval(j); 
            document.getElementById("bar").style.display = "block";
            myMove(); 
        });

        function myMove() {
            var text = document.getElementById("animate");
            var bar = document.getElementById("bar");
            var str = "ERP. 만드는 중.";
            var pos = 0;
            var count = 0;
            bar.style.display = "block";
            
            function flash(duration) {
                j = window.setInterval(function() {
                    bar.style.display = (bar.style.display === 'none' ? '' : 'none');
                }, 500);
                setTimeout(function() {
                    clearInterval(j); 
                    bar.style.display = "block";
                }, duration); 
            }
            
            i = window.setInterval(frame, 150);

            function erase() {
                clearInterval(j); 
                clearInterval(i);
                i = window.setInterval(frame, 50);
            }

            function frame() {
                if (pos < 5 || (pos >= 20 && pos < 31)) {
                    count++;
                    pos++; 
                    text.innerHTML = str.substring(0, count);
                    bar.style.left = (text.offsetWidth + 15) + 'px';
                } else if (pos > 47 && pos <= 63) {
                    count--;
                    pos++; 
                    text.innerHTML = str.substring(0, count);
                    bar.style.left = (text.offsetWidth + 15) + 'px';
                } else if (pos === 80) {
                    clearInterval(i);
                    pos = 0; 
                    i = window.setInterval(frame, 150);
                } else if (pos === 47) {
                    erase();
                    pos++;
                } else if (pos === 5 || pos === 31) {
                    flash(1800);
                    pos++;
                } else {
                    pos++;
                }
            }
        }
    </script>
</head>
<body>
    <!-- 홈페이지 상단에 고정된 헤더 영역 -->
    <div id="header-container">
        <div id="header-content">
            <span id="animate"></span>
            <div id="bar"></div>
        </div>
    </div>
</body>
</html>
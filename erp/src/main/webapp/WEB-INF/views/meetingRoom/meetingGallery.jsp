<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>회의실 목록(갤러리)</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 10px; /* 이미지 간 여백을 위한 설정 */
        }

        .image {
            width: calc(25% - 10px); /* 기본적으로 4열 */
            transition: width 0.3s ease;
        }

        .w-25 {
            width: calc(25% - 10px); /* 4열 */
        }

        .w-50 {
            width: calc(50% - 10px); /* 2열 */
        }

        img {
            width: 100%;
            height: auto;
            display: block;
        }
    </style>
    <script type="text/javascript">
        function change50() {
            var images = document.querySelectorAll(".image");
            images.forEach(function(image) {
                image.classList.remove("w-25");
                image.classList.add("w-50");
            });
        }

        function change25() {
            var images = document.querySelectorAll(".image");
            images.forEach(function(image) {
                image.classList.remove("w-50");
                image.classList.add("w-25");
            });
        }
    </script>
</head>

<body>
    <div class="row right">
        <h3>회의실 미리보기</h3>
        <button type="button" onclick="change25();">4열</button>
        <button type="button" onclick="change50();">2열</button>
    </div>
    <h1>서울 본사</h1>
    <hr>
    <div class="row">
        <div class="image w-25"><img src="https://picsum.photos/id/1/400/400" alt="회의실1"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/2/400/400" alt="회의실2"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/3/400/400" alt="회의실3"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/4/400/400" alt="회의실4"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/5/400/400" alt="회의실5"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/6/400/400" alt="회의실6"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/7/400/400" alt="회의실7"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/8/400/400" alt="회의실8"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/9/400/400" alt="회의실9"></div>
    </div>
    <h1>서부 지점</h1>
    <hr>
    <div class="row">
        <div class="image w-25"><img src="https://picsum.photos/id/1/400/400" alt="회의실1"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/2/400/400" alt="회의실2"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/3/400/400" alt="회의실3"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/4/400/400" alt="회의실4"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/5/400/400" alt="회의실5"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/6/400/400" alt="회의실6"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/7/400/400" alt="회의실7"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/8/400/400" alt="회의실8"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/9/400/400" alt="회의실9"></div>
    </div>
    <h1>남부 지점</h1>
    <hr>
    <div class="row">
        <div class="image w-25"><img src="https://picsum.photos/id/1/400/400" alt="회의실1"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/2/400/400" alt="회의실2"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/3/400/400" alt="회의실3"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/4/400/400" alt="회의실4"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/5/400/400" alt="회의실5"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/6/400/400" alt="회의실6"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/7/400/400" alt="회의실7"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/8/400/400" alt="회의실8"></div>
        <div class="image w-25"><img src="https://picsum.photos/id/9/400/400" alt="회의실9"></div>
    </div>
</body>

</html>

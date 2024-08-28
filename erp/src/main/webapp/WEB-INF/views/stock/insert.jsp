<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재고 등록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fce4ec; /* 부드러운 핑크색 배경 */
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 20px auto; /* 수평 가운데 정렬 */
            padding: 20px;
            background-color: #ffffff; /* 폼 배경색 흰색 */
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #f8a5b0; /* 부드러운 핑크색 헤더 텍스트 */
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 15px;
            display: flex;
            flex-direction: column; /* 레이블과 입력 필드를 수직으로 정렬 */
        }

        .form-group label {
            font-weight: bold;
            color: #555; /* 레이블 색상 */
            margin-bottom: 5px; /* 레이블과 입력 필드 사이의 여백 */
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group input[type="date"],
        .form-group input[type="file"] { /* 날짜 입력 필드 추가 */
            padding: 10px;
            border: 1px solid #ddd; /* 연한 회색 테두리 */
            border-radius: 5px;
            font-size: 16px;
            width: 90%; /* 입력 필드를 컨테이너의 전체 너비로 설정 */
        }

        button {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #f8a5b0; /* 부드러운 핑크색 배경 */
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 10px; /* 버튼 위쪽 여백 */
        }

        button:hover {
            background-color: #f48fb1; /* 버튼 호버 시 약간 어두운 핑크색 */
        }

        .image-preview {
            max-width: 150px; /* 이미지 최대 너비를 늘려서 보기 쉽게 */
            max-height: auto;
            border-radius: 5px; /* 이미지 모서리를 둥글게 */
            margin-bottom: 10px; /* 이미지와 다른 요소 간의 여백 */
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // 사용자가 이미지를 업로드하면 즉시 미리보기 표시
            $('#image').change(function() {
                let reader = new FileReader();
                reader.onload = function(e) {
                    $('#imagePreview').attr('src', e.target.result); // 미리보기 이미지 설정
                    $('#imagePreview').show(); // 미리보기 이미지 표시
                }
                reader.readAsDataURL(this.files[0]); // 파일 읽기
            });

            // 폼 제출 시 확인 대화상자
            $('form').submit(function(event) {
                if (!confirm('정말 등록하시겠습니까?')) {
                    event.preventDefault(); // 사용자가 취소를 클릭하면 폼 제출을 막음
                }
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <h1>재고 등록</h1>
        <!-- enctype="multipart/form-data" 추가 -->
        <form action="insert" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="stockCategory">카테고리:</label>
                <input type="text" id="stockCategory" name="stockCategory" required>
            </div>

            <div class="form-group">
                <label for="stockName">이름:</label>
                <input type="text" id="stockName" name="stockName" required>
            </div>

            <div class="form-group">
                <label for="stockQuantity">수량:</label>
                <input type="number" id="stockQuantity" name="stockQuantity" required>
            </div>

            <!-- 유통기한 입력 필드 추가 -->
            <div class="form-group">
                <label for="expirationDate">유통기한:</label>
                <input type="date" id="expirationDate" name="expirationDate">
            </div>

            <!-- 이미지 업로드 필드 추가 -->
            <div class="form-group">
                <label for="image">이미지(업로드 사진을 미리 확인하세요)</label>
                <input type="file" id="image" name="image" accept="image/*">
            </div>

            <div class="form-group">
                <img id="imagePreview" class="image-preview" style="display:none;" />
            </div>

            <button type="submit">등록</button>
        </form>
    </div>
</body>
</html>
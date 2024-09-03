<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>재고 등록</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5; /* 기존 페이지와 일관성 있는 배경색 */
            margin: 0;
            padding: 0;
            color: #333; /* 기존 페이지와 일관성 있는 텍스트 색상 */
        }

        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333333; /* 기존 페이지와 일관성 있는 제목 색상 */
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 15px;
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: bold;
            color: #555; /* 레이블 색상 */
            margin-bottom: 5px;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group input[type="date"],
        .form-group input[type="file"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            width: 95%;
        }

        button {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #333333; /* 기존 페이지와 일관성 있는 버튼 색상 */
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        button:hover {
            background-color: #555555; /* 버튼 호버 시 색상 */
        }

        .image-preview {
            max-width: 150px;
            max-height: auto;
            border-radius: 5px;
            margin-bottom: 10px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        $(document).ready(function() {
            // 사용자가 이미지를 업로드하면 즉시 미리보기 표시
            $('#image').change(function() {
                let reader = new FileReader();
                reader.onload = function(e) {
                    $('#imagePreview').attr('src', e.target.result);
                    $('#imagePreview').show();
                }
                reader.readAsDataURL(this.files[0]);
            });

            // 폼 제출 시 비동기적으로 데이터 전송
            $('form').on('submit', function(event) {
                event.preventDefault(); // 기본 폼 제출 막기

                let formData = new FormData(this);

                $.ajax({
                    url: $(this).attr('action'),
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        Swal.fire({
                            icon: 'success',
                            title: '등록 성공',
                            text: '재고가 성공적으로 등록되었습니다.',
                            confirmButtonText: '확인'
                        }).then(function() {
                            // 성공 후 리스트 페이지로 리다이렉트
                            window.location.href = '/stock/list3'; // 실제 리스트 페이지 URL로 변경
                        });
                    },
                    error: function() {
                        Swal.fire({
                            icon: 'error',
                            title: '등록 실패',
                            text: '재고 등록에 실패했습니다. 다시 시도해 주세요.',
                            confirmButtonText: '확인'
                        });
                    }
                });
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <h1>재고 등록</h1>
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

            <div class="form-group">
                <label for="expirationDate">유통기한:</label>
                <input type="date" id="expirationDate" name="expirationDate">
            </div>

            <div class="form-group">
                <label for="image">이미지(.png 권장) 업로드 사진을 미리 확인하세요</label>
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

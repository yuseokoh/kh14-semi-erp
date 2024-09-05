<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 수정</title>
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding: 0;
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
    color: #333333;
    margin-bottom: 20px;
    font-size: 24px;
    background-color: #ffffff;
    padding: 10px 0;
    border-bottom: 2px solid #333333;
}

form {
    display: flex;
    flex-direction: column;
}

.form-group {
    margin-bottom: 20px;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
}

.form-group label {
    font-weight: bold;
    color: #333333;
    margin-bottom: 8px;
    font-size: 16px;
}

.form-group input[type="text"], .form-group input[type="number"],
.form-group input[type="date"], .form-group input[type="file"] {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    width: 100%;
    box-sizing: border-box;
}

button {
    padding: 12px 20px;
    border: none;
    border-radius: 5px;
    background-color: #333333;
    color: white;
    font-size: 18px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    align-self: center;
}

button:hover {
    background-color: #555555;
}

.image-preview {
    max-width: 150px;
    max-height: auto;
    border-radius: 5px;
    margin-bottom: 10px;
}

.current-expiration-date {
    font-size: 16px;
    color: #555555;
    margin-bottom: 10px;
    text-align: left;
}

a {
    display: block;
    text-align: center;
    color: #ffffff;
    text-decoration: none;
    font-weight: bold;
    padding: 10px;
    border-radius: 5px;
    background-color: #333333;
    margin-top: 20px;
}

a:hover {
    background-color: #555555;
}

/* SweetAlert2 custom styles */
.swal2-popup {
    background-color: #ffffff !important;
    color: #333333 !important;
}

.swal2-title {
    font-size: 26px !important;
    font-weight: bold;
}

.swal2-confirm, .swal2-cancel {
    background-color: #333333 !important;
    color: white !important;
    border: 2px solid #333333 !important;
    font-size: 14px;
}

.swal2-confirm:hover, .swal2-cancel:hover {
    background-color: #555555 !important;
    border-color: #555555 !important;
}

.swal2-cancel {
    background-color: #ffffff !important;
    color: #333333 !important;
}
</style>
<script>
$(document).ready(function() {
    // Image preview
    $('#image').change(function() {
        let reader = new FileReader();
        reader.onload = function(e) {
            $('#imagePreview').attr('src', e.target.result);
            $('#imagePreview').show();
        }
        reader.readAsDataURL(this.files[0]);
    });

    // Form submission with SweetAlert2
    $('form').submit(function(event) {
        event.preventDefault(); // Prevent default form submission

        let formData = new FormData(this);

        Swal.fire({
            title: '수정 확인',
            text: '변동 사항을 잘 확인하세요. 정말 수정하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#333333',
            cancelButtonColor: '#ffffff',
            confirmButtonText: '수정',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/stock/edit',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function(response) {
                        if (response.error) {
                            Swal.fire({
                                title: '오류!',
                                text: response.message,
                                icon: 'error',
                                confirmButtonText: '확인'
                            });
                        } else {
                            Swal.fire({
                                title: '수정 완료!',
                                text: '재고 정보가 성공적으로 수정되었습니다.',
                                icon: 'success',
                                confirmButtonText: '확인'
                            }).then(() => {
                                window.location.href = '${pageContext.request.contextPath}/stock/detail?stockNo=' + response.stockNo;
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                            title: '오류!',
                            text: '수정 중 오류가 발생했습니다.',
                            icon: 'error',
                            confirmButtonText: '확인'
                        });
                    }
                });
            }
        });
    });
});
</script>
</head>
<body>
    <div class="container">
        <h1>재고 수정</h1>
        <form action="${pageContext.request.contextPath}/stock/edit" method="post" enctype="multipart/form-data">
            <input type="hidden" name="stockNo" value="${dto.stockNo}">
            <input type="hidden" id="imageUrl" name="imageUrl" value="${fn:escapeXml(dto.imageUrl)}">

            <div class="form-group">
                <label for="stockCategory">카테고리</label>
                <input type="text" id="stockCategory" name="stockCategory" value="${dto.stockCategory}" required>
            </div>

            <div class="form-group">
                <label for="stockName">이름</label>
                <input type="text" id="stockName" name="stockName" value="${dto.stockName}" required>
            </div>

            <div class="form-group">
                <label for="stockQuantity">수량</label>
                <input type="number" id="stockQuantity" name="stockQuantity" value="${dto.stockQuantity}" required>
            </div>

            <div class="form-group">
                <label for="expirationDate">수정할 유통기한을 입력하세요</label>
                <input type="date" id="expirationDate" name="expirationDate" value="${dto.expirationDate != null ? fn:escapeXml(dto.expirationDate) : ''}">
            </div>

            <div class="form-group">
                <label>현재 이미지</label>
                <img id="imagePreview" src="${pageContext.request.contextPath}/stock/uploaded-images?filename=${dto.imageUrl}" alt="Image Preview" class="image-preview" style="display: block;">
            </div>

            <div class="form-group">
                <label for="image">새 이미지 업로드 (.png 권장) 현재 이미지를 확인하세요</label>
                <input type="file" id="image" name="image">
            </div>

            <button type="submit">수정</button>
        </form>
        <a href="${pageContext.request.contextPath}/stock/list">목록으로 돌아가기</a>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- SweetAlert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="text/javascript">	 
function showAlert() {
    Swal.fire({
        title: '<span class="custom-title">이메일 발송완료</span>',
        icon: 'success',
        customClass: {
            title: 'custom-title'
        }
    }).then((result) => {
        if (result.isConfirmed) {
            // 첫 번째 알림창의 "확인" 버튼 클릭 시 두 번째 알림창 표시
            Swal.fire({
                title: '<span class="custom-title">이메일을 확인해주세요</span>',
                text: ' ',
                icon: 'success',
                customClass: {
                    title: 'custom-title'
                }
            });
        }
    });
}
</script>
<div class="container w-600 my-50">
	<div class="row center"><h1>비밀번호 찾기</h1></div>
	<form action="findPw" method="post" autocomplete="off" class="check-form">
	<div class="row">
		<label>아이디</label><input class="field w-100" type="text" name="loginId">
		<br>
		<label>이메일</label><input class="field w-100" 
		name="EmpEmail"type="email" placeholder="이메일로 임시 비밀번호가 발급됩니다.">
		<button onclick="showAlert()">클릭</button>
		 <c:if test="${param.error!=null}">
    <div class="row center">
        <h3 style="color:red" class="field">올바른 아이디를 입력해 주세요</h3>
    </div>
</c:if> 
	</div>
	</form>
</div>

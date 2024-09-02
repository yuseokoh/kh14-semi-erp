<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>




<div class="container w-600 my-50">
	<div class="row center">
		<h1>비밀번호 재설정</h1>
	</div>
	<form action="resetPw" method="post" autocomplete="off">
		<input type="hidden" name=certEmail value="${certDto.certEmail}">
		<input type="hidden" name=certNumber value="${certDto.certNumber}">
		<input type="hidden" name=loginId value="${loginId}">
		<div class="row">
			<label>변경할 비밀번호</label><input class="field w-100" type="password" name="password">
		</div>
		<div class="row mt-30">
			<button type="submit" class="w-100">
			<i class="fa-solid fa-user-lock"></i> 변경하기</button>
		</div>
	</form>
</div>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form method="post" action="addImage" enctype="multipart/form-data">
	<input type="hidden" name="loginId" value="${sessionScope.createdUser}">
	<div class="row">
    	<input type="file" name="attach" accept="image/*" class="field w-100">
	</div>
	<button type="submit">수정하기</button>    
</form>

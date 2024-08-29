<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script type="text/javascript">
 $(function(){
	 
	 $(".check-form").submit(function(){
		 var btn = $(this).find(".btn-positive");
		 btn.find("i").removeClass("fa-paper-plane").addClass("fa-spinner fa-spin");
		 btn.find(".a").text("받는중....");
	 });
 });
</script>
<div class="container w-600 my-50">
	<div class="row center"><h1>비밀번호 찾기</h1></div>
	<form action="findPw" method="post" autocomplete="off" class="check-form">
	<div class="row">
		<label>아이디</label><input class="field w-100" type="text" name="loginId">
		<br>
		<label>이메일</label><input class="field w-100" 
		name="EmpEmail"type="email" placeholder="이메일로 임시 비밀번호가 발급됩니다.">
		<button type="submit" class="w-100 pd-30">
		 <i class="fa-solid fa-paper-plane"></i>  <span class="a">발급받기</span></button>
		 <c:if test="${param.error!=null}">
    <div class="row center">
        <h3 style="color:red" class="field">올바른 아이디를 입력해 주세요</h3>
    </div>
</c:if> 
	</div>
	</form>
</div>

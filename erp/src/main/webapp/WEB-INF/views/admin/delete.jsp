<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>정말 삭제하시겠습니까?</h1>
<form action="delete" autocomplete="off" method="post">
<input type="hidden" value="${loginId}" name="loginId">
<button type="submit">지우기</button>
</form>
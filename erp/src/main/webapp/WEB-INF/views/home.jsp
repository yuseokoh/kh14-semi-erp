<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<h1>${sessionScope.createdUser}</h1>
<h1>홈</h1>

<c:choose>
<c:when test="${sessionScope.createdUser!=null}">
	<a href="/tb/logout">로그아웃</a>
</c:when>
<c:otherwise>
	<a href="/tb/login">로그인</a>
</c:otherwise>
</c:choose>
<a href="/tb/edit">수정하기</a>
<a href="/tb/mypage">마이페이지</a>
<a href="/tb/list">검색/리스트확인</a>
<c:if test="${sessionScope.userType=='A'}">
	<a href="/admin/home">관리자페이지</a>
</c:if>


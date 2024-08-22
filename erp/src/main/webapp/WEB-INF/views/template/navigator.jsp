<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 네비게이터 -->
<div class="container w-800">
	<div class="row">
		<div class="pagination">
			<c:if test="${pageVO.hasPrev()}">
			<a href="list?column=${pageVO.column}&keyword=${pageVO.keyword}&page=${pageVO.getPrevBlock()}">
			<i class="fa-solid fa-chevron-left"></i></a> 
			</c:if>
	<%--?부터 ?까지 반복문으로 출력  --%>
	<c:forEach var="n" begin="${pageVO.startBlock}" 
				end="${pageVO.finishBlock}" step="1"> 

		<c:choose>
			<c:when test="${pageVO.page==n}">
				<a class="on">${n}</a></c:when>
			<c:otherwise>
				<a href="list?column=${pageVO.column}&keyword=${pageVO.keyword}&page=${n}">${n}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${pageVO.hasNext()}">
	<a href="list?column=${pageVO.column}&keyword=${pageVO.keyword}&page=${pageVO.getNextBlock()}">
			<i class="fa-solid fa-chevron-right"></i></a>
	</c:if>
		
		</div>
	</div>
</div>

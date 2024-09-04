<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 네비게이터 -->
<h2>
	<c:if test="${pageVO.hasPrev()}">
	<a href="noticList?column=${pageVO.column}&keyword=${pageVO.keyword}&page=${pageVO.prevBlock}">이전</a>
	</c:if>
	
	<%-- 
		startBlock부터 
		finishBlock과 lastBlock중 작은값까지 
		반복문으로 링크 출력 
	--%>
	<c:forEach var="n" begin="${pageVO.startBlock}" 
								end="${pageVO.finishBlock}" step="1">
		<c:choose>
			<c:when test="${pageVO.page == n}">
				<a>${n}</a>
			</c:when>
			<c:otherwise>
				<a href="noticList?column=${pageVO.column}&keyword=${pageVO.keyword}&page=${n}">${n}</a>		
			</c:otherwise>
		</c:choose>
	</c:forEach>
	 
	<%-- 다음 버튼은 마지막 구간이 아닐 때(finishBlock < lastBlock) 나온다 --%>
	<c:if test="${pageVO.hasNext()}">
	<a href="noticList?column=${pageVO.column}&keyword=${pageVO.keyword}&page=${pageVO.nextBlock}">다음</a>
	</c:if>
</h2>
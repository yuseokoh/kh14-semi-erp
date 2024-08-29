<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-900 my-50">
	<div class="row">
		<h1>공지사항 게시판</h1>
	</div>

	<div class="row right">
		<%-- 비회원일 때와 회원일 때 다르게 보이도록 처리 --%>
		<c:choose>
			<c:when test="${sessionScope.createdtestUser != null}">
				<a href="write" class="btn btn-neutral">글쓰기</a>
			</c:when>
			<c:otherwise>
				<a title="로그인 하셔야 이용하실 수 있습니다" class="btn btn-neutral">글쓰기</a>
			</c:otherwise>
		</c:choose>
	</div>
	
	<!-- 글목록 -->
	<!-- 1 / 9페이지 (?개 중 ?~?번째) -->
	<div class="row right">
		${pageVO.page} / ${pageVO.lastBlock} 페이지
		(${pageVO.beginRow} - ${pageVO.endRow} / ${pageVO.count} 개)
	</div>
	
	<div class="row">
		<table class="table table-border table-stripe table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>좋아요</th>
					<th>번호</th>
<!-- 					<th>그룹</th> -->
<!-- 					<th>상위</th> -->
<!-- 					<th>차수</th> -->
				</tr>
			</thead>
			<tbody>
				<c:forEach var="noticeDto" items="${noticeList}">
				<tr>
					<td>${noticeDto.noticeNo}</td>
					<td class="left" style="padding-left:${noticeDto.noticeDepth*15 + 20}px">
						<c:if test="${noticeDto.noticeDepth > 0}">
							<img src="/images/reply.png" width="16" height="16">
						</c:if>
					
						<!-- 제목에 링크를 부여해서 상세 페이지로 이동하도록 구현 -->
						<a class="link link-animation" href="detail?noticeNo=${noticeDto.noticeNo}">${noticeDto.noticeTitle}</a>
					
						<!-- 댓글 숫자 출력(0보다 크면) -->
						<c:if test="${noticeDto.noticeReplies > 0}">
						[${noticeDto.noticeReplies}]
						</c:if>
					
					</td>
					<td>
						<%--
						<c:choose>
							<c:when test="${boardDto.boardWriter == null}">
								탈퇴한사용자
							</c:when>
							<c:otherwise>${boardDto.boardWriter}</c:otherwise>
						</c:choose>
						 --%>
						 ${noticeDto.noticeWriterString}
					</td>
					<td>${noticeDto.noticeWtimeString}</td>
					<td class="right">
						<fmt:formatNumber value="${noticeDto.noticeViews}" pattern="#,##0"/>
					</td>
					<td class="right">
						<fmt:formatNumber value="${noticeDto.noticeLikes}" pattern="#,##0"/>
					</td>
					
					<td>${noticeDto.noticeNo}</td>
<%-- 					<td>${boardDto.boardGroup}</td> --%>
<%-- 					<td>${boardDto.boardTarget}</td> --%>
<%-- 					<td>${boardDto.boardDepth}</td> --%>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="row">
		<!-- 네비게이터 불러오는 코드 -->
		<jsp:include page="/WEB-INF/views/template/navigator.jsp"/>
	</div>
	
	<!-- 검색창 -->
	<div class="row center">
		<form action="list" method="get" autocomplete="off">
			<select name="column" class="field">
				<option value="notice_title" <c:if test="${param.column == 'notice_title'}">selected</c:if>>제목</option>
				<option value="notice_writer" <c:if test="${param.column == 'notice_writer'}">selected</c:if>>작성자</option>
			</select>
			<input class="field" type="text" name="keyword" placeholder="검색어" value="${param.keyword}">
			<button class="btn btn-positive" type="submit">검색</button>
		</form>
	</div>
	
</div>


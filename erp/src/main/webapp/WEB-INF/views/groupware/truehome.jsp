<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<body>
	<div id="content" style="margin-top: 200px;">
		<main id="body">
			<!-- <div id="content" style="margin-top: 200px;"> -->
			<!-- 여기서부터 메인 화면의 콘텐츠가 시작됩니다. -->
			<h2>${sessionScope.createdUser}님 환영합니다 일하십쇼</h2>
			<p></p>

			<div class="row flex-box w-1200">
				<div class="w-50 center">
					<canvas class="my-chart"></canvas>
				</div>
				<div class="w-50 center">내정보</div>
			</div>


			<div class="row flex-box w-1200">
				<div class="calendar w-80 center"></div>
				<div class="w-70 center">채팅?편지함?</div>
			</div>
		</main>
	</div>
	
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
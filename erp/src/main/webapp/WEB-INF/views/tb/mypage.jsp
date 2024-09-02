<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>    

<div>
	<div>
		<h1>${tbEmpDto.name}님의 정보</h1>
	</div>
	
	<div>
		<h2>직급 [${tbEmpDto.empLevel}]</h2>
		<h2>부서 [${tbEmpDto.empDept}]</h2>
	</div>
	<div>
<!-- 	개인정보 -->
		<h2>이메일 [${tbEmpDto.empEmail}]</h2>
		<h2>전화번호[${tbEmpDto.empHp}]</h2>
	</div>
	<div>
		<img src="/tb/myImage?loginId=${tbEmpDto.loginId}" width="100">
		<a href="addImage">사진 추가 등록하기</a>
	</div>
	<div>
		<h2>오늘까지의 근무일수는 ${workingDays}일 입니다.</h2>
	
	</div>
	<div>
		<a href="edit">수정하기</a>
	</div>

</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>    
<form method="post" action="edit" autocomplete="off">
   
<div>
	<div>
		<h1>정보 수정하기</h1>
	</div>
	이름,전화번호,이메일,생일,최종학력,비고,주소
	<div>
		<label>이름</label><input value="${tbEmpDto.name }" name="name" type="text">
		<label>전화번호</label><input value="${tbEmpDto.empHp }" name="empHp" type="text">
		<label>이메일</label><input value="${tbEmpDto.empEmail}" name="empEmail" type="email">
		<label>생일</label><input value="${tbEmpDto.empBirth}" name="empBirth" type="date">
		<label>최종학력</label><input value="${tbEmpDto.empEdu}" name="empEdu" type="text">
		<label>비고</label><input value="${tbEmpDto.empMemo}" name="empMemo" type="text">
		
	</div>
	<div>
		<label>우편번호</label><input value="${tbEmpDto.empPost}" name="empPost" type="number">
		<label>기본주소</label><input value="${tbEmpDto.empAddress1}" name="empAddress1" type="text">
		<label>상세주소</label><input value="${tbEmpDto.empAddress2}" name="empAddress2" type="text">
	</div>

</div>
<button type="submit">수정하기</button>
</form>
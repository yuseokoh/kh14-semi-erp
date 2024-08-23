<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<h2>전화번호 [${tbEmpDto.empHp}]</h2>
	</div>
</div>	

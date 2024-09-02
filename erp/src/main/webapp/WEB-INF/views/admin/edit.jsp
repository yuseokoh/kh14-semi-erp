<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<form method="post" action="edit" autocomplete="off">
   
<div>
	<div>
		<h1>정보 수정하기(관리자)</h1>
	</div>
	돈관련,직급,부서,비고,각종보험들,보험등록일자,세후급여,계좌번호,은행
	<div>
		<input type="hidden" value="${tbEmpDto.loginId}" name="loginId">
		<label>직급</label><input value="${tbEmpDto.empLevel }" name="empLevel" type="text">
		<label>부서</label><input value="${tbEmpDto.empDept }" name="empDept" type="text">
		<label>비고</label><input value="${tbEmpDto.empMemo}" name="empMemo" type="text">
		<label>산재 보험</label><input value="${tbEmpDto.salSan}" name="salSan" type="text">
		<label>고용 보험</label><input value="${tbEmpDto.salKo}" name="salKo" type="text">
		<label>건강 보험</label><input value="${tbEmpDto.salKun}" name="salKun" type="text">
		<label>국민 보험</label><input value="${tbEmpDto.salKuk}" name="salKuk" type="text">
		<label>기본급</label><input value="${tbEmpDto.salPre}" name="salPre" type="number">원
		<label>등록일자</label><input value="${tbEmpDto.salDate}" name="salDate" type="text">
		<label>은행</label><input value="${tbEmpDto.empBank}" name="empBank" type="text">
		<label>계좌번호</label><input value="${tbEmpDto.empAccountNumber}" name="empAccountNumber" type="text" 
		placeholder="숫자만 입력하세요">
	</div>
</div>
<button type="submit">수정하기</button>
</form>
<a href="/admin/home">홈으로</a>
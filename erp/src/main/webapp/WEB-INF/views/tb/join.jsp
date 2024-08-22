<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <form method="post" action="join">
<div><label>아이디</label><input type="text" name="loginId"></div>
<div><label>이름</label><input type="text" name="name"></div>
<div><label>비밀번호</label><input type="password" name="password"></div>
<div><label>직급</label><select name="empLevel">
    <option value="">===선택===</option>
    <option value="인턴">인턴</option>
    <option value="사원">사원</option>
    <option value="사장">사장</option>
</select></div>
<div><label>부서명</label><select name="empDept">
    <option value="">===선택===</option>
    <option value="i">인사팀</option>
    <option value="c">청소팀</option>
    </select>
</div>
<div><label>번호</label><input type="tel" name="empHp"></div>
<div><label>이메일</label><input type="email" name="empEmail"></div>
<div><label>생일</label><input type="date" name="empBirth"></div>
<div><label>입사일</label><input type="date" name="empSdate"></div>

<div><label>주소</label><input type="text" name="empPost"></div>
<div><label>기본주소</label><input type="text" name="empAddress1"></div>
<div><label>상세주소</label><input type="text" name="empAddress2"></div>


<button type="submit">등록하기</button>
</form>


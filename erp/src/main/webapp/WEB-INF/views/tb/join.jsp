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
<div><label>성별</label><select name="empGender">
    <option value="">===선택===</option>
    <option value="M">남자</option>
    <option value="W">여자</option>
</select></div>
<div><label>번호</label><input type="tel" name="empHp"></div>
<div><label>이메일</label><input type="email" name="empEmail"></div>
<div><label>생일</label><input type="date" name="empBirth"></div>
<div><label>학력</label><input type="text" name="empEdu"></div>
<div><label>입사일</label><input type="date" name="empSdate"></div>
<div><label>메모</label><input type="text" name="empMemo"></div>
<div><label>계좌번호</label><input type="text" name="empAccountNumber"></div>
<div><label>은행명</label><select name="empBank">
    <option value="">===선택===</option>
    <option value="국민">국민은행</option>
    <option value="신한">신한은행</option>
    <option value="기업">기업은행</option>
    <option value="하나">하나은행</option>
    <option value="농협">농협은행</option>
</select></div>
<div><label>주소</label><input type="text" name="empPost"></div>
<div><label>기본주소</label><input type="text" name="empAddress1"></div>
<div><label>상세주소</label><input type="text" name="empAddress2"></div>
<div><label>세전급여</label><input type="number" name="salPre"></div>

<button>등록하기</button>
</form>

    
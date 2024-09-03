<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="edit" method="post">
		<div class="row">
			<h3>예약을 변경하시려면 예약자 이름과 아아디를 입력해주세요</h3>
			예약 번호 : <input type="text" name="resId"> <br>
			비밀번호 : <input type="password" name="inputPw">
		</div>
		<button type="submit">예약 변경하기</button>
	</form>
</body>
</html>
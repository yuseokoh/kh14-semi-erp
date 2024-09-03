<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 취소 페이지</title>
<script type="text/javascript">
    function confirmCancellation() {
        return confirm("정말 예약을 취소하시겠습니까?");
    }
</script>
</head>
<body>
    <div class="container">
    <form action="delete" method="post" onsubmit="return confirmCancellation()">
        <div class="row">
            <h3>예약을 취소하시려면 예약자 이름과 예약 번호를 입력해주세요</h3>
            예약 번호 : <input type="text" name="resId"> <br>
            비밀번호 : <input type="password" name="inputPw">
        </div>
        <button type="submit">예약 취소하기</button>
    </form>
    </div>
</body>
</html>

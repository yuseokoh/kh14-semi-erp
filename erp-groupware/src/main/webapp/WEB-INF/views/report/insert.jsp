<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>보고서 입력페이지</title>
    
    <!--폰트 어썸 icon cdn-->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
   
    <!--my css-->
    <link rel="stylesheet" type="text/css" href="./commons.css">
    <link rel="stylesheet" type="text/css" href="test.css">
    <style>

    </style>
</head>
<body>
<form action="#" method="post">
    <div class="container">
        <div class="row center">
            <h1>제목</h1>
            <input type="text" name="title">
        </div>
        <div class="row flex-box">
	        <div>
	            <span>작성자이름</span>
	            <input type="text" name="wname" >
	        </div>
	        <div>
	            <span>부서</span>
	            <input type="text" name="dept">
	        </div>
        </div>
        <div class="row flex-box">
            <span>결재자</span>
            <input type="text" name="approBos" readonly>
        </div>
        <div class="row ">           
            <li>금일목표</li>
                <ul>목표1 : <input type="text" name="todayGoal"></ul>
                <ul>목표2 : <input type="text" name="todayGoal2"></ul>
                <ul>목표3 : <input type="text" name="todayGoal3"></ul>
            <li>달성내역</li>
                <ul><input type="checkbox"><input type="text" name="achievement"></ul>
                <ul><input type="checkbox"><input type="text" name="achievement2"></ul>
                <ul><input type="checkbox"><input type="text" name="achievement3"></ul>
            <li>미달성사유</li>
                <ul>
                	<label>미달성사유 1</label>
                	<textarea name="noAchievementReason" cols="30" rows="5"></textarea>
                </ul>
                <ul>
                	<label>미달성사유 2</label>
                	<textarea name="noAchievementReason2" cols="30" rows="5"></textarea>
                </ul>
        </div>
        <div class="right">
            <button type="submit">등록하기</button>
        </div>
    </div>
</form>
</body>
</html>
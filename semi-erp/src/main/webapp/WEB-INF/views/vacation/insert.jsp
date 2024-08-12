<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>휴가신청서</title>
    <!--구글 폰트cdn-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <!--폰트 어썸 icon cdn-->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
   
    <!--my css-->
    <link rel="stylesheet" type="text/css" href="./commons.css">
    <link rel="stylesheet" type="text/css" href="./test.css">
</head>
<body>
<form action="/insert" method="post" enctype="multipart/form-data">
    <div class="container w-600 my-50" >
        <div class="row center">
            <h1>기안서 작성</h1>
        </div>
        <div class="row">
        <table class="w-100">
            <tr> 
                <th>일자</th>
                <td>
                    <input type="date">~
                    <input type="date">
                </td>
            </tr>
            <tr>               
                <th>제목</th>
                <td>
                    <span>휴가신청서</span>
                </td>
            </tr>
            <tr>               
                <th>사유</th>
                <td>
                    <textarea rows="5" cols="100%"></textarea>
                </td>
            </tr>
            <tr>
                <th>결제라인<i class="fa-solid fa-star-of-life"></i></th>
                <td>
                    <span>결제자</span> <input type="text" name="" id=""><br>
                    <span>참조자</span> <input type="text" name="" id=""><br>
                    <span>공유자</span> <input type="text" name="" id="">
                </td>
            </tr>
            <tr>
                <th>구분</th> 
                <td>
                    <select name="" id="">
                        <option value="">기안서 종류를 선택하세요</option>
                        <option value="사내대출신청서">사내대출신청서</option>
                        <option value="지출결의서">지출결의서</option>
                        <option value="외근 보고">외근 보고</option>
                        <option value="휴가신청서">휴가신청서</option>
                        <option value="판매내역 보고">판매내역 보고</option>
                        <option value="발주내역 보고">발주내역 보고</option>
                        <option value="회의록">회의록</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>결제문서<i class="fa-solid fa-star-of-life"></i></th>
                <td>
                    <!--다중파일업로드 가능하게-->
                    <input type="file" name = "attach">
                </td>
            </tr>
            <tr>
                <th>첨부</th>
                <td>
                    <input type="file" name="attach">
                </td>
            </tr>
        </table>
        <hr>
        <tr>
            <button type="submit">저장/결재</button>
        </tr>
    </div>
</div>    
</form>

</body>
</html>
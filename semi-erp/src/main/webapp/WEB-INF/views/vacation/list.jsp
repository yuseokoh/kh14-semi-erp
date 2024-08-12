<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>디자인 수업</title>
    <!--구글 폰트cdn-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <!--폰트 어썸 icon cdn-->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
   
    <!--my css-->
    <link rel="stylesheet" type="text/css" href="./commons.css">
    <link rel="stylesheet" type="text/css" href="test.css">
    <style>
      
    </style>
</head>
<body>

    <div class="container">
        <div class="row center">
            <h1>기안서 작성</h1>
        </div>
        <div class="row right">
            <input type="text"> 
            <button>검색</button>
            <select>
                <option value="양식명">양식명</option>
                <option value="구분">구분</option>
                <option value="결재문서">결재문서</option>
            </select>
        </div>
        <div class="row">
        <table>
            <tr>
                <th>정렬순서</th>
                <th>양식명</th>
                <th>구분</th>
                <th>결재문서</th>
            </tr>
            <c:forEach var="vacationDto" items=${ vacationList}>
            <tr>
                <td></td>
            </tr>
            </c:forEach>
        </table> 
        </div>
        
    </div>

</body>
</html>
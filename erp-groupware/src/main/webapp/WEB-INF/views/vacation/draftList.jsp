<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 기안서 목록 -->
  <div class="container">
        <h1>기안서 목록</h1>
        <div class="row">
        
        <table border="1" width="800">
            <thead>
                <tr>
                    <th>휴가번호</th>
                    <th>양식명</th>
                    <th>휴가신청일</th>
                    <th>결재여부</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="vacationDto" items="${list}">
                    <tr>
                        <td>${vacationDto.vacaNo}</td>
                        <td>
                            <a href="detail?vacaNo=${vacationDto.vacaNo }">휴가신청서(상세보기)</a>
                        </td>
                        <td>${vacationDto.vacaReqDate}</td>
                        <td>${vacationDto.approYN}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
        <!--페이징 처리 해야함-->
    </div>
    <a href="insert">글쓰기</a>
</body>

</html>
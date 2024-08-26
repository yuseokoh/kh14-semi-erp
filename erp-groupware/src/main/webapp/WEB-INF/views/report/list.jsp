<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 보고서 목록 -->
  <div class="container">
        <h1>보고서 목록</h1>
        <div class="row">
        
        <table border="1" width="800">
            <thead>
                <tr>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>작성자이름</th>
                    <th>결재자</th>
                    <th>작성날짜</th>
                    <th>결재여부</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="reportDto" items="${list}">
                    <tr>
                        <td>${reportDto.repNo}</td>
                        <td>
                            <a href="detail?repNo=${reportDto.repNo }">${reportDto.title}</a>
                        </td>
                        <td>${reportDto.wname}</td>
                        <td>${reportDto.approBos }</td>
                        <td>${reportDto.wdate}</td>
                        <td>${reportDto.approYN}</td>
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
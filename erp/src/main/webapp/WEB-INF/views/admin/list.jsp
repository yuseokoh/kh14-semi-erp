<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
     <link rel="stylesheet" type="text/css" href="/css/vacation.css">
<div class="container w-800 my-50">
        <div class="row center">
            <h1>사원 조회</h1>
        </div>
             <h2><a href="/home"><i class="fa-solid fa-left-long"></i></a></h2>

<!-- 검색창 -->
<form action="list" method="get" autocomplete="off">
    <div class="row">
        <select name="column" class="field">
            <option value="name" <c:if test="${param.column == 'name'}">selected</c:if>>사원명</option>
            <option value="emp_dept" <c:if test="${param.column == 'emp_dept'}">selected</c:if>>부서</option>
        </select>
        <input type="text" name="keyword" value="${param.keyword}" class="field">
        <button class="btn btn-neutral">검색</button>
    </div>
</form>
<!-- 결과 화면 -->
    <div class="tb-box">
        <table class="tb">
            <thead>
                <tr>
                	<th>사진</th>
                    <th>사원명</th>
                    <th>이메일</th>
                    <th>직급</th>
                    <th>부서</th>
                    <th>입사일</th>
                   
                    <th>삭제하기</th>
                </tr>
            </thead>
            <tbody align="center">
                <c:choose>
                    <c:when test="${list.isEmpty()}">
                        <%-- 결과가 없을 때 --%>
                        <tr>
                            <td colspan="5">결과가 존재하지 않습니다</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <%-- 결과가 있을 때 --%>
                        <c:forEach var="tbEmpDto" items="${list}">
                        <tr>
                        	<td><img src="/tb/myImage?loginId=${tbEmpDto.loginId}" width="25"></td>
                            <td>
                                <a href="detail?loginId=${tbEmpDto.loginId}">
                                    ${tbEmpDto.name}
                                </a>
                            </td>
                            <td>${tbEmpDto.empEmail}</td>
                            <td>${tbEmpDto.empLevel}</td>
                            <td>${tbEmpDto.empDept}</td>
                            <td>
                            ${tbEmpDto.empSdate} 				
                            </td>
                            <td><a href="delete?loginId=${tbEmpDto.loginId}">퇴사</a></td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                
            </tbody>
        </table>

    </div>

    <!-- 네비게이터 추가 -->
<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
    </div>
    



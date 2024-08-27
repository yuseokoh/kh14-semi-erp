<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 이곳은 <header>  -->
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 여기서부터 작성 -->
				 <!-- 휴가 신청서 작성 -->
             
            <main id="body"> 
                    <body>
                        <div class="container w-900">
                            <div class="title">휴가신청서</div>
                    ${tbEmpDto}
                            <div class="table-container">
                                <table class="table">
                                    <label>결재자</label>
                                    <thead>
                                        <tr>
                                            <th>직급</th>
                                            <th>넣는</th>
                                            <th>곳</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>&nbsp</td>
                                            <td>&nbsp</td>
                                            <td>&nbsp</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                    
                            <div class="row flex-box">
                                <div>
                                    <div class="row">
                                        <label>사원명</label>
                                        <input type="text" class="filed form" name="applicantId" value="${tbEmpDto.name}" readonly>
                                    </div>
                                </div>
                            </div>
                    
                            <div class="row">
                                <div>
                                    <label>사원번호</label>
                                    <input type="text" class="form" name="empNo" value="${tbEmpDto.empNo}" readonly>
                                </div>
                                <div>
                                    <label>직급</label>
                                    <input type="text" class="form" name="empLevel" value="${tbEmpDto.empLevel}" readonly>
                                </div>
                                <div>
                                    <label>부서</label>
                                    <input type="text" class="form" name="empDept" value="${tbEmpDto.empDept}" readonly>
                                </div>
                            </div>
                    
                            <div class="row">
                                <div>
                                    <label>EMAIL</label>
                                    <input type="text" class="form" name="empEmail" value="${tbEmpDto.empEmail}" readonly>
                                </div>
                                <div>
                                    <label>휴대폰 번호</label>
                                    <input type="number" class="form" placeholder="00011112222">
                                </div>
                            </div>
                    
                            <div class="row flex-box">
                                <div class="w-50">
                                    <label>휴가 시작일</label>
                                    <input type="text" class="field w-100 test7-1 form">
                                </div>
                                <div class="w-50">
                                    <label>휴가 종료일</label>
                                    <input type="text" class="field w-100 test7-2 form">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div>
                                    <label>휴가 종류</label>
                                    <select class="form">
                                        <option value="" class="text-secondary">휴가 종류</option>
                                        <option value="">개인사유</option>
                                        <option value="">연차</option>
                                        <option value="">병가</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="row flex-box" style="position: relative;">
                                <div>
                                    <label>휴가 사유</label>
                                    <textarea class="field w-100 form" rows="3" style="padding-right: 100px;"></textarea>
                                    <button type="button" class="btn btn-positive">휴가신청</button>
                                </div>
                            </div>
                        </div>
                    </body>


				<!-- 이곳에서부터 <footer>  -->
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

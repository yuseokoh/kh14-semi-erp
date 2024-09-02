<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page= "/WEB-INF/views/template/header.jsp"></jsp:include>
<!--chart js-->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" type="text/css" href="/css/vacation.css">
<script type="text/javascript">
function createChart(url,selector,legend='',type='bar'){
    //step 1 - 차트를 만들기 위해 필요한 데이터 요청
    //step 2 - 데이터를 이용해 차트를 생성
//step 1
$.ajax({
    url: url,
    method:"post",
    success:function(response){
        //response는 객체 배열 형태[{...},{...}]
        // console.log(response);

        //response를 두개로 분리
        var names = [];
        var values = [];

        for(var i=0;i<response.length;i++){
            names.push(response[i].title);//title을 names 에 추가
            values.push(response[i].cnt);//cnt를 values에 추가
        }
        

        //step 2
         //차트를 그릴 대상 선택
const ctx = document.querySelector(selector);
//차트 생성 코드
//new Chart(캔버스태그)
new Chart(ctx, {
    type: type,//차트 유형(bar/pie/doughnut/line)
    data: {
        //차트에 표시되는 항목(x축)
        labels: names,
        //실제로 차트에 표시될 값
        datasets: [{
            label: legend,//범례
            data: values,//데이터
            borderWidth: 1//디자인 속성(테두리 두께)
        }]
    },
    options: {
        scales: {
            y: {
                // beginAtZero: true//차트를 0부터 표기
            }
        }
    }
});
    }
}
)};

$(function(){
    createChart("http://localhost:8080/rest/emp/status/hi",".emp-new-chart","입사자 수", "bar");
    createChart("http://localhost:8080/rest/emp/status/bye",".emp-bye-chart","퇴사자 수", "bar");
});
    </script>    
<div class="container w-600 my-50">
			<div class="row flex-box w-600">
            <div class="w-50">
                <div class="row">
                    <h1 class="center">신규 입사자 현황</h1>
                    <canvas class="emp-new-chart"></canvas>
                </div>
            </div>
            <div class="w-50">
                <div class="row">
                    <h1 class="center">퇴사자 현황</h1>
                    <canvas class="emp-bye-chart"></canvas>
                </div>
            </div>
			</div>
			 <div class="row flex-box w-1200">
        <div class="w-50 center"> 
            <h1 class="center">입사일 현황</h1>
            <c:forEach var="item" items="${empSdateList}">
            <tr>
                <td>${item.entryDate}</td>
                <td>${item.cnt}</td>
            </tr>
        </c:forEach>
        </div>
    
        <div class="w-50 center"> 
            <h1 class="center">퇴사일 현황</h1>
            <c:forEach var="item" items="${empEdateList}">
            <tr>
                <td>${item.entryDate}</td>
                <td>${item.cnt}</td>
            </tr>
            <table border="1">
                <thead>
                    <tr>
                        <th>사원 번호</th>
                        <th>이름</th>
                        <th>근무일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${workingDayList}">
                        <tr>
                            <td>${item.empNo}</td>
                            <td>${item.name}</td>
                            <td>${item.workingDays}일</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:forEach>
        </div>
    </div>
        </div>

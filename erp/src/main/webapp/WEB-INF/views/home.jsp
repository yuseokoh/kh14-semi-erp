<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script type="text/javascript">
    	 $(function () {
             var canvas = document.getElementById("canvas");
             var context = canvas.getContext("2d");
             var clearButton = document.getElementById("clearButton");
             var saveButton = document.getElementById("saveButton");
             var signatureImage = document.getElementById("signatureImage");

             var drawing = false;

             canvas.addEventListener("mousedown", () => {
             drawing = true;
             context.beginPath();
             });

             canvas.addEventListener("mousemove", (event) => {
             if (!drawing) return;

   var x = event.clientX - canvas.getBoundingClientRect().left;
   var y = event.clientY - canvas.getBoundingClientRect().top;
   context.lineTo(x, y);
   context.stroke();
 });

 canvas.addEventListener("mouseup", () => {
   drawing = false;
   context.closePath();
 });

 clearButton.addEventListener("click", () => {
   context.clearRect(0, 0, canvas.width, canvas.height);
 });

         });
</script>

<script type="text/javascript">
	$(function(){
		$("#saveButton").on("click",function(){
            var signatureDataURL = canvas.toDataURL("image/png");
            signatureImage.src = signatureDataURL;
            console.log(signatureDataURL);
            $.ajax({
                url : "/rest/document/sign",
                method : "post",
                data:{ 
                       signatureDataURL : signatureDataURL
                    },
                success : function(response){
                            alert("저장했습니다")
                        }
            });

        });
		
		
	});

</script>

    
<h1>${sessionScope.createdUser}</h1>
<h1>홈</h1>

<c:choose>
    <c:when test="${sessionScope.createdUser != null}">
        <a href="/tb/logout">로그아웃</a>
    </c:when>
    <c:otherwise>
        <a href="/tb/login">로그인</a>
    </c:otherwise>
</c:choose>
<a href="/tb/edit">수정하기</a>
<a href="/tb/mypage">마이페이지</a>
<a href="/tb/list">검색/리스트확인</a>
<c:if test="${sessionScope.userType == 'A'}">
    <a href="/admin/home">관리자페이지</a>
</c:if>


 <canvas id="canvas" width="200" height="200" style="border:1px solid black"></canvas>
<br />
<button id="clearButton">초기화</button>
<button id="saveButton">서명 저장</button>
<img id="signatureImage" style="display: none;">

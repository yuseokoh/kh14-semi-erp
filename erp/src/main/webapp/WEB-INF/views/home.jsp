<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fabric.js/5.3.1/fabric.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        // id="c"인 캔버스를 찾아서 Fabric Canvas로 변환하는 코드
        var canvas = new fabric.Canvas('c', {
            isDrawingMode: true
        });
        fabric.Object.prototype.transparentCorners = false;

        // id="clear-canvas" 버튼을 누르면 캔버스의 내용이 사라지도록 처리
        $('#clear-canvas').on('click', function () {
            canvas.clear();
        });

        // id="save-canvas" 버튼을 누르면 캔버스의 내용이 JSON으로 export 되도록 처리
        $('#save-canvas').on('click', function() {
            var canvasJSON = JSON.stringify(canvas.toJSON()); // 캔버스 상태를 JSON으로 변환
            $.ajax({
                url: "/rest/approval/sign",
                type: "POST",
                dataType: "json",
                contentType: "application/json", // 데이터를 JSON 형식으로 서버에 전달
                data: JSON.stringify({ result: canvasJSON }), // JSON 형식으로 문자열화
                success: function(response) {
                    console.log("통신성공");
                    console.log(response);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("통신 실패", textStatus, errorThrown);
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


 <canvas id="c" width="500" height="500"></canvas>
    <button id="clear-canvas">clear</button>
    <button id="save-canvas">save</button>

    <div id="result"></div>
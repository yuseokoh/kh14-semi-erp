<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 홈페이지</title>

    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="/css/commons.css">
    <link rel="stylesheet" type="text/css" href="/css/test.css">
    <style>
    	.profile-wrapper {
    		position:relative;
    		width: 50%;
    		overflow : hidden;
    		border-radius: 50%;
    	}
    	
    	.profile-wrapper > .user-image{
    		width : 100%;
    		height : 100%;
    	}
        .profile-wrapper > label {
        	background-color:rgba(0, 0, 0, 0.3);
        	position:absolute;
        	top:0;
        	left:0;
        	right:0;
        	bottom:0;
        	/* border-radius: 50%; */
/*         	display:flex; */
        	justify-content:center;
        	align-items:center;
        	color:white;
        	cursor:pointer;
        	
        	display: none;
        }
        .profile-wrapper:hover > label {
        	display: flex;
        }
    </style>
    
    <!-- 자바스크립트 -->
    <!-- moment JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>
    
    <!-- jquery cdn -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- 내가만든 jQuery 라이브러리 -->
    <script src="/js/checkbox.js"></script>
    <script src="/js/confirm-link.js"></script>
    <script src="/js/multipage.js"></script>
    
    <script type="text/javascript">
    	//이미지 선택 태그가 변경된 경우 사용자 이미지를 변경하도록 처리(회원전용)
    	$(function(){
    		$("#change-image").change(function(){
    			//this == 파일선택태그
    			
    			//파일을 선택하지 않았으면 중단
    			if(this.files.length == 0) return;
    			
    			//전송 데이터 준비
    			var form = new FormData();
    			form.append("attach", this.files[0]);
    			
    			//비동기 통신으로 파일 업로드
    			$.ajax({
    				processData:false,
    				contentType:false,
    				url:"/rest/member/profile",
    				method:"post",
    				data:form,
    				success:function(response){
    					//프로필 이미지 주소를 재설정한다
    					//(문제) 브라우저 캐싱으로 인해서 주소가 같아 바뀐 이미지가 보이지 않음
    					//(해결) 주소에서 한글자라도 변화를 줘야함(의미없는 파라미터 생성)
    					
    					//자바스크립트에서 겹치지 않는 시리얼 번호를 생성하는 코드
    					var uuid = crypto.randomUUID();
    					console.log("uuid", uuid);
    					
    					$(".user-image")
    							.attr("src", "/member/myImage?uuid="+uuid);//재설정
    				},
    			});
    			
    		});
    	});
    </script>
    
</head>
<body>
    <!-- 홈페이지 크기를 결정하는 외부 영역(main) -->
    <div class="container w-1200">

        <!-- 헤더 영역 -->
        <div class="row my-0 flex-box">
            <div class="w-25 flex-core">
                <img src="https://placehold.co/150x60">
            </div>
            <div class="w-50">
                <h1 class="center">KH 정보교육원 수업자료</h1>
            </div>
            <div class="w-25 flex-core">
                <img src="https://placehold.co/150x60">
            </div>
        </div>

        <!-- 메뉴 영역 -->
        <div class="row my-0">
			<jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>
		</div>

        <!-- 컨텐츠 영역 -->
        <div class="row my-0 flex-box" style="min-height: 400px;">
            <div class="w-200 pt-20">
            	<c:choose>
					<c:when test="${sessionScope.createdUser != null}">
						<div class="row center flex-core">
							<div class="profile-wrapper">
								<img src="/member/myImage"
			                    		class="image image-circle image-lift user-image w-100">
								<label for="change-image">변경하기</label>  
								<input type="file" id="change-image" accept="image/*" style="display:none;">
							</div>
		                </div>
		                <div class="row center">
		                	${sessionScope.createdUser}
		                	(${sessionScope.createdLevel})
		                </div>
		                <div class="row center">
		                	<a href="/member/mypage" class="link link-animation">
		                		내정보<i class="fa-solid fa-square-arrow-up-right"></i>
		                	</a>
		                </div>
					</c:when>
					<c:otherwise>
						<div class="row center">
							<a href="/member/login" class="link link-animation">
								로그인<i class="fa-solid fa-square-arrow-up-right"></i>
							</a> 하세요
						</div>
					</c:otherwise>
				</c:choose>
            </div>
            <div style="flex-grow: 1;">

		
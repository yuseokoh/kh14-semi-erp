<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 링크받고 넘어온 페이지</title>
    <!-- 헤더 포함 -->
    <iframe src="header.html" style="border: none; width: 100%; height: auto;"></iframe>
    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <!-- my css -->
    <!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->

    <!-- 프로젝트 스타일 -->
    <!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./attendancemystatus.css"> -->
    <link rel="stylesheet" type="text/css" href="./commons.css">
    <!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./gotowork.css"> -->
    <link rel="stylesheet" type="text/css" href="./join.css">
    <link rel="stylesheet" type="text/css" href="./join2.css">
    <link rel="stylesheet" type="text/css" href="./login.css">
    <link rel="stylesheet" type="text/css" href="./modal.css">
    <link rel="stylesheet" type="text/css" href="./modal2.css">
    <!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./sidebar.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./vacation.css"> -->
    <link rel="stylesheet" type="text/css" href="./alertBtn.css">
   <style>
.a1 {
    display: flex; 
    align-items: center; 
    justify-content: center;
    color: black;
    text-decoration: none;
    height: 3rem;
    width: 20rem;
    margin-top: 3rem;
    background-color: wheat;
    border-radius: 0.5rem;
    border: none;
    font-size: 16px;
    transition: all 400ms;
    box-shadow: 0 0 10px antiquewhite, 0 0 10px antiquewhite;
    position: relative;
    bottom: 30px;
    text-align: center; 
}

.a1:hover {
    background-color: antiquewhite;
    box-shadow: none;
}

    </style>

  
    <!-- lightpick cdn -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
    <!-- jquery cdn -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- <script src="checkbox.js"></script> -->
    <!-- <script src="confirm-link.js"></script> -->
    <!-- <script src="multipage.js"></script> -->

        <!-- SweetAlert2 CDN -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- 프로젝트 js-->
    <!-- <script src="gotoworkbtn.js"></script> -->
    <!-- <script src="menuToggle.js"></script> -->
    <!-- <script src="delete.js"></script> -->
    <script src="modal.js"></script>
    <!-- chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <!-- 자바스크립트 코드 작성 영역 -->
    <script type="text/javascript">
    </script>
    <script type="text/javascript">
$(document).ready(function() {
    var $modal = $('#myModal2');
    // 페이지가 로드된 후 모달을 보여줍니다
    $modal.show();
        // 모달 외부 클릭 시 닫기 방지
        $(window).click(function (event) {
                // 외부 클릭 시 모달이 닫히지 않도록 주석 처리
                // if ($(event.target).is('#myModal')) {
                //     $('#myModal').hide();
                // }
            });
            // 폼 제출 시 모달 닫히지 않도록 방지
            $('.modal2-content2').click(function (event) {
                event.stopPropagation();
            });
});
    </script>

<script type="text/javascript">
    async function showAlert() {
               // 첫 번째 알림창
               const result = await Swal.fire({
                   title: '<span class="custom-title">이메일 발송완료</span>',
                   icon: 'success',
                   customClass: {
                       title: 'custom-title',
                       popup: 'custom-background',
                       confirmButton: 'custom-button' // "확인" 버튼 스타일 적용
                   }
               });
   
               // 첫 번째 알림창의 "확인" 버튼 클릭 시 두 번째 알림창 표시
               if (result.isConfirmed) {
                   await Swal.fire({
                       title: '<span class="custom-title">이메일을 확인해주세요</span>',
                       text: ' ',
                       icon: 'success',
                       customClass: {
                           title: 'custom-title',
                           popup: 'custom-background',
                           confirmButton: 'custom-button' // "확인" 버튼 스타일 적용
                       }
                   });
               }
           }
       </script>

</head>

<body>
    <!-- 모달 창 구조 -->
    <div id="myModal2" class="modal2">
        <div class="modal2-content2">
            <span class="close">&times;</span>
            
            <form  class="form2" action="#" method="post">
                <p class="title2">비밀번호 찾기</p>
                <p class="message2">비밀번호 찾기를 위해 정보를 입력하세요</p>

                <label>
                    <input class="input2" type="text" name="loginId" placeholder="" required="">
                    <span class="span2">아이디</span>
                </label>

                <label>
                    <input class="input2" type="email" name="empEmail" placeholder="" required="">
                    <span class="span2">이메일</span>
                </label>

               <a href="#" class="a1" onclick="showAlert()" >Send Email</a>
               
            </div>
        </div>
        
    </form>

</body>

</html>
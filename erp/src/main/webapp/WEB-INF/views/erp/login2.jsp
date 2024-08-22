<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
    <!-- 헤더 포함 -->
    <iframe src="header.html" style="border: none; width: 100%; height: auto;"></iframe>
    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="./commons.css">
    <link rel="stylesheet" type="text/css" href="./test.css">
    <style>
        ::selection {
            background-color: gray;
        }

        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background-color: #222; 
            display: flex;
            flex-direction: column;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex: 1;
        }

        .form {
            width: 400px;
            height: 400px;
            background-image: linear-gradient(to bottom, #424242, #212121);
            display: flex;
            align-items: center;
            flex-direction: column;
            border-radius: 0.5rem;
        }

        .title {
            color: wheat !important;
            margin: 3rem 0;
            font-size: 2rem;
        }

        .input {
            margin: 0.5rem 0;
            padding: 1rem 0.5rem;
            width: 20rem;
            background-color: inherit;
            color: wheat;
            border: none;
            outline: none;
        }

        .username {
            border-bottom: 1px solid wheat;
            transition: all 400ms;
        }

        .username:hover {
            background-color: #424242;
            border: none;
            border-radius: 0.5rem;
        }

        .password {
            border-bottom: 1px solid wheat;
            transition: all 400ms;
        }

        .password:hover {
            background-color: #424242;
            border: none;
            border-radius: 0.5rem;
        }

           .btn {
            height: 3rem;
            width: 20rem;
            margin-top: 3rem;
            background-color: wheat;
            border-radius: 0.5rem;
            border: none;
            font-size: 1.2rem;
            transition: all 400ms;
            box-shadow: 0 0 10px antiquewhite, 0 0 10px antiquewhite;
            position: relative; 
            top: -1.5rem; 
        }

        .btn:hover {
            background-color: antiquewhite;
            box-shadow: none;
        }
        
                .span {
  text-decoration: none;
  color: white;
  width: 100%;
  display: flex;
  justify-content: center;
}
.span a {
  color: antiquewhite;
  box-shadow: none;
  
}

.span:last-of-type {
    margin-top: 0.5rem;
    position: relative; 
            top: -1rem; 
}



    </style>

<style>
    /* 모달 기본 스타일 */
    .modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 8px;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
    background-color: #1a1a1a;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 400px;
    border-radius: 20px;
    background-image: linear-gradient(to bottom, #424242, #212121);
    position: relative;
}

.close {
    color: #aaa;
    font-size: 28px;
    font-weight: bold;
    position: absolute; 
    top: 10px; 
    right: 25px; 
    z-index: 99998;

}

.close:hover,
.close:focus {
    color: wheat;
    text-decoration: none;
    cursor: pointer;
}
#openModal{
    height: 1rem;
    width: 3rem;
    margin-top: 3rem;
    border-radius: 0.5rem;
    border: none;
    font-size: 0.6rem;
    position: relative; 
    top: -2.7rem;
    left: 0.5rem;
    transform: .3s ease;
    background-color: wheat;
    transition: all 400ms;
    box-shadow: 0 0 10px antiquewhite, 0 0 10px antiquewhite;
}

#openModal:hover {
    background-color: antiquewhite;
    box-shadow: none;
}
</style>

<style>
    .form1 {
    display: flex;
    flex-direction: column;
    gap: 10px;
    max-width: 350px;
    padding: 20px;
    border-radius: 20px;
    position: relative;
    background-color: #1a1a1a;
    color: #fff;
    background-image: linear-gradient(to bottom, #424242, #212121);
    }

.title1 {
font-size: 28px;
font-weight: 600;
letter-spacing: -1px;
position: relative;
display: flex;
align-items: center;
padding-left: 30px;
color: antiquewhite;
}

.title1::before {
width: 18px;
height: 18px;
}

.title1::after {
width: 18px;
height: 18px;
animation: pulse 1s linear infinite;
}

.title1::before,
.title1::after {
position: absolute;
content: "";
height: 16px;
width: 16px;
border-radius: 50%;
left: 0px;
background-color: wheat;
}

.message1, 
.signin1 {
font-size: 14.5px;
color: rgba(255, 255, 255, 0.7);
}

.signin1 {
text-align: center;
}

.signin1 a:hover {
text-decoration: underline wheat;
}

.signin1 a {
color: wheat;
}

.flex1 {
display: flex;
width: 100%;
gap: 6px;
}

.form1 label {
position: relative;
}

.form1 label .input1 {
background-color: #333;
color: rgba(255, 255, 255, 0.5);
width: 100%;
padding: 20px 05px 05px 10px;
outline: 0;
border: 1px solid rgba(105, 105, 105, 0.397);
border-radius: 10px;
}

.form1 label .select1  {
background-color: #333;
color: rgba(255, 255, 255, 0.5);
width: 152px;
padding: 20px 05px 05px 10px;
outline: 0;
border: 1px solid rgba(105, 105, 105, 0.397);
border-radius: 10px;
}

.form1 label .join1  {
background-color: #333;
color: rgba(255, 255, 255, 0.5);
width: 152px;
padding: 20px 05px 05px 10px;
outline: 0;
border: 1px solid rgba(105, 105, 105, 0.397);
border-radius: 10px;
}

.form1 label .birthday1  {
background-color: #333;
color: rgba(255, 255, 255, 0.5);
width: 152px;
padding: 20px 05px 05px 10px;
outline: 0;
border: 1px solid rgba(105, 105, 105, 0.397);
border-radius: 10px;
}

.form1 label .address {
background-color: #333;
color: rgba(255, 255, 255, 0.5);
width: 40%;
padding: 20px 05px 05px 10px;
outline: 0;
border: 1px solid rgba(105, 105, 105, 0.397);
border-radius: 10px;

}

.form1 label .address1 {
background-color: #333;
color: rgba(255, 255, 255, 0.5);
width: 100%;
padding: 20px 05px 05px 10px;
outline: 0;
border: 1px solid rgba(105, 105, 105, 0.397);
border-radius: 10px;

}

.form1 label .address2 {
background-color: #333;
color: rgba(255, 255, 255, 0.5);
width: 100%;
padding: 20px 05px 05px 10px;
outline: 0;
border: 1px solid rgba(105, 105, 105, 0.397);
border-radius: 10px;

}

.form1 label .input1 + span {
color: rgba(255, 255, 255, 0.5);
position: absolute;
left: 10px;
top: 0px;
font-size: 0.9em;
cursor: text;
transition: 0.3s ease;
}
.form1 label .select1+ span {
color: rgba(255, 255, 255, 0.5);
position: absolute;
left: 10px;
top: 0px;
font-size: 0.9em;
cursor: text;
transition: 0.3s ease;
}

.form1 label .join1+ span {
color: rgba(255, 255, 255, 0.5);
position: absolute;
left: 10px;
top: 0px;
font-size: 0.9em;
cursor: text;
transition: 0.3s ease;
}

.form1 label .birthday1+ span {
color: rgba(255, 255, 255, 0.5);
position: absolute;
left: 10px;
top: 0px;
font-size: 0.9em;
cursor: text;
transition: 0.3s ease;
}

.form1 label .address+ span {
color: rgba(255, 255, 255, 0.5);
position: absolute;
left: 10px;
top: 0px;
font-size: 0.9em;
cursor: text;
transition: 0.3s ease;
}

.form1 label .address1+ span {
color: rgba(255, 255, 255, 0.5);
position: absolute;
left: 10px;
top: 0px;
font-size: 0.9em;
cursor: text;
transition: 0.3s ease;
}

.form1 label .address2+ span {
color: rgba(255, 255, 255, 0.5);
position: absolute;
left: 10px;
top: 0px;
font-size: 0.9em;
cursor: text;
transition: 0.3s ease;
}




.form1 label .address+ span {
color: rgba(255, 255, 255, 0.5);
position: absolute;
left: 10px;
top: 0px;
font-size: 0.9em;
cursor: text;
transition: 0.3s ease;
}

.form1 label .input1:placeholder-shown + span {
top: 12.5px;
font-size: 0.9em;
}

.form1 label .select1:placeholder-shown + span {
top: 12.5px;
font-size: 0.9em;
}

.form1 label .address:placeholder-shown + span {
top: 12.5px;
font-size: 0.9em;
}

.form1 label .address1:placeholder-shown + span {
top: 12.5px;
font-size: 0.9em;
}

.form1 label .address2:placeholder-shown + span {
top: 12.5px;
font-size: 0.9em;
}
.form1 label .input1:focus + span,
.form1 label .input1:valid + span {
color: antiquewhite;
top: 0px;
font-size: 0.7em;
font-weight: 600;
}

.form1 label .select1:focus + span,
.form1 label .input1:valid + span {
color: antiquewhite;
top: 0px;
font-size: 0.7em;
font-weight: 600;
}

.form1 label .join1:focus + span,
.form1 label .input1:valid + span {
color: antiquewhite;
top: 0px;
font-size: 0.7em;
font-weight: 600;
}
.form1 label .birthday1:focus + span,
.form1 label .input1:valid + span {
color: antiquewhite;
top: 0px;
font-size: 0.7em;
font-weight: 600;
}

.form1 label .address:focus + span,
.form1 label .address:valid + span {
color: antiquewhite;
top: 0px;
font-size: 0.7em;
font-weight: 600;
}

.form1 label .address1:focus + span,
.form1 label .address1:valid + span {
color: antiquewhite;
top: 0px;
font-size: 0.7em;
font-weight: 600;
}

.form1 label .address2:focus + span,
.form1 label .address2:valid + span {
color: antiquewhite;
top: 0px;
font-size: 0.7em;
font-weight: 600;
}

.input1 {
font-size: medium;
}

.select1,
.join1,
.birthday1
{
font-size: medium;
}

.address,
.address1,
.address2 {
font-size: medium;
}

.submit1 {
border: none;
outline: none;
padding: 10px;
border-radius: 10px;
color: black;
font-size: 16px;
transform: .3s ease;
background-color: wheat;
transition: all 400ms;
box-shadow: 0 0 10px antiquewhite, 0 0 10px antiquewhite;
}

.submit1:hover {
    background-color: antiquewhite;
    box-shadow: none;
}

@keyframes pulse {
from {
transform: scale(0.9);
opacity: 1;
}

to {
transform: scale(1.8);
opacity: 0;
}
}


.btn-address{
 display: none;
}


.success {
    border-color: wheat !important;
}

.fail, .fail2, .fail3
{
    border-color: #d63031 !important;
}

</style>

    <!-- lightpick cdn -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>

    <!-- jquery cdn -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="checkbox.js"></script>
    <script src="confirm-link.js"></script>
    <script src="multipage.js"></script>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <!-- chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- 자바스크립트 코드 작성 영역 -->
    <script type="text/javascript">
    $(document).ready(function() {
            // 모달 열기
            $('#openModal').click(function() {
                $('#myModal').show();
            });

             // 닫기 버튼 클릭 시 모달 닫기
                 $('.close').click(function() {
            $('#myModal').hide();
        });

        // 모달 외부 클릭 시 닫기 방지
        $(window).click(function(event) {
            // 외부 클릭 시 모달이 닫히지 않도록 주석 처리
            // if ($(event.target).is('#myModal')) {
            //     $('#myModal').hide();
            // }
        });

            // 폼 제출 시 모달 닫히지 않도록 방지
            $('.modal-content').click(function(event) {
                event.stopPropagation();
            });
        });

    </script>

<script type="text/javascript">
        $(function(){
            //상태 객체
            var status = {
                memberIdValid : false, //형식검사
                memberIdCheckValid : false, //중복검사
                memberPwValid : false,
                memberPwCheckValid : false,
                memberEmailValid : false,
                memberJoinValid : false,
                memberContactValid : false ,
                memberBirthValid : false , //선택항목
                memberAddressValid : false , //선택항목
                memberCompanyNameValid : false,
                memberNameValid : false,
                memberRankValid : false,
                memberDeptValid : false,
                ok : function(){
                    return this.memberIdValid && this.memberIdCheckValid
                        && this.memberPwValid && this.memberPwCheckValid 
                        && this.memberEmailValid && this.memberJoinValid
                        && this.memberContactValid
                        && this.memberBirthValid && this.memberAddressValid
                        && this.memberCompanyNameValid && this.memberNameValid
                        && this.memberRankValid && this.memberDeptValid;
                },
            };

            //입력창 검사
            $("[name=memberId]").blur(function(){
                //step 1 : 아이디에 대한 형식 검사
                var regex = /^[a-z][a-z0-9]{7,19}$/;
                var memberId = $(this).val();//this.value
                var isValid = regex.test(memberId);
                //step 2 : 아이디 중복 검사(형식이 올바른 경우만)
                if(isValid) {
                    //비동기 통신으로 중복 검사 수행
                    $.ajax({
                        url:"http://localhost:8080/rest/member/checkId",
                        method:"post",
                        data:{ memberId : memberId },
                        success: function(response) {
                            //console.log("중복 확인 결과", response);
                            if(response) {//.success - 아이디가 사용가능한 경우
                                status.memberIdCheckValid = true;
                                $("[name=memberId]").removeClass("success fail fail2")
                                                                    .addClass("success");
                            }
                            else {//.fail2 - 아이디가 이미 사용중인 경우
                                status.memberIdCheckValid = false;
                                $("[name=memberId]").removeClass("success fail fail2")
                                                                    .addClass("fail2");
                            }
                        },
                    });
                }
                else {//.fail - 아이디가 형식에 맞지 않는 경우
                    $("[name=memberId]").removeClass("success fail fail2")
                                                        .addClass("fail");
                }
                status.memberIdValid = isValid;
            });

            //비밀번호 
            $("[name=memberPw]").blur(function(){
                var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
                var isValid = regex.test($(this).val());
                $(this).removeClass("success fail")
                            .addClass(isValid ? "success" : "fail");
                status.memberPwValid = isValid;
            });
            $("#password-check").blur(function(){
                var isValid = $("[name=memberPw]").val().length
                                && $(this).val() == $("[name=memberPw").val();
                $(this).removeClass("success fail")
                            .addClass(isValid ? "success" : "fail");
                status.memberPwCheckValid = isValid;
            });


                 //회사이름
                 $("[name=memberCompanyName]").blur(function(){
                var regex = /^[가-힣a-zA-Z0-9]+$/
                var isValid = regex.test($(this).val());
                $(this).removeClass("success fail")
                            .addClass(isValid ? "success" : "fail");
                status.memberCompanyNameValid = isValid;
            });

                 //이름
                 $("[name=memberName]").blur(function(){
                var regex =  /^[가-힣]{2,6}$/;
                var isValid = regex.test($(this).val());
                $(this).removeClass("success fail")
                            .addClass(isValid ? "success" : "fail");
                status.memberNameValid = isValid;
            });

            //직급
            $("[name=memberRank]").blur(function(){
            var memberRank = $(this).val();
            status.memberRankValid = memberRank.length > 0;
            if(status.memberRankValid) {//올바른 선택이라면
                $("[name=memberRank]").removeClass("success fail")
                                                        .addClass("success");
            }
            else {//잘못된 선택이라면
                $("[name=memberRank]").removeClass("success fail")
                                                        .addClass("fail");
            }
        });

                 //직급
                 $("[name=memberDept]").blur(function(){
            var memberDept = $(this).val();
            status.memberDeptValid = memberDept.length > 0;
            if(status.memberDeptValid) {//올바른 선택이라면
                $("[name=memberDept]").removeClass("success fail")
                                                        .addClass("success");
            }
            else {//잘못된 선택이라면
                $("[name=memberDept]").removeClass("success fail")
                                                        .addClass("fail");
            }
        });




            //핸드폰 
            $("[name=memberContact]").blur(function(){
                var regex = /^010[1-9][0-9]{7}$/;
                var isValid = regex.test($(this).val());
                $(this).removeClass("success fail")
                            .addClass(isValid ? "success" : "fail");
                status.memberContactValid = isValid;
            });

            
                //이메일
                $("[name=memberEmail]").blur(function(){
                var regex = /^[a-z][a-z0-9\-_]{4,19}@[a-z0-9]{2,40}(\.co\.kr|\.net|\.com|\.org|\.dev)$/;
                var isValid = regex.test($(this).val());
                $(this).removeClass("success fail")
                            .addClass(isValid ? "success" : "fail");
                status.memberEmailValid = isValid;
            });

            //입사일
            $("[name=memberJoin],[name=memberBirth]").blur(function() {
    var regex = /^([0-9]{4})-(02-(0[1-9]|1[0-9]|2[0-9])|(0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30)|(0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01]))$/;
    var inputDateStr = $(this).val();
    var isValid = false;

    if (inputDateStr.length === 0 || regex.test(inputDateStr)) {
        // 입력된 날짜 문자열을 Date 객체로 변환
        var inputDate = new Date(inputDateStr);

        // 현재 날짜
        var now = new Date();
        now.setHours(23, 59, 59, 999); // 오늘 날짜의 00:00:00으로 설정

        // 입력된 날짜가 유효한지 확인
        if (inputDate instanceof Date && !isNaN(inputDate)) {
            // 과거 또는 오늘 날짜인지 확인
            if (inputDate  < now) {
                isValid = true; // 과거 날짜 또는 오늘 날짜는 유효
            }
        }
    }

    $(this).removeClass("success fail")
           .addClass(isValid ? "success" : "fail");
    status.memberJoinValid = isValid;
});








            //주소는 모두 없거나 모두 있거나 둘 중 하나면 통과
            $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]").blur(function(){
                var memberPost = $("[name=memberPost]").val();
                var memberAddress1 = $("[name=memberAddress1]").val();
                var memberAddress2 = $("[name=memberAddress2]").val();

                var isEmpty = memberPost.length == 0 
                                    && memberAddress1.length == 0 
                                    && memberAddress2.length == 0;
                var isFill = memberPost.length > 0
                                    && memberAddress1.length > 0
                                    && memberAddress2.length > 0;
                var isValid = isEmpty || isFill;
                $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]")
                            .removeClass("success fail")
                            .addClass(isValid ? "success" : "fail");
                status.memberAddressValid = isValid;
            });

            //폼 검사
            $(".check-form").submit(function(){
                $("[name], #password-check").trigger("input1").trigger("blur")
                .trigger(select1);
                return status.ok();
            });



            //부가기능
            $(".field-show").change(function(){
                var checked = $(this).prop("checked");
                $("[name=memberPw] , #password-check")
                            .attr("type", checked ? "text" : "password");
            });


            $(".fa-eye").click(function(){
                var checked = $(this).hasClass("fa-eye");
                if(checked) {
                    $(this).removeClass("fa-eye").addClass("fa-eye-slash");
                    $("[name=memberPw] , #password-check").attr("type", "text");
                }
                else {
                    $(this).removeClass("fa-eye-slash").addClass("fa-eye");
                    $("[name=memberPw] , #password-check").attr("type", "password");
                }
            });

            $("[name=attach]").change(function(){
                //파일 태그에만 존재하는 files라는 항목에는 선택된 파일 정보가 담김
                //- length가 0이면 파일을 선택하지 않았다는 뜻
                //- length가 0보다 크면 파일을 선택했다는 뜻
                if(this.files.length == 0) {
                    $(this).parent().next().children("img")
                            .attr("src", "https://placehold.co/150?text=NO");
                }
                else {//1개라는 뜻
                    var file = this.files[0];
                    var url = window.URL.createObjectURL(file);
                    $(this).parent().next().children("img").attr("src", url);
                }
            });

            $("[name=memberPost],[name=memberAddress1], .btn-find-address")
            .click(function(){
                new daum.Postcode({
                    oncomplete: function(data) {
                        var addr = ''; // 주소 변수

                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }

                        document.querySelector("[name=memberPost]").value = data.zonecode;
                        document.querySelector("[name=memberAddress1]").value = addr;
                        // 커서를 상세주소 필드로 이동한다.
                        document.querySelector("[name=memberAddress2]").focus();
                        $("[name=memberPost]").trigger("input");
                    }
                }).open();
            });

            $(".btn-clear-address").click(function(){
                $("[name=memberPost]").val("");
                $("[name=memberAddress1]").val("");
                $("[name=memberAddress2]").val("");
            });

            $(".btn-clear-address").hide();
            $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]")
            .on("input", function(){
                var len1 = $("[name=memberPost]").val().length;
                var len2 = $("[name=memberAddress1]").val().length;
                var len3 = $("[name=memberAddress2]").val().length;
                if(len1 + len2 + len3 > 0) {
                    $(".btn-clear-address").fadeIn();
                }
                else {
                    $(".btn-clear-address").fadeOut();
                }
            });

            //엔터 차단 코드
            $(".check-form").find(".field").keypress(function(e){
                switch(e.keyCode) {
                    case 13: return false;
                }
            });

   

        });



     
</script>

</head>
<body>
    <div class="container">
        <form class="form" action="login" method="post">
            <p class="title">Login</p>
            <input placeholder="Username" class="username input" type="text" name="loginId">
            <input placeholder="Password" class="password input" type="password" name="password">
            <span class="span"><a href="#">Forgot password?</a></span>
            <button class="btn" type="submit">Login</button>
            <span class="span">Don't have an account?
                <button id="openModal">  Sign up</button></span>
            <div id="myModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                </form>
                
      
<form class="form1" action="join" method="post">
    <p class="title1">ERP </p>
    <p class="message1">ERP 가입을 위해 정보를 적으세요</p>
        
    <label>
        <input class="input1" type="text" name="memberId" placeholder="" required="">
        <span class="span1">아이디</span>
    </label>

    <label>
        <input class="input1" type="password" name="memberPw" placeholder="" required="">
        <span class="span1">비밀번호</span>
    </label>
    <label>
        <input class="input1" type="password" id="password-check" placeholder="" required="">
        <span class="span1">비밀번호 확인</span>
    </label>
    
    
    
    
    
    <div class="flex1">
        <label>
            <input class="input1" name="memberCompanyName" type="text" placeholder="" required="">
            <span class="span1">회사이름</span>
        </label>

        <label>
            <input class="input1" name="memberName" type="text" placeholder="" required="">
            <span class="span1">이름</span>
        </label>
    </div>  

    <div class="flex1">
        <label>
            <select class="select1" name="memberRank">
                <option value="">직급선택</option>
                <option value="어쩌고">어쩌고</option>
                <option value="저쩌고">저쩌고</option>
                <option value="직급">직급</option>
            </select>
            <span class="span1">직급</span>
        </label>

        <label>
            <select class="select1" name="memberDept">
                <option value="">부서선택</option>
                <option value="어쩌고">어쩌고</option>
                <option value="저쩌고">저쩌고</option>
                <option value="부서">부서</option>
            </select>
            <span class="span1">부서</span>
        </label>
    </div>

    <div class="flex1">
        <label>
            <input class="birthday1" name="memberBirth" type="date" placeholder="" required="">
            <span class="span1">생일</span>
        </label>

        <label>
            <input class="join1" name="memberJoin" type="date" placeholder="" required="">
            <span class="span1">입사일</span>
        </label>
    </div>  

    
    <label>
        <input class="input1" name="memberContact" type="text" placeholder="" required="">
        <span class="span1">핸드폰번호</span>
    </label> 
    <label>
        <input class="input1" name="memberEmail" type="email" placeholder="" required="">
        <span class="span1">이메일</span>
    </label> 
    
    <label>
        <input class="address" name="memberPost" type="text" placeholder="" required="">
        <span class="span1">우편번호</span>
        <button class="btn-address">
        </button>
    </label>

    <label>
        <input class="address1" name="memberAddress1" type="text" placeholder="" required="">
        <span class="span1">주소</span>
    </label>
    <label>
        <input class="address1" name="memberAddress2" type="text" placeholder="" required="">
        <span class="span1">상세주소</span>
    </label>




    
    <button class="submit1">Submit</button>
    <p class="signin1">Already have an account ? <a href="#">Sign in</a> </p>
</form>

                </div>
    </div>
</body>
</html>

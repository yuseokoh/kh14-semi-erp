<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 비밀번호 찾기추가</title>
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
    <style>

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
        $(function () {
            //상태 객체
            var status = {
                memberIdValid: false, //형식검사
                memberIdCheckValid: false, //중복검사
                memberPwValid: false,
                memberPwCheckValid: false,
                memberEmailValid: false,
                memberJoinValid: false,
                memberContactValid: false,
                memberBirthValid: false, //선택항목
                memberAddressValid: false, //선택항목
                memberCompanyNameValid: false,
                memberNameValid: false,
                memberRankValid: false,
                memberDeptValid: false,
                ok: function () {
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
            $("[name=memberId]").blur(function () {
                //step 1 : 아이디에 대한 형식 검사
                var regex = /^[a-z][a-z0-9]{7,19}$/;
                var memberId = $(this).val();//this.value
                var isValid = regex.test(memberId);
                //step 2 : 아이디 중복 검사(형식이 올바른 경우만)
                if (isValid) {
                    //비동기 통신으로 중복 검사 수행
                    $.ajax({
                        url: "http://localhost:8080/rest/member/checkId",
                        method: "post",
                        data: { memberId: memberId },
                        success: function (response) {
                            //console.log("중복 확인 결과", response);
                            if (response) {//.success - 아이디가 사용가능한 경우
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
            $("[name=memberPw]").blur(function () {
                var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
                var isValid = regex.test($(this).val());
                $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
                status.memberPwValid = isValid;
            });
            $("#password-check").blur(function () {
                var isValid = $("[name=memberPw]").val().length
                    && $(this).val() == $("[name=memberPw").val();
                $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
                status.memberPwCheckValid = isValid;
            });


            //회사이름
            $("[name=memberCompanyName]").blur(function () {
                var regex = /^[가-힣a-zA-Z0-9]+$/
                var isValid = regex.test($(this).val());
                $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
                status.memberCompanyNameValid = isValid;
            });

            //이름
            $("[name=memberName]").blur(function () {
                var regex = /^[가-힣]{2,6}$/;
                var isValid = regex.test($(this).val());
                $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
                status.memberNameValid = isValid;
            });

            //직급
            $("[name=memberRank]").blur(function () {
                var memberRank = $(this).val();
                status.memberRankValid = memberRank.length > 0;
                if (status.memberRankValid) {//올바른 선택이라면
                    $("[name=memberRank]").removeClass("success fail")
                        .addClass("success");
                }
                else {//잘못된 선택이라면
                    $("[name=memberRank]").removeClass("success fail")
                        .addClass("fail");
                }
            });

            //직급
            $("[name=memberDept]").blur(function () {
                var memberDept = $(this).val();
                status.memberDeptValid = memberDept.length > 0;
                if (status.memberDeptValid) {//올바른 선택이라면
                    $("[name=memberDept]").removeClass("success fail")
                        .addClass("success");
                }
                else {//잘못된 선택이라면
                    $("[name=memberDept]").removeClass("success fail")
                        .addClass("fail");
                }
            });




            //핸드폰 
            $("[name=memberContact]").blur(function () {
                var regex = /^010[1-9][0-9]{7}$/;
                var isValid = regex.test($(this).val());
                $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
                status.memberContactValid = isValid;
            });


            //이메일
            $("[name=memberEmail]").blur(function () {
                var regex = /^[a-z][a-z0-9\-_]{4,19}@[a-z0-9]{2,40}(\.co\.kr|\.net|\.com|\.org|\.dev)$/;
                var isValid = regex.test($(this).val());
                $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
                status.memberEmailValid = isValid;
            });

            //입사일
            $("[name=memberJoin],[name=memberBirth]").blur(function () {
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
                        if (inputDate < now) {
                            isValid = true; // 과거 날짜 또는 오늘 날짜는 유효
                        }
                    }
                }
                $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
                status.memberJoinValid = isValid;
            });

            //주소는 모두 없거나 모두 있거나 둘 중 하나면 통과
            $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]").blur(function () {
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
            $(".check-form").submit(function () {
                $("[name], #password-check").trigger("input1").trigger("blur")
                    .trigger(select1);
                return status.ok();
            });



            //부가기능
            $(".field-show").change(function () {
                var checked = $(this).prop("checked");
                $("[name=memberPw] , #password-check")
                    .attr("type", checked ? "text" : "password");
            });


            $(".fa-eye").click(function () {
                var checked = $(this).hasClass("fa-eye");
                if (checked) {
                    $(this).removeClass("fa-eye").addClass("fa-eye-slash");
                    $("[name=memberPw] , #password-check").attr("type", "text");
                }
                else {
                    $(this).removeClass("fa-eye-slash").addClass("fa-eye");
                    $("[name=memberPw] , #password-check").attr("type", "password");
                }
            });

            $("[name=attach]").change(function () {
                //파일 태그에만 존재하는 files라는 항목에는 선택된 파일 정보가 담김
                //- length가 0이면 파일을 선택하지 않았다는 뜻
                //- length가 0보다 크면 파일을 선택했다는 뜻
                if (this.files.length == 0) {
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
                .click(function () {
                    new daum.Postcode({
                        oncomplete: function (data) {
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

            $(".btn-clear-address").click(function () {
                $("[name=memberPost]").val("");
                $("[name=memberAddress1]").val("");
                $("[name=memberAddress2]").val("");
            });

            $(".btn-clear-address").hide();
            $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]")
                .on("input", function () {
                    var len1 = $("[name=memberPost]").val().length;
                    var len2 = $("[name=memberAddress1]").val().length;
                    var len3 = $("[name=memberAddress2]").val().length;
                    if (len1 + len2 + len3 > 0) {
                        $(".btn-clear-address").fadeIn();
                    }
                    else {
                        $(".btn-clear-address").fadeOut();
                    }
                });

            //엔터 차단 코드
            $(".check-form").find(".field").keypress(function (e) {
                switch (e.keyCode) {
                    case 13: return false;
                }
            });

        });




    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            // 모달 열기
            $('#openModal2').click(function () {
                $('#myModal2').show();
            });
            // 닫기 버튼 클릭 시 모달 닫기
            $('.close').click(function () {
                $('#myModal2').hide();
            });
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

</head>

<body>
    <div class="container">
        <form class="form" action="#">
            <p class="title">Login</p>
            <input placeholder="Username" class="username input" type="text">
            <input placeholder="Password" class="password input" type="password">
            
            <!-- 비밀번호 찾기 -->
            <span class="span3">Forgot password?
                <button id="openModal2">Find</button>
            </span>
            <div id="myModal2" class="modal2">
                <div class="modal2-content2">
                    <span class="close">&times;</span>
                    
                    <div class="form2">
                        <p class="title2">비밀번호 찾기 </p>
                        <p class="message2">비밀번호 찾기를 위해 정보를 입력하세요</p>

                        <form  class="form2" action="#" method="post">
                        <label>
                            <input class="input2" type="text" name="loginId" placeholder="" required="">
                            <span class="span2">아이디</span>
                        </label>

                        <label>
                            <input class="input2" type="email" name="empEmail" placeholder="" required="">
                            <span class="span2">이메일</span>
                        </label>

                        <button class="submit2">Submit</button>
                        <p class="signin2"><a href="#">Send Email</a> </p>
                    </form>
                    </div>

                </div>
            </div>

            <!-- 비밀번호 찾기 여기까지-->

            <button class="btn" type="submit">Login</button>

            <!-- 회원가입 모달 시작-->
            <span class="span">Don't have an account?
                <button id="openModal"> Sign up</button></span>
            <div id="myModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
        </form>

        <!-- 회원가입-->
        <form class="form1">
            <p class="title1">ERP </p>
            <p class="message1">ERP 가입을 위해 정보를 적으세요</p>

            <label>
                <input class="input1" type="text" name="loginId" placeholder="" required="">
                <span class="span1">아이디</span>
            </label>

            <label>
                <input class="input1" type="password" name="password" placeholder="" required="">
                <span class="span1">비밀번호</span>
            </label>
            <label>
                <input class="input1" type="password" id="password-check" placeholder="" required="">
                <span class="span1">비밀번호 확인</span>
            </label>

            <label>
                <input class="input1" name="name" type="text" placeholder="" required="">
                <span class="span1">이름</span>
            </label>

            <div class="flex1">
                <label>
                    <select class="select1" name="empLevel">
                        <option value="">직급선택</option>
                        <option value="인턴">인턴</option>
                    </select>
                    <span class="span1">직급</span>
                </label>

                <label>
                    <select class="select1" name="empDept">
                        <option value="">부서선택</option>
                        <option value="a00">인사팀</option>
                        <option value="a01">총무팀</option>
                        <option value="a02">영업팀</option>
                        <option value="a03">개발팀</option>
                        <option value="a04">생산팀</option>
                    </select>
                    <span class="span1">부서</span>
                </label>
            </div>

            <div class="flex1">
                <label>
                    <input class="birthday1" name="empBirth" type="date" placeholder="" required="">
                    <span class="span1">생일</span>
                </label>

                <label>
                    <input class="join1" name="empHp" type="date" placeholder="" required="">
                    <span class="span1">입사일</span>
                </label>
            </div>


            <label>
                <input class="input1" name="empHp" type="text" placeholder="" required="">
                <span class="span1">핸드폰번호</span>
            </label>
            <label>
                <input class="input1" name="empEmail" type="email" placeholder="" required="">
                <span class="span1">이메일</span>
            </label>

            <label>
                <input class="address" name="empPost" type="text" placeholder="" required="">
                <span class="span1">우편번호</span>
                <button class="btn-address">
                </button>
            </label>

            <label>
                <input class="address1" name="empAddress1" type="text" placeholder="" required="">
                <span class="span1">주소</span>
            </label>
            <label>
                <input class="address1" name="empAddress2" type="text" placeholder="" required="">
                <span class="span1">상세주소</span>
            </label>





            <button class="submit1">Submit</button>
            <p class="signin1">Already have an acount ? <a href="#">Sign in</a> </p>
        </form>

    </div>
    </div>
</body>

</html>
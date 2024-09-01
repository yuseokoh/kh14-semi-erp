<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
    <!-- 헤더 삽입 -->
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
            position: relative; /* position을 relative로 설정 */
            top: -1.5rem; /* 버튼을 위로 이동 */
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
            position: relative; /* position을 relative로 설정 */
            top: -1rem; /* 버튼을 위로 이동 */
        }
    </style>

    <style>
        /* 모달 창 스타일 */
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
            position: absolute; /* Position absolutely within the modal-content */
            top: 10px; /* Distance from the top of modal-content */
            right: 25px; /* Distance from the right edge of modal-content */
            z-index: 99998;
        }

        .close:hover,
        .close:focus {
            color: wheat;
            text-decoration: none;
            cursor: pointer;
        }

        #openModal {
            height: 1rem;
            width: 3rem;
            margin-top: 3rem;
            border-radius: 0.5rem;
            border: none;
            font-size: 0.6rem;
            position: relative; /* position을 relative로 설정 */
            top: -2.7rem; /* 버튼을 위로 이동 */
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
            color: #fff;
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

        .form1 label .input1:placeholder-shown + span {
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

        .input1 {
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

    <!-- chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- 푸터 스크립트 추가 -->
    <script type="text/javascript">
    $(document).ready(function() {
            // 모달 창 열기
            $('#openModal').click(function() {
                $('#myModal').show();
            });

            // 모달 창 닫기
            $('.close').click(function() {
                $('#myModal').hide();
            });

            // 모달 외부 클릭 시 닫기
            $(window).click(function(event) {
                if ($(event.target).is('#myModal')) {
                    $('#myModal').hide();
                }
            });

            // 모달 내용 클릭 시 전파 방지
            $('.modal-content').click(function(event) {
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
            <span class="span"><a href="#">Forgot password?</a></span>
            <button class="btn" type="submit">Login</button>
            <span class="span">Don't have an account?
                <button id="openModal">Sign up</button></span>
            <div id="myModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <form class="form1">
                        <p class="title1">ERP </p>
                        <p class="message1">ERP를 통해 간편하게 가입하세요</p>
                        <div class="flex1">
                            <label>
                                <input class="input1" type="text" placeholder="" required="">
                                <span class="span1">Company name</span>
                            </label>

                            <label>
                                <input class="input1" type="text" placeholder="" required="">
                                <span class="span1">Name</span>
                            </label>
                        </div>  

                        <label>
                            <input class="input1" type="email" placeholder="" required="">
                            <span class="span1">Phone number</span>
                        </label> 
                        <label>
                            <input class="input1" type="email" placeholder="" required="">
                            <span class="span1">Email</span>
                        </label> 

                        <label>
                            <input class="input1" type="password" placeholder="" required="">
                            <span class="span1">Password</span>
                        </label>
                        <label>
                            <input class="input1" type="password" placeholder="" required="">
                            <span class="span1">Confirm password</span>
                        </label>
                        <button class="submit1">Submit</button>
                        <p class="signin1">Already have an account? <a href="#">Sign in</a></p>
                    </form>
                </div>
            </div>
        </form>
    </div>
</body>
</html>

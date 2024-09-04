<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--구글 폰트cdn-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
    rel="stylesheet">

<!--폰트 어썸 icon cdn-->
<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<title>회의실 예약 리스트</title>
  <!-- SweetAlert2 CDN -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- google font cdn -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
    rel="stylesheet">

<!-- font awesome icon cdn -->
<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    
<!-- my css -->
<link rel="stylesheet" type="text/css" href="./commons.css">
<link rel="stylesheet" type="text/css" href="./test.css">
<link rel="stylesheet" type="text/css" href="./sidebar.css">
<link rel="stylesheet" type="text/css" href="./notic.css">
<link rel="stylesheet" type="text/css" href="./alertA.css">
<style>
   .btn-write {
                    background-color: wheat !important;
            color: white;
            border-radius: 0.2em;
            border: 1px solid antiquewhite !important;
        }

        .btn-write:hover {
            background-color: rgb(252, 241, 228) !important;
            color: rgb(252, 197, 94);
}

.btn-delete {
            background-color: #d63031 !important;
            color: white;
            border-radius: 0.2em;
            border: 1px solid #cde1ff !important;
        }

        .btn-delete:hover {
    background-color: #ff7675 !important;
    color: black; 
}

 .a1{
    color: black;
    text-decoration: none;
 }
 .a2{
    color: white;
    text-decoration: none;
 }

</style>

<!-- lightpick cdn -->
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script
    src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>

<!-- jquery cdn -->
<script
    src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="checkbox.js"></script>
<script src="confirm-link.js"></script>
<script src="multipage.js"></script>

    <!-- fullcalendar cdn-->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>
  <!-- lightpick cdn -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
  <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
  <!-- jquery cdn -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="./checkbox.js"></script>
  <script src="./confirm-link.js"></script>
  <!-- <script src="multipage.js"></script> -->
  <!-- 프로젝트 js-->
<script src="./gotoworkbtn.js"></script>
<script src="./menuToggle.js"></script>
  <!-- chart js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 자바스크립트 코드 작성 영역 -->
<script type="text/javascript">
    function showDeleteConfirmation() {
        Swal.fire({
            title: '취소 하시겠습니까?',
            icon: 'warning',
            showCancelButton: true, 
            confirmButtonColor: '#3085d6', 
            cancelButtonColor: '#d33', 
            confirmButtonText: '네, 취소하겠습니다!',
            cancelButtonText: '아니요!'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire(
                    '취소완료!',
                    '',
                    'success'
                );
            } else {
                Swal.fire(
                    'Cancelled',
                    '',
                    'error'
                );
            }
        });
    }

</script>

</head>
<body>
    <header id="header">
        <div id="menuToggle">
            <i class="fa fa-bars"></i>
        </div>
        <div id="logo">
            <a href="#" class="notif-alert"> <i
                class="fa-solid fa-envelope email"></i> <span
                class="notif-count content">0</span>
            </a> <a href="#"><i class="fa-solid fa-circle-user user"></i></a>
        </div>
    </header>

    <aside id="sidebar">
        <nav id="menu">
            <div class="container">
                <div class="row center">
                    <h1>ERP</h1>
                </div>

                <div class="row">
                    <ul class="menu-hover-fill">
                        <li><a href="/" data-text="home">HOME</a></li>

                        <li><a href="/poketmon/list" data-text=""> <i
                                class="fa-solid fa-file-signature"></i> 그룹웨어(poketmon)
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul></li>

                        <li><a href="/emp/list" data-text=""> <i
                                class="fa-solid fa-cart-flatbed"></i> 재고관리(emp)
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul></li>

                        <li><a href="/book/list" data-text=""> <i
                                class="fa-solid fa-people-group"></i> 인사관리(book)
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul></li>

                        <li><a href="/member/mypage" data-text=""> <i
                                class="fa-solid fa-id-card"></i> mypage
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul></li>

                        <li><a href="/board/list" data-text=""> <i
                                class="fa-solid fa-comment"></i> 예비용
                        </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul></li>

                        <c:if test="${sessionScope.createdLevel == '관리자'}">
                            <li><a href="/admin" data-text=""> <i
                                    class="fa-solid fa-gears"></i> 관리자
                            </a></li>
                        </c:if>

                        <li><a href="/logout" data-text=""> <i
                                class="fa-solid fa-power-off"></i> 로그아웃
                        </a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </aside>
    <div id="content" style="margin-top : 200px;">
        <main id="body">
       

            <!-- 회의실 예약 목록 -->
            <body>
                <div class="noticbox w-1200">

                    <form id="searchForm" action="list" method="get" autocomplete="off">


                    <div class="row notice">
                           <div class="row noticname">회의실 예약</div>
                           <div class="actions" name="column">
                               <select class="row actions1" style="flex-grow: 1;">
                                <option value="guest_name">예약자 이름</option>
                                <option value="room_name">회의실 이름</option>
                               </select>
                               <div class="row search" style="flex-grow: 1;">
                                <input type="text" name="keyword" class="row">
                               </div>
                               <button type="submit" class="search button" style="flex-grow: 1;">검색</button>
                           </div>
                       </div>
               
               
                       <div class="tb-box">
                           <table class="">
                               <thead>
                                   <tr>
                                    <th style="width: 3%;">선택</th>
                                    <th>예약 ID</th>
                                    <th>회의실 이름</th>
                                    <th>예약자 이름</th>
                                    <th>대여 상태</th>
                                    <th>예약 시간</th>
                                   </tr>
                               </thead>
                               <tbody class="tbody">
                                <c:forEach var="reservation" items="${list}">
                                <tr data-room-id="${reservation.roomId}"
                                    data-cal-date="${reservation.calDate}"
                                    data-stime="${reservation.stime}"
                                    data-etime="${reservation.etime}">
                                    <td><input type="checkbox" class="check-item"></td>
                                    <td>${reservation.resId}</td>
                                    <td>${reservation.roomName}</td>
                                    <td>${reservation.guestName}</td>
                                    <td>${reservation.resYN}</td>
                                    <td>[${reservation.calDate}] ${reservation.stime} ~
                                        ${reservation.etime}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
               
                           <div class="flex-box ">
                               <div class="row left">
                                   <button type="button" class="btn btn-write " ><a class="a1" href="insert">예약 추가</a></button>
                                   <button type="button" class="btn btn-write " ><a class="a1" href="insert">예약 수정</a></button>
                               </div>
                               <div class="row center">
                                 <span>span지우고 네비게이터 넣는곳 </span> 
                               </div>
                               <div class="row right">
                                   <button type="button" class="btn btn-delete" onclick="showDeleteConfirmation()" > 예약 취소</button>
                               </div>
                           </div>
                       </div>

                    <!-- <a href="list">검색 초기화</a> -->

                    <!-- 페이지 네비게이션 처리 -->
                    <div class="row" style="display: flex; justify-content: center; align-items: center;">
                        <jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
                    </div>
            </div>
        </main>
    </div>
</body>
</html>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>출퇴근 관리 시스템</title>

 <!-- Google Font CDN -->
 <link rel="preconnect" href="https://fonts.googleapis.com">
 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
 <!-- Font Awesome Icon CDN -->
 <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
 <!-- My CSS -->
 <link rel="stylesheet" type="text/css" href="/css/commons.css">
 <!-- Additional CSS -->
 <link rel="stylesheet" type="text/css" href="/css/gotowork.css">
 <link rel="stylesheet" type="text/css" href="/css/sidebar.css">
 <!-- External Scripts -->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
 <script src="checkbox.js"></script>
 <script src="confirm-link.js"></script>
 <script src="multipage.js"></script>
 <script src="gotoworkbtn.js"></script>
 <script src="menuToggle.js"></script>
 <script src="delete.js"></script>
 <!-- Summernote CDN -->
 <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
 <!-- Chart.js CDN -->
 <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
table {
    width: 100%;
    max-width: 1200px;
    border-collapse: collapse;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    margin: 0 auto;
}

th, td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #80bdff;
    color: white;
    font-weight: bold;
}

tr:hover {
    background-color: #cde1ff;
}

a {
    color: #2e86de;
    text-decoration: none;
    font-weight: bold;
}

a:hover {
    text-decoration: underline;
}

.product-image {
    max-width: 100px;
    max-height: 120px;
    height: auto;
    border-radius: 5px;
}

.change-info {
    display: flex;
    align-items: center;
    justify-content: center;
}

.arrow {
    color: #2e86de;
    font-size: 1.2em;
    margin: 0 7px;
    margin-bottom: 5px;
}
</style>

</head>
<body>
    <header id="header">
        <div id="menuToggle"><i class="fa fa-bars"></i></div>
        <div id="logo">
            <a href="#" class="notif-alert">
                <i class="fa-solid fa-envelope email"></i>
                <span class="notif-count content">0</span>
            </a>
            <a href="#"><i class="fa-solid fa-circle-user user"></i></a> 
        </div>
    </header>

    <aside id="sidebar">
        <nav id="menu">
            <div class="container">
                <!-- 출퇴근 관리 -->
                <div id="commute-wrap">
                    <div id="date-wrap">
                        <span id="cur-date"></span><br>
                        <span id="cur-time"></span>
                    </div>
                    <div id="start-time">
                        <i>출근 시간</i>
                        <span id="start-time-display">미등록</span>
                    </div>
                    <div id="end-time">
                        <i>퇴근 시간</i>
                        <span id="end-time-display">미등록</span>
                    </div>
                    <div id="attendance-btns">
                        <button id="start-btn" class="on">출근</button>
                        <button id="end-btn" class="on">퇴근</button>
                    </div>
                </div>
                <!-- 출퇴근 관리 끝 -->

                <!-- 메뉴 -->
                <div class="row">
                    <ul class="menu-hover-fill">
                        <li><a href="/" data-text="home">HOME</a></li>
                        <li><a href="/poketmon/list" data-text="">
                            <i class="fa-solid fa-file-signature"></i> 그룹웨어(poketmon)</a>
                            <ul>
                                <li><a href="#">휴가</a></li>
                                <li><a href="#">보고서</a></li>
                            </ul>
                        </li>
                        <li><a href="/emp/list" data-text="">
                            <i class="fa-solid fa-cart-flatbed"></i> 재고관리(emp)</a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>
                        <li><a href="/book/list" data-text="">
                            <i class="fa-solid fa-people-group"></i> 인사관리(book)</a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>
                        <li><a href="/member/mypage" data-text="">
                            <i class="fa-solid fa-id-card"></i> mypage</a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>
                        <li><a href="/board/list" data-text="">
                            <i class="fa-solid fa-comment"></i> 예비용</a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>
                        <c:if test="${sessionScope.createdLevel == '관리자'}">
                            <li><a href="/admin" data-text="">
                                <i class="fa-solid fa-gears"></i> 관리자</a>
                            </li>
                        </c:if>
                        <li><a href="/logout" data-text="">
                            <i class="fa-solid fa-power-off"></i> 로그아웃</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </aside>
    
    <div id="content">
       <main id="body"> 
           <div id="content">
               <!-- 페이지 내용이 여기에 들어갑니다. -->
           </div>
       </main>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>leave form</title>

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
        html, body { 
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
            overflow-x: hidden; /* 가로 스크롤바 숨김 */
        }
        body {
            display: flex;
            justify-content: center; /* 수평 중앙 정렬 */
            /* align-items: center; 수직 중앙 정렬 */
            background: rgb(220,220,220); /* 배경 색상 설정 */
        }
        #header {
            width: 100%;
            height: 60px;
            background: #333; /* 헤더 배경 색상 */
            color: gainsboro; /* 헤더 글자 색상 */
            position: fixed; /* 고정 위치 */
            top: 0;
            left: 0;
            z-index: 1180; /* 다른 요소들보다 위에 위치 */
            display: flex;
            align-items: center; /* 수직 중앙 정렬 */
            justify-content: space-between; /* 좌우 정렬 */
            padding: 0; /* 패딩 제거 */
        }
        #menuToggle {
            font-size: 24px; /* 아이콘 크기 */
            width: 50px;
            height: 50px;
            text-align: center; /* 텍스트 중앙 정렬 */
            background: #444; /* 버튼 배경 색상 */
            color: #fff; /* 버튼 글자 색상 */
            border-radius: 50%; /* 원형 버튼 */
            cursor: pointer; /* 마우스 커서 변경 */
            transition: background 0.3s ease, transform 0.3s ease; /* 배경 색상 및 크기 변화 애니메이션 */
            display: flex;
            align-items: center; /* 수직 중앙 정렬 */
            justify-content: center; /* 수평 중앙 정렬 */
            margin: 10px;
        }
        #menuToggle:hover {
            background: #666; /* 호버 시 배경 색상 */
            transform: scale(1.1); /* 호버 시 크기 확대 */
        }
        #logo {
            font-size: 35px; /* 로고 폰트 크기 */
            color: gainsboro; /* 로고 색상 */
            position: relative;
            margin: 10px;
        }

        #sidebar {
            min-width: 60px;
            width: 230px;
            height: 100%;
            background: #222; /* 사이드바 배경 색상 */
            color: gainsboro; /* 사이드바 글자 색상 */
            padding: 60px 0; /* 상하 여백 */
            position: fixed; /* 고정 위치 */
            top: 0;
            left: -300px; /* 기본적으로 사이드바를 화면 밖으로 이동 */
            transition: left 0.3s; /* 열림/닫힘 애니메이션 */
            z-index: 1170; /* 헤더보다 아래 위치 */
        }
        #sidebar.opened {
            left: 0; /* 사이드바 열림 상태 */
        }
        
        #body {
            padding: 15px 20px; /* 상하좌우 여백 */
            transition: padding-left 0.3s; /* 패딩 변경 애니메이션 */
            width: calc(100% - 300px); /* 사이드바 너비를 제외한 전체 너비 */
        }
        #content {
            padding: 15px 20px; /* 상하좌우 여백 */
            color: black; /* 글자 색상 */
            background-color: rgb(220,220,220); /* 배경 색상 */
        }
        nav#menu {
            display: flex;
            flex-direction: column; /* 수직 정렬 */
            padding: 0;
            margin: 0;
            list-style: none; /* 리스트 스타일 제거 */
            height: calc(100% - 20px); /* 사이드바 높이에서 여백 제외 */
        }
        nav#menu ul {
            padding: 0;
            margin: 0;
            list-style: none; /* 리스트 스타일 제거 */
        }
        nav#menu ul li {
            border-bottom: 1px solid #ddd; /* 항목 사이에 경계선 */
            position: relative; /* 서브메뉴를 위한 상대적 위치 설정 */
        }
        nav#menu ul li:hover > ul {
            display: block; /* 서브메뉴 표시 */
        }
        nav#menu ul li ul {
            display: none; /* 기본적으로 서브메뉴 숨김 */
            padding-left: 20px; /* 서브메뉴 왼쪽 여백 */
            background: #333; /* 서브메뉴 배경 색상 */
            position: absolute; /* 절대 위치 */
            left: 100%; /* 부모 메뉴 오른쪽에 위치 */
            top: 0;
            min-width: 200px; /* 서브메뉴 최소 너비 */
        }
        nav#menu ul li ul li {
            border-bottom: none; /* 서브메뉴 항목 간 경계선 제거 */
        }
        nav#menu ul li a {
            display: block; /* 블록 수준 요소로 설정 */
            padding: 10px 20px; /* 상하좌우 여백 */
            text-decoration: none; /* 밑줄 제거 */
            color: gainsboro; /* 글자 색상 */
            font-weight: bold; /* 글자 굵게 */
        }
        nav#menu ul li a:hover {
            background-color: #666; /* 호버 시 배경 색상 */
            color: #636e72; /* 호버 시 글자 색상 */
        }
        /* 서브 메뉴 항목 기본 색상 */
        nav#menu ul li ul li a {
            color: gainsboro; /* 서브메뉴 기본 글자 색상 */
            font-weight: normal; /* 서브메뉴 글자 굵기 */
        }
        /* 서브 메뉴 항목 hover 색상 */
        nav#menu ul li ul li a:hover {
            background-color: #666; /* 서브메뉴 호버 시 배경 색상 */
            color: #fff; /* 서브메뉴 호버 시 글자 색상 */
        }
        .menu-hover-fill li:nth-child(1):hover > a,
.menu-hover-fill li:nth-child(1) ul li:hover a {
    color: var(--primary-color) !important; /* 첫 번째 항목 호버 시 색상 */
}
.menu-hover-fill li:nth-child(2):hover > a,
.menu-hover-fill li:nth-child(2) ul li:hover a {
    color: var(--info-color) !important; /* 두 번째 항목 호버 시 색상 */
}
.menu-hover-fill li:nth-child(3):hover > a,
.menu-hover-fill li:nth-child(3) ul li:hover a {
    color: var(--success-color) !important; /* 세 번째 항목 호버 시 색상 */
}
.menu-hover-fill li:nth-child(4):hover > a,
.menu-hover-fill li:nth-child(4) ul li:hover a {
    color: var(--warning-color) !important; /* 네 번째 항목 호버 시 색상 */
}
.menu-hover-fill li:nth-child(5):hover > a,
.menu-hover-fill li:nth-child(5) ul li:hover a {
    color: var(--danger-color) !important; /* 다섯 번째 항목 호버 시 색상 */
}
.menu-hover-fill li:nth-child(6):hover > a,
.menu-hover-fill li:nth-child(6) ul li:hover a {
    color: var(--danger-color) !important; /* 여섯 번째 항목 호버 시 색상 */
}
.menu-hover-fill li:nth-child(7):hover > a,
.menu-hover-fill li:nth-child(7) ul li:hover a {
    color: var(--danger-color) !important; /* 일곱 번째 항목 호버 시 색상 */
}
.menu-hover-fill li:nth-child(8):hover > a,
.menu-hover-fill li:nth-child(8) ul li:hover a {
    color: var(--logout-color) !important; /* 여덟 번째 항목 호버 시 색상 */
}
        :root {
            --grey-color: #7f8c8d; /* 회색 색상 */
            --primary-color: #2d3436; /* 기본 색상 */
            --info-color: #1abc9c; /* 정보 색상 */
            --success-color: #2ecc71; /* 성공 색상 */
            --warning-color: #f39c12; /* 경고 색상 */
            --danger-color: #e74c3c; /* 위험 색상 */
            --logout-color: red; /* 로그아웃 색상 */
        }


   /* 특정 아이콘의 색상 설정 */
   .talk {
        color: white; /* 아이콘 색상 설정 */
    }

    .email {
        color: white; /* 아이콘 색상 설정 */
    }

    .user {
        color: white; /* 아이콘 색상 설정 */
    }

/* .notif-alert 클래스를 가진 요소의 상대적인 위치 설정 */
.notif-alert {
    position: relative; /* 배지가 아이콘 위에 올바르게 배치되도록 아이콘의 부모 요소를 상대 위치로 설정 */
    display: inline-block; /* 인라인 블록으로 설정하여 배지가 아이콘 위에 제대로 표시되도록 함 */
}

/* 알림 배지의 스타일 정의 */
.notif-count {
    content: "5"; /* 배지에 표시할 내용(예: 알림 개수) */
    position: absolute; /* 배지를 부모 요소에 대해 절대 위치로 설정 */
    top: 2px; /* 아이콘 위쪽으로 배지 위치 조정 */
    right: -10px; /* 아이콘 오른쪽으로 배지 위치 조정 */
    background: orange; /* 배지의 배경 색상 */
    width: 25px; /* 배지의 너비를 25px로 설정 */
    height: 25px; /* 배지의 높이를 25px로 설정 (너비와 같게 설정하여 동그랗게 만듬) */
    border-radius: 50%; /* 배지의 모서리를 완전히 둥글게 만듬 */
    padding: 0; /* 배지 내부 여백을 0으로 설정하여 텍스트가 중앙에 위치하도록 함 */
    text-align: center; /* 배지 내의 텍스트 중앙 정렬 */
    font-size: 16px; /* 배지 내 텍스트의 폰트 크기 설정 */
    overflow: hidden; /* 배지 내용이 배지 경계를 넘지 않도록 숨김 */
    color: #222; /* 배지의 텍스트 색상 */
    font-weight: bold; /* 배지의 텍스트를 굵게 표시 */
    display: flex; /* 배지의 내용을 플렉스 박스로 설정하여 중앙 정렬을 더 쉽게 함 */
    align-items: center; /* 플렉스 박스의 아이템을 수직 중앙 정렬 */
    justify-content: center; /* 플렉스 박스의 아이템을 수평 중앙 정렬 */
}
    </style>

<!-- 달력 스타일 수정필요할듯?-->
<style>
    /* html, body {    
      overflow: hidden;    
      font-family: Arial, Helvetica Neue, Helvetica, sans-serif;   
       font-size: 14px;  }  
       /* 캘린더 위의 해더 스타일(날짜가 있는 부분) */  
       .fc-header-toolbar {   
           padding-top: 1em;    
           padding-left: 1em;    
          padding-right: 1em; 
         } 
   
          .fc .fc-toolbar-title{
            display: flex;
            flex-wrap: nowrap;
          }
          .fc-header-toolbar {
    display: flex; /* 부모 요소에 flex를 적용 */
    padding-top: 1em;
    padding-left: 1em;
    padding-right: 1em;
}
          .fc .fc-button:not(:disabled){
            flex-grow: 1 !important;
          }
</style>

<!-- 메인화면 info1 & 달력-->
<style>


</style>


<!-- 게시판 공지사항 style -->


<style>

    .noticbox{
        margin-left: auto;
        margin-right: auto;
    }
            .btn{
             color: white;
             background-color: #80bdff;
            border-color: #7f8c8d;
             border-radius: 4px;
             height: 35px; /* Ensure consistent height */
            }
            .search, 
            .delete, 
            .write {
              width: 100%;
           }
           .search{
            font-size: 16px;
           }
           .actions1{
            font-size: 16px;
           }
           .button{
            text-decoration: none; /* 밑줄 제거 */
            display: inline-block;/* 한줄에 여러개 배치 + 폭 설정 가능하게 */
             font-size: 16px; /* 입력창과 동일하게 */
            padding: 0.5em 0.75em; /*입력창과 동일하게*/
            color: white;
            background-color: #80bdff;
            border: 1px solid #7f8c8d;
            border-radius: 0.2em;
            cursor: pointer; /* 커서모양 변경 */
            text-align: center;
            line-height: 1.2;
           }

            .notice {
                     display: flex;
                     justify-content: space-between;
                     align-items: center; 
                 }
         
                 .notice .noticname {
                     font-weight: bold;
                 }
         
                 .notice .actions {
                     display: flex;
                     align-items: center; 
                    
                 }

  
            
                 .notice select, .notice input, .notice button {
                     margin-left: 0px; 
                     max-width: 150px; 
                     height: 35px;
                 }
         
                 .tb-box .flex-box {
                     display: flex;
                     justify-content: space-between;
                     align-items: center;
                 }
               
                 .tb{
                     border-top: 1px solid #7f8c8d;
                     border-bottom: 1px solid #7f8c8d;  
                     width: 100%;
                     border-collapse: collapse;
                     font-size: 16px;
                 }
                 .tb > thead {
             border-bottom: 1px solid #7f8c8d;
             }
             .name{
                  color: #80bdff;
                  font-weight: bold;
              }
                 
              .tbody{
                border-bottom: 1px solid #7f8c8d;
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
  <!-- 자바스크립트 코드 작성 영역 -->
  <script type="text/javascript">
        $(document).ready(function() {
            $('#menuToggle').on('click', function() {
                var $sidebar = $('#sidebar');
                var $body = $('#body');
                var isOpened = $sidebar.hasClass('opened');
                
                if (isOpened) {
                    $sidebar.removeClass('opened');
                    $body.css('width', '100%');
                    $body.css('padding-left', 0);
                } else {
                    $sidebar.addClass('opened');
                    $body.css('width', 'calc(100% - 300px)');
                    $body.css('padding-left', '320px');
                }
            });
    });
    </script>

<!-- fullcalendar cdn-->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>
<script>

  document.addEventListener('DOMContentLoaded', function() {
    const calendarEl = document.getElementById('calendar')
    const calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth'
    })
    calendar.render()
  })

</script>
<!-- 자바스크립트 코드 작성 영역 -->
<script type="text/javascript">
    (function() {
$(function() {
// Calendar element 취득
var calendarEl = $('#calendar')[0];

// FullCalendar 생성하기
var calendar = new FullCalendar.Calendar(calendarEl, {
  height: '600px', // Calendar 높이 설정
  expandRows: true, // 화면에 맞게 높이 재설정
  slotMinTime: '08:00', // Day 캘린더에서 시작 시간
  slotMaxTime: '20:00', // Day 캘린더에서 종료 시간

  // 헤더에 표시할 툴바
  headerToolbar: {
    left: '',
    center: 'prev,title,next',
    right: 'today'
  },

  initialView: 'dayGridMonth', // 초기 로드 될 때 보이는 캘린더 화면(기본 설정: 달)
  initialDate: '2024-08-22', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
  navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
  editable: true, // 수정 가능?
  selectable: true, // 달력 일자 드래그 설정 가능
  nowIndicator: true, // 현재 시간 마크
  dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
  locale: 'ko', // 한국어 설정

  // 이벤트 핸들러
  eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
    console.log(obj);
  },
  eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
    console.log(obj);
  },
  eventRemove: function(obj) { // 이벤트가 삭제되면 발생하는 이벤트
    console.log(obj);
  },
  select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
    var title = prompt('Event Title:');
    if (title) {
      calendar.addEvent({
        title: title,
        start: arg.start,
        end: arg.end,
        allDay: arg.allDay
      });
    }
    calendar.unselect();
  },

  // 이벤트 데이터
  events: [
    // {
    //   title: 'All Day Event',
    //   start: '2021-07-01'
    // },
    // {
    //   title: 'Long Event',
    //   start: '2021-07-07',
    //   end: '2021-07-10'
    // },
    // {
    //   groupId: 999,
    //   title: 'Repeating Event',
    //   start: '2021-07-09T16:00:00'
    // },
    // {
    //   groupId: 999,
    //   title: 'Repeating Event',
    //   start: '2021-07-16T16:00:00'
    // },
    // {
    //   title: 'Conference',
    //   start: '2021-07-11',
    //   end: '2021-07-13'
    // },
    // {
    //   title: 'Meeting',
    //   start: '2021-07-12T10:30:00',
    //   end: '2021-07-12T12:30:00'
    // },
    // {
    //   title: 'Lunch',
    //   start: '2021-07-12T12:00:00'
    // },
    // {
    //   title: 'Meeting',
    //   start: '2021-07-12T14:30:00'
    // },
    // {
    //   title: 'Happy Hour',
    //   start: '2021-07-12T17:30:00'
    // },
    // {
    //   title: 'Dinner',
    //   start: '2021-07-12T20:00:00'
    // },
    // {
    //   title: 'Birthday Party',
    //   start: '2021-07-13T07:00:00'
    // },
    // {
    //   title: 'Click for Google',
    //   url: 'http://google.com/', // 클릭 시 해당 URL로 이동
    //   start: '2021-07-28'
    // }
  ]
});

// Calendar 렌더링
calendar.render();
});
})();

</script>





</head>
<body>  
    <header id="header">
        <div id="menuToggle"><i class="fa fa-bars"></i></div>
        <div id="logo">
            <a href="#" class="notif-alert">
                <i class="fa-solid fa-envelope email"></i></i>
                <span class="notif-count content">0</span>
            </a>
            <a href="#"><i class="fa-solid fa-circle-user user"></i></a> 
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

                        <li><a href="/poketmon/list" data-text="">
                            <i class="fa-solid fa-file-signature"></i> 그룹웨어(poketmon) </a>
                            <ul>
                                <li><a href="#">서브메뉴1</a></li>
                                <li><a href="#">서브메뉴2</a></li>
                            </ul>
                        </li>

                        <li><a href="/stock/list" data-text="">
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


    <main id="body">
           <div class="container w-1200 my-50">
            <div class="row center">
                <h2> 메인화면 </h2>
            </div>

            <div class="row">
               <div class="flex-box">

                   <div class="row calendar  w-60">
                       
                       <div class="calendar-body">  
                           <!-- calendar 태그 -->  
                           <div id='calendar-container'>    
                               <div id='calendar'>
                            </div>  
                        </div>
                    </div>
                </div>
                

                <div class="row  w-40">
                    <img class="image image-fade image-hover" src="https://picsum.photos/id/1/300/300">                
                    
                 </div>


                
            </div> <!-- flex-box -->
          </div> <!-- row -->



         <!-- 여기부터 아래 2칸 -->
          <div class="row">
            <div class="flex-box">
                <!--3번째 칸-->
                <div class="row  w-50">
                    
                    <div class="row">  
                        <!-- 공지사항 태그 -->  
                        <div id="notic-container">    
                            <!-- 3째칸 내용입력-->
                            <div class="row notice">
                                <div class="row noticname">공지사항</div>
                                <div class="actions">
                                    <select class="row actions1" style="flex-grow: 1;">
                                        <option value="">작성일</option>
                                        <option value="" class="row">제목</option>
                                        <option value="">작성자</option>
                                    </select>
                                    <div class="row search" style="flex-grow: 1;">
                                        <input class="row"/>
                                    </div>
                                    <button type="button" class="search button" style="flex-grow: 1;">검색</button>
                                </div>
                            </div>
                    
                    <hr class="row mt-15 mb-50">
                    
                            <div class="tb-box">
                                <table class="tb">
                                    <thead>
                                        <tr>
                                            <th>선택</th>
                                            <th>작성일</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>조회수</th>
                                        </tr>
                                    </thead>
                                    <tbody class="tbody">
                                     <tr class="row center">
                                            <td><input type="checkbox" class="check-item"></td>
                                            <td>${게시판Dto.게시판작성자}</td>
                                            <td class="name">${게시판Dtto.게시판제목}</td>
                                            <td>${게시판Dto.게시판작성자}</td>
                                            <td>${게시판Dto.게시판조회수}</td>
                                        </tr>
                                    </tbody>
                                    <tbody lass="tbody">
                                     <tr class="row center">
                                            <td><input type="checkbox" class="check-item"></td>
                                            <td>연습용</td>
                                            <td class="name">실제적용시</td>
                                            <td>위에 tbody부터 </td>
                                            <td>아래tbody까지 지워야함</td>
                                        </tr>
                                    </tbody>
                                    
                                </table>
                    
                                <div class="flex-box ">
                                    <div class="row left">
                                        <button type="button" class="btn delete ">삭제</button>
                                    </div>
                                    <div class="row center">
                                      <span>span지우고 네비게이터 넣는곳 </span> 
                                    </div>
                                    <div class="row right">
                                        <button type="button" class="btn write">글작성</button>
                                    </div>
                                </div>
                    
                    
                    
                    
                            </div>
                    
                            </div>
                        </div>

<!--여기까지 -->
                            <div id="notic">
                         </div>  
                     </div>
                 
                 
                 
                 
                 <!--4번째 칸-->
                 <div class="row  w-50">
                     <!--4번째칸 내용입력-->
                     <div class="row notice">
                        <div class="row noticname">공지사항</div>
                    </div>
            
            <hr class="row mt-15 mb-50">
            
                    <div class="tb-box">
                        <table class="tb">
                            <thead>
                                <tr>
                                    <th>작성일</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                </tr>
                            </thead>
                            <tbody class="tbody">
                             <tr class="row center">
                                    <!-- <td>${게시판Dto.게시판작성일}</td> -->
                                    <td>2024/08/22</td>
                                    <!-- <td class="name">${게시판Dtto.게시판제목}</td> -->
                                    <td class="name">[공지] 이메일로 유포중인 어쩌고저쩌고</td>
                                    <!-- <td>${게시판Dto.게시판작성자}</td> -->
                                    <td>오유석</td>
                                </tr>
                            </tbody>

                            <!-- 값넣었을경우 여기서부터는 제거-->
                            <tbody lass="tbody">
                             <tr class="row center">
                                    <td>연습용</td>
                                    <td class="name">실제적용시</td>
                                    <td>위에 tbody부터 </td>
                                </tr>
                            </tbody>
                            
                            <!-- 값이 없기때문에 더미데이터 넣어서 줄 늘려본것-->
                            <!-- 여기까지 제거 -->

                        </table>
            
                        </div>
            
            
            
            
                    </div>
                     
                     
                    </div>
                    
                    
                </div> 
                </div> <!-- row -->
         </div> <!-- flex-box -->
       </div> <!-- row -->


        </div> <!-- 컨테이너 -->

    </div>
    </div>
</body>
</html>

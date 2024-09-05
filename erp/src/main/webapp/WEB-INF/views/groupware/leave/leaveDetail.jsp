<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>휴가 수정</title>

    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="/css/commons.css">
    <!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->

    <!-- 프로젝트 스타일 -->
    <link rel="stylesheet" type="text/css" href="/css/gotowork.css">
    <link rel="stylesheet" type="text/css" href="/css/sidebar.css">
    <!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
    <link rel="stylesheet" type="text/css" href="/css/vacation.css">

    <!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
    <link rel="stylesheet" type="text/css" href="/css/alertA.css">
    <link rel="stylesheet" type="text/css" href="/css/alertBtn.css">

    <style>
        .btn-container {
            position: relative;
            margin-top: 10px;
        }

        .btn-positive {
            background-color: #99c2ff !important;
            color: white;
            border-radius: 0.2em;
            border: 1px solid #cde1ff !important;
        }

        .btn-positive:hover {
            background-color: #dde6f3 !important;
            color: #66a2fc;
        }

        /* 비활성화된 스타일 */
        .disabled,
        .form[disabled] {
            background-color: #f0f0f0;
            color: #a0a0a0;
            cursor: not-allowed;
            border-color: #d0d0d0;
        }

        .disabled:focus,
        .form[disabled]:focus {
            outline: none;
        }

        .title1 {
            width: 70% !important;
            height: 40px;
            margin-right: 40%
        }

        /* 숨김 클래스 추가 */
        .hidden {
            display: none;
        }
    </style>



    <!-- lightpick cdn -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
    <!-- jquery cdn -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="/js/checkbox.js"></script>
    <script src="/js/confirm-link.js"></script>
    <script src="/js/multipage.js"></script>

    <!-- 프로젝트 js-->
    <script src="/js/gotoworkbtn.js"></script>
    <script src="/js/menuToggle.js"></script>
    <!-- chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- SweetAlert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script type="text/javascript">
        $(function() {
            $('.btn-positive').on(
                'click',
                function() {

                    $('[name=vacaTitle]').removeClass('disabled').removeClass(
                        'hidden').addClass('show').prop('disabled', false);
                    $('[name=vacaTel]').removeClass('disabled').removeClass(
                        'hidden').addClass('show').prop('disabled', false);
                    $('#beforVacaType').addClass('hidden').addClass('disabled')
                        .prop('disabled', true);
                    $('[name=vacaType]').removeClass('disabled').removeClass(
                        'hidden').addClass('show').prop('disabled', false);
                    $('[name=vacaReason]').removeClass('disabled').removeClass(
                        'hidden').addClass('show').prop('disabled', false);
                    $('[name=vacaSdate]').removeClass('disabled').removeClass(
                        'hidden').addClass('show').prop('disabled', false);
                    $('[name=vacaEdate]').removeClass('disabled').removeClass(
                        'hidden').addClass('show').prop('disabled', false);

                    $(this).text('수정완료').removeClass('btn-positive').addClass(
                        'btn-warning');

                    $('.btn-warning').on('click', function() {

                        //비동기통신해서 내용만 바꾸기
                        $.ajax({
                            url: '/rest/vacation/update', // 요청할 URL
                            type: 'POST', // 요청 방법 (GET, POST, PUT, DELETE 등)
                            data: { // 서버에 보낼 데이터 (필요에 따라 JSON, 폼 데이터 등)
                                approNo: $('[name=approNo]').val(),
                                approYN: $('[name=approYN]').val(),
                                vacaNo: $('[name=vacaNo]').val(),
                                vacaTitle: $('[name=vacaTitle]').val(),
                                vacaSdate: $('[name=vacaSdate]').val(),
                                vacaEdate: $('[name=vacaEdate]').val(),
                                vacaType: $('[name=vacaType]').val(),
                                vacaTel: $('[name=vacaTel]').val(),
                                vacaReason: $('[name=vacaReason]').val(),
                            },
                            success: function(response) { // 요청이 성공했을 때 호출되는 함수
                                if (response) {
                                    Swal.fire({
                                        icon: 'success',
                                        title: '수정 완료',
                                        text: '수정이 완료되었습니다.',
                                        timer: 1500, // 1500ms = 1.5초 후 자동으로 닫힘
                                        timerProgressBar: true, // 타이머 진행 바 표시
                                        didOpen: () => {
                                            Swal.showLoading();
                                        },
                                        willClose: () => {
                                            location.reload();
                                        },
                                        customClass: {
                                            title: 'custom-title',
                                            popup: 'custom-background',
                                            confirmButton: 'custom-button' // "확인" 버튼 스타일 적용
                                        }
                                    });
                                } else {
                                    Swal.fire({
                                        icon: 'error',
                                        title: '에러',
                                        text: '이 페이지는 이미 서명되었거나 공란이 존재합니다',
                                        timer: 1500, // 1500ms = 1.5초 후 자동으로 닫힘
                                        timerProgressBar: true, // 타이머 진행 바 표시
                                        didOpen: () => {
                                            Swal.showLoading();
                                        },
                                        willClose: () => {
                                            location.href = '/vacation/mylist?loginId=${sessionScope.createdUser}';
                                        },
                                        customClass: {
                                            title: 'custom-title',
                                            popup: 'custom-background',
                                            confirmButton: 'custom-button' // "확인" 버튼 스타일 적용
                                        }
                                    });
                                }
                            },
                            error: function(xhr, status, error) { // 요청이 실패했을 때 호출되는 함수
                                console.error('Error:', error);
                            }
                        });
                    });
                });

        });
    </script>


    <!-- 자바스크립트 코드 작성 영역 -->
    <script type="text/javascript">
        $(function() {
            var picker7 = new Lightpick({
                field: document.querySelector(".test7-1"), //설치대상1
                secondField: document.querySelector(".test7-2"), //설치대상2
                singleDate: false, //하루만 선택하는 모드를 해제
                format: "YYYY-MM-DD", //날짜의 표시 형식(momentJS 형식)
                firstDay: 7, //일요일부터 표시
                numberOfMonths: 4, //표시할 월의 수
                numberOfColumns: 2, //한줄에 표시할 월의 수
            });
        });
    </script>


</head>

<body>
    <header id="header">
        <div id="menuToggle">
            <i class="fa fa-bars"></i>
        </div>
        <div id="logo">
            <a href="#" class="notif-alert"> <i class="fa-solid fa-envelope email"></i></i> <span class="notif-count content">0</span>
            </a> <a href="#"><i class="fa-solid fa-circle-user user"></i></a>
        </div>
    </header>

    <aside id="sidebar">
        <nav id="menu">
            <div class="container">

                <!-- 이미지? -->


                <!-- 여기까지 이미지?-->


                <!--출퇴근-->
                <div id="commute-wrap">
                    <div id="date-wrap">
                        <span id="cur-date"></span><br> <span id="cur-time"></span>
                    </div>
                    <div id="start-time">
                        <i>출근 시간</i>
                        <!-- 출근 여부에 따른 표시 -->
                        <span id="start-time-display">미등록</span>
                    </div>
                    <div id="end-time">
                        <i>퇴근 시간</i>
                        <!-- 퇴근 여부에 따른 표시 -->
                        <span id="end-time-display">미등록</span>
                    </div>
                    <div id="attendance-btns">
                        <button id="start-btn" class="on">출근</button>
                        <button id="end-btn" class="on">퇴근</button>
                    </div>
                </div>
            </div>
            </div>
            <!-- 출퇴근 여기까지-->



            <!-- 사이드바-->
            <div class="row" style="display:initial !important;">
                <ul class="menu-hover-fill">
                    <li><a href="/home" data-text="home"> <i class="fa-solid fa-house-user"></i> HOME
                        </a></li>

                    <li><a href="#" data-text=""> <i class="fa-solid fa-file-signature"></i> 그룹웨어
                        </a>
                        <ul>
                            <li><a href="/vacation/mylist?loginId=${sessionScope.createdUser}">휴가신청서</a></li>
                            <li><a href="/report/mylist?loginId=${sessionScope.createdUser}">보고서</a></li>
                            <li><a href="/res/list">회의실 예약</a></li>
                        </ul>
                    </li>

                    <li><a href="/stock/list" data-text=""> <i class="fa-solid fa-cart-flatbed"> </i> 재고관리(emp)
                        </a>
                        <ul>
                            <li><a href="/stock/changeLogList">재고 변경 내역</a></li>
                            <li><a href="/stock/categoryQuantity">재고 그래프</a></li>
                        </ul>
                    </li>

                    <li><a href="/tb/list" data-text=""> <i class="fa-solid fa-people-group"> </i> 인사관리
                        </a></li>

                    <li><a href="/tb/mypage?loginId=${sessionScope.createdUser}" data-text=""> <i class="fa-solid fa-id-card"></i> mypage
                        </a></li>

                    <li><a href="/groupware/notice/noticList" data-text=""> <i class="fa-solid fa-comment"></i> 공지사항
                        </a></li>

                    <c:if test="${sessionScope.userType == 'A'}">
                        <li><a href="#" data-text=""> <i class="fa-solid fa-gears"></i> 관리자
                            </a>
                            <ul>
                                <li><a href="/admin/emp/list">사원조회</a></li>
                                <li><a href="/admin/emp/status">사원현황</a></li>
                                <li><a href="/admin/emp/approvalList">결재현황</a></li>
                                <li><a href="/admin/emp/hoursMgmt">사원근무기록 현황</a></li>
                            </ul>
                        </li>
                    </c:if>

                    <li><a href="/tb/logout" data-text=""> <i class="fa-solid fa-power-off"></i> 로그아웃
                        </a></li>
                </ul>
            </div>
            </div>
        </nav>
    </aside>

    <div id="content">

        <main id="body">
            <div id="content">


                <!-- 휴가 신청서 작성 -->

                <body>
                    <div class="container w-900">
                        <div class="title">휴가신청서</div>

                        <div class="table-container">
                            <table class="table">
                                <label>결재자</label>
                                <thead>
                                    <tr>
                                        <th>
                                            <c:choose>
                                                <c:when test="${tbEmpApprovalDto.approBosName == null}">
                                                    직급
                                                </c:when>
                                                <c:otherwise>
                                                    ${tbEmpApprovalDto.approBosName}
                                                </c:otherwise>
                                            </c:choose>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><img src="/vacation/signImage?approNo=${tbEmpVacaReqDto.approNo}&applicantId=${tbEmpVacaReqDto.applicantId}"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>


                        <div class="row">
                            <label>제목</label> <input type="text" class="form title1 disabled" name="vacaTitle" value="${tbEmpVacaReqDto.vacaTitle}" disabled>
                        </div>


                        <div class="row">
                            <label>사원명</label> <input type="text" class="filed form disabled" value="${tbEmpDto.name}" disabled>
                        </div>

                        <div class="row">
                            <div>
                                <label>사원번호</label> <input type="text" class="form disabled" value="${tbEmpDto.empNo}" disabled>
                            </div>
                            <div>
                                <label>직급</label> <input type="text" class="form disabled" name="empLevel" value="${tbEmpDto.empLevel}" disabled>
                            </div>
                            <div>
                                <label>부서</label> <input type="text" class="form disabled" name="empDept" value="${tbEmpDto.empDept}" disabled>
                            </div>
                        </div>

                        <div class="row">
                            <div>
                                <label>EMAIL</label> <input type="text" class="form disabled" name="empEmail" value="${tbEmpDto.empEmail}" disabled>
                            </div>
                            <div>
                                <label>비상 연락처</label> <input type="text" class="form disabled" placeholder="00011112222" name="vacaTel" value="${tbEmpVacaReqDto.vacaTel}" disabled>
                            </div>
                        </div>

                        <div class="row flex-box">
                            <div class="w-50">
                                <label>휴가 시작일</label> <input type="text" name="vacaSdate" class="field w-100 test7-1 form disabled" value="${tbEmpVacaReqDto.vacaSdate}" disabled>
                            </div>
                            <div class="w-50">
                                <label>휴가 종료일</label> <input type="text" name="vacaEdate" class="field w-100 test7-2 form disabled" value="${tbEmpVacaReqDto.vacaEdate}" disabled>
                            </div>
                        </div>
                        <div class="row">
                            <div>
                                <label>휴가 종류</label> <select class="form disabled hidden" disabled name="vacaType">
                                    <option value="" class="text-secondary">휴가 종류</option>
                                    <option value="개인사유" ${tbEmpVacaReqDto.vacaType=='개인사유' ? 'selected' : '' }>개인사유</option>
                                    <option value="연차" ${tbEmpVacaReqDto.vacaType=='연차' ? 'selected' : '' }>연차</option>
                                    <option value="병가" ${tbEmpVacaReqDto.vacaType=='병가' ? 'selected' : '' }>병가</option>
                                </select> <input class="form disabled" id="beforVacaType" value="${tbEmpVacaReqDto.vacaType}" disabled>
                            </div>
                        </div>

                        <div class="row flex-box" style="position: relative;">
                            <div>
                                <label>휴가 사유</label>
                                <textarea name="vacaReason" class="field w-100 form disabled" disabled rows="3" style="padding-right: 100px;">${tbEmpVacaReqDto.vacaReason}</textarea>
                                <!-- <button type="button" class="btn btn-positive">휴가신청</button> -->
								
								<c:if test="${tbEmpVacaReqDto.vacaReject != null}">
									<label>반려 사유</label>
									<textarea class="field w-100 form disabled" disabled rows="3" style="padding-right: 100px;">${tbEmpVacaReqDto.vacaReject}</textarea>
								</c:if>
								<c:if test="${tbEmpVacaReqDto.vacaReject == null}">
                                	<button type="button" class="btn btn-positive submit flex-core">수정</button>
								</c:if>
                            </div>
                        </div>
                    </div>

                    <!-- 이거도 전송해야댐 why? 수정위해서 -->
                    <input type="hidden" name="approNo" value="${tbEmpApprovalDto.approNo}">
                    <input type="hidden" name="approYN" value="${tbEmpApprovalDto.approYN}">
                    <input type="hidden" name="vacaNo" value="${tbEmpVacaReqDto.vacaNo}">
                </body>

                <!-- 이곳에서부터 <footer>  -->
            </div>
        </main>
</body>

</html>
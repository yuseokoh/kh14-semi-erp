<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>보고서 수정</title>

    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="/css/commons.css">

    <!-- 프로젝트 스타일 -->
    <link rel="stylesheet" type="text/css" href="/css/gotowork.css">
    <link rel="stylesheet" type="text/css" href="/css/sidebar.css">
    <!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
    <link rel="stylesheet" type="text/css" href="/css/vacation.css">
    <!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
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

        .title1 {
            width: 70% !important;
            height: 40px;
            margin-right: 40%
        }

        /* 체크박스와 텍스트 사이의 여백 추가 */
        #preview li input[type="checkbox"] {
            width: auto;
            /* 기본 너비로 설정 */
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
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
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
            // 초기에 textarea 숨기기
            $('#preview').addClass('show').prop('disabled', true);
            $('.reason-textarea').addClass('hidden').prop('disabled', true);
            // 수정 버튼 클릭 시 동작
            $('.btn-positive').on(
                'click',
                function() {
                    // textarea를 보이게 하고 수정할 수 있도록 설정
                    $('#preview').removeClass('show').addClass('hidden');
                    $('.reason-textarea').removeClass('hidden').prop(
                        'disabled', false);
                    // 버튼 텍스트와 스타일 변경
                    $(this).text('수정완료').removeClass('btn-positive').addClass(
                        'btn-warning');
                    $('.btn-warning').on(
                        'click',
                        function() {

                            var reportContent = $('.reason-textarea').val();
                            // 								console.log(reportContent);
                            // 								$('.reason-textarea').addClass('hidden').prop(
                            // 										'disabled', true);
                            // 								$('#preview').removeClass('hidden').addClass(
                            // 										'show').prop('disabled', true);
                            // 								$(this).text('수정완료').addClass('hidden');

                            //비동기통신해서 내용만 바꾸기
                            $.ajax({
                                url: '/rest/report/update', // 요청할 URL
                                type: 'POST', // 요청 방법 (GET, POST, PUT, DELETE 등)
                                data: { // 서버에 보낼 데이터 (필요에 따라 JSON, 폼 데이터 등)
                                    reportContent: reportContent,
                                    approNo: $('[name=approNo]').val(),
                                    approYN: $('[name=approYN]').val(),
                                    reportNo: $('[name=reportNo]').val(),
                                    reportTitle: $('[name=reportTitle]').val(),
                                },
                                success: function(response) { // 요청이 성공했을 때 호출되는 함수
                                    if (response) {
                                        Swal.fire({
                                            title: '수정 완료',
                                            text: '수정이 완료되었습니다.',
                                            icon: 'success',
                                            timer: 1500,
                                            timerProgressBar: true,
                                            didOpen: () => {
                                                Swal.showLoading();
                                            },
                                            willClose: () => {
                                                location.reload();
                                            },
                                            customClass: {
                                                title: 'custom-title',
                                                popup: 'custom-background',
                                                confirmButton: 'custom-button'
                                            }
                                        });
                                    } else {
                                        Swal.fire({
                                            title: '수정 실패',
                                            text: '이미 서명된 페이지입니다.',
                                            icon: 'error',
                                            timer: 1500,
                                            timerProgressBar: true,
                                            didOpen: () => {
                                                Swal.showLoading();
                                            },
                                            willClose: () => {
                                                location.href = '/report/mylist?loginId=${sessionScope.createdUser}';
                                            },
                                            customClass: {
                                                title: 'custom-title',
                                                popup: 'custom-background',
                                                confirmButton: 'custom-button'
                                            }
                                        });
                                    }
                                },
                                error: function(xhr, status, error) {
                                    Swal.fire({
                                        title: '오류',
                                        text: '서버 요청 중 오류가 발생했습니다.',
                                        icon: 'error',
                                        timer: 1500,
                                        timerProgressBar: true
                                    });
                                }

                            });
                        });

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
            <a href="#" class="notif-alert"> <i class="fa-solid fa-envelope email"></i> <span class="notif-count content">0</span>
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



                <!-- 보고서 수정 -->
                <div class="container w-900">
                    <div class="title">일일 업무 보고서</div>

                    <div class="table-container">
                        <table class="table form">
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
                                    <td><img src="/report/signImage?approNo=${tbEmpReportDto.approNo}&writerId=${tbEmpReportDto.writerId}"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <label>제목</label> <input type="text" name="reportTitle" class="form title1" value="${tbEmpReportDto.reportTitle}">
                    </div>

                    <div class="row">
                        <label>사원명</label> <input type="text" class="filed form " value="${tbEmpReportDto.writerName}" readonly>
                    </div>

                    <div class="row">
                        <div>
                            <label>사원번호</label> <input type="text" class="form " value="${tbEmpDto.empNo}" readonly>
                        </div>
                        <div>
                            <label>직급</label> <input type="text" class="form " value="${tbEmpDto.empLevel}" readonly>
                        </div>
                        <div>
                            <label>부서</label> <input type="text" class="form " value="${tbEmpReportDto.writerDept}" readonly>

                        </div>
                    </div>

                    <!-- 이거도 전송해야댐 why? 수정위해서 -->
                    <input type="hidden" name="approNo" value="${tbEmpApprovalDto.approNo}">
                    <input type="hidden" name="approYN" value="${tbEmpApprovalDto.approYN}">
                    <input type="hidden" name="reportNo" value="${tbEmpReportDto.reportNo}">

                    <div class="row flex-box btn-container" style="justify-content: space-between;">
                        <textarea id="markdown" class="field w-100 form reason-textarea hidden" rows="3" style="padding-right: 100px;">${tbEmpReportDto.reportContent}</textarea>
                        <div id="preview"></div>
                        <c:if test="${tbEmpReportDto.reportReject != null}">
                            <label>반려 사유</label>
                            <textarea class="field w-100 form disabled" disabled rows="3" style="padding-right: 100px;">${tbEmpReportDto.reportReject}</textarea>
                        </c:if>
                        <c:if test="${tbEmpReportDto.reportReject == null}">
                            <button type="button" class="btn btn-positive submit flex-core">수정</button>
                        </c:if>
                    </div>
                </div>
            </div>


            <footer id="footer">
                <!-- Footer content here -->
            </footer>
            <script type="text/javascript">
                document.addEventListener('DOMContentLoaded', function() {
                    const textarea = document.getElementById('markdown');
                    const preview = document.getElementById('preview');

                    function updatePreview() {
                        const markdownText = textarea.value;
                        preview.innerHTML = marked.parse(markdownText);
                    }

                    textarea.addEventListener('input', updatePreview);
                    updatePreview(); // 초기 렌더링
                });
            </script>
</body>

</html>
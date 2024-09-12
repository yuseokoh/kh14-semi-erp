<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>보고서 반려 / 기안</title>
    <script type="text/javascript">
		var contextPath = "${pageContext.request.contextPath}";
	</script>
    <!-- google font cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <!-- font awesome icon cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <!-- my css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons.css">

    <!-- 프로젝트 스타일 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/gotowork.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sidebar.css">
    <!-- <link rel="stylesheet" type="text/css" href="./notic.css"> -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vacation.css">
    <!-- <link rel="stylesheet" type="text/css" href="./attendancelist.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./attcommons.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./myStatus.css"> -->
    <!-- <link rel="stylesheet" type="text/css" href="./commons1.css"> -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/alertA.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/alertBtn.css">

    <style>
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

        .hidden {
            display: none;
        }

        .btn-container {
            position: relative;
            margin-top: 10px;
        }

        .btn-container .btn {
            position: absolute;
            bottom: -40px;
            right: 15px;
        }

        .btn-warning {
            background-color: #f39c12;
            color: white;
            margin-bottom: 40px;
            border: 1px solid #ff9d00 !important;
            border-radius: 0.2em;
        }

        .btn-positive {
            background-color: #99c2ff !important;
            color: white;
            margin-bottom: 40px;
            border-radius: 0.2em;
            border: 1px solid #cde1ff !important;
        }

        .btn-positive:hover {
            background-color: #dde6f3 !important;
            color: #66a2fc;
        }

        .btn-warning:hover {
            background-color: #fae7ca;
            color: #f39c12;
        }

        .reject {
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            padding: 0.5em 0.75em;
            color: #2d3436;
            background-color: #dfe6e9;
            border: 1px solid #2d3436;
            border-radius: 0.2em;
            cursor: pointer;
            text-align: center;
            line-height: 1.2;
            border-color: #636e72;
            background-color: #636e72;
            color: white;
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
    </style>
    <!-- lightpick cdn -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
    <!-- jquery cdn -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/checkbox.js"></script>
    <script src="${pageContext.request.contextPath}/js/confirm-link.js"></script>
    <script src="${pageContext.request.contextPath}/js/multipage.js"></script>
    <!-- 프로젝트 js-->
    <script src="${pageContext.request.contextPath}/js/gotoworkbtn.js"></script>
    <script src="${pageContext.request.contextPath}/js/menuToggle.js"></script>
    <!-- <script src="delete.js"></script> -->
    <!-- chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- SweetAlert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- 전자 서명 -->
    <script type="text/javascript">
        $(function() {

            //여기서 정리를 해야할거 같은데 어떻게할지.. 아마 이걸로 정리해야할 듯
            if (document.getElementById("canvas")) {
                var canvas = document.getElementById("canvas");
                var context = canvas.getContext("2d");
                var clearButton = document.getElementById("clearButton");
                var signatureImage = document.getElementById("signatureImage");

                var drawing = false;

                canvas.addEventListener("mousedown", () => {
                    drawing = true;
                    context.beginPath();
                });

                canvas.addEventListener("mousemove", (event) => {
                    if (!drawing) return;

                    var x = event.clientX - canvas.getBoundingClientRect().left;
                    var y = event.clientY - canvas.getBoundingClientRect().top;
                    context.lineTo(x, y);
                    context.stroke();
                });

                canvas.addEventListener("mouseup", () => {
                    drawing = false;
                    context.closePath();
                });

                clearButton.addEventListener("click", () => {
                    context.clearRect(0, 0, canvas.width, canvas.height);
                });



            } else {
                $('#clearButton').hide();
            }
        });
    </script>





    <!-- 자바스크립트 코드 작성 영역 -->
    <script type="text/javascript">
        $(function() {

            const approNo = $('[name=approNo]').val();

            // 초기에 textarea 숨기기
            $('#preview').addClass('show').prop('disabled', true);
            $('.reason-textarea').addClass('hidden').prop('disabled', true);

            // 반려 버튼 클릭 시 동작
            $('#reject').on('click', function() {
                // 휴가 사유 라벨을 반려 사유 라벨로 변경
                $('.reason-label').text('반려 사유');

                // id=preview 숨기고 반려 사유 textarea 보이기
                $('#preview').addClass('hidden').prop('disabled', true);
                $('.reject-reason-textarea').removeClass('hidden').prop('disabled', false);

                // 반려 버튼을 숨기고 반려완료 버튼만 보이도록 설정
                $(this).hide();
                $('#rejectComplete').removeClass('hidden');
                $('.submit').addClass('hidden'); // 기안 버튼 숨기기
            });

            // 반려완료 버튼 클릭 시 동작
            $('#rejectComplete').on('click', function() {
                var signatureDataURL = canvas.toDataURL("image/png");
                signatureImage.src = signatureDataURL;
                const isConfirmed = window.confirm('정말로 반려하시겠습니까?');

                if (!$('.reject-reason-textarea').hasClass('hidden')) {
                    const rejectReason = $('.reject-reason-textarea').val();

                    if (rejectReason && isConfirmed) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/rest/document/sign",
                            method: "POST",
                            data: {
                                signatureDataURL: signatureDataURL,
                                rejectReason: rejectReason,
                                approNo: approNo
                            },
                            success: function(response) {
                                Swal.fire({
                                    title: '저장 완료',
                                    text: '서명이 저장되었습니다.',
                                    icon: 'success',
                                    timer: 1500,
                                    timerProgressBar: true,
                                    customClass: {
                                        title: 'custom-title',
                                        popup: 'custom-background',
                                        confirmButton: 'custom-button'
                                    }
                                }).then(() => {
                                    $.ajax({
                                        url: "${pageContext.request.contextPath}/rest/report/reject",
                                        method: "POST",
                                        data: {
                                            rejectReason: rejectReason,
                                            approNo: approNo
                                        },
                                        success: function() {
                                            location.reload();
                                        }
                                    });
                                });
                            }
                        });
                    } else {
                        Swal.fire({
                            title: '입력 오류',
                            text: '반려 사유를 입력해 주세요.',
                            icon: 'warning',
                            customClass: {
                                title: 'custom-title',
                                popup: 'custom-background',
                                confirmButton: 'custom-button'
                            }
                        });
                    }
                }
            });


            // 기안 버튼 클릭 시 동작
            $(".submit").on("click", function() {
                var signatureDataURL = canvas.toDataURL("image/png");
                signatureImage.src = signatureDataURL;

                $.ajax({
                    url: "${pageContext.request.contextPath}/rest/document/sign",
                    method: "POST",
                    data: {
                        signatureDataURL: signatureDataURL,
                        approNo: approNo
                    },
                    success: function(response) {
                        Swal.fire({
                            title: '저장 완료',
                            text: '서명이 저장되었습니다.',
                            icon: 'success',
                            timer: 2500,
                            timerProgressBar: true,
                            customClass: {
                                title: 'custom-title',
                                popup: 'custom-background',
                                confirmButton: 'custom-button'
                            }
                        }).then(() => {
                            // 서명이 저장된 후 페이지를 새로 고침합니다
                            window.location.reload();
                        });
                    }
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
            <a href="#" class="notif-alert"> <i class="fa-solid fa-envelope email"></i>
                <span class="notif-count content">0</span>
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
			<div class="row" style="display: initial !important;">
				<ul class="menu-hover-fill">
					<li><a href="${pageContext.request.contextPath}/home"
						data-text="home"> <i class="fa-solid fa-house-user"></i> HOME
					</a></li>

					<li><a href="#" data-text=""> <i
							class="fa-solid fa-file-signature"></i> 그룹웨어
					</a>
						<ul>
							<li><a
								href="${pageContext.request.contextPath}/vacation/mylist?loginId=${sessionScope.createdUser}">휴가신청서</a></li>
							<li><a
								href="${pageContext.request.contextPath}/report/mylist?loginId=${sessionScope.createdUser}">보고서</a></li>
							<li><a href="${pageContext.request.contextPath}/res/list">회의실
									예약</a></li>
						</ul></li>

					<li><a href="${pageContext.request.contextPath}/stock/list"
						data-text=""> <i class="fa-solid fa-cart-flatbed"> </i>
							재고관리(emp)
					</a>
						<ul>
							<li><a
								href="${pageContext.request.contextPath}/stock/changeLogList">재고
									변경 내역</a></li>
							<li><a
								href="${pageContext.request.contextPath}/stock/categoryQuantity">재고
									그래프</a></li>
						</ul></li>

					<li><a href="${pageContext.request.contextPath}/tb/list"
						data-text=""> <i class="fa-solid fa-people-group"> </i> 인사관리
					</a></li>

					<li><a
						href="${pageContext.request.contextPath}/tb/mypage?loginId=${sessionScope.createdUser}"
						data-text=""> <i class="fa-solid fa-id-card"></i> mypage
					</a></li>

					<li><a
						href="${pageContext.request.contextPath}/groupware/notice/noticList"
						data-text=""> <i class="fa-solid fa-comment"></i> 공지사항
					</a></li>

					<c:if test="${sessionScope.userType == 'A'}">
						<li><a href="#" data-text=""> <i
								class="fa-solid fa-gears"></i> 관리자
						</a>
							<ul>
								<li><a
									href="${pageContext.request.contextPath}/admin/emp/list">사원조회</a></li>
								<li><a
									href="${pageContext.request.contextPath}/admin/emp/status">사원현황</a></li>
								<li><a
									href="${pageContext.request.contextPath}/admin/emp/approvalList">결재현황</a></li>
								<li><a
									href="${pageContext.request.contextPath}/admin/emp/hoursMgmt">사원근무기록
										현황</a></li>
							</ul></li>
					</c:if>

					<li><a href="${pageContext.request.contextPath}/tb/logout"
						data-text=""> <i class="fa-solid fa-power-off"></i> 로그아웃
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
                                    <td>
                                        <c:choose>
                                            <c:when test="${tbEmpApprovalDto.approBosName != null && tbEmpApprovalDto.approBosId != null}">
                                                <!-- 서명 이미지가 있는 경우 -->
                                                <img src="${pageContext.request.contextPath}/report/signImage?approNo=${tbEmpReportDto.approNo}&writerId=${tbEmpReportDto.writerId}">
                                            </c:when>
                                            <c:otherwise>
                                                <!-- 서명 할 공간 보여주기 -->
                                                <canvas id="canvas" width="200" height="200" style="border: 1px solid black"></canvas>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                        <button id="clearButton">초기화</button>
                    </div>
                    <div class="row">
                        <label>제목</label> <input type="text" name="reportTitle" class="form title1" value="${tbEmpReportDto.reportTitle}" readonly>
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




                    <div class="row flex-box btn-container" style="justify-content: space-between;">
                        <div>
                            <label class="reason-label">금일 목표</label>

                            <textarea id="markdown" class="field w-100 form reason-textarea hidden" rows="3" style="padding-right: 100px;">${tbEmpReportDto.reportContent}</textarea>
                            <div id="preview"></div>
                            <textarea class="field w-100 form hidden reject-reason-textarea" disabled rows="3" style="padding-right: 100px;" placeholder="반려 사유를 입력하세요."></textarea>
                            <c:if test="${tbEmpReportDto.reportReject != null}">
                            	<label>반려 사유</label>
                            	<textarea class="field w-100 form disabled" disabled rows="3" style="padding-right: 100px;">${tbEmpReportDto.reportReject}</textarea>
                        	</c:if>
                            <c:if test="${tbEmpApprovalDto.approBosName == null || tbEmpApprovalDto.approBosId == null}">
                                <button type="button" id="reject" class="reject flex-core">반려</button>
								<button type="button" class="flex-core btn-warning hidden" id="rejectComplete" style="padding:0.5em 0.75em;">반려완료</button>
                                <button type="button" class="btn btn-positive submit flex-core">기안</button>
                            </c:if>
                        </div>
                    </div>
                </div>

                <input type="hidden" name="approNo" value="${tbEmpApprovalDto.approNo}">
                <img id="signatureImage" style="display: none;">

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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>휴가 반려 / 승인</title>
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
<!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->

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
.disabled, .form[disabled] {
	background-color: #f0f0f0;
	color: #a0a0a0;
	cursor: not-allowed;
	border-color: #d0d0d0;
}

.disabled:focus, .form[disabled]:focus {
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
	border-radius: 0.2em;
	margin-bottom: 40px;
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
	/* 밑줄 제거 */
	display: inline-block;
	/* 한줄에 여러개 배치 + 폭 설정 가능하게 */
	font-size: 16px;
	/* 입력창과 동일하게 */
	padding: 0.5em 0.75em;
	/*입력창과 동일하게*/
	color: #2d3436;
	background-color: #dfe6e9;
	border: 1px solid #2d3436;
	border-radius: 0.2em;
	cursor: pointer;
	/* 커서모양 변경 */
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
</style>

<!-- lightpick cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/checkbox.js"></script>
<script src="${pageContext.request.contextPath}/js/confirm-link.js"></script>
<script src="${pageContext.request.contextPath}/js/multipage.js"></script>
<!-- 프로젝트 js-->
<script src="${pageContext.request.contextPath}/js/gotoworkbtn.js"></script>
<script src="${pageContext.request.contextPath}/js/menuToggle.js"></script>
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
            var picker7 = new Lightpick({
                field: document.querySelector(".test7-1"), //설치대상1
                secondField: document.querySelector(".test7-2"), //설치대상2
                singleDate: false, //하루만 선택하는 모드를 해제
                format: "YYYY-MM-DD", //날짜의 표시 형식(momentJS 형식)
                firstDay: 7, //일요일부터 표시
                numberOfMonths: 4, //표시할 월의 수
                numberOfColumns: 2, //한줄에 표시할 월의 수
            });


            const approNo = $('[name=approNo]').val();

            // 반려 버튼 클릭 시 동작
            $('.reject').on('click', function() {
                // 휴가 사유 라벨을 반려 사유 라벨로 변경
                $('.reason-label').text('반려 사유');

                // 휴가 사유 textarea 숨기고 반려 사유 textarea 보이기
                $('.reason-textarea').addClass('hidden').prop('disabled', true);
                $('.reject-reason-textarea').removeClass('hidden').prop('disabled', false);

                // 휴가신청 버튼을 수정완료 버튼으로 변경
                $(this).hide();
                $('#rejectComplete').removeClass('hidden');
                $('.submit').addClass('hidden'); // 기안 버튼 숨기기
            });





            // 반려완료 버튼 클릭 시 동작
            $('#rejectComplete').on('click', function() {
                var signatureDataURL = canvas.toDataURL("image/png");
                signatureImage.src = signatureDataURL;
                const isConfirmed = window.confirm('정말로 반려하시겠습니까?');

                // textarea가 제대로 표시되고 있는지 확인
                if (!$('.reject-reason-textarea').hasClass('hidden')) {
                    const rejectReason = $('.reject-reason-textarea').val(); // 입력값

                    if (isConfirmed && rejectReason != null) { // 확인을 눌렀고 반려 사유가 입력된 경우
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
                                        url: "${pageContext.request.contextPath}/rest/vacation/reject",
                                        method: "POST",
                                        data: {
                                            rejectReason: rejectReason,
                                            approNo: approNo
                                        },
										success: function() {
										    location.reload(); // 페이지 새로고침
										}
                                    });
                                });
                            }
                        });
                    } else { // 반려 사유가 입력되지 않은 경우
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
                        // 첫 번째 AJAX 요청이 성공한 후
                        $.ajax({
                            url: "${pageContext.request.contextPath}/rest/vacation/deducted",
                            method: "POST",
                            data: {
                                approNo: approNo
                            },
                            success: function(response) {
                                Swal.fire({
                                	title: '저장했습니다',
                                    icon: 'success',
                                    timer: 1500, // 1500ms (1.5초) 후에 자동으로 닫힘
                                    timerProgressBar: true, // 타이머 진행 바 표시
                                    willClose: () => {
                                        // 타이머가 끝난 후 페이지 새로 고침
                                        window.location.reload();
                                    }
                                });
                            }
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

				<!--휴가신청서작성-->

				<div class="container w-900">
					<div class="title">휴가신청서</div>

					<div class="table-container">
						<table class="table">
							<label>결재자</label>
							<thead>
								<tr>
									<th><c:choose>
											<c:when test="${tbEmpApprovalDto.approBosName == null}">
                                                직급
                                            </c:when>
											<c:otherwise>
                                                ${tbEmpApprovalDto.approBosName}
                                            </c:otherwise>
										</c:choose></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:choose>
											<c:when test="${tbEmpApprovalDto.approBosName != null && tbEmpApprovalDto.approBosId != null}">
												<!-- 서명 이미지가 있는 경우 -->
												<img src="${pageContext.request.contextPath}/vacation/signImage?approNo=${tbEmpVacaReqDto.approNo}&applicantId=${tbEmpVacaReqDto.applicantId}">
											</c:when>
											<c:otherwise>
												<!-- 서명 할 공간 보여주기 -->
												<canvas id="canvas" width="200" height="200" style="border: 1px solid black"></canvas>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</tbody>
						</table>
						<button id="clearButton">초기화</button>
					</div>

					<div class="row">
						<label>제목</label> <input type="text" class="form title1 disabled" disabled value="${tbEmpVacaReqDto.vacaTitle}">
					</div>
					<div class="row">
						<label>사원명</label> <input type="text" class="filed form disabled" value="${tbEmpDto.name}" disabled>
					</div>

					<div class="row">
						<div>
							<label>사원번호</label> <input type="text" class="form disabled" value="${tbEmpDto.empNo}" disabled>
						</div>
						<div>
							<label>직급</label> <input type="text" class="form disabled" value="${tbEmpDto.empLevel}" disabled>
						</div>
						<div>
							<label>부서</label> <input type="text" class="form disabled" value="${tbEmpDto.empDept}" disabled>
						</div>
					</div>

					<div class="row">
						<div>
							<label>EMAIL</label> <input type="text" class="form disabled" value="${tbEmpDto.empEmail}" disabled>
						</div>
						<div>
							<label>비상 연락처</label> <input type="text" class="form disabled" value="${tbEmpVacaReqDto.vacaTel}" disabled>
						</div>
					</div>

					<div class="row flex-box">
						<div class="w-50">
							<label>휴가 시작일</label> <input type="text" disabled class="field w-100 test7-1 form disabled" value="${tbEmpVacaReqDto.vacaSdate}">
						</div>
						<div class="w-50">
							<label>휴가 종료일</label> <input type="text" disabled class="field w-100 test7-2 form disabled" value="${tbEmpVacaReqDto.vacaEdate}">
						</div>
					</div>

					<div class="row">
						<div>
							<label>휴가 종류</label> <input type="text" class="form disabled" value="${tbEmpVacaReqDto.vacaType}" disabled>
						</div>
					</div>

					<div class="row flex-box btn-container" style="justify-content: space-between;">
						<div>
							<label class="reason-label">휴가 사유</label>
							<textarea class="field w-100 form reason-textarea" disabled rows="3" style="padding-right: 100px;">${tbEmpVacaReqDto.vacaReason}</textarea>
							<textarea class="field w-100 form hidden reject-reason-textarea" name="rejectReason" disabled rows="3" style="padding-right: 100px;" placeholder="반려 사유를 입력하세요."></textarea>
							<c:if test="${tbEmpVacaReqDto.vacaReject != null}">
									<label>반려 사유</label>
									<textarea class="field w-100 form disabled" disabled rows="3" style="padding-right: 100px;">${tbEmpVacaReqDto.vacaReject}</textarea>
							</c:if>
							<c:if test="${tbEmpApprovalDto.approBosName == null || tbEmpApprovalDto.approBosId == null}">
								<button type="button" id="reject" class="reject flex-core">반려</button>
								<button type="button" class="flex-core btn-warning hidden" id="rejectComplete" style="padding: 0.5em 0.75em;">반려완료</button>
								<button type="button" class="btn btn-positive submit flex-core">휴가 승인</button>
							</c:if>
						</div>
					</div>
				</div>


				<input type="hidden" name="approNo" value="${tbEmpApprovalDto.approNo}"> <img id="signatureImage" style="display: none;">
		</main>
	</div>
</body>

</html>
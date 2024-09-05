<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세보기</title>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- Summernote CDN -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

<!-- Google Fonts & Font Awesome -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<!-- Project CSS -->
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<link rel="stylesheet" type="text/css" href="/css/gotowork.css">
<link rel="stylesheet" type="text/css" href="/css/sidebar.css">
<link rel="stylesheet" type="text/css" href="/css/vacation.css">
<link rel="stylesheet" type="text/css" href="/editor/editor.css">

<!-- Custom Styles -->
<style>
    .title1 {
        width: 60% !important;
        height: 40px;
        margin-right: 40%;
    }
    .title2 {
        border: 1px solid;
        border-radius: 6px;
        margin-bottom: 25px;
        padding: .60rem 1.25rem;
        background-color: gainsboro;
        border-color: #fff;
        color: #495057;
        font-weight: 800;
        text-align: center !important;
        width: 98%; 
        box-sizing: border-box;
    }
    .readonly {
        background-color: #f0f0f0; 
        border: 1px solid #ccc;
        pointer-events: none;
    }
    .reply-wrapper {
        display: flex;
    }
    .reply-wrapper > .image-wrapper {
        width: 100px;
        min-width: 100px;
        padding: 10px;
    }
    .reply-wrapper > .image-wrapper > img {
        width: 100%;
    }
    .reply-wrapper > .content-wrapper {
        flex-grow: 1;
        font-size: 16px;
    }
    .reply-wrapper > .content-wrapper > .reply-title {
        font-size: 1.25em;
    }
    .reply-wrapper > .content-wrapper > .reply-content {
        font-size: 0.95em;
        min-height: 50px;
    }
    .reply-wrapper > .content-wrapper > .reply-info {
        font-size: 0.85em;
        color: #666;
    }
    .fa-heart {
        color: red;
        cursor: pointer;
    }
</style>

<!-- jQuery CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- Custom JS -->
<script src="/js/checkbox.js"></script>
<script src="/js/confirm-link.js"></script>
<script src="/js/multipage.js"></script>
<script src="/js/gotoworkbtn.js"></script>
<script src="/js/menuToggle.js"></script>
<script src="/js/delete.js"></script>

<!-- Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">
    $(function() {
        var editorOptions = {
            height: 120,
            minHeight: 120,
            toolbar: [
                ['font', ['style', 'fontname', 'fontsize', 'forecolor', 'backcolor']]
            ],
            disableDragAndDrop: true,
            callbacks: {
                onImageUpload: function(files) {},
                onKeydown: function() {},
                onKeyup: function() {
                    var content = $(this).val();
                    var byteCount = getByteLength(content);
                    console.log("바이트 : " + byteCount);
                },
            },
        };

        function getByteLength(str) {
            let byteLength = 0;
            for (let i = 0; i < str.length; i++) {
                const charCode = str.charCodeAt(i);
                if (charCode <= 0x7F) {
                    byteLength += 1;  
                } else if (charCode <= 0x7FF) {
                    byteLength += 2;  
                } else if (charCode <= 0xFFFF) {
                    byteLength += 3;  
                } else {
                    byteLength += 4;  
                }
            }
            return byteLength;
        }

        // 댓글 등록
        $(".reply-add-btn").click(function() {
            var content = $(".reply-input").val();
            if (content.length == 0) return;
            $.ajax({
                url: "/rest/reply/write",
                method: "post",
                data: {
                    replyContent: content,
                    replyOrigin: noticeNo
                },
                success: function(response) {
                    $('.reply-input').summernote('code', '');
                    loadList();
                }
            });
        });

        // 댓글 목록 처리
        loadList();
        function loadList(page = 1) {
            $.ajax({
                url: "/rest/reply/list/paging",
                method: "post",
                data: {
                    replyOrigin: noticeNo,
                    page: page
                },
                success: function(response) {
                    var backup = null;
                    if (page >= 2) {
                        backup = $(".reply-list-wrapper").html();
                    }
                    $(".reply-list-wrapper").empty();
                    if (response.currentPage < response.totalPage) {
                        $("<button>").addClass("btn btn-neutral w-100 my-20 btn-more")
                            .text("이전 댓글 더 보기 (" + (response.currentPage + 1) + " / " + response.totalPage + ")")
                            .attr("data-page", page + 1)
                            .appendTo(".reply-list-wrapper");
                    }
                    var list = response.list;
                    for (var i = 0; i < list.length; i++) {
                        var template = $("#reply-template").text();
                        var html = $.parseHTML(template);
                        $(html).find(".image-wrapper").children("img")
                            .attr("src", "/member/image?memberId=" + list[i].replyWriter);
                        $(html).find(".reply-title").text(list[i].replyWriter);
                        $(html).find(".reply-content").html(list[i].replyContent);
                        var time = moment(list[i].replyWtime).fromNow();
                        $(html).find(".reply-info > .time").text(time);
                        if (list[i].replyWriter == currentUser) {
                            $(html).find(".reply-edit-btn, .reply-delete-btn")
                                .attr("data-reply-no", list[i].replyNo);
                        } else {
                            $(html).find(".reply-edit-btn, .reply-delete-btn").remove();
                        }
                        $(".reply-list-wrapper").append(html);
                    }
                    if (page >= 2) {
                        $(".reply-list-wrapper").append(backup);
                    }
                }
            });
        }

        $(document).on("click", ".reply-delete-btn", function(e) {
            e.preventDefault();
            var choice = window.confirm("정말 삭제하시겠습니까?");
            if (choice == false) return;
            var replyNo = $(this).attr("data-reply-no");
            $.ajax({
                url: "/rest/reply/delete",
                method: "post",
                data: { replyNo: replyNo },
                success: function(response) {
                    loadList();
                },
            });
        });

        $(document).on("click", ".reply-edit-btn", function(e) {
            e.preventDefault();
            $(".reply-wrapper").show();
            $(".reply-edit-wrapper").remove();
            var template = $("#reply-edit-template").text();
            var html = $.parseHTML(template);
            $(this).parents(".reply-wrapper").after(html);
            $(this).parents(".reply-wrapper").hide();
            var src = $(this).parents(".reply-wrapper").find(".image-wrapper > img").attr("src");
            $(html).find(".image-wrapper > img").attr("src", src);
            var replyWriter = $(this).parents(".reply-wrapper").find(".reply-title").text();
            $(html).find(".reply-title").text(replyWriter);
            var replyContent = $(this).parents(".reply-wrapper").find(".reply-content").text();
            $(html).find(".reply-edit-input").val(replyContent);
            var replyNo = $(this).attr("data-reply-no");
            $(html).find(".reply-edit-btn").attr("data-reply-no", replyNo);
            $(".reply-edit-wrapper").find(".reply-edit-input").summernote(editorOptions);
        });

        $(document).on("click", ".reply-edit-save-btn", function(e) {
            e.preventDefault();
            var replyContent = $(".reply-edit-input").val();
            var replyNo = $(this).attr("data-reply-no");
            $.ajax({
                url: "/rest/reply/edit",
                method: "post",
                data: {
                    replyContent: replyContent,
                    replyNo: replyNo
                },
                success: function(response) {
                    $(".reply-edit-wrapper").remove();
                    loadList();
                }
            });
        });

        $(document).on("click", ".reply-edit-cancel-btn", function(e) {
            e.preventDefault();
            $(".reply-edit-wrapper").remove();
            $(".reply-wrapper").show();
        });
    });
</script>

<!-- Templates for Reply and Reply Edit -->
<script type="text/template" id="reply-template">
    <div class="reply-wrapper">
        <div class="image-wrapper">
            <img src="" alt="Profile Image">
        </div>
<<<<<<< HEAD
    </header>

    <aside id="sidebar">
        <nav id="menu">
            <div class="container" >

   <!-- 이미지? -->
        

<!-- 여기까지 이미지?-->


				<!--출퇴근-->
				<div id="commute-wrap">
					<div id="date-wrap">
						<span id="cur-date"></span><br>
						<span id="cur-time"></span>
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
                <div class="row">
                    <ul class="menu-hover-fill">
                        <li><a href="/" data-text="home">HOME</a></li>

                        <li><a href="/poketmon/list" data-text="">
                            <i class="fa-solid fa-file-signature"></i> 그룹웨어(poketmon) </a>
                            <ul>
                                <li><a href="#">휴가신청서</a></li>
                                <li><a href="#">보고서(수인씨작성중)</a></li>
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
=======
        <div class="content-wrapper">
            <div class="reply-title"></div>
            <div class="reply-content"></div>
            <div class="reply-info">
                <span class="time"></span>
                <i class="fa fa-heart"></i>
                <button class="reply-edit-btn">Edit</button>
                <button class="reply-delete-btn">Delete</button>
>>>>>>> refs/remotes/origin/main
            </div>
<<<<<<< HEAD
        </nav>
    </aside>
    
    <div id="content">
        
       <main id="body"> 
           <div id="content">






<div class="container w-900">
    <!-- 제목 -->
  <div class="title2">
      ${noticeDto.noticeTitle}
            <c:if test="${noticeDto.noticeUtime != null}">
                (수정됨)
            </c:if></div>


    <!-- 작성자 -->
    <div class="row flex-box user1 readonly" readonly style="margin-top: 20px;">
    <div class="row">
       
        ${noticeDto.noticeWriterString}
=======
        </div>
>>>>>>> refs/remotes/origin/main
    </div>
<<<<<<< HEAD
    </div>

    <!-- 작성일 -->
    <div class="row right readonly creation "  readonly>
        <fmt:formatDate value="${noticeDto.noticeWtime}" 
                                    pattern="y년 M월 d일 E a h시 m분 s초"/>
    </div>
    <!-- 내용 -->
    <div class="row readonly"  style="min-height:200px" readonly>
        <!-- pre 태그는 내용을 작성된 형태 그대로 출력한다
                Rich Text Editor를 쓸 경우는 할 필요가 없다 -->
        ${noticeDto.noticeCont}
    </div>
	<!-- 정보 -->
	<div class="row">
		조회 
		<fmt:formatNumber value="${noticeDto.noticeViews}"
										pattern="#,##0"/>
		
	</div>
	

	
	<!-- 각종 이동버튼들 -->
	<div class="row left">
		<a class="btn btn-positive" href="noticInsert">글쓰기</a>
		
		<%-- 본인 글만 표시되도록 조건 설정 --%>
		<c:set var="isAdmin" value="${sessionScope.createdLevel == '관리자'}"/>
		<c:set var="isLogin" value="${sessionScope.createdUser != null}"/>
		<c:set var="isOwner" value="${sessionScope.createdUser == noticeDto.noticeWriter}"/>
		
		<c:if test="${isLogin}">
			<c:if test="${isOwner}">
				<a class="btn btn-negative btn-edit " href="noitcEdit?noticeNo=${noticeDto.noticeNo}" >수정</a>
			</c:if>
			<c:if test="${isOwner || isAdmin}">
				<a class="btn btn-negative btn-delete"  href="delete?noticeNo=${noticeDto.noticeNo}">삭제</a>
			</c:if>
		</c:if>
		
		<a class="btn btn-neutral" href="noticList">목록</a>

	</div>
</div>
=======
</script>

<script type="text/template" id="reply-edit-template">
    <div class="reply-edit-wrapper">
        <div class="image-wrapper">
            <img src="" alt="Profile Image">
        </div>
        <div class="content-wrapper">
            <div class="reply-title"></div>
            <textarea class="reply-edit-input"></textarea>
            <button class="reply-edit-save-btn">Save</button>
            <button class="reply-edit-cancel-btn">Cancel</button>
        </div>
    </div>
</script>
>>>>>>> refs/remotes/origin/main

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        <div class="content-wrapper">
            <div class="reply-title"></div>
            <div class="reply-content"></div>
            <div class="reply-info">
                <span class="time"></span>
                <i class="fa fa-heart"></i>
                <button class="reply-edit-btn">Edit</button>
                <button class="reply-delete-btn">Delete</button>
            </div>
        </div>
    </div>
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

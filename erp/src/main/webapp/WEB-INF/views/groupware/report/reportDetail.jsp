<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Markdown 변환기</title>

<!-- Showdown Markdown parser CDN -->
<script src="https://cdn.jsdelivr.net/npm/showdown@2.0.0/dist/showdown.min.js"></script>

<style>
  .markdown-body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    border: 1px solid #ccc;
    padding: 10px;
    margin-top: 10px;
  }
  textarea {
    width: 100%;
    height: 200px;
  }
  .container {
    width: 80%;
    margin: 0 auto;
  }
  .btn {
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
  }
  .btn:hover {
    background-color: #0056b3;
  }
</style>
</head>
<body>
<div class="container">
  <h1>Markdown 변환기</h1>
  <textarea id="markdownInput" placeholder="여기에 Markdown을 입력하세요..."></textarea>
  <button class="btn" onclick="renderMarkdown()">변환하기</button>

  <div id="content" class="markdown-body">
    <!-- 변환된 Markdown 콘텐츠가 여기에 표시됩니다 -->
  </div>
</div>

<script>
  function renderMarkdown() {
    // 입력된 Markdown 텍스트를 가져오기
    var markdownText = document.getElementById('markdownInput').value;

    // Showdown 객체 생성
    var converter = new showdown.Converter();
    
    // Markdown 텍스트를 HTML로 변환
    var htmlContent = converter.makeHtml(markdownText);

    // HTML 콘텐츠를 div에 설정
    document.getElementById('content').innerHTML = htmlContent;
  }
</script>
</body>
</html>

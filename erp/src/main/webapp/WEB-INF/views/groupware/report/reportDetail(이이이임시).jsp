<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Markdown Preview</title>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
    <style>
        #markdown {
            width: 100%;
            height: 200px;
            margin-bottom: 20px;
        }
        #preview {
            border: 1px solid #ddd;
            padding: 10px;
        }
    </style>
</head>
<body>
    <h1>Markdown Preview</h1>
    <textarea id="markdown">${tbEmpReportDto.reportContent}</textarea>
    <div id="preview"></div>

    <script>
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

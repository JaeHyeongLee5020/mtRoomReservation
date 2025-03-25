<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 글 수정</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .form-group label {
            font-weight: bold;
        }
        .form-group textarea {
            resize: vertical;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <h1 class="text-center">글 수정</h1>
    <div class="form-container">
        <form action="/board/edit" method="post">
            <input type="hidden" name="bno" value="${board.bno}">
            <div class="form-group">
                <label for="title">제목:</label>
                <input type="text" id="title" name="title" class="form-control" value="${board.title}">
            </div>
            <div class="form-group">
                <label for="content">내용:</label>
                <textarea id="content" name="content" class="form-control" rows="5">${board.content}</textarea>
            </div>
            <button type="submit" class="btn btn-primary btn-block">수정</button>
        </form>
    </div>

    <!-- jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>

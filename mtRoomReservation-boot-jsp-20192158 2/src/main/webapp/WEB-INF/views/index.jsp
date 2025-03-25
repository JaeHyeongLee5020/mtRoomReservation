<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link href="${pageContext.request.contextPath}/resources/css/com.css" rel="stylesheet" type="text/css" />
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            font-size: 24px;
            margin: 20px 0;
            color: #333;
        }

        a {
            text-decoration: none;
            color: #007bff;
            font-size: 18px;
        }

        a:hover {
            color: #0056b3;
        }

        .link {
            margin: 20px 0;
            display: block;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .link:hover {
            background-color: #e2e2e2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Main</h1>
        <a href='/mtRoomList' class="link" title='회의실 관리'>
            <h1>회의실 관리</h1>
        </a>
        <a href='/mtResList' class="link" title='회의실 예약 관리'>
            <h1>회의실 예약 관리</h1>
        </a>
    </div>
</body>
</html>

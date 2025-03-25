<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회의실 검색 결과</title>
    <link href="${pageContext.request.contextPath}/resources/css/com.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/button.css" rel="stylesheet" type="text/css" />
    <style>
        .board_list {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            margin: 20px 0;
        }

        .board_list th, .board_list td {
            border: 1px solid #ddd;
            padding: 10px;
        }

        .board_list th {
            background-color: #f4f4f4;
            font-weight: bold;
        }

        .board_list td.left {
            text-align: left;
        }

        .board_list tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .board_list tr:hover {
            background-color: #e2e2e2;
        }

        .btn_back {
            display: inline-block;
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }

        .btn_back:hover {
            background-color: #0056b3;
        }

        .page_title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="page_title">회의실 검색 결과</div>
    
    <c:if test="${empty mtRoomList}">
        <p>검색 결과가 없습니다.</p>
    </c:if>
    
    <c:if test="${not empty mtRoomList}">
        <table class="board_list">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>회의실명</th>
                    <th>개방시간</th>
                    <th>수용인원</th>
                    <th>위치</th>
                    <th>건물</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="mtRoom" items="${mtRoomList}">
                    <tr>
                        <td>${mtRoom.mrNo}</td>
                        <td class="left">
                            <a href="${pageContext.request.contextPath}/mtRoomDetail?mrNo=${mtRoom.mrNo}" class="link">
                                ${mtRoom.mr_Name}
                            </a>
                        </td>
                        <td>${mtRoom.start_Time} ~ ${mtRoom.end_Time}</td>
                        <td>${mtRoom.capacity} 명</td>
                        <td>${mtRoom.location}</td>
                        <td>${mtRoom.building}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    
    <a href="${pageContext.request.contextPath}/mtRoomList" class="btn_back">목록으로 돌아가기</a>
</body>
</html>

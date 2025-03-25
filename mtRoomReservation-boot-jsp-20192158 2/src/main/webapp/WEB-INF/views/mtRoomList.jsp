<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>회의실 관리 목록</title>
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

        .btn_register, .btn_search {
            display: inline-block;
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 10px;
        }

        .btn_register:hover, .btn_search:hover {
            background-color: #0056b3;
        }

        .page_title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-top: 20px;
        }

        .button_container {
            text-align: right;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="page_title">회의실 관리 목록</div>
    
    <div class="button_container">
        <form action="${pageContext.request.contextPath}/searchMtRoom" method="get" style="display:inline;">
            <input type="text" name="searchKeyword" placeholder="회의실 검색">
            <input type="submit" class="btn_search" value="검색">
        </form>
        <form action="${pageContext.request.contextPath}/insertMtRoom" method="get" style="display:inline;">
            <input type="submit" class="btn_register" value="등록">
        </form>
    </div>

    <div>
        <table class="board_list">    
            <colgroup>
                <col style="width:7%" />
                <col style="width:20%" />
                <col style="width:25%" />
                <col style="width:5%" />
                <col style="width:15%" />
                <col style="width:15%" />
            </colgroup>
                        
            <thead>
                <tr>
                    <th scope="col">번호</th>
                    <th scope="col">회의실명</th>
                    <th scope="col">개방시간</th>
                    <th scope="col">수용인원</th>
                    <th scope="col">위치</th>
                    <th scope="col">건물</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="mtRoom" items="${mtRoomList}" varStatus="status">
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
                        <td>${mtRoom.building} ${mtRoom.roomNo}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>

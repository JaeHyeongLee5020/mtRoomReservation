<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회의실 상세 페이지</title>

    <link href="${pageContext.request.contextPath}/resources/css/com.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/button.css" rel="stylesheet" type="text/css" />
    <style>
        .wTable {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        .wTable th, .wTable td {
            border: 1px solid #ddd;
            padding: 10px;
            vertical-align: middle;
        }

        .wTable th {
            background-color: #f4f4f4;
            font-weight: bold;
            text-align: left;
        }

        .wTableFrm {
            margin: 0 auto;
            width: 80%;
        }

        .btn {
            text-align: center;
            margin-top: 20px;
        }

        .btn_s a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn_s a:hover {
            background-color: #0056b3;
        }

        .btn_s a.delete {
            background-color: #dc3545;
        }

        .btn_s a.delete:hover {
            background-color: #c82333;
        }
    </style>
    <script type="text/javascript">
        function fncDeleteMtRoom(mrNo) {
            if (confirm("삭제 하시겠습니까?")) {
                location.href = '<c:url value="/deleteMtRoom"/>?mrNo=' + mrNo;
            }
        }
    </script>
</head>
<body>
    <div class="wTableFrm">
        <h2>회의실 상세</h2>
        <table class="wTable">
            <colgroup>
                <col style="width:25%" />
                <col style="width:25%" />
                <col style="width:25%" />
                <col style="width:25%" />
            </colgroup>
            <tr>
                <th>회의실 명</th>
                <td colspan="3">
                    <c:out value="${mtRoomVO.mr_Name}" />
                </td>
            </tr>
            <tr>
                <th>수용인원</th>
                <td>
                    <c:out value="${mtRoomVO.capacity}" /> 명
                </td>
                <th>개방시간</th>
                <td>
                    <c:out value="${mtRoomVO.start_Time}" /> ~ <c:out value="${mtRoomVO.end_Time}" />
                </td>
            </tr>
            <tr>
                <th>위치</th>
                <td colspan="3">
                    <c:out value="${mtRoomVO.location}" /> <c:out value="${mtRoomVO.building}" /> <c:out value="${mtRoomVO.roomNo}" />
                </td>
            </tr>
            <c:if test="${!empty mtRoomVO.picture}">
                <tr>
                    <th>이미지 파일</th>
                    <td colspan="3">
                        <img src="<c:url value='/resources/images/${mtRoomVO.picture}' />" width="200" height="150" alt="회의실 이미지">
                    </td>
                </tr>
            </c:if>
        </table>
        <!-- 하단 버튼 -->
        <div class="btn">
            <span class="btn_s">
                <a href="<c:url value='/updateMtRoom'/>?mrNo=<c:out value='${mtRoomVO.mrNo}'/>">수정</a>
            </span>
            <span class="btn_s">
                <a href="#" class="delete" onclick="fncDeleteMtRoom('${mtRoomVO.mrNo}'); return false;">삭제</a>
            </span>
        </div>
    </div>
</body>
</html>

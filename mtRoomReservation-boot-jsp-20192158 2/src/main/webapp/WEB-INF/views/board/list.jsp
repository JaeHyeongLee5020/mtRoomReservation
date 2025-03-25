<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 목록</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
function selectedOptionCheck() {
    $("#type > option[value=${param.type}]").attr("selected", "true");
}

function moveAction(where) {
    switch (where) {
        case 1:
            location.href = "write";
            break;
        case 2:
            location.href = "list";
            break;
    }
}

function deleteArticle(bno) {
    if (confirm("정말 삭제하시겠습니까?")) {
        location.href = "/board/delete/" + bno;
    }
}
</script>

<style>
    body {
        background-color: #f8f9fa;
        padding: 20px;
    }
    .wrapper {
        max-width: 800px;
        margin: 0 auto;
        background: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .navBar {
        margin-bottom: 20px;
    }
    .boardTable {
        width: 100%;
        border-collapse: collapse;
    }
    .boardTable th, .boardTable td {
        border: 1px solid #dee2e6;
        padding: 10px;
        text-align: center;
    }
    .boardTable th {
        background-color: #e9ecef;
    }
    .boardTable td.subject a {
        color: #007bff;
        text-decoration: none;
    }
    .boardTable td.subject a:hover {
        text-decoration: underline;
    }
    .writeBt {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
    }
    .writeBt:hover {
        background-color: #0056b3;
    }
    .deleteBt {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 5px 10px;
        border-radius: 5px;
        cursor: pointer;
    }
    .deleteBt:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body onload="selectedOptionCheck()">
    <div class="wrapper">
        <div class="navBar" align="center">
            <h2>스마트 게시판</h2>
            <form action="list" method="get">
                <select id="type" name="type">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="writerId">작성자</option>
                </select>
                <input type="text" id="keyword" name="keyword" value="${param.keyword != null ? param.keyword : ''}" />
                <input type="submit" value="검색"/>
            </form>
        </div>

        <table class="boardTable table table-hover">
            <thead>
                <tr>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>댓글수</th>
                    <th>조회수</th>
                    <th>추천수</th>
                    <th>작성일</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="board" items="${boardList}" varStatus="status">
                    <tr>
                        <td class="idx">${startRow + status.index + 1}</td> <!-- 페이지에 따른 글번호 계산 -->
                        <td align="left" class="subject">
                            <a href="view/${board.bno}?tempNo=${startRow + status.index + 1}">${board.title}</a> <!-- 임시 글번호를 URL 파라미터로 넘김 -->
                        </td>
                        <td class="writer">${board.writerId}</td>
                        <td class="comment">${board.replycnt}</td>
                        <td class="hitcount">${board.viewcnt}</td>
                        <td class="recommendcount">${board.recommendcnt}</td>
                        <td class="writeDate">${board.regDate}</td>
                        <td><button class="deleteBt" onclick="deleteArticle(${board.bno})">삭제</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="text-center">
            ${pageHtml} <!-- 페이지네이션 -->
        </div>
        <br /><br />
        <div class="text-center">
            <input type="button" value="글쓰기" class="writeBt" onclick="moveAction(1)" />
            <input type="button" value="첫 페이지로" class="writeBt" onclick="moveAction(2)" />
        </div>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>회의실 등록</title>

    <link href="${pageContext.request.contextPath}/resources/css/com.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/button.css" rel="stylesheet" type="text/css" />
    <style>
        /* 테이블 스타일 */
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

        .wTable select, .wTable input[type="text"], .wTable input[type="file"] {
            width: 90%;
            padding: 5px;
            box-sizing: border-box;
        }

        .btn {
            text-align: center;
            margin-top: 20px;
        }

        .btn_s, .s_submit {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn_s:hover, .s_submit:hover {
            background-color: #0056b3;
        }
    </style>

    <script type="text/javascript">
        function fncInsertMtRoom() {
            if (mtRoomForm.start_Time.value === "") {
                alert("개방 오픈 시간을 선택하세요");
                return false;
            }
            if (mtRoomForm.end_Time.value === "") {
                alert("개방 종료 시간을 선택하세요");
                return false;
            }
            if (parseInt(mtRoomForm.start_Time.value.substring(0, 2)) >= parseInt(mtRoomForm.end_Time.value.substring(0, 2))) {
                alert("개방 오픈 시간이 개방 종료 시간보다 늦거나 같습니다. 개방 시간을 확인하세요");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <form:form modelAttribute="mtRoomVO" name="mtRoomForm" method="post" action="insertMtRoom"
               onsubmit="return fncInsertMtRoom()" enctype="multipart/form-data">
        <div class="wTableFrm">
            <h2>회의실 등록</h2>
            <table class="wTable">
                <colgroup>
                    <col style="width:25%" />
                    <col style="width:25%" />
                    <col style="width:25%" />
                    <col style="width:25%" />
                </colgroup>
                <tr>
                    <th>회의실명<span class="pilsu"></span></th>
                    <td colspan="3">
                        <form:input path="mr_Name" title="회의실명" required="required" />
                    </td>
                </tr>
                <tr>
                    <th>수용가능인원<span class="pilsu"></span></th>
                    <td>
                        <select name="capacity" title="수용가능인원">
                            <option value="0">선택하세요</option>
                            <option value="5" selected>5명</option>
                            <option value="10">10명</option>
                            <option value="15">15명</option>
                            <option value="20">20명</option>
                            <option value="25">25명</option>
                            <option value="30">30명</option>
                            <option value="50">50명</option>
                            <option value="70">70명</option>
                            <option value="100">100명</option>
                        </select>
                    </td>
                    <th>개방시간<span class="pilsu"></span></th>
                    <td>
                        <select name="start_Time" title="개방시작시간">
                            <option value="">선택하세요</option>
                            <option value="08:00" selected>08:00</option>
                            <option value="09:00">09:00</option>
                            <option value="10:00">10:00</option>
                            <option value="11:00">11:00</option>
                            <option value="12:00">12:00</option>
                            <option value="13:00">13:00</option>
                            <option value="14:00">14:00</option>
                            <option value="15:00">15:00</option>
                            <option value="16:00">16:00</option>
                            <option value="17:00">17:00</option>
                            <option value="18:00">18:00</option>
                            <option value="19:00">19:00</option>
                            <option value="20:00">20:00</option>
                            <option value="21:00">21:00</option>
                        </select>
                        ~
                        <select name="end_Time" title="개방종료시간">
                            <option value="">선택하세요</option>
                            <option value="08:00">08:00</option>
                            <option value="09:00">09:00</option>
                            <option value="10:00">10:00</option>
                            <option value="11:00">11:00</option>
                            <option value="12:00">12:00</option>
                            <option value="13:00">13:00</option>
                            <option value="14:00">14:00</option>
                            <option value="15:00">15:00</option>
                            <option value="16:00">16:00</option>
                            <option value="17:00">17:00</option>
                            <option value="18:00">18:00</option>
                            <option value="19:00">19:00</option>
                            <option value="20:00">20:00</option>
                            <option value="21:00" selected>21:00</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>위치<span class="pilsu"></span></th>
                    <td colspan="3">
                        <form:input path="location" title="위치" placeholder="지역" required="true" />
                        <form:input path="building" title="건물" placeholder="건물" required="true" />
                        <form:input path="roomNo" title="층:방번호" placeholder="층 or 방번호" required="true" />
                    </td>
                </tr>
                <tr>
                    <th>이미지 파일첨부</th>
                    <td colspan="3">
                        <input name="file_1" id="egovComFileUploader" type="file" title="첨부파일" />
                        <div id="egovComFileList"></div>
                    </td>
                </tr>
            </table>
            <div class="btn">
                <input class="btn_s" type="reset" value="초기화" />
                <input class="s_submit" type="submit" value="저장" />
            </div>
        </div>
    </form:form>
</body>
</html>

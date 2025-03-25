<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>회의실예약관리 목록</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/css/egovframework/com/com.css'/>" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/egovframework/com/button.css'/>" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/jqueryui.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>
    <script type="text/javascript" defer="defer">
        function initCalendar(){
            $("#resveDeView").datepicker({
                dateFormat: 'yy-mm-dd',
                showOn: 'both',
                buttonImage: '<c:url value="/resources/images/cmm/icon/bu_icon_carlendar.gif"/>',
                buttonImageOnly: true,
                showMonthAfterYear: true,
                showOtherMonths: true,
                selectOtherMonths: true,
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true
            });
            $("#resveDeView").change(function() {
                $("#reserve_Day").val($(this).val().replace(/-/gi,"/"));
            });
        }
        function fncMtResveList(pageNo){
            document.listForm.searchCondition.value = "1";
            document.listForm.pageIndex.value = pageNo;
            document.listForm.action = "<c:url value='/mtResList'/>";
            document.listForm.submit();
        }
    </script>
    <style>
        body {
            background-color: white;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            width: 100%;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .btn-danger {
            width: 100%;
            height: 100%;
        }
        .table {
            background-color: white;
            width: 80vw;
            max-width: 800px;
        }
        .thead-dark th {
            background-color: #007bff;
            color: white;
        }
        .container {
            text-align: center;
        }
    </style>
</head>
<body onLoad="initCalendar();">
<div class="container mt-4">
    <h1 class="text-center">회의실예약관리</h1>
    <form name="listForm" action="<c:url value='mtResList'/>" method="post">
        <div class="form-group row">
            <label for="resveDeView" class="col-sm-2 col-form-label">회의일자:</label>
            <div class="col-sm-3">
                <input id="reserve_Day" name="reserve_Day" type="hidden" value="<c:out value='${reserve_Day}'/>"/>
                <input id="resveDeView" name="resveDeView" type="text" value="${reserve_Day}" readonly="readonly" title="조회" class="form-control"/>
            </div>
            <div class="col-sm-2">
                <button class="btn btn-primary" type="submit" title='조회' onclick="fncMtResveList('1'); return false;">조회</button>
            </div>
        </div>
    </form>
    <p class="mb-4">※ 회의일자 변경시 조회 버튼 클릭하셔야 예약 리스트가 조회됩니다.<br/>
    ※ 회의실 예약은 회의실의 색이 없는 빈 시간을 클릭하시면 예약신청화면으로 이동합니다. (그래프 클릭시 상세화면 이동.)</p>

    <table class="table table-bordered table-striped" summary="회의실 예약관리 목록">
        <caption class="sr-only">회의실 예약관리 목록</caption>
        <thead class="thead-dark">
            <tr>
                <th class="title" scope="col">회의실명</th>
                <th class="title" colspan="2" scope="col">08</th>
                <th class="title" colspan="2" scope="col">09</th>
                <th class="title" colspan="2" scope="col">10</th>
                <th class="title" colspan="2" scope="col">11</th>
                <th class="title" colspan="2" scope="col">12</th>
                <th class="title" colspan="2" scope="col">13</th>
                <th class="title" colspan="2" scope="col">14</th>
                <th class="title" colspan="2" scope="col">15</th>
                <th class="title" colspan="2" scope="col">16</th>
                <th class="title" colspan="2" scope="col">17</th>
                <th class="title" colspan="2" scope="col">18</th>
                <th class="title" colspan="2" scope="col">19</th>
                <th class="title" colspan="2" scope="col">20</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="mtResTable" items="${mrResTimeList}" varStatus="status">
                <tr>
                    <td class="al"><c:out value='${mtResTable.mr_Name}'/></td>
                    <c:forEach var="i" begin="800" end="2050" step="50">
                        <c:choose>
                            <c:when test="${(i % 100) > 30}">
                                <c:set var="num" value="${i - 20}"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="num" value="${i}"/>
                            </c:otherwise>
                        </c:choose>
                        <c:set var="resveTn" value="resveTemp${num}" />
                        <c:set var="resveTm" value="${mtResTable[resveTn]}" />
                        <c:choose>
                            <c:when test="${resveTm != '0'}">
                                <td>
                                    <form name="item" method="post" action="<c:url value='/updateResView'/>">
                                        <input type="hidden" name="mrNo" value="<c:out value='${mtResTable.mrNo}'/>">
                                        <input type="hidden" name="mr_Name" value="<c:out value='${mtResTable.mr_Name}'/>">
                                        <input type="hidden" name="reserve_Day" value="<c:out value='${mtResTable.reserve_Day}'/>">
                                        <input type="hidden" name="reserve_Start" value="${num}">
                                        <button type="submit" class="btn btn-danger" style="width:100%; height:100%;"></button>
                                    </form>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td>
                                    <form name="item" method="post" action="<c:url value='/mtResRegist'/>">
                                        <input type="hidden" name="mrNo" value="<c:out value='${mtResTable.mrNo}'/>">
                                        <input type="hidden" name="mr_Name" value="<c:out value='${mtResTable.mr_Name}'/>">
                                        <input type="hidden" name="reserve_Day" value="<c:out value='${mtResTable.reserve_Day}'/>">
                                        <input type="hidden" name="reserve_Start" value="${num}">
                                        <button type="submit" class="btn btn-primary" style="width:100%; height:100%;"></button>
                                    </form>
                                </td>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>

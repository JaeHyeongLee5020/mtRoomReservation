<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <title>회의실 예약 수정</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 커스텀 CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/com.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/button.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/jqueryui.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery 및 jQuery UI -->
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>
    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
        function initCalendar(){
            $("#reserve_Day").datepicker({
                dateFormat: 'yy-mm-dd',
                showOn: 'button',
                buttonImage: "<c:url value='/resources/images/cmm/icon/bu_icon_carlendar.gif'/>",
                buttonImageOnly: true,
                showMonthAfterYear: true,
                showOtherMonths: true,
                selectOtherMonths: true,
                changeMonth: true, // 월선택 select box 표시 (기본은 false)
                changeYear: true, // 년선택 selectbox 표시 (기본은 false)
                showButtonPanel: true // 하단 today, done 버튼기능 추가 표시 (기본은 false)
            });
        }

        function fncMrResUpdate() {
            alert("수정 함수 호출됨:");
            var form = document.getElementById("mtgPlaceResve");
            form.action = "<c:url value='updateReserve'/>";
            form.submit();
        }

        function fncMrResDelete(reNo) {
            alert("삭제 함수 호출됨: " + reNo);
            var form = document.getElementById("mtgPlaceResve");
            form.action = "<c:url value='deleteReserve'/>";
            if (confirm("예약을 삭제하시겠습니까?")) {
                form.submit();
            } else {
                return false;
            }
        }

        function resDupCheck() {
            // 중복 체크 로직을 여기에 추가하세요
            alert("중복 체크 함수 호출됨");
            // 예시: AJAX 요청을 통해 중복 여부 확인
        }

        window.onload = initCalendar;
    </script>
</head>
<body>
    <div class="container mt-5">
        <form:form modelAttribute="mrReserveVO" name="mtgPlaceResve" id="mtgPlaceResve" method="post">
            <input type="hidden" name="dupCeck" id="dupCeck" value="<c:out value='' />" />
            <input type="hidden" name="reNo" value="<c:out value='${mrReserveVO.reNo}'/>" />
            <input type="hidden" name="bookerID" value="<c:out value='${sessionScope.userId}'/>" />
            <input type="hidden" name="first_Reg_ID" value="<c:out value='${mrReserveVO.first_Reg_ID}'/>" />
            <input type="hidden" name="mrNo" value="<c:out value='${mtRoomVO.mrNo}'/>" />
            <div class="wTableFrm">
                <!-- 타이틀 -->
                <h2 class="mb-4">회의실 예약 수정</h2>
                <!-- 등록폼 -->
                <table class="table table-bordered">
                    <colgroup>
                        <col style="width:16%" />
                        <col style="" />
                        <col style="width:16%" />
                        <col style="" />
                    </colgroup>
                    <tr>
                        <th>제목 <span class="text-danger"></span></th>
                        <td colspan="3">
                            <input name="title" type="text" class="form-control" maxlength="70" title="제목" value="${mrReserveVO.title}" required="required" />
                        </td>
                    </tr>
                    <tr>
                        <th>회의실명 <span class="text-danger"></span></th>
                        <td colspan="3">
                            <c:out value="${mtRoomVO.mr_Name}" />
                        </td>
                    </tr>
                    <tr>
                        <th>회의실 위치 <span class="text-danger">*</span></th>
                        <td colspan="3">
                            <c:out value="${mtRoomVO.location}" /> 
                            <c:out value="${mtRoomVO.building}" /> 
                            <c:out value="${mtRoomVO.roomNo}" />
                        </td>
                    </tr>
                    <tr>
                        <th>예약자 ID <span class="text-danger">*</span></th>
                        <td>
                            <input name="first_Reg_ID" type="text" class="form-control" maxlength="20" value="<c:out value='${sessionScope.userId}'/>" required="required" />
                        </td>
                        <th>예약자 이름</th>
                        <td>
                            <c:out value="${resName}" />
                        </td>
                    </tr>
                    <tr>
                        <th>예약시간 <span class="text-danger">*</span></th>
                        <td colspan="3">
                            <div class="d-flex align-items-center">
                                <input name="reserve_Day" id="reserve_Day" type="text" class="form-control me-2" size="10" value="${mrReserveVO.reserve_Day}" title="예약일자"
                                    maxlength="10" required="required" style="width:150px;" />
                                <span class="mx-2">~</span>
                                <select name="reserve_Start" class="form-select me-2" title="예약시작시간" style="width:150px;">
                                    <option value="800" <c:if test="${mrReserveVO.reserve_Start == '800' || mrReserveVO.reserve_Start == '0800'}">selected</c:if>>08:00</option>
                                    <option value="830" <c:if test="${mrReserveVO.reserve_Start == '830' || mrReserveVO.reserve_Start == '0830'}">selected</c:if>>08:30</option>
                                    <option value="900" <c:if test="${mrReserveVO.reserve_Start == '900' || mrReserveVO.reserve_Start == '0900'}">selected</c:if>>09:00</option>
                                    <option value="930" <c:if test="${mrReserveVO.reserve_Start == '930' || mrReserveVO.reserve_Start == '0930'}">selected</c:if>>09:30</option>
                                    <option value="1000" <c:if test="${mrReserveVO.reserve_Start == '1000'}">selected</c:if>>10:00</option>
                                    <option value="1030" <c:if test="${mrReserveVO.reserve_Start == '1030'}">selected</c:if>>10:30</option>
                                    <option value="1100" <c:if test="${mrReserveVO.reserve_Start == '1100'}">selected</c:if>>11:00</option>
                                    <option value="1130" <c:if test="${mrReserveVO.reserve_Start == '1130'}">selected</c:if>>11:30</option>
                                    <option value="1200" <c:if test="${mrReserveVO.reserve_Start == '1200'}">selected</c:if>>12:00</option>
                                    <option value="1230" <c:if test="${mrReserveVO.reserve_Start == '1230'}">selected</c:if>>12:30</option>
                                    <option value="1300" <c:if test="${mrReserveVO.reserve_Start == '1300'}">selected</c:if>>13:00</option>
                                    <option value="1330" <c:if test="${mrReserveVO.reserve_Start == '1330'}">selected</c:if>>13:30</option>
                                    <option value="1400" <c:if test="${mrReserveVO.reserve_Start == '1400'}">selected</c:if>>14:00</option>
                                    <option value="1430" <c:if test="${mrReserveVO.reserve_Start == '1430'}">selected</c:if>>14:30</option>
                                    <option value="1500" <c:if test="${mrReserveVO.reserve_Start == '1500'}">selected</c:if>>15:00</option>
                                    <option value="1530" <c:if test="${mrReserveVO.reserve_Start == '1530'}">selected</c:if>>15:30</option>
                                    <option value="1600" <c:if test="${mrReserveVO.reserve_Start == '1600'}">selected</c:if>>16:00</option>
                                    <option value="1630" <c:if test="${mrReserveVO.reserve_Start == '1630'}">selected</c:if>>16:30</option>
                                    <option value="1700" <c:if test="${mrReserveVO.reserve_Start == '1700'}">selected</c:if>>17:00</option>
                                    <option value="1730" <c:if test="${mrReserveVO.reserve_Start == '1730'}">selected</c:if>>17:30</option>
                                    <option value="1800" <c:if test="${mrReserveVO.reserve_Start == '1800'}">selected</c:if>>18:00</option>
                                    <option value="1830" <c:if test="${mrReserveVO.reserve_Start == '1830'}">selected</c:if>>18:30</option>
                                    <option value="1900" <c:if test="${mrReserveVO.reserve_Start == '1900'}">selected</c:if>>19:00</option>
                                    <option value="1930" <c:if test="${mrReserveVO.reserve_Start == '1930'}">selected</c:if>>19:30</option>
                                    <option value="2000" <c:if test="${mrReserveVO.reserve_Start == '2000'}">selected</c:if>>20:00</option>
                                    <option value="2030" <c:if test="${mrReserveVO.reserve_Start == '2030'}">selected</c:if>>20:30</option>
                                    <option value="2100" <c:if test="${mrReserveVO.reserve_Start == '2100'}">selected</c:if>>21:00</option>
                                </select>
                                <span class="mx-2">~</span>
                                <select name="reserve_End" class="form-select me-2" title="예약종료시간" style="width:150px;">
                                    <option value="800" <c:if test="${mrReserveVO.reserve_End == '800' || mrReserveVO.reserve_End == '0800'}">selected</c:if>>08:00</option>
                                    <option value="830" <c:if test="${mrReserveVO.reserve_End == '830' || mrReserveVO.reserve_End == '0830'}">selected</c:if>>08:30</option>
                                    <option value="900" <c:if test="${mrReserveVO.reserve_End == '900' || mrReserveVO.reserve_End == '0900'}">selected</c:if>>09:00</option>
                                    <option value="930" <c:if test="${mrReserveVO.reserve_End == '930' || mrReserveVO.reserve_End == '0930'}">selected</c:if>>09:30</option>
                                    <option value="1000" <c:if test="${mrReserveVO.reserve_End == '1000'}">selected</c:if>>10:00</option>
                                    <option value="1030" <c:if test="${mrReserveVO.reserve_End == '1030'}">selected</c:if>>10:30</option>
                                    <option value="1100" <c:if test="${mrReserveVO.reserve_End == '1100'}">selected</c:if>>11:00</option>
                                    <option value="1130" <c:if test="${mrReserveVO.reserve_End == '1130'}">selected</c:if>>11:30</option>
                                    <option value="1200" <c:if test="${mrReserveVO.reserve_End == '1200'}">selected</c:if>>12:00</option>
                                    <option value="1230" <c:if test="${mrReserveVO.reserve_End == '1230'}">selected</c:if>>12:30</option>
                                    <option value="1300" <c:if test="${mrReserveVO.reserve_End == '1300'}">selected</c:if>>13:00</option>
                                    <option value="1330" <c:if test="${mrReserveVO.reserve_End == '1330'}">selected</c:if>>13:30</option>
                                    <option value="1400" <c:if test="${mrReserveVO.reserve_End == '1400'}">selected</c:if>>14:00</option>
                                    <option value="1430" <c:if test="${mrReserveVO.reserve_End == '1430'}">selected</c:if>>14:30</option>
                                    <option value="1500" <c:if test="${mrReserveVO.reserve_End == '1500'}">selected</c:if>>15:00</option>
                                    <option value="1530" <c:if test="${mrReserveVO.reserve_End == '1530'}">selected</c:if>>15:30</option>
                                    <option value="1600" <c:if test="${mrReserveVO.reserve_End == '1600'}">selected</c:if>>16:00</option>
                                    <option value="1630" <c:if test="${mrReserveVO.reserve_End == '1630'}">selected</c:if>>16:30</option>
                                    <option value="1700" <c:if test="${mrReserveVO.reserve_End == '1700'}">selected</c:if>>17:00</option>
                                    <option value="1730" <c:if test="${mrReserveVO.reserve_End == '1730'}">selected</c:if>>17:30</option>
                                    <option value="1800" <c:if test="${mrReserveVO.reserve_End == '1800'}">selected</c:if>>18:00</option>
                                    <option value="1830" <c:if test="${mrReserveVO.reserve_End == '1830'}">selected</c:if>>18:30</option>
                                    <option value="1900" <c:if test="${mrReserveVO.reserve_End == '1900'}">selected</c:if>>19:00</option>
                                    <option value="1930" <c:if test="${mrReserveVO.reserve_End == '1930'}">selected</c:if>>19:30</option>
                                    <option value="2000" <c:if test="${mrReserveVO.reserve_End == '2000'}">selected</c:if>>20:00</option>
                                    <option value="2030" <c:if test="${mrReserveVO.reserve_End == '2030'}">selected</c:if>>20:30</option>
                                    <option value="2100" <c:if test="${mrReserveVO.reserve_End == '2100'}">selected</c:if>>21:00</option>
                                </select>
                                <button type="button" class="btn btn-outline-secondary ms-2" onclick="resDupCheck();" title="중복체크">
                                    중복체크
                                </button>
                                <span id="dupMsg" class="ms-2"></span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>참석인원</th>
                        <td colspan="3">
                            <div class="input-group">
                                <input name="attendees" type="text" class="form-control" value="<c:out value='${mrReserveVO.attendees}'/>" maxlength="3"
                                    style="width:80px;" title="참석인원" required="required" />
                                <span class="input-group-text">명</span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>회의내용 <span class="text-danger">*</span></th><!-- 회의내용 -->
                        <td colspan="3">
                            <form:textarea path="contents" class="form-control" rows="4" cols="70" title="회의내용" value="${mrReserveVO.contents}"
                                required="required"></form:textarea>
                        </td>
                    </tr>
                </table>
                <!-- 첨부파일 -->
                <c:if test="${!empty mtRoomVO.picture}">
                    <table class="table table-bordered">
                        <tr>
                            <th>이미지 파일</th>
                            <td colspan="3">
                                <img src="<c:url value='/resources/images/${mtRoomVO.picture}'/>" class="img-fluid" alt="회의실 이미지" style="max-width:200px; max-height:150px;">
                            </td>
                        </tr>
                    </table>
                </c:if>
                <!-- 하단 버튼 -->
                <div class="d-flex justify-content-end mt-4">
                    <button type="button" class="btn btn-primary me-2" onclick="fncMrResUpdate();">수정</button>
                    <a href="#" class="btn btn-danger me-2" onclick="fncMrResDelete('${mrReserveVO.reNo}');">삭제</a>
                    <a href="<c:url value='/mtRoomList.do'/>?searchCondition=1" class="btn btn-secondary">목록</a>
                </div>
                <div style="clear:both;"></div>
            </div>
        </form:form>
    </div>
</body>
</html>

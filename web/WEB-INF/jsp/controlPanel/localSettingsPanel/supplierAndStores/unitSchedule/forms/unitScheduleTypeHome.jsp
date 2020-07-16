<%-- 
    Document   : unitScheduleTypeHome
    Created on : Apr 17, 2018, 10:48:09 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div >
    <div class="row">
        <div class="col-md-12">
        </div>
    </div>
    <div style="margin: 10px;">
        <fieldset style="min-height:100px;">
            <legend>Manage Registered Facility Unit Schedule</legend>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <table class="table table-hover table-bordered" id="unitscheduletypetable">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Schedule day</th>
                                        <th>Abbreviation</th>
                                        <th>Scheduled?</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% int j = 1;%>
                                    <% int i = 1;%>
                                    <c:forEach items="${facilityunitschedules}" var="a">
                                        <tr>
                                            <td align="center"><%=i++%></td>
                                            <td>${a.scheduledayname}</td>
                                            <td>${a.abbreviation}</td>
                                            <td class="center">
                                                <div style="margin-left: 45%;">
                                                    <label class="check-Label">
                                                        <input <c:if test="${a.assigned==true}">checked="true"</c:if> class="medicalIssues${a.scheduleid}" value="${a.scheduleid}" onchange="if (this.checked) {
                                                                    checkedoruncheckedschedule(this.value, 'checked');
                                                                } else {
                                                                    checkedoruncheckedschedule(this.value, 'unchecked');
                                                                }" type="checkbox" id="1no" name="asthma">
                                                        <span class="checkmark"></span>
                                                    </label>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>  
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
    </div> 
</div>


<script>
    $('#unitscheduletypetable').DataTable();

    function checkedoruncheckedschedule(scheduleid, type) {
        if (type === 'checked') {
            $.ajax({
                type: 'POST',
                url: "unitschedulemanagement/checkedoruncheckedschedule.htm",
                data: {scheduleid: scheduleid, type: 'checked'},
                success: function (data, textStatus, jqXHR) {

                }
            });
        } else {
            $.ajax({
                type: 'POST',
                url: "unitschedulemanagement/checkedoruncheckedschedule.htm",
                data: {scheduleid: scheduleid, type: 'unchecked'},
                success: function (data, textStatus, jqXHR) {

                }
            });
        }
    }

</script>
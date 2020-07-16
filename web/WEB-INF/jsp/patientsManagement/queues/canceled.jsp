<%-- 
    Document   : canceled
    Created on : Oct 12, 2018, 3:59:18 PM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<div class="row">
    <div class="col-sm-12 col-md-12">
        <table class="table table-hover table-bordered table-striped" id="patients">
            <thead>
                <tr>
                    <th>No</th>
                    <th class="left">Names</th>
                    <th class="left">Visit No.</th>
                    <th class="left">Gender</th>
                    <th class="right">Canceled</th>
                    <th class="left">Canceled By</th>
                    <th class="center">Restore</th>
                </tr>
            </thead>
            <tbody>
                <% int k = 1;%>
                <c:forEach items="${patients}" var="patient">
                    <tr>
                        <td><%=k++%></td>
                        <td class="left">${patient.names}</td>
                        <td class="left">${patient.visitno}</td>
                        <td class="left">${patient.gender}</td>
                        <td class="right">
                            <span class="text-info">
                                <c:if test="${patient.time < 1}">
                                    0 Minutes
                                </c:if>
                                <c:if test="${patient.time == 1}">
                                    1 Minute
                                </c:if>
                                <c:if test="${patient.time > 1}">
                                    <c:if test="${patient.time < 60}">
                                        ${patient.time} Minutes
                                    </c:if>
                                    <c:if test="${patient.time == 60}">
                                        1 Hour
                                    </c:if>
                                    <c:if test="${patient.time > 60}">
                                        <fmt:parseNumber var="hours" integerOnly="true" type="number" value="${patient.time/60}"/>
                                        <c:if test="${hours == 1}">
                                            1 Hour
                                        </c:if>
                                        <c:if test="${hours != 1}">
                                            ${hours} Hours
                                        </c:if>
                                    </c:if>
                                </c:if>
                            </span>
                        </td>
                        <td class="left">${patient.servicedby}</td>
                        <td class="center">
                            <button style="margin-top: -5px" class="btn btn-success btn-sm" id="restore${patient.visitid}" onclick="restoreCanceledPatient(${patient.visitid}, ${patient.serviceid}, '${patient.names}', '${patient.visitno}')">
                                <i class="fa fa-level-down"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#patients').DataTable();
    });
</script>
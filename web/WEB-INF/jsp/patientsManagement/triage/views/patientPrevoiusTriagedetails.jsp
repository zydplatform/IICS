<%-- 
    Document   : patientPrevoiusTriagedetails
    Created on : Oct 10, 2018, 6:02:03 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../include.jsp" %>

<div class="row">
    <div class="col-sm-12 col-md-12">
        <table class="table table-hover table-bordered" id="tablePrevoiusTriagedetails">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Weight</th>
                    <th>Temperature</th>
                    <th>Height</th>
                    <th>Pulse</th>
                    <th>Head Circum</th>
                    <th>Body Surface Area</th>
                    <th>Respiration Rate</th>
                    <th>Pressure Systolic</th>
                    <th>Pressure Diastolic</th>
                    <th>BMI</th>
                    <th>Notes</th>
                    <th>Visit Date</th>
                    <th>Facility</th>
                </tr>
            </thead>
            <tbody id="">
                <% int k = 1;%>
                <c:forEach items="${previousTriageList}" var="visit">
                    <tr>
                        <td><%=k++%></td>
                        <td>${visit.weight}</td>
                        <td>${visit.temperature}</td>
                        <td>${visit.height}</td>
                        <td>${visit.pulse}</td>
                        <td>${visit.headcircum}</td>
                        <td>${visit.bodysurfacearea}</td>
                        <td>${visit.respirationrate}</td>
                        <td>${visit.patientpressuresystolic}</td>
                        <td>${visit.patientpressurediastolic}</td>
                        <td>${visit.bmi}</td>
                        <td>${visit.notes}</td>
                        <td>${visit.dateadded}</td>
                        <td>${visit.facilityname}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#tablePrevoiusTriagedetails').DataTable();
    });
</script>
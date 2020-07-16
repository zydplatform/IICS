<%-- 
    Document   : patientConditionsDetail
    Created on : Oct 24, 2018, 11:50:39 AM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<table  class="table table-hover table-bordered" id="patientconditionstables">
    <thead>
        <tr>
            <th>No</th>
            <th>Symptom</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <c:forEach items="${symptomsFound}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.symptom}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#patientconditionstables').DataTable();
</script>

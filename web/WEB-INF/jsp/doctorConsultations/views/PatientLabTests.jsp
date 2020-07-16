<%-- 
    Document   : PatientLabTests
    Created on : Oct 5, 2018, 1:15:30 PM
    Author     : HP
--%>

<%@include file="../../include.jsp" %>
<table  class="table table-hover table-bordered" id="patientsLaboratoryRequestTestsTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Test Name</th>
            <th>Tested</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <c:forEach items="${laboratoryrequesttestList}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.testname}</td>
                <td align="center"><c:if test="${a.tested==true}"><img src="static/images/authorisedsmall.png"></c:if> <c:if test="${a.tested==false}"><img src="static/images/noaccesssmall.png"></c:if></td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#patientsLaboratoryRequestTestsTable').DataTable();
</script>

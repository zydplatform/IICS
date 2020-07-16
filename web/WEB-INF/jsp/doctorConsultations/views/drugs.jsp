<%-- 
    Document   : drugs
    Created on : Sep 21, 2018, 5:07:13 PM
    Author     : HP
--%>

<%@include file="../../include.jsp" %>
<hr>
<table  class="table table-hover table-bordered" id="previousPrescriptionDrugsTable">
    <thead>
        <tr>
            <th>No</th>
            <!---->
<!--            <th>Drug Name</th>-->
            <th>Medicine</th>
            <th>Dosage</th>
            <th>Duration</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <c:forEach items="${prescriptiondrugsFound}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.fullname}</td>
                <td>${a.dosage}</td>
                <td>${a.days}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#previousPrescriptionDrugsTable').DataTable();
</script>
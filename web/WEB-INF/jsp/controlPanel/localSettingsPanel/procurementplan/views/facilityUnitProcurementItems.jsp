<%-- 
    Document   : facilityUnitProcurementItems
    Created on : May 2, 2018, 11:29:46 AM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<table class="table table-hover table-bordered" id="facilityunitprocurementtableitems">
    <c:if test="${orderperiodtype=='Quarterly'}">
        <thead>
            <tr>
                <th>No</th>
                <th>Generic Name</th>
                <th>Pack Size</th>
                <th>Monthly Need</th>
                <th>Quarterly Need</th>
            </tr>
        </thead>
        <tbody>
            <% int j = 1;%>
            <c:forEach items="${items}" var="a">
                <tr>
                    <td><%=j++%></td>
                    <td>${a.genericname}</td>
                    <td>${a.packsize}</td>
                    <td>${a.averagemonthlyconsumption}</td>
                    <td>${a.averagequarterconsumption}</td>
                </tr>
            </c:forEach>
        </tbody>
    </c:if>
</table>
<script>
    $('#facilityunitprocurementtableitems').DataTable();
</script>
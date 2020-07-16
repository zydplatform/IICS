<%-- 
    Document   : facilityUnitItems
    Created on : Jun 13, 2018, 4:31:10 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<table class="table table-hover table-bordered" id="tableconsolidatedFacilityprocplanItems">
    <thead>
        <tr>
            <th>No</th>
            <th>Generic Name</th>
            <th>Monthly Need</th>
            <th>${orderperiodtype} Need</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <c:forEach items="${itemsFound}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.genericname}</td>
                <td>${a.averagemonthlyconsumption}</td>
                <td><c:if test="${orderperiodtype=='Quarterly'}">${a.averagequarterconsumption}</c:if><c:if test="${orderperiodtype=='Monthly'}">${a.averageannualcomsumption} </c:if><c:if test="${orderperiodtype=='Annually'}">${a.averageannualcomsumption}</c:if></td>
                </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#tableconsolidatedFacilityprocplanItems').DataTable();
</script>
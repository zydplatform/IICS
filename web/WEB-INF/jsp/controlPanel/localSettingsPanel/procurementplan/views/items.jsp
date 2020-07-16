<%-- 
    Document   : items
    Created on : May 7, 2018, 7:43:50 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp" %>
<table class="table table-hover table-bordered" id="itemstable34">
    <thead>
        <tr>
            <th>No</th>
            <th>Generic Name</th>
            <th>A.M.C</th>
            <c:if test="${orderperiodtype=='Quarterly'}"><th>A.Q.C</th></c:if>
            <c:if test="${orderperiodtype=='Annually'}"><th>A.A.C</th></c:if>
            <c:if test="${orderperiodtype=='Monthly'}"><th>A.A.C</th></c:if>
            </tr>
        </thead>
        <tbody>
        <% int j = 1;%>
        <c:forEach items="${procurementPlansItemsFound}" var="b">
            <tr>
                <td><%=j++%></td>
                <td>${b.genericname}</td>
                <td>${b.amc}</td>
                <td>
                    <c:if test="${orderperiodtype=='Quarterly'}">${b.aqc}</c:if>
                    <c:if test="${orderperiodtype=='Annually'}">${b.aac}</c:if>
                    <c:if test="${orderperiodtype=='Monthly'}">${b.aac}</c:if>
                    </td>
                </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#itemstable34').DataTable();
</script>

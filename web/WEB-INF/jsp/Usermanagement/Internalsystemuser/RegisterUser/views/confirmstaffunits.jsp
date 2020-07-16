<%-- 
    Document   : confirmstaffunits
    Created on : Sep 25, 2018, 4:20:13 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<table class="table table-hover table-bordered col-md-12" id="batchestable">
    <thead class="col-md-12">
        <tr>
            <th>No</th>
            <th>Facility Unit(s)</th>
        </tr>
    </thead>
    <tbody class="col-md-12" id="tableFacilityOwner">
        <% int m = 1;%>
        <c:forEach items="${staffunits}" var="data">
            <tr>
                <td><%=m++%></td>
                <td>${data.facilityunitname}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

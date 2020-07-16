<%-- 
    Document   : consolidatedItems
    Created on : Jun 27, 2018, 8:19:03 AM
    Author     : IICS
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<table class="table table-hover table-bordered" id="consolidatedacilityprocuremitems3">
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
        <% int i = 1;%>
        <c:forEach items="${ItemsFound}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.genericname}</td>
                <td>${a.averagemonthconsumption}</td>
                <td>
                   ${a.averagequarterorannualconsumption} 
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
      $('#consolidatedacilityprocuremitems3').DataTable();
</script>
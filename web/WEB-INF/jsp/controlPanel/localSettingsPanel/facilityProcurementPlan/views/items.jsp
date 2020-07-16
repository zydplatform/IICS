<%-- 
    Document   : items
    Created on : May 11, 2018, 1:00:46 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<table class="table table-hover table-bordered" id="acilityprocuremitems3">
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
        <c:forEach items="${items}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.genericname}</td>
                <td>${a.averagemonthconsumption}</td>
                <td>
                    <c:if test="${orderperiodtype=='Quarterly'}">
                        ${a.averagequarterconsumption}
                    </c:if>
                    <c:if test="${orderperiodtype=='Monthly'}">
                        ${a.averageannualconsumption}
                    </c:if>
                    <c:if test="${orderperiodtype=='Annually'}">
                        ${a.averageannualconsumption}
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
      $('#acilityprocuremitems3').DataTable();
</script>
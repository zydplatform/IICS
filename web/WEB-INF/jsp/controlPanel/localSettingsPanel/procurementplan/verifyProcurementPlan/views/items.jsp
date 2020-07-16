<%-- 
    Document   : items
    Created on : Apr 16, 2018, 3:09:08 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table class="table table-hover table-bordered" id="procurementtableitems">
    <thead>
        <tr>
            <th>No</th>
            <th>Generic Name</th>
            <th>Pack Size</th>
            <th>Monthly Need</th>
            <th>Annual Need</th>
            <th>Unit Cost</th>
        </tr>
    </thead>
    <tbody id="tableFacilityOwner">
        <% int j = 1;%>
        <c:forEach items="${financialyritems}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.genericname}</td>
                <td>${a.packsize}</td>
                <td>${a.amc}</td>
                <td>${a.aac}</td>
                <td>${a.unitcost}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#procurementtableitems').DataTable();
</script>
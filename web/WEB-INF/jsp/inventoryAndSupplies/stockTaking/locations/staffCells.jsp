<%-- 
    Document   : staffCells
    Created on : 28-May-2018, 16:26:39
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<table class="table table-hover table-striped" id="staffAssignedCellsTable">
    <thead>
        <tr>
            <th>#</th>
            <th>Cell</th>
            <th>Row</th>
            <th>Bay</th>
            <th>Zone</th>
        </tr>
    </thead>
    <tbody>
        <% int i = 1;%>
        <c:forEach items="${staffCells}" var="cell">
            <tr>
                <td><%=i++%></td>
                <td>${cell.cell}</td>
                <td>${cell.row}</td>
                <td>${cell.bay}</td>
                <td>${cell.zone}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script type="text/javascript">
    $('#staffAssignedCellsTable').DataTable();
</script>
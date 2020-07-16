<%-- 
    Document   : setCells
    Created on : 22-May-2018, 15:42:35
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<table class="table table-hover table-striped" id="setCellTable">
    <thead>
        <tr>
            <th>#</th>
            <th>Zone</th>
            <th>Bay</th>
            <th>Row</th>
            <th>Cell</th>
            <th>Staff</th>
            <th class="center">Remove</th>
        </tr>
    </thead>
    <tbody>
        <% int l = 1;%>
        <c:forEach items="${setCells}" var="cell">
            <tr>
                <td><%=l++%></td>
                <td>${cell.zone}</td>
                <td>${cell.bay}</td>
                <td>${cell.row}</td>
                <td>${cell.cell}</td>
                <td>${cell.names}</td>
                <td class="center">
                    <c:if test="${cell.status == 'PENDING'}">
                        <span class="badge badge-danger icon-custom" onclick="deleteActivityCell(${cell.id}, '${cell.cell}')">
                            <i class="fa fa-close"></i>
                        </span>
                    </c:if>
                    <c:if test="${cell.status != 'PENDING'}">
                        <c:if test="${cell.status == 'SUBMITTED'}">
                            <span class="order-items-process span-size">
                                <span class="badge badge-info">Submitted</span>
                            </span>
                        </c:if>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#setCellTable').DataTable();
</script>
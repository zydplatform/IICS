<%-- 
    Document   : staffCells
    Created on : 28-May-2018, 16:26:39
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<table class="table table-hover table-striped" id="assignedCellsTable">
    <thead>
        <tr>
            <th>#</th>
            <th>Cell</th>
            <th>Counted</th>
            <th>Count Status</th>
            <th class="center">Manage</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <c:forEach items="${staffCells}" var="cell">
            <tr>
                <td class="middle"><%=j++%></td>
                <td class="middle">${cell.cell}</td>
                <td class="middle">
                    <c:if test="${cell.itemCount == '1'}">
                        ${cell.itemCount} Item
                    </c:if>
                    <c:if test="${cell.itemCount != '1'}">
                        ${cell.itemCount} Items
                    </c:if>
                </td>
                <td class="middle" id="status${cell.id}">
                    <c:if test="${cell.status == 'PENDING'}">
                        <span class="order-items-process span-size">
                            <span class="badge badge-warning">Pending</span>
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
                <td class="center" id="manage${cell.id}">
                    <c:if test="${cell.status == 'PENDING'}">
                        <a href="#!" onclick="submitCell(${cell.id}, '${cell.cell}')" title="Submit Cell Items">
                            <i class="fa fa-fw fa-lg fa-check-square"></i>
                        </a><br><br>
                        <a href="#viewCellItems" onclick="viewCellItems(${cell.id}, '${cell.cell}')" title="View Cell Items">
                            <i class="fa fa-fw fa-lg fa-dedent"></i>
                        </a>
                        <a href="#setActivityCells" onclick="countCellItems(${cell.id}, '${cell.cell}')" title="Count Cell Items">
                            <i class="fa fa-fw fa-lg fa-edit"></i>
                        </a>
                    </c:if>
                    <c:if test="${cell.status != 'PENDING'}">
                        <c:if test="${cell.status == 'SUBMITTED'}">
                            <a href="#viewCellItems" onclick="viewCellItems(${cell.id}, '${cell.cell}')" title="View Cell Items">
                                <i class="fa fa-fw fa-lg fa-dedent"></i>
                            </a>
                        </c:if>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script type="text/javascript">
    $('#assignedCellsTable').DataTable();
</script>
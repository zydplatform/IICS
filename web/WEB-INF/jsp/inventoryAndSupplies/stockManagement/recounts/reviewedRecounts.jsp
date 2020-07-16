<%-- 
    Document   : staffAssignedItems
    Created on : 19-Jun-2018, 12:30:30
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<div class="tile">
    <h3 class="tile-title">Reviewed Recounts</h3>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-striped" id="assignedItems">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Item</th>
                        <th>Cell</th>
                        <th>Reviewed by</th>
                        <th class="right">Expected</th>
                        <th class="right">Counted</th>
                        <th class="center">Details</th>
                    </tr>
                </thead>
                <tbody>
                    <% int q = 1;%>
                    <c:forEach items="${items}" var="item">
                        <tr>
                            <td><%=q++%></td>
                            <td>${item.name}</td>
                            <td class="no-wrap">${item.cell}</td>
                            <td>${item.reviewer}</td>
                            <td class="right">${item.expected}</td>
                            <td class="right">${item.counted}</td>
                            <td class="center" id="manageR${item.id}">
                                <button class="btn btn-sm btn-secondary" onclick="viewItemCountSheet(${item.id}, '${item.name}', ${item.itemid}, ${item.cellid}, ${item.activitycellid})">
                                    <i class="fa fa-dedent"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
    $('#assignedItems').DataTable();
</script>
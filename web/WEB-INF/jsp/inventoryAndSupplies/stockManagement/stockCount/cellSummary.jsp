<%-- 
    Document   : cellSummary
    Created on : 13-Jun-2018, 16:00:42
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<div class="tile">
    <div class="row">
        <div class="col-md-12 col-sm-12 right">
            <button id="generateReport" onclick="loadActivityReport()" class="btn btn-small btn-primary">
                Stock Report
            </button>
            <button id="pendingReport" class="btn btn-small btn-info" title="Pending Cell Reviews" disabled="true">
                Stock Report
            </button>
        </div>
    </div>
    <fieldset>
        <table class="table table-hover table-striped" id="cellCounts">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Cell</th>
                    <th>Expected Items</th>
                    <th>Counted Items</th>
                    <th class="center">Counted Status</th>
                    <th class="center">Details</th>
                </tr>
            </thead>
            <tbody>
                <% int m = 1;%>
                <c:forEach items="${cells}" var="cell">
                    <tr>
                        <td><%=m++%></td>
                        <td>${cell.cell}</td>
                        <td>${cell.expected}</td>
                        <td>${cell.count}</td>
                        <td class="center">
                            <c:if test="${cell.closed == true}">
                                <span class="order-items-process span-size">
                                    <span class="badge badge-info">Reviewed</span>
                                </span><br>
                                <strong>${cell.review}</strong>
                            </c:if>
                            <c:if test="${cell.closed == false}">
                                <span class="order-items-process span-size">
                                    <span class="badge badge-warning">Pending Review</span>
                                </span>
                            </c:if>
                        </td>
                        <td class="center">
                            <button class="btn btn-sm btn-secondary" onclick="viewCellCountSheet(${cell.activitycellid}, ${cell.cellid}, '${cell.cell}')">
                                <i class="fa fa-dedent"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </fieldset>
</div>
<script type="text/javascript">
    var activityid = 0;
    $(document).ready(function () {
        $('#cellCounts').DataTable();
        $('#pendingReport').hide();
        $('#generateReport').hide();
        checkPendingItems();
    });
</script>
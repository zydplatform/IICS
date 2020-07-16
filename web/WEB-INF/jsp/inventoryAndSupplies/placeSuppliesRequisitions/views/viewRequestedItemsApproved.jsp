<%-- 
    Document   : viewRequestedItemsApproved
    Created on : Nov 13, 2018, 4:31:49 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../include.jsp"%>

<div class="tile">
    <div class="tile-body">
        <table class="table table-hover table-bordered col-md-12" id="table-view-orders-items2">
            <thead class="col-md-12">
                <tr>
                    <th class="center">No</th>
                    <th>Item</th>
                    <th class="right">Qty Ordered</th>
                    <th class="right">Qty Approved</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="tableFacilityOwner">
                <% int v = 1;%>
                <c:forEach items="${orderItemsList}" var="item">
                    <tr>
                        <td class="center"><%=v++%></td>
                        <td class="">${item.genericname}</td>
                        <td class="right">${item.qtyordered}</td>
                        <td class="right">${item.qtyapproved}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $('#table-view-orders-items2').DataTable();
</script>
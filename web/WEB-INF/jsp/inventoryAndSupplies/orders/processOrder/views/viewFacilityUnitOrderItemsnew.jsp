<%-- 
    Document   : viewFacilityUnitOrderItems
    Created on : Jul 16, 2018, 4:15:37 PM
    Author     : IICS-GRACE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>

<div class="tile">
    <div class="tile-body">
        <table class="table table-hover table-bordered col-md-12" id="table-view-items-new-orders">
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
                        <td class="right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${item.qtyordered / item.packsize}"/></td>
                        <td class="right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${item.qtyapproved / item.packsize}"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $('#table-view-items-new-orders').DataTable();
</script>
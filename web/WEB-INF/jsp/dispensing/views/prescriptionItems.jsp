<%-- 
    Document   : prescriptionItems
    Created on : Oct 6, 2018, 2:24:19 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp"%>

<div class="tile">
    <div class="tile-body">
        <table class="table table-hover table-bordered col-md-12" id="table-view-items-ready-orders">
            <thead class="col-md-12">
                <tr>
                    <th class="center">No</th>
                    <th>Item</th>
                    <th class="right">Quantity Approved</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="tableFacilityOwner">
                <% int v = 1;%>
            <c:forEach items="${prescItemsList}" var="item">
                <tr>
                    <td class="center"><%=v++%></td>
                    <td class="">${item.genericname}</td>
                    <td class="right">${item.quantityapproved}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $('#table-view-items-ready-orders').DataTable();
</script>
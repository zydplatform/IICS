<%-- 
    Document   : viewFacilityUnitOrderItemssanctioned
    Created on : Jul 17, 2018, 12:43:20 PM
    Author     : IICS-GRACE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>

<div class="tile">
    <div class="tile-body">
        <table class="table table-hover table-bordered col-md-12" id="table-view-items-sanctioned-orders">
            <thead class="col-md-12">
                <tr>
                    <th class="center">No</th>
                    <th>Item</th>
                    <th class="right">Qty Sanctioned</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="tableFacilityOwner">
                <% int v = 1;%>
                <c:forEach items="${orderItemsList}" var="item">
                    <tr>
                        <td class="center"><%=v++%></td>
                        <td class="">${item.genericname}</td>
                        <td class="right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${item.qtysanctioned / item.packsize}"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $('#table-view-items-sanctioned-orders').DataTable();
</script>
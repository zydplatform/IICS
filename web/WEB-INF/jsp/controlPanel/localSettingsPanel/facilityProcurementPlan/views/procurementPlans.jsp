<%-- 
    Document   : procurementPlans
    Created on : May 11, 2018, 12:14:11 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<table class="table table-hover table-bordered" id="tableFacilityprocurementplns">
    <thead>
        <tr>
            <th>No</th>
            <th>Procurement Plan</th>
            <th>Items</th>
            <th>Start Date</th>
            <th>End Date</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <% int i = 1;%>
        <c:forEach items="${facilityfinancialyearplans}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.orderperiodname}</td>
                <td align="center">
                    <button onclick="facilityprocurementplanitemzview(${a.orderperiodid},'${orderperiodtype}')"  title=" The Procured Procurement Plan Items." class="btn btn-secondary btn-sm add-to-shelf">
                        ${a.itemcount} Items
                    </button>
                </td>
                <td>${a.startdate}</td>
                <td>${a.enddate}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#tableFacilityprocurementplns').DataTable();
    function facilityprocurementplanitemzview(orderperiodid,orderperiodtype){
        ajaxSubmitData('facilityprocurementplanmanagement/facilityproczprocurementplanitemsview.htm', 'procurementplan_itemzdiv', 'act=a&orderperiodid=' + orderperiodid + '&orderperiodtype=' + orderperiodtype + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        $('#facilityprocurementplan_itemzview').modal('show');
    }
</script>
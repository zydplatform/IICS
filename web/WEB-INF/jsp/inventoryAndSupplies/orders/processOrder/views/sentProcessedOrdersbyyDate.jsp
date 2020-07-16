<%-- 
    Document   : sentProcessedOrdersbyyDate
    Created on : Oct 30, 2018, 4:07:25 AM
    Author     : HP
--%>
<%@include file="../../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="tile-body">
    <table class="table table-hover table-bordered col-md-12" id="table-sent-processed-orders099">
        <thead class="col-md-12">
            <tr>
                <th class="center">No</th>
                <th>Order Number</th>
                <th class="">Ordering Unit</th>
                <th class="center">No. of Items</th>
                <th class="">Serviced By</th>
                <th class="">Date Serviced</th>
                <th>Date Ordered</th>
                <th>Date Required </th>
                <th class="">Issue Out</th>
            </tr>
        </thead>
        <tbody class="col-md-12" id="">
            <% int f = 1;%>
            <c:forEach items="${sentApprovedOrderItemQtyList}" var="a">
                <tr id="">
                    <td class="center"><%=f++%></td>
                    <td><strong>${a.facilityorderno}</strong></td>
                    <td>${a.orderingUnit}</td>
                    <td class="center"><span class="badge badge-pill badge-success"><a href="#" style="color: #fff" onclick="functionViewOrderItemsappr(${a.facilityorderid})">${a.numberofitems}</a></span></td>
                    <td class="">${a.servicedby}</td>
                    <td class="">${a.dateserviced}</td>
                    <td>${a.dateprepared}</td>
                    <td>${a.dateneeded}</td>
                    <td class=""><button style="margin-top: -5px" class="order-items-pick-list btn btn-success btn-sm" data-facilityorderappid="${a.facilityorderid}" type="button" onclick="functionorderitemspicklist('${a.facilityorderid}')"><i class="fa fa-mail-reply-all"></i>Generate Pick List</button></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
            
            <script>
                $('#table-sent-processed-orders099').DataTable();
            </script>
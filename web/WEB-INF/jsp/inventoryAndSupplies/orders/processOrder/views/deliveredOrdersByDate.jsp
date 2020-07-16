<%-- 
    Document   : deliveredOrdersByDate
    Created on : Oct 30, 2018, 5:27:40 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<div class="tile-body">
    <table class="table table-hover table-bordered col-md-12" id="table-delivered-orders">
        <thead class="col-md-12">
            <tr>
                <th class="center">No</th>
                <th>Order Number</th>
                <th class="">Ordering Unit</th>
                <th class="center">No. of Items</th>
                <th class="">Handed Over By</th>
                <th class="">Handed Over To</th>
                <th class="center">Date Taken</th>
                <th>Date Ordered</th>
                <th>Date Required </th>
            </tr>
        </thead>
        <tbody class="col-md-12" id="">
            <% int f = 1;%>
            <c:forEach items="${deliveredOrders}" var="a">
                <tr id="${a.facilityorderid}">
                    <td class="center"><%=f++%></td>
                    <td><strong>${a.facilityorderno}</strong></td>
                    <td class=""><strong>${a.orderingUnit}</strong></td>
                    <td class="center"><span class="badge badge-pill badge-success"><a href="#" style="color: #fff" onclick="functionViewOrderItemsDerivered('${a.facilityorderid}')">${a.numberofitems}</a></span></td>
                    <td class="">${a.deliveredby}</td> 
                    <td class="">${a.deliveredto}</td>
                    <td class="center">${a.datedelivered}</td>
                    <td>${a.dateprepared}</td>
                    <td>${a.dateneeded}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
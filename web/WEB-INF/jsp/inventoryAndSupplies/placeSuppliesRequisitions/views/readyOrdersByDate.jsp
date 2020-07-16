<%-- 
    Document   : deliveredOrdersByDate
    Created on : Oct 30, 2018, 5:27:40 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../include.jsp"%>
<div class="tile-body">
    <table class="table table-hover table-bordered col-md-12" id="table-serviced-orders">
        <thead class="col-md-12">
            <tr>
                <th class="center">No</th>
                <th>Order Number</th>
                <th class="center">No. of Items</th>
                <th class="">Requester</th>
                <th class="">Date Requested</th>
                <th class="">Approved By</th>
                <th class="">Date Approved</th>
                <th class="">Issued By</th>
            </tr>
        </thead>
        <tbody class="col-md-12" id="">
            <% int f = 1;%>
            <c:forEach items="${deliveredOrders}" var="a">
                <tr id="${a.suppliesorderid}">
                    <td class="center"><%=f++%></td>
                    <td><strong>${a.orderno}</strong></td>
                    <td class="center"><span class="badge badge-pill badge-success"><a href="#" style="color: #fff" onclick="functionViewOrderItemsServicedSup('${a.suppliesorderid}')">${a.numberofitems}</a></span></td>
                    <td class="">${a.requester}</td> 
                    <td class="">${a.daterequested}</td>
                    <td class="">${a.approved}</td>
                    <td class="">${a.dateapproved}</td>
                    <td class="">${a.issuedby}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<%-- 
    Document   : viewReadyToIssueByyDate
    Created on : Oct 30, 2018, 4:41:03 AM
    Author     : HP
--%>
<%@include file="../../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="tile-body">
    <table class="table table-hover table-bordered col-md-12" id="table-sent-processed-orders22">
        <thead class="col-md-12">
            <tr>
                <th class="center">No</th>
                <th>Order Number</th>
                <th class="">Ordering Unit</th>
                <th class="center">No. of Items</th>
                <th class="">Picked By</th>
                <th class="center">Date Picked</th>
                <th>Date Ordered</th>
                <th>Date Required </th>
                <th class="center">Hand Over</th>
            </tr>
        </thead>
        <tbody class="col-md-12" id="">
            <% int f = 1;%>
            <c:forEach items="${pickedReadyToIssueList}" var="a">
                <tr id="">
                    <td class="center"><%=f++%></td>
                    <td><strong>${a.facilityorderno}</strong></td>
                    <td>${a.orderingUnit}</td>
                    <td class="center"><span class="badge badge-pill badge-success"><a href="#" style="color: #fff" onclick="functionViewOrderItemsIssue(${a.facilityorderid})">${a.numberofitems}</a></span></td>
                    <td class="">${a.pickedby}</td>
                    <td class="center">${a.datepicked}</td>
                    <td>${a.dateprepared}</td>
                    <td>${a.dateneeded}</td>
            <input type="hidden" value="${a.facilityorderno}" id="orderno${a.facilityorderid}"/>
            <td class="center"><button id="" data-facilityorderno="${a.facilityorderno}" data-facilityunitorderid="${a.facilityorderid}" data-originstore="${a.originstore}" style="margin-top: -5px" class="btn btn-success btn-sm btnSendOrderForHandOverOrder" type="button" onclick="functionsendOrderForHandOverOrder('${a.originstore}', '${a.facilityorderid}')"><i class="fa fa-handshake-o"></i></button></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    $('#table-sent-processed-orders22').DataTable();
</script>
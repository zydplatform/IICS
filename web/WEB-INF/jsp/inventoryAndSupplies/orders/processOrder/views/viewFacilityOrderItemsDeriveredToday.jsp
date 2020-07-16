<%-- 
    Document   : viewFacilityOrderItemsDeriveredToday
    Created on : Jul 31, 2018, 7:37:02 PM
    Author     : IICS-GRACE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<div class="">
    <div class="">
        <div class="tile">
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
                        <c:forEach items="${todayDeliveredOrders}" var="a">
                            <tr id="${a.facilityorderid}">
                                <td class="center"><%=f++%></td>
                                <td><strong>${a.facilityorderno}</strong></td>
                                <td class=""><a href="#" class="class-facility-unit-details4" data-facilityunitid4="${a.originstore}"><font color="blue"><strong>${a.orderingUnit}</strong></font></a></td>
                                <td class="center"><span class="badge badge-pill badge-success"><a href="#" style="color: #fff" onclick="functionViewTodayOrderItemsDerivered(${a.facilityorderid})">${a.noOfItems}</a></span></td>
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
        </div>
    </div>
</div>
<script>
    function functionViewTodayOrderItemsDerivered(facilityorderid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "ordersmanagement/viewfacilityunitorderitemsdeliveredorders.htm",
            data: {facilityorderid: facilityorderid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">ORDER DELIVERED ITEMS TODAY.</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '80%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    buttons: {
                        somethingElse: {
                            text: 'OK',
                            btnClass: 'btn-purple',
                            action: function () {
                            }
                        }
                    }
                });
            }
        });
    }
</script>
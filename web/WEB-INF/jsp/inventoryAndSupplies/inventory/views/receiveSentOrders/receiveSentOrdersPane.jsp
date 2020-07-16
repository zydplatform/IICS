<%--
    Document   : receiveSentOrdersPane
    Created on : Sep 27, 2018, 6:27:53 AM
    Author     : HP
--%>
<%@include file="../../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    .order-delivered-items-view:hover{
        text-decoration: underline !important;
        cursor: pointer; 
    }
</style>
<div class="tile">
    <div class="tile-body">
        <table class="table table-hover table-bordered col-md-12" id="table-receive-unit-orders">
            <thead class="col-md-12">
                <tr>
                    <th class="center">No</th>
                    <th>Order Number</th>
                    <th class="">Supplier Unit</th>
                    <th class="center">No. of Items</th>
                    <th class="">Issued By</th>
                    <th class="">Issued To</th>
                    <th class="center">Receive</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="">
                <% int e = 1;%>
                <c:forEach items="${readyOrdersList}" var="a">
                    <tr id="">
                        <td class="center"><%=e++%></td>
                        <td><a data-facilityorderid="${a.facilityorderid}"><strong>${a.orderno}</strong></a></td>
                        <td>${a.supplierunit}</td>
                        <td class="center"><span class="badge badge-pill badge-success"><a class="order-delivered-items-view" onclick="functionViewOrderItemsReadyOrderItems(${a.facilityorderid})" style="color: #fff">${a.numberofitems}</a></span></td>
                        <td class="">${a.deliveredby}</td>
                        <td class="">${a.deliveredto}</td>
                        <td class="center" id="order${a.facilityorderid}" data-ordernumber="${a.orderno}" onclick="functionRecieveReadyOreder(${a.facilityorderid}, ${a.destinationstore})"><i style="font-size: 147%" class="fa fa-download order-delivered-items-view" aria-hidden="true"></i></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    $('#table-receive-unit-orders').DataTable();
    function functionRecieveReadyOreder(facilityorderid, destinationstore) {
        var ordernumber = $('#order' + facilityorderid).data('ordernumber');
        $.ajax({
            type: "GET",
            cache: false,
            url: "ordersmanagement/receiveFacilityUnitReadyOrder.htm",
            data: {facilityorderid: facilityorderid, destinationstore: destinationstore, ordernumber: ordernumber},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">RECEIVE ORDER ITEMS.</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '90%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        somethingElse: {
                            text: 'Close',
                            btnClass: 'btn-red close-dialog',
                            confirm: function () {

                            }
                        }
                    }
                });
            }
        });
    }
    
    function functionViewOrderItemsReadyOrderItems(facilityorderid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "ordersmanagement/viewfacilityunitorderitemsdeliveredorders22.htm",
            data: {facilityorderid: facilityorderid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">ISSUED ITEMS.</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        somethingElse: {
                            text: 'Close',
                            btnClass: 'btn-red',
                            action: function () {

                            }
                        }
                    }
                });
            }
        });
    }
</script>

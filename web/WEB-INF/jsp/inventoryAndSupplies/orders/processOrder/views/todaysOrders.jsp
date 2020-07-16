<%--
    Document   : todaysOrders
    Created on : May 16, 2018, 6:50:06 AM
    Author     : IICS-GRACE
--%>
<style>
    .order-items-process:hover{
        text-decoration: underline !important;
        cursor: pointer; 
    }
</style>
<%@include file="../../../../include.jsp"%>
<div class="tabsSec">
    <div class="tabsnew row">
        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-1" checked class="tab-switch">
            <label for="tab-1" class="tab-label">New Orders <span class="badge badge badge-info">${todaysOrdersCount}</span></label>
            <div class="tab-content" style="margin-left: -10px">
                <div class="">
                    <div class="">
                        <div class="tile">
                            <div class="tile-body">
                                <table class="table table-hover table-bordered col-md-12" id="tableTodayProcessOrders">
                                    <thead class="col-md-12">
                                        <tr>
                                            <th class="center">No</th>
                                            <th>Order Number</th>
                                            <th class="">Ordering Unit</th>
                                            <th class="center">No. of Items</th>
                                            <th class="">Prepared By</th>
                                            <th class="">Approved By</th>
                                            <th>Date Ordered</th>
                                            <th>Date Required </th>
                                        </tr>
                                    </thead>
                                    <tbody class="col-md-12" id="">
                                        <% int y = 1;%>
                                        <c:forEach items="${todaysOrders}" var="a">
                                            <c:choose>
                                                <c:when test="${a.isemergency == 'true'}">
                                                    <tr id="" style="background-color: #fda4a4">
                                                        <td class="center"><%=y++%></td>
                                                        <td><a class="order-items-process" data-facilityorderid="${a.facilityorderid}" data-ordering-unit-id="${a.orderingunitid}"><font color="blue"><strong>${a.facilityorderno}</strong></font></a></td>
                                                        <td><strong>${a.orderingUnit}</strong></td>
                                                        <td class="center"><span class="badge badge-pill badge-success"><a onclick="functionViewOrderItems(${a.facilityorderid})" style="color: #fff" href="#">${a.numberofitems}</a></span></td>
                                                        <td class="">${a.preparedby}</td>
                                                        <td class="">${a.approvedby}</td>
                                                        <td>${a.dateprepared}</td>
                                                        <td>${a.dateneeded}</td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr id="">
                                                        <td class="center"><%=y++%></td>
                                                        <td><a class="order-items-process" data-facilityorderid="${a.facilityorderid}" data-ordering-unit-id="${a.orderingunitid}"><font color="blue"><strong>${a.facilityorderno}</strong></font></a></td>
                                                        <td><strong>${a.orderingUnit}</strong></td>
                                                        <td class="center"><span class="badge badge-pill badge-success"><a onclick="functionViewOrderItems(${a.facilityorderid})" style="color: #fff" href="#">${a.numberofitems}</a></span></td>
                                                        <td class="">${a.preparedby}</td>
                                                        <td class="">${a.approvedby}</td>
                                                        <td>${a.dateprepared}</td>
                                                        <td>${a.dateneeded}</td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>

                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-2" class="tab-switch" onclick="ajaxSubmitData('ordersmanagement/viewSentApprovedOrders.htm', 'apprroved-order-content', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label for="tab-2" class="tab-label">Sanctioned Orders <span id="noOfSanctioned" class="badge badge-info">0</span></label>
            <div class="tab-content" style="margin-left: -140px">
                <div class="" id="apprroved-order-content">

                </div>
            </div>
        </div>

        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-3" class="tab-switch" onclick="ajaxSubmitData('ordersmanagement/viewReadyToIssueOrders.htm', 'ready-to-issue-order-content', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label for="tab-3" class="tab-label">Ready for Issue <span id="noOfPicked" class="badge badge-info">0</span></label>
            <div class="tab-content" style="margin-left: -320px">
                <div class="" id="ready-to-issue-order-content">

                </div>
            </div>
        </div>

        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-4" class="tab-switch" onclick="ajaxSubmitData('ordersmanagement/viewTodaysDeliveredOrders.htm', 'today-delivered-facilityunit-orders', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label for="tab-4" class="tab-label">Issued Orders <span class="badge badge-info">${noOfTodaysDelivereditemsCount}</span></label>
            <div class="tab-content" style="margin-left: -494px">
                <div class="" id="today-delivered-facilityunit-orders">

                </div>
            </div>
        </div>

    </div>
</div>

<!--model Manage Order Items-->
<div class="">
    <div id="modalOrderitems" class="modalOrderitemsdialog">
        <div class="">
            <div id="head">
                <h3 class="modal-title" id="title"><font color="purple">Order Processing...</font></h3>
                <a href="#close" title="Close" class="close2">X</a>
                <hr>
            </div>
            <div class="scrollbar row" id="content">

            </div>
        </div>
    </div>
</div>

<div id="showgenericname"></div>
<script>
    $(document).ready(function () {
        $('#tableTodayProcessOrders').DataTable();
        breadCrumb();

//        $('.order-items-process').click(function () {
//            var facilityorderid = $(this).data("facilityorderid");
//            $('#content').html('');
//            $.ajax({
//                type: 'GET',
//                data: {facilityorderid: facilityorderid},
//                url: 'ordersmanagement/ordersitemsprocessmanagement.htm',
//                success: function (items) {
//                    $('#content').html(items);
//                }
//            });
//            window.location = '#modalOrderitems';
//            initDialog('modalOrderitemsdialog');
//        });

        $('#tableTodayProcessOrders').on('click', '.order-items-process', function () {
            var facilityorderid = $(this).data("facilityorderid");
            var orderingUnitId = $(this).data("ordering-unit-id");
            $('#content').html('');
            $.ajax({
                type: 'GET',
                data: { facilityorderid: facilityorderid, orderingunitid: orderingUnitId },
                url: 'ordersmanagement/ordersitemsprocessmanagement.htm',
                success: function (items) {
                    $('#content').html(items);
                }
            });
            window.location = '#modalOrderitems';
            initDialog('modalOrderitemsdialog');
        });

        $.ajax({
            type: 'GET',
            data: {},
            url: 'ordersmanagement/orderSanctionedCount.htm',
            success: function (items) {
                $('#noOfSanctioned').html(items);
            }
        });
        
        $.ajax({
            type: 'GET',
            data: {},
            url: 'ordersmanagement/readyToIssue.htm',
            success: function (items) {
                $('#noOfPicked').html(items);
            }
        });

    });

    function functionViewOrderItems(facilityorderid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "ordersmanagement/viewfacilityunitorderitemsneworders.htm",
            data: {facilityorderid: facilityorderid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">FACILITY UNIT ORDERED ITEMS.</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '50%',
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
    
    function showOrderItems(facilityunitorderid){
        $('#content').html('');
        $.ajax({
            type: 'GET',
            data: {facilityorderid: facilityunitorderid},
            url: 'ordersmanagement/ordersitemsprocessmanagement.htm',
            success: function (items) {
                $('#content').html(items);
            }
        });
        window.location = '#modalOrderitems';
        initDialog('modalOrderitemsdialog');
    }
</script>
<%-- 
    Document   : unservicedOrders
    Created on : Jul 17, 2019, 8:51:35 AM
    Author     : IICS TECHS
--%>

<%@include file="../../../../include.jsp"%>

<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-5 col-sm-6 text-right"  style="line-height: 2.50em;">                
                <label for="target-date">Date: </label>
            </div>
            <div class="col-md-2 col-sm-4">
                <form>
                    <div class="form-group">
                        <input class="form-control" id="target-date" name="target-date" type="text" placeholder="DD-MM-YYYY"/>
                    </div>
                </form>
            </div>
            <div class="col-md-2 col-sm-1">
                <button class="btn btn-primary" id="search-unserviced-orders" type="button" style="margin-top: auto; margin-bottom: auto;">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <table id="unserviced-orders-table" class="table table-bordered">
            <thead>
                <th>No.</th>
                <th>Order Number</th>
                <th>Recorded By</th>
                <th>Date Recorded</th>
                <th>Servicing Unit</th>
                <th>Ordering Unit</th>
                <th>Date Ordered</th>
                <th>Date Required </th>
                <th class="center">View Items</th>
            </thead>
            <tbody>
                <c:forEach items="${orders}" var="order">
                    <tr>
                        <td></td>
                        <td>${order.facilityorderno}</td>
                        <td>${order.addedby}</td>
                        <td>${order.dateadded}</td>
                        <td>${order.servicingunit}</td>
                        <td>${order.orderingunit}</td>
                        <td>${order.dateprepared}</td>
                        <td>${order.dateneeded}</td>
                        <td class="center">
                            <button class="btn btn-sm btn-primary fa fa-list view-unserviced-order-items" 
                                    data-unserviced-order-id="${order.unservicedorderid}"
                                    data-order-number="${order.facilityorderno}"
                                    data-recorded-by="${order.addedby}"
                                    data-date-recorded="${order.dateadded}"></button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot></tfoot>
        </table>
    </div>
</div>


<script>
    var serverDate = '${serverdate}';
    $(function(){
        var targetDate = '${targetdate}';
        $("#target-date").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(targetDate)            
        });
        if (!$.fn.DataTable.isDataTable('#unserviced-orders-table')) {
            var table = $('#unserviced-orders-table').DataTable({
                "lengthMenu": [5,10, 25, 50, 100],
                "pageLength": 10
            });
            table.on('order.dt search.dt', function () {
                table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                    cell.innerHTML = i + 1;
                });
            }).draw();
        }
    });
    $('#search-unserviced-orders').on('click', function(){
        getUnservicedOrders($('#target-date').val());
    });
    $('#unserviced-orders-table').on('click', '.view-unserviced-order-items', function(){
        var unservicedOrderId = $(this).data('unserviced-order-id');
        var order = $(this).data('order-number');
        var recordedBy = $(this).data('recorded-by');
        var dateRecorded = $(this).data('date-recorded');        
        $.ajax({
            type: 'GET',
            data: { unservicedorderid: unservicedOrderId },
            url: 'ordersmanagement/unservicedorderitems.htm',
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'UNSERVICED ORDER ITEMS',
                    type: 'purple',
                    typeAnimated: true,
                    boxWidth: '65%',
                    closeIcon: true,
                    useBootstrap: false,
                    content: data,
                    buttons: {
                        CLOSE: {
                            text: 'Close',
                            btnClass: 'btn btn-purple',
                            action: function () {
                                
                            }
                        }
                    },
                    onContentReady: function () {
                        var table = this.$content.find('#unserviced-order-items-table');                        
                        this.$content.find('#order').html(order);
                        this.$content.find('#recorded-by').html(recordedBy);
                        this.$content.find('#date-recorded').html(dateRecorded);
                        if (!$.fn.DataTable.isDataTable('#unserviced-order-items-table')) {
                            var table = $('#unserviced-order-items-table').DataTable({
                                "lengthMenu": [5,10, 25, 50, 100],
                                "pageLength": 10
                            });
                            table.on('order.dt search.dt', function () {
                                table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                                    cell.innerHTML = i + 1;
                                });
                            }).draw();
                        }
                    }
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    });
</script>
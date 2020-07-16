<%-- 
    Document   : deliveredOrders
    Created on : Jul 20, 2018, 4:45:33 AM
    Author     : IICS-GRACE
--%>

<%@include file="../../../../include.jsp"%>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-2">
                <form>
                    <div class="form-group">
                        <label for="">Select Date</label>
                        <input class="form-control" id="reportDeliveredDate" type="text" placeholder="DD-MM-YYYY">
                    </div>
                </form>
            </div>
            <div class="col-md-2" style="margin-top: 21px; margin-left: -1%;">
                <button class="btn btn-primary" id="" type="button" onclick="functionreportDeliveredOrders()">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>
<div class="tile" id="deliveredOrderContent">
    <%@include file="../views/deliveredOrdersByDate.jsp"%>
</div>

<script>
    var serverDate = '${serverdate}';
    $(document).ready(function () {
        var reportDeliveredDate;
        $("#reportDeliveredDate").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });

        $('#table-delivered-orders').DataTable();

        $('.class-facility-unit-details4').click(function () {
            var facilityunitid = $(this).data("facilityunitid4");
            $.ajax({
                type: 'GET',
                data: {facilityunitid: facilityunitid},
                url: 'ordersmanagement/viewfacilityunitdetails.htm',
                success: function (items) {
                    $('#orderingUnitDetails4').html(items);
                }
            });
            $('#modalFacilityUnitDetails4').modal('show');
        });
    });

    function functionViewOrderItemsDerivered(facilityorderid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "ordersmanagement/viewfacilityunitorderitemsdeliveredorders.htm",
            data: {facilityorderid: facilityorderid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">ORDER DELIVERED ITEMS.</strong>',
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
    
    function functionreportDeliveredOrders() {
        reportDeliveredDate = $('#reportDeliveredDate').val();
        $('#deliveredOrderContent').html('');
        $.ajax({
            type: 'GET',
            data: {date: reportDeliveredDate},
            url: 'ordersmanagement/managedeliveredordersbyydate.htm',
            success: function (report) {
                $('#deliveredOrderContent').html(report);
            }
        });
    }
</script>
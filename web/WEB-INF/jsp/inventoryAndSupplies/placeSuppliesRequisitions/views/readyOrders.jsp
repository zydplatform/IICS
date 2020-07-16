<%-- 
    Document   : deliveredOrders
    Created on : Jul 20, 2018, 4:45:33 AM
    Author     : IICS-GRACE
--%>

<%@include file="../../../include.jsp"%>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-2">
                <form>
                    <div class="form-group">
                        <label for="">Select Date</label>
                        <input class="form-control" id="reportServicedDatesup" type="text" placeholder="DD-MM-YYYY">
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
<div class="tile" id="deliveredOrderContentsup">
    <%@include file="../views/readyOrdersByDate.jsp"%>
</div>

<script>
    var serverDate = '${serverdate}';
    $(document).ready(function () {
        var reportServicedDatesup;
        $("#reportServicedDatesup").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });

        $('#table-serviced-orders').DataTable();
    });

    function functionViewOrderItemsServicedSup(suppliesorderid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "sandriesreq/manageServicedOrders.htm",
            data: {suppliesorderid: suppliesorderid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">FACILITY UNIT SERVICED ITEMS.</strong>',
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

    function functionreportDeliveredOrders() {
        reportServicedDatesup = $('#reportServicedDatesup').val();
        $('#deliveredOrderContentsup').html('');
        $.ajax({
            type: 'GET',
            data: {date: reportServicedDatesup},
            url: 'sandriesreq/viewfacilityunitorderitemsservicedsupbydate.htm',
            success: function (report) {
                $('#deliveredOrderContentsup').html(report);
            }
        });
    }
</script>
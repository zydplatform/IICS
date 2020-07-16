<%-- 
    Document   : sentProcessedApprovedOrders
    Created on : Jun 29, 2018, 12:59:47 PM
    Author     : IICS-GRACE
--%>
<%@include file="../../../../include.jsp"%>
<div class="row">
<!--    <div class="col-md-12">
        <div class="row">
            <div class="col-md-2">
                <form>
                    <div class="form-group">
                        <label for="">Select Date</label>
                        <input class="form-control" id="reportSanctionedDate" type="text" placeholder="DD-MM-YYYY">
                    </div>
                </form>
            </div>
            <div class="col-md-2" style="margin-top: 21px; margin-left: -1%;">
                <button class="btn btn-primary" id="" type="button" onclick="functionreportSanctionedOrders()">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>-->
</div>
<div class="tile col-md-12" id="sanctionedOrderContent">
    <%@include file="../views/sentProcessedOrdersbyyDate.jsp"%>
</div>

<script>
    var serverDate = '${serverdate}';
    $(document).ready(function () {
        var reportSanctionedDate;
        $("#reportSanctionedDate").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });

    });

    function functionorderitemspicklist(facilityorderid) {
        console.log(facilityorderid);
        $('#content').html('');
        $.ajax({
            type: 'GET',
            data: {facilityorderid: facilityorderid},
            url: 'ordersmanagement/generateorderpicklist.htm',
            success: function (items) {
                $('#content').html(items);
            }
        });
        window.location = '#modalOrderitems';
        initDialog('modalOrderitemsdialog');
    }

    function functionViewOrderItemsappr(facilityorderid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "ordersmanagement/viewfacilityunitorderitemssanctionedorder.htm",
            data: {facilityorderid: facilityorderid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">SANCTIONED ITEMS.</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '60%',
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

    function functionreportSanctionedOrders() {
        reportSanctionedDate = $('#reportSanctionedDate').val();
        $('#sanctionedOrderContent').html('');
        $.ajax({
            type: 'GET',
            data: {date: reportSanctionedDate},
            url: 'ordersmanagement/viewSentApprovedOrdersByDate.htm',
            success: function (report) {
                $('#sanctionedOrderContent').html(report);
            }
        });
    }
</script>
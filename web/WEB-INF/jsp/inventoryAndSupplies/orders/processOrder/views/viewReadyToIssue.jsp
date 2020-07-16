<%--
    Document   : viewReadyToIssue
    Created on : Jul 3, 2018, 5:18:28 PM
    Author     : IICS-GRACE
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<!--<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-2">
                <form>
                    <div class="form-group">
                        <label for="">Select Date</label>
                        <input class="form-control" id="reportPickedDate" type="text" placeholder="DD-MM-YYYY">
                    </div>
                </form>
            </div>
            <div class="col-md-2" style="margin-top: 21px; margin-left: -1%;">
                <button class="btn btn-primary" id="" type="button" onclick="functionreportPickedOrders()">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>-->
<div class="tile" id="pickeddOrderContent">    
    <%@include file="../views/viewReadyToIssueByyDate.jsp"%>
</div>
<script>
    var serverDate = '${serverdate}';
    $(document).ready(function () {
        var reportPickedDate;
        $("#reportPickedDate").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });
    });

    function functionsendOrderForHandOverOrder(originstore, facilityunitorderid) {
        $('#content').html('');
        var fOrderno =  $('#orderno'+facilityunitorderid).val();
        $.ajax({
            type: 'GET',
            url: 'ordersmanagement/handOverOrder.htm',
            data: {facilityorderid: facilityunitorderid, originstore: originstore, orderno: fOrderno},
            success: function (items) {
                $('#content').html(items);
                $('#modalOrderitemsContents').show();
            }
        });
        window.location = '#modalOrderitems';
        initDialog('modalOrderitemsdialog');
    }

    function functionViewOrderItemsIssue(facilityorderid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "ordersmanagement/viewfacilityunitorderitemspickedorder.htm",
            data: {facilityorderid: facilityorderid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">ORDER PICKED ITEMS.</strong>',
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

    function functionreportPickedOrders() {
        reportPickedDate = $('#reportPickedDate').val();
        $('#pickeddOrderContent').html('');
        $.ajax({
            type: 'GET',
            data: {date: reportPickedDate},
            url: 'ordersmanagement/viewReadyToIssueOrdersByDate.htm',
            success: function (report) {
                $('#pickeddOrderContent').html(report);
            }
        });
    }
</script>
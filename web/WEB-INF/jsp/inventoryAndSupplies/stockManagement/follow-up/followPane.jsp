<%-- 
    Document   : followPane
    Created on : 12-Jul-2018, 10:58:34
    Author     : IICS
--%>

<%@include file="../../../include.jsp" %>
<c:if test="${not empty activities}">
    <div class="row">
        <div class="col-md-4 col-sm-4">
            <form action="" class="formName">
                <div class="form-group">
                    <select class="form-control" id="follow-select">
                        <c:forEach items="${activities}" var="activity">
                            <option value="${activity.id}" id="fol${activity.id}" data-name="${activity.name}">${activity.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12" id="follow-items">

        </div>
    </div>
</c:if>
<c:if test="${empty activities}">
    <div class="row">
        <div class="col-md-12 text-center">
            <h5>
                No Activities Set.
            </h5>
        </div>
    </div>
</c:if>
<c:if test="${not empty activities}">
    <script type="text/javascript">
        var activityid = 0;
        $(document).ready(function () {
            $('#follow-select').select2();
            $('.select2').css('width', '100%');
            activityid = $('#follow-select').val();
            ajaxSubmitData('stock/fetchActivityFollowupItems.htm', 'follow-items', '&activityid=' + activityid, 'POST');
            $('#follow-select').change(function () {
                $('#follow-items').html('');
                activityid = $('#follow-select').val();
                ajaxSubmitData('stock/fetchActivityFollowupItems.htm', 'follow-items', '&activityid=' + activityid, 'POST');
            });
        });
        function checkItemFollowupStatus(itemid, batchNo, delta) {
            activityid = $('#follow-select').val();
            var data = {
                activityid: activityid,
                itemid: itemid,
                batch: batchNo
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'stock/checkItemFollowupStatus.htm',
                success: function (response) {
                    var status = JSON.parse(response);
                    if (status.action === '-') {
                        if (delta < 0) {
                            $('#button' + itemid.toString() + batchNo.toString()).html('Record Discrepancy');
                        } else {
                            $('#button' + itemid.toString() + batchNo.toString()).html('Add to Stock');
                        }
                        $('#button' + itemid.toString() + batchNo.toString()).prop('disabled', false);
                    } else {
                        if (delta < 0) {
                            $('#batch' + itemid.toString() + batchNo.toString()).html('<span class="badge span-size-15 badge-success">Discrepancy Recorded</span>');
                        } else {
                            $('#batch' + itemid.toString() + batchNo.toString()).html('<span class="badge span-size-15 badge-success">Added to Stock</span>');
                        }
                    }
                }
            });
        }

        function discrepancyAction(itemid, delta, batchNo, itemName, expiry) {
            activityid = $('#follow-select').val();
            if (delta < 0) {
                var data = {
                    activityid: activityid,
                    itemid: itemid,
                    batch: batchNo,
                    expiry: expiry,
                    discrepancy: parseInt(0 - delta)
                };
                $.confirm({
                    title: '<h3>Record Discrepancy</h3>',
                    content: '<h4 class="itemTitle">Item: <strong style="color: blue;">' + itemName + '</strong></h4>' +
                            '<h5 class="itemTitle">Batch No: <strong style="color: blue;">' + batchNo + '</strong></h5>' +
                            '<h5 class="itemTitle">Quantity: <strong style="color: red;">' + parseInt(0 - delta) + '</strong></h5>',
                    type: 'blue',
                    boxWidth: '35%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Record',
                            btnClass: 'btn-info',
                            action: function () {
                                $.ajax({
                                    type: 'POST',
                                    data: data,
                                    url: 'stock/recordDiscrepancy.htm',
                                    success: function (res) {
                                        if (res === 'saved') {
                                            $('#batch' + itemid.toString() + batchNo.toString()).html('<span class="badge span-size-15 badge-success">Discrepancy Recorded</span>');
                                        } else if (res === 'failed') {
                                            $.toast({
                                                heading: 'Warning',
                                                text: 'Failed to Record Discrepancy',
                                                icon: 'warning',
                                                hideAfter: 2000,
                                                position: 'mid-center'
                                            });
                                        } else if (res === 'refresh') {
                                            document.location.reload(true);
                                        }
                                    }
                                });
                            }
                        },
                        close: {
                            text: 'Cancel',
                            btnClass: 'btn-red',
                            action: function () {

                            }
                        }
                    }
                });
            } else {
                var data = {
                    activityid: activityid,
                    itemid: itemid,
                    batch: batchNo,
                    discrepancy: delta,
                    expiry: expiry
                };
                $.confirm({
                    title: '<h3>Add Item to Stock</h3>',
                    content: '<h4 class="itemTitle">Item: <strong style="color: blue;">' + itemName + '</strong></h4>' +
                            '<h5 class="itemTitle">Batch No: <strong style="color: blue;">' + batchNo + '</strong></h5>' +
                            '<h5 class="itemTitle">Quantity: <strong style="color: green;">' + delta + '</strong></h5>',
                    type: 'blue',
                    boxWidth: '35%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Add Item',
                            btnClass: 'btn-info',
                            action: function () {
                                $.ajax({
                                    type: 'POST',
                                    data: data,
                                    url: 'stock/addItemtoStock.htm',
                                    success: function (res) {
                                        if (res === 'saved') {
                                            $('#batch' + itemid.toString() + batchNo.toString()).html('<span class="badge span-size-15 badge-success">Added to Stock</span>');
                                        } else if (res === 'failed') {
                                            $.toast({
                                                heading: 'Warning',
                                                text: 'Failed to Add Items',
                                                icon: 'warning',
                                                hideAfter: 2000,
                                                position: 'mid-center'
                                            });
                                        } else if (res === 'refresh') {
                                            document.location.reload(true);
                                        }
                                    }
                                });
                            }
                        },
                        close: {
                            text: 'Cancel',
                            btnClass: 'btn-red',
                            action: function () {

                            }
                        }
                    }
                });
            }
        }

        function printDiscrepancyReport(fileName) {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Print Stock Activity Discrepancies!',
                content: '<div id="printBox" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
                type: 'purple',
                typeAnimated: true,
                boxWidth: '70%',
                useBootstrap: false,
                buttons: {
                    close: {
                        text: 'Close',
                        action: function () {

                        }
                    }
                },
                onContentReady: function () {
                    var printBox = this.$content.find('#printBox');
                    $.ajax({
                        type: 'GET',
                        data: {file: fileName},
                        url: 'stock/createDiscrepancyReportPDF.htm',
                        success: function (res) {
                            if (res !== '') {
                                var objbuilder = '';
                                objbuilder += ('<object width="100%" height="500px" data="data:application/pdf;base64,');
                                objbuilder += (res);
                                objbuilder += ('" type="application/pdf" class="internal">');
                                objbuilder += ('<embed src="data:application/pdf;base64,');
                                objbuilder += (res);
                                objbuilder += ('" type="application/pdf"/>');
                                objbuilder += ('</object>');
                                printBox.html(objbuilder);
                            } else {
                                printBox.html('<div class="bs-component">' +
                                        '<div class="alert alert-dismissible alert-warning">' +
                                        '<h4>Warning!</h4>' +
                                        '<p>Error generating PDF, click <strong><a class="alert-link" onclick="resetPrint()" href="#!">Here</a></strong> to refresh.</p></div></div>'
                                        );
                            }
                        }
                    });
                }
            });
        }

        function resetPrint() {
            $('#follow-items').html('');
            activityid = $('#follow-select').val();
            ajaxSubmitData('stock/fetchActivityFollowupItems.htm', 'follow-items', '&activityid=' + activityid, 'POST');
            $('.jconfirm-buttons > .btn').click();
        }
    </script>
</c:if>
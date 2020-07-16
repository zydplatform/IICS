<%-- 
    Document   : cellCounts
    Created on : 16-May-2018, 15:24:39
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty activities}">
    <div class="row">
        <div class="col-md-4 col-sm-4">
            <form action="" class="formName">
                <div class="form-group">
                    <select class="form-control" id="count-select">
                        <c:forEach items="${activities}" var="activity">
                            <option value="${activity.id}" id="act${activity.id}" data-name="${activity.name}">${activity.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12" id="itemCounts">

        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="viewCellItemCount" class="modalDialog viewCellItemCount">
                <div>
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title" id="cell-count-title"></h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="content">
                        <div class="col-md-12" id="cellItemCount"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="viewActivityReport" class="modalDialog viewActivityReport">
                <div>
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title" id="activity-report-title"></h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="content">
                        <div class="col-md-12" id="reportContent"></div>
                    </div>
                </div>
            </div>
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
            $('#count-select').select2();
            $('.select2').css('width', '100%');

            activityid = $('#count-select').val();
            ajaxSubmitData('stock/fetchActivityCellSummary.htm', 'itemCounts', '&activityid=' + activityid, 'POST');
            $('#count-select').change(function () {
                $('#itemCounts').html('');
                activityid = $('#count-select').val();
                ajaxSubmitData('stock/fetchActivityCellSummary.htm', 'itemCounts', '&activityid=' + activityid, 'POST');
            });
        });

        function viewCellCountSheet(activitycellid, cellid, cellName) {
            $('#cellItemCount').html('');
            $('#cell-count-title').html(cellName);
            window.location = '#viewCellItemCount';
            initDialog('viewCellItemCount');
            activityid = $('#count-select').val();
            ajaxSubmitData('stock/fetchCellCountDetails.htm', 'cellItemCount', '&activitycellid=' + activitycellid + '&cellid=' + cellid + '&activityid=' + activityid, 'POST');
        }

        function recountCell(itemid, itemName, activitycellid) {
            $.confirm({
                title: '<h3>' + itemName + '</h3>',
                content: '<div class="form-group">' +
                        '<label for="staff">Select Staff</label>' +
                        '<select id="staff" class="form-control"/>' +
                        '</select>' +
                        '</div>',
                boxWidth: '45%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    formSubmit: {
                        text: 'Save Recount',
                        btnClass: 'btn-purple',
                        action: function () {
                            var staff = this.$content.find('#staff');
                            if (parseInt(staff.val()) > 0) {
                                var data = {
                                    staffid: staff.val(),
                                    itemid: itemid,
                                    activitycellid: activitycellid
                                };
                                $.ajax({
                                    type: 'POST',
                                    data: data,
                                    url: 'stock/saveRecount.htm',
                                    success: function (res) {
                                        if (res === 'saved') {
                                            $.toast({
                                                heading: 'Alert',
                                                text: 'Recount Set',
                                                icon: 'info',
                                                hideAfter: 2000,
                                                position: 'mid-center'
                                            });
                                            $('.issue-recount').html('Resount Issued');
                                            $('.issue-recount' + itemid).prop('disabled', 'true');
                                            $('.recount').prop('disabled', true);
                                            $('.close-cell').prop('disabled', true);
                                            $('#itemCounts').html('');
                                            activityid = $('#count-select').val();
                                            ajaxSubmitData('stock/fetchActivityCellSummary.htm', 'itemCounts', '&activityid=' + activityid, 'POST');
                                        } else if (res === 'failed') {
                                            $.toast({
                                                heading: 'Alert',
                                                text: 'Failed to set Item Recount',
                                                icon: 'warning',
                                                hideAfter: 2000,
                                                position: 'mid-center'
                                            });
                                        } else if (res === 'refresh') {
                                            document.location.reload(true);
                                        }
                                    }
                                });
                            } else {
                                $.alert('Please Select a Staff Member');
                                return false;
                            }
                        }
                    },
                    close: {
                        text: 'Cancel',
                        btnClass: 'btn-red'
                    }
                },
                onContentReady: function () {
                    // bind to events
                    var staff = this.$content.find('#staff');
                    $.ajax({
                        type: 'POST',
                        url: 'stock/fetchUnitStaffJSON.htm',
                        success: function (res) {
                            var staffList = JSON.parse(res);
                            for (i in staffList) {
                                staff.append('<option value="' + staffList[i].id + '">' + staffList[i].names + '</option>');
                            }
                        }
                    });
                }
            });
        }

        function closeCell(activitycellid, cellid) {
            $.confirm({
                title: '<h3>' + $('#cell-count-title').html() + '</h3>',
                content: '<h4 class="itemTitle">Cell <strong>' + $('#cell-count-title').html() + '</strong> Will be closed for <strong>' + $('#act' + activityid).data('name') + '</strong> Stock Taking.</h4>',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Close Cell',
                        btnClass: 'btn-purple',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {cellid: cellid, activitycellid: activitycellid},
                                url: 'stock/closeCell.htm',
                                success: function (res) {
                                    if (res === 'saved') {
                                        $('.recount').prop('disabled', true);
                                        $('.close-cell').prop('disabled', 'true');
                                        $('.close-cell').html('<i class="fa fa-close"></i>&nbsp;Cell Closed');
                                        activityid = $('#count-select').val();
                                        ajaxSubmitData('stock/fetchActivityCellSummary.htm', 'itemCounts', '&activityid=' + activityid, 'POST');
                                        checkPendingItems();
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

        function checkPendingItems() {
            activityid = $('#count-select').val();
            $.ajax({
                type: 'POST',
                data: {activityid: activityid},
                url: 'stock/countActivityPendingCells',
                success: function (response) {
                    var pending = parseInt(response);
                    if (pending === 0) {
                        $('#pendingReport').hide();
                        $('#generateReport').show();
                    } else {
                        $('#pendingReport').show();
                        $('#generateReport').hide();
                    }
                }
            });
        }

        function loadActivityReport() {
            $('#reportContent').html('');
            activityid = $('#count-select').val();
            $('#activity-report-title').html($('#act' + activityid).data('name'));
            window.location = '#viewActivityReport';
            initDialog('viewActivityReport');
            ajaxSubmitData('stock/loadActivityReport.htm', 'reportContent', '&activityid=' + activityid, 'POST');
        }

        function printStockReport(fileName) {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Print Stock Taking Report!',
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
                        url: 'stock/createStockReportPDF.htm',
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
            $('#itemCounts').html('');
            activityid = $('#count-select').val();
            ajaxSubmitData('stock/fetchActivityCellSummary.htm', 'itemCounts', '&activityid=' + activityid, 'POST');
            $('.jconfirm-buttons > .btn').click();
        }
    </script>
</c:if>
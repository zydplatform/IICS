<%-- 
    Document   : recounts
    Created on : 20-Jun-2018, 11:32:19
    Author     : IICS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${not empty activities}">
    <div class="row">
        <div class="col-md-4 col-sm-4">
            <form action="" class="formName">
                <div class="form-group">
                    <select class="form-control" id="recount-select">
                        <c:forEach items="${activities}" var="activity">
                            <option value="${activity.id}" id="act${activity.id}" data-name="${activity.name}">${activity.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </form>
        </div>
        <div class="col-md-7 col-sm-7 right">
            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                <div class="btn-group" role="group">
                    <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-sliders" aria-hidden="true"></i>
                    </button>
                    <div class="dropdown-menu dropdown-menu-left">
                        <a class="dropdown-item" href="#!" id="load-pending-items">Pending Review</a><hr>
                        <a class="dropdown-item" href="#!" id="load-reviewed-items">Reviewed Recounts</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12" id="recountedItems">

        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="viewItemRecountDetails" class="modalDialog viewItemRecountDetails">
                <div>
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title" id="item-recount-title"></h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="content">
                        <div class="col-md-12" id="itemRecount"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${empty activities}">
    <div class="row">
        <div class="col-md-12 center">
            <h2>No Activities Set</h2>
        </div>
    </div>
</c:if>
<c:if test="${not empty activities}">
    <script>
        var activityid = 0;
        $(document).ready(function () {
            $('#recount-select').select2();
            $('.select2').css('width', '100%');
            activityid = $('#recount-select').val();
            ajaxSubmitData('stock/fetchRecountReviewItems.htm', 'recountedItems', '&activityid=' + activityid, 'POST');
            $('#recount-select').change(function () {
                $('#recountedItems').html('');
                activityid = $('#recount-select').val();
                ajaxSubmitData('stock/fetchRecountReviewItems.htm', 'recountedItems', '&activityid=' + activityid, 'POST');
            });

            $('#load-pending-items').click(function () {
                activityid = $('#recount-select').val();
                ajaxSubmitData('stock/fetchRecountReviewItems.htm', 'recountedItems', '&activityid=' + activityid, 'POST');
            });

            $('#load-reviewed-items').click(function () {
                $('#recountedItems').html('');
                activityid = $('#recount-select').val();
                ajaxSubmitData('stock/fetchReviewedRecountItems.htm', 'recountedItems', '&activityid=' + activityid, 'POST');
            });
        });

        function viewItemCountSheet(recountid, itemName, itemid, cellid, activityCellid) {
            $('#itemRecount').html('');
            $('#item-recount-title').html(itemName);
            window.location = '#viewItemRecountDetails';
            initDialog('viewItemRecountDetails');
            ajaxSubmitData('stock/fetchItemRecountDetails.htm', 'itemRecount', '&recountid=' + recountid + '&itemid=' + itemid + '&cellid=' + cellid + '&activitycellid=' + activityCellid, 'POST');
        }

        function closeRecount(recountid, activitycellid) {
            $.confirm({
                title: '<h3>Close Recount</h3>',
                content: '<h4 class="itemTitle">Previous Count for <strong>' + $('#item-recount-title').html() + '</strong> Will be replaced  by current recount.</h4>',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Confirm',
                        btnClass: 'btn-purple',
                        action: function () {
                            var data = {
                                recountid: recountid,
                                activitycellid: activitycellid,
                                closeStatus: true
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'stock/closeRecount.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#recountedItems').html('');
                                        $('.updateCount').prop('disabled', 'true');
                                        activityid = $('#recount-select').val();
                                        ajaxSubmitData('stock/fetchRecountReviewItems.htm', 'recountedItems', '&activityid=' + activityid, 'POST');
                                        ajaxSubmitData('stock/fetchActivityCellSummary.htm', 'itemCounts', '&activityid=' + $('#count-select').val(), 'POST');
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Alert',
                                            text: 'Failed to Update Item Recount',
                                            icon: 'warning',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
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
        
        function ignoreRecount(recountid, activitycellid) {
            $.confirm({
                title: '<h3>Close Recount</h3>',
                content: '<h4 class="itemTitle">Recount for <strong>' + $('#item-recount-title').html() + '</strong> Will be Discarded.</h4>',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Confirm',
                        btnClass: 'btn-purple',
                        action: function () {
                            var data = {
                                recountid: recountid,
                                activitycellid: activitycellid,
                                closeStatus: false
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'stock/closeRecount.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#recountedItems').html('');
                                        $('.updateCount').prop('disabled', 'true');
                                        activityid = $('#recount-select').val();
                                        ajaxSubmitData('stock/fetchRecountReviewItems.htm', 'recountedItems', '&activityid=' + activityid, 'POST');
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Alert',
                                            text: 'Failed to Update Item Recount',
                                            icon: 'warning',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
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
    </script>
</c:if>
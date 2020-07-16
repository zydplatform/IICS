<%-- 
    Document   : countItems
    Created on : 08-Jun-2018, 10:47:15
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty activities}">
    <div class="tile">
        <div class="row">
            <div class="col-md-4 col-sm-4">
                <form action="" class="formName">
                    <div class="form-group">
                        <select class="form-control" id="activity-select-count">
                            <c:forEach items="${activities}" var="activity">
                                <option value="${activity.id}" data-time="${activity.end}" id="act${activity.id}">${activity.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="col-md-8 col-sm-8 right" id="timer">

            </div>
        </div>
        <div class="row">
            <div class="col-md-12" id="asignedCells">

            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="setActivityCells" class="supplierCatalogDialog setActivityCells">
                <div>
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title" id="activityCells"></h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="content">
                        <div class="col-md-4">
                            <div class="tile" id="searchTile">
                                <input type="hidden" value="0" id="count-Activity-Cell"/>
                                <div class="tile-body">
                                    <div id="search-form_3">
                                        <input id="itemSearch" type="text" oninput="searchItems()" placeholder="Search Items" onfocus="setSearchPane()" class="search_3 dropbtn"/>
                                    </div><br>
                                    <div id="searchResults" class="scrollbar">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile">
                                        <h4 class="tile-title">Selected Items.</h4>
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Item</th>
                                                    <th class="right no-wrap">Batch No.</th>
                                                    <th class="right no-wrap">Expiry Date</th>
                                                    <th class="right">Quantity</th>
                                                    <th class="center">
                                                        <i class="fa fa-undo"></i>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody id="enteredItemsBody">

                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12 text-right">
                                            <input type="hidden" id="selected-activity" value="0"/>
                                            <button type="button" class="btn btn-primary" id="saveCounts">
                                                Save
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="viewCellItems" class="supplierCatalogDialog viewCellItems">
                <div>
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title" id="view-cell-items"></h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="content">
                        <div class="col-md-12" id="counted-cells">

                        </div>
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
                No running stock taking activities.
            </h5>
        </div>
    </div>
</c:if>
<c:if test="${not empty activities}">
    <script type="text/javascript">
        var count = 1;
        var counted = [];
        var activityid = 0;
        $(document).ready(function () {
            $('#activity-select-count').select2();
            $('.select2').css('width', '100%');
            activityid = $('#activity-select-count').val();
            ajaxSubmitData('stock/fetchStaffAssignedCells.htm', 'asignedCells', '&activityid=' + activityid, 'POST');
            $('#activity-select').change(function () {
                $('#asignedCells').html('');
                activityid = $('#activity-select-count').val();
                ajaxSubmitData('stock/fetchStaffAssignedCells.htm', 'asignedCells', '&activityid=' + activityid, 'POST');
            });

            $('#saveCounts').click(function () {
                if (counted.length > 0) {
                    $.ajax({
                        type: 'POST',
                        url: 'stock/saveCellItemCount.htm',
                        data: {items: JSON.stringify(counted)},
                        success: function (responseBody) {
                            if (responseBody === 'saved') {
                                counted = [];
                                $.toast({
                                    heading: 'Alert',
                                    text: 'Items Saved',
                                    icon: 'info',
                                    hideAfter: 2000,
                                    position: 'mid-center'
                                });
                                $('#enteredItemsBody').html('');
                                activityid = $('#activity-select-count').val();
                                ajaxSubmitData('stock/fetchStaffAssignedCells.htm', 'asignedCells', '&activityid=' + activityid, 'POST');
                            } else if (responseBody === 'failed') {
                                $.toast({
                                    heading: 'Warning',
                                    text: 'Failed to Save Items',
                                    icon: 'warning',
                                    hideAfter: 2000,
                                    position: 'mid-center'
                                });
                            } else if (responseBody === 'refresh') {
                                document.location.reload(true);
                            }
                        }
                    });
                } else {
                    $.toast({
                        heading: 'Warning',
                        text: 'No Items Added',
                        icon: 'info',
                        hideAfter: 2000,
                        position: 'mid-center'
                    });
                }
            });
        });

        function countCellItems(cellid, cellName) {
            $('#activityCells').html(cellName);
            $('#count-Activity-Cell').val(cellid);
            initDialog('setActivityCells');
        }

        function setSearchPane() {
            var div = $('.supplierCatalogDialog > div').height();
            var divHead = $('.supplierCatalogDialog > div > #head').height();
            var searchForm = $('#search-form_3').height();
            $('#searchResults').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.16) - parseInt(searchForm));
            $(window).resize(function () {
                div = $('.supplierCatalogDialog > div').height();
                divHead = $('.supplierCatalogDialog > div > #head').height();
                searchForm = $('#search-form_3').height();
                $('#searchResults').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.16) - parseInt(searchForm));
            });
        }

        function searchItems() {
            var name = $('#itemSearch').val();
            if (name.length > 0) {
                ajaxSubmitDataNoLoader('stock/searchStock.htm', 'searchResults', '&name=' + name, 'GET');
            } else
                $('#searchResults').html('');
        }

        function remove(count) {
            $('#count' + count).remove();
            for (i in counted) {
                if (counted[i].count === count) {
                    counted.splice(i, 1);
                    break;
                }
            }
        }

        function viewCellItems(cellid, cellName) {
            $('#view-cell-items').html(cellName);
            initDialog('viewCellItems');
            ajaxSubmitDataNoLoader('stock/fetchCellCountedItems.htm', 'counted-cells', '&cellid=' + cellid, 'GET');
        }

        function submitCell(cellid, cellName) {
            $.confirm({
                title: '<h3>Submit ' + cellName + '</h3>',
                content: '<h4 class="itemTitle">Cell ' + cellName + ' will be submitted!<br><strong>No more counting will be done on this cell</strong></h4>',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Submit',
                        btnClass: 'btn-purple',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {cellid: cellid},
                                url: 'stock/submitActivityCell.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $('#status' + cellid).html('<span class="order-items-process span-size"><span class="badge badge-info">Submitted</span></span>');
                                        $('#manage' + cellid).html('<a href="#viewCellItems" onclick="viewCellItems(' + cellid + ', \'' + cellName + '\')" title="View Cell Items"><i class="fa fa-fw fa-lg fa-dedent"></i></a>')
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Submit Cell.',
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
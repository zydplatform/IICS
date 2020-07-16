<%-- 
    Document   : setupPage
    Created on : 16-May-2018, 12:52:16
    Author     : IICS
--%>
<div class="row">
    <div class="col-md-11 col-sm-11 text-right">
        <button class="btn btn-sm btn-primary icon-btn" onclick="addStockActivity()">
            <i class="fa fa-plus"></i>
            Add Activity
        </button>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <table class="table table-hover table-striped" id="activity">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Activity</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th class="center">Set Cells</th>
                        <th class="center">Time Left</th>
                        <th class="center">Manage</th>
                    </tr>
                </thead>
                <tbody>
                    <% int k = 1;%>
                    <c:forEach items="${activities}" var="activity">
                        <tr>
                            <td><%=k++%></td>
                            <td>${activity.name}</td>
                            <td>${activity.start}</td>
                            <td>${activity.end}</td>
                            <td class="center">
                                <c:if test="${activity.state == 0}">
                                    <span class="btn btn-success btn-sm" onclick="viewActivityCells(${activity.id}, '${activity.name}')">
                                        ${activity.completion} / ${activity.cells}
                                    </span>
                                </c:if>
                                <c:if test="${activity.state == 1}">
                                    <span class="btn btn-info btn-sm" onclick="viewActivityCells(${activity.id}, '${activity.name}')">
                                        ${activity.completion} / ${activity.cells}
                                    </span>
                                </c:if>
                                <c:if test="${activity.state == 2}">
                                    <span class="btn btn-warning btn-sm" onclick="viewActivityCells(${activity.id}, '${activity.name}')">
                                        ${activity.completion} / ${activity.cells}
                                    </span>
                                </c:if>
                            </td>
                            <td class="center">
                                <c:if test="${activity.state == 0}">
                                    <button class="btn btn-success btn-sm" onclick="extendDeadline(${activity.id}, '${activity.name}', '${activity.start}', '${activity.end}')" title="Edit Deadline">
                                        <c:if test="${activity.days == 1}">
                                            ${activity.days} Day.
                                        </c:if>
                                        <c:if test="${activity.days != 1}">
                                            ${activity.days} Days
                                        </c:if>
                                    </button>
                                </c:if>
                                <c:if test="${activity.state == 1}">
                                    <button class="btn btn-info btn-sm">
                                        Pending
                                    </button>
                                </c:if>
                                <c:if test="${activity.state == 2}">
                                    <button class="btn btn-warning btn-sm">
                                        Closed
                                    </button>
                                </c:if>
                            </td>
                            <td class="center">
                                <c:if test="${activity.state == 0}">
                                    <button class="btn btn-success btn-sm" onclick="manageActivityCells(${activity.id}, '${activity.name}')">
                                        Add Cells
                                    </button>
                                </c:if>
                                <c:if test="${activity.state == 1}">
                                    <button class="btn btn-info btn-sm" onclick="manageActivityCells(${activity.id}, '${activity.name}')">
                                        Add Cells
                                    </button>
                                </c:if>
                                <c:if test="${activity.state == 2}">
                                    <button class="btn btn-warning btn-sm">
                                        Closed
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="setActivityCells" class="supplierCatalogDialog add-cells-dialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="activityCells"></h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-4">
                        <div class="tile" id="searchTile">
                            <div class="tile-body">
                                <div id="search-form_3">
                                    <input id="itemSearch" type="text" oninput="searchCells()" placeholder="Search Cells" onfocus="setSearchPane()" class="search_3 dropbtn"/>
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
                                                <th>Zone</th>
                                                <th>Bay</th>
                                                <th>Row</th>
                                                <th>Cell</th>
                                                <th class="center">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody id="enteredItemsBody">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12 text-right">
                                        <input type="hidden" id="selected-activity" value="0"/>
                                        <button type="button" class="btn btn-primary" id="saveCells">
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
        <div id="viewActivityCells" class="modalDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="viewCells"></h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <input type="hidden" id="cell-view" value="0"/>
                    <div class="col-md-12" id="cellsTile"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var serverDate = '${serverdate}';
    var cellList = new Set();
    $('#activity').DataTable();
    var monthIndex = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
    ];

    $(document).ready(function () {
        $('#saveCells').click(function () {
            var cells = Array.from(cellList);
            if (cells.length > 0) {
                var data = {
                    activityid: parseInt($('#selected-activity').val()),
                    cells: JSON.stringify(cells)
                };
                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'stock/saveActivityCells.htm',
                    success: function (res) {
                        if (res === 'Saved') {
                            ajaxSubmitData('stock/stockManagementPane.htm', 'workpane', '&tab=tab1', 'GET');
                            cellList = new Set();
                        } else if (res === 'refresh') {
                            document.location.reload(true);
                        }
                    }
                });
            }
        });
    });
    function addStockActivity() {
        $.confirm({
            title: 'Add Stock Taking Activity!',
            content: '<div class="form-group">' +
                    '<label class="control-label" for="title">Actvity Title</label>' +
                    '<input class="form-control" id="title" type="text" placeholder="Actvity Title">' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label class="control-label" for="start">Start Date</label>' +
                    '<input class="form-control" id="start" type="text" placeholder="Start Date">' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label class="control-label" for="end">End Date</label>' +
                    '<input class="form-control" id="end" type="text" placeholder="End Date">' +
                    '</div>',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                formSubmit: {
                    text: 'Save Activity',
                    btnClass: 'btn-purple',
                    action: function () {
                        var title = this.$content.find('#title').val();
                        var start = this.$content.find('#start').val();
                        var end = this.$content.find('#end').val();
                        if (title.length > 0 && start.length > 0 && end.length > 0) {
                            var data = {
                                title: title,
                                end: end,
                                start: start
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'stock/saveStockActivity.htm',
                                success: function (response) {
                                    if (response === 'saved') {
                                        ajaxSubmitData('stock/stockManagementPane.htm', 'workpane', '&tab=tab1', 'GET');
                                    } else if (response === 'refresh')
                                        document.location.reload(true);
                                }
                            });
                        }
                    }
                },
                close: {
                    text: 'Close',
                    btnClass: 'btn-blue',
                    action: function () {

                    }
                }
            },
            onContentReady: function () {
                // bind to events
                var today = new Date(serverDate);
                var title = this.$content.find('#title');
                var start = this.$content.find('#start');
                var end = this.$content.find('#end');
                title.val(monthIndex[today.getMonth()] + '-' + today.getFullYear());
//                start.datetimepicker({
//                    pickTime: false,
//                    format: "DD-MM-YYYY",
//                    minDate: new Date(new Date().getTime() + 24 * 60 * 60 * 1000),
//                    defaultDate: new Date(new Date().getTime() + 24 * 60 * 60 * 1000)
//                });
//                end.datetimepicker({
//                    pickTime: false,
//                    format: "DD-MM-YYYY",
//                    minDate: new Date(new Date().getTime() + 24 * 60 * 60 * 1000),
//                    defaultDate: new Date(new Date().getTime() + 24 * 60 * 60 * 1000)
//                });
                start.datetimepicker({
                    pickTime: false,
                    format: "DD-MM-YYYY",
                    minDate: new Date(serverDate),
                    defaultDate: new Date(new Date(serverDate).getTime() + 24 * 60 * 60 * 1000)
                });
                end.datetimepicker({
                    pickTime: false,
                    format: "DD-MM-YYYY",
                    minDate: new Date(serverDate),
                    defaultDate: new Date(new Date(serverDate).getTime() + 24 * 60 * 60 * 1000)
                });
            }
        });
    }

    function manageActivityCells(activityId, activityTitle) {
        $('#activityCells').html('Set ' + activityTitle + ' Cells');
        $('#selected-activity').val(activityId);
        window.location = '#setActivityCells';
        initDialog('add-cells-dialog');
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

    function searchCells() {
        var name = $('#itemSearch').val();
        var activityid = parseInt($('#selected-activity').val());
        if (name.length > 0) {
            ajaxSubmitDataNoLoader('stock/searchCells.htm', 'searchResults', '&name=' + name + '&activityid=' + activityid, 'GET');
        } else
            $('#searchResults').html('');
    }

    function removeCell(rowId) {
        $('#cellrow' + rowId).remove();
        cellList.delete(rowId);
    }

    function viewActivityCells(activityId, activityTitle) {
        $('#viewCells').html(activityTitle + ' Cells');
        $('#cell-view').val(activityId);
        window.location = '#viewActivityCells';
        initDialog('modalDialog');
        $.ajax({
            type: 'POST',
            data: {activityid: activityId},
            url: 'stock/fetchActivityCells.htm',
            success: function (response) {
                $('#cellsTile').html(response);
            }
        });
    }

    function deleteActivityCell(cellid, cellLabel) {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Remove ' + cellLabel + "!",
            content: 'Cell <strong>' + cellLabel + '</strong> and its activities will permenently be romoved from stock taking activities.',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Remove Cell',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {id: cellid},
                            url: 'stock/removeActivityCell.htm',
                            success: function (res) {
                                if (res === 'deleted') {
                                    $.ajax({
                                        type: 'POST',
                                        data: {activityid: parseInt($('#cell-view').val())},
                                        url: 'stock/fetchActivityCells.htm',
                                        success: function (response) {
                                            $('#cellsTile').html(response);
                                        }
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
                    action: function () {

                    }
                }
            }
        });
    }

    function extendDeadline(activityid, activityName, startDate, endDate) {
        $.confirm({
            title: activityName,
            content: '<div class="form-group">' +
                    '<label class="control-label" for="start">Start Date</label>' +
                    '<input class="form-control" id="start" value="' + startDate + '" disabled="true" type="text" placeholder="Start Date">' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label class="control-label" for="end">End Date</label>' +
                    '<input class="form-control" id="end" value="' + endDate + '"  type="text" placeholder="End Date">' +
                    '</div>',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                formSubmit: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var end = this.$content.find('#end').val();
                        if (end.length > 0) {
                            var data = {
                                end: end,
                                activityid: activityid
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'stock/updateActivityDeadline.htm',
                                success: function (response) {
                                    if (response === 'updated') {
                                        ajaxSubmitData('stock/stockManagementPane.htm', 'workpane', '&tab=tab1', 'GET');
                                    } else if (response === 'refresh') {
                                        document.location.reload(true);
                                    } else if (response === 'error') {
                                        $.alert('Wrong Date Format Provided');
                                        return false;
                                    } else if (response === 'error') {
                                        $.alert('Failed to Update Deadline');
                                        return false;
                                    }
                                }
                            });
                        }
                    }
                },
                close: {
                    text: 'Cancel',
                    btnClass: 'btn-blue',
                    action: function () {

                    }
                }
            },
            onContentReady: function () {
                // bind to events
                var end = this.$content.find('#end');
                end.datetimepicker({
                    pickTime: false,
                    format: "DD-MM-YYYY",
                    minDate: new Date(serverDate),
                    defaultDate: new Date(endDate)
                });
            }
        });
    }
</script>
<%-- 
    Document   : unitStock
    Created on : Apr 10, 2018, 9:21:52 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<style>
    .dot {
        width: 13%;
        background-color: #1bd0c5;
        border-radius: 26%;
        display: inline-block;
    }

    /* BLINKING BUTTON */
    @-webkit-keyframes blink {
        0% {
            opacity: 1;
        }
        50% {
            opacity: 0;
        }
        100% {
            opacity: 1;
        }
    }
    @-moz-keyframes blink {
        0% {
            opacity: 1;
        }
        50% {
            opacity: 0;
        }
        100% {
            opacity: 1;
        }
    }
    @-o-keyframes blink {
        0% {
            opacity: 1;
        }
        50% {
            opacity: 0;
        }
        100% {
            opacity: 1;
        }
    }
    /*
        #receive-ordered-items {
            margin-left: 47%;
            -webkit-animation: blink 2s;
            -webkit-animation-iteration-count: infinite;
            -moz-animation: blink 2s;
            -moz-animation-iteration-count: infinite;
            -o-animation: blink 1s;
            -o-animation-iteration-count: infinite;
        }
    
        #receive-donated-items {
            margin-left: 170%;
            -webkit-animation: blink 2s;
            -webkit-animation-iteration-count: infinite;
            -moz-animation: blink 2s;
            -moz-animation-iteration-count: infinite;
            -o-animation: blink 1s;
            -o-animation-iteration-count: infinite;
        }*/
</style>
<div class="row">
    <div class="col-md-6">
        <div class="row">
            <button <c:if test="${readyUnitOrdersCount != '0'}">disabled="true" title="Please Recieve Orders First"</c:if> class="btn btn-primary icon-btn" id="enter-item" href="#enterItems">
                    <i class="fa fa-plus"></i>
                    Enter Items
                </button>&nbsp;&nbsp;&nbsp;
            <c:if test="${readyUnitOrdersCount != '0'}">
                <button class="btn btn-primary icon-btn" id="receive-ordered-items" href="#enterItems">
                    Receive Orders <span class="dot">${readyUnitOrdersCount}</span>
                </button>
            </c:if>
            <c:if test="${readyUnitDonationsCount != '0'}">
                <button id="receive-donated-items" style="margin-left: 170%;" class="btn btn-primary icon-btn" >
                    Receive Donations <span class="dot">${readyUnitDonationsCount}</span>
                </button>
            </c:if>
            <button class="btn btn-primary icon-btn" style="margin-left: 2%;" id="view-out-of-stock-items">Out Of Stock Order Items</button>    
        </div>
    </div>
    <div class="col-md-2"></div>
    <div class="col-md-4" align="right">
        <select class="form-control" id="displayClassification">
            <option value="0">All Categories</option>
            <c:forEach items="${allClassifications}" var="classification">
                <option id="class${classification.id}" data-name="${classification.name}" value="${classification.id}">${classification.name}</option>
            </c:forEach>
        </select>
    </div>
</div>
<fieldset>
    <div class="row" id="stockItems">

    </div>
</fieldset>
<div class="row">
    <div class="col-md-12">
        <div id="enterItems" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Update Stock Info.</h2>
                    <hr>
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <div class="tile-body">
                                <div id="search-form_3">
                                    <input id="itemSearch" type="text" oninput="searchItem()" placeholder="Search Item" onfocus="displaySearchResults()" class="search_3 dropbtn"/>
                                </div>
                                <div id="myDropdown" class="search-content">

                                </div><br>
                            </div>
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <h4 class="tile-title">Entered Items.</h4>
                                    <table class="table table-sm" id="newItemsTable">
                                        <thead>
                                            <tr>
                                                <th>No.</th> <!---->
                                                <th>Item</th>
                                                <th class="right">Batch No</th>
                                                <th class="right">Total Quantity</th>
                                                <th>Expiry</th>
                                                <th class="center">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody id="enteredItemsBody">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12 text-right">
                                        <button type="button" class="btn btn-primary" id="saveItems">
                                            Save
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="addadmintype" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content" style="width: 100%;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="title">Enter item Details</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <form>
                                                    <input type="hidden" id="itemid">
                                                    <input type="hidden" id="stockid" value="0">
                                                    <input type="hidden" id="qtyAvailable" value="0">
                                                    <div class="form-group">
                                                        <label for="itemname">Item Name</label>
                                                        <input class="form-control" id="itemname" type="text"  disabled="true">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="itemclass">Batch No.</label>
                                                        <input class="form-control" oninput="formatBatchNo()" id="batch" type="text"  placeholder="Batch No." >
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="itemclass">Expiry Date</label>
                                                        <input class="form-control" id="expiryDate" type="text"  placeholder="DD-MM-YYYY">
                                                    </div>
                                                    <div class="form-group" id="package">
                                                        <label for="itemclass" id="packageLabel"></label>
                                                        <input class="form-control" id="packageQty" type="text"  placeholder="Quantity Available" disabled="true">
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="itemclass" id="packsLabel">Quantity</label>
                                                                <input class="form-control" oninput="flagQuantityEmpty()" id="itemQty" type="number"  placeholder="Quantity">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="itemclass" id="packsLabel">Packs</label>
                                                                <input class="form-control" oninput="flagPacksEmpty()" id="packsQty" type="number"  placeholder="Packs">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="itemclass" id="packsLabel">loose Items</label>
                                                                <input class="form-control" oninput="flaglooseEmpty()" id="looseQty" type="number"  placeholder="loose Items">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="itemclass" id="packsLabel">Total Quantity</label>
                                                        <input class="form-control" id="totalQty" type="number"  placeholder="Total Quantity" disabled="true">
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12" align="right">
                                                <button class="btn btn-primary" id="addItem" type="submit">
                                                    <i class="fa fa-check-circle"></i>
                                                    Add Item
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
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="shelveItems" class="shelveItemDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="stockItem"></h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-5">
                        <div class="tile">
                            <h4 class="tile-title">Destination Cell</h4>
                            <input type="hidden" id="quantityStocked" value="0">
                            <input type="hidden" id="selectedStock" value="0">
                            <input type="hidden" id="isolated" value="true">
                            <form><hr>
                                <div class="form-group">
                                    <label for="storageZone">Zone</label>
                                    <select class="form-control" id="storageZone">
                                        <option value="0">Select Zone</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="zoneBay">Bay</label>
                                    <select class="form-control" id="zoneBay">
                                        <option value="0">Select Bay</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="bayRow">Bay Row</label>
                                    <select class="form-control" id="bayRow">
                                        <option value="0">Select Row</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="exampleSelect1">Cell</label>
                                    <select class="form-control" id="rowCell">
                                        <option value="0">Select Cell</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="qtyts">Quantity To Shelve</label>
                                    <input class="form-control" id="qtyts" min="1" type="number" placeholder="Qauntity to Shelve">
                                </div><hr>
                            </form>
                            <div class="form-group">
                                <div class="col-sm-12 text-right">
                                    <button type="button" class="btn btn-primary" id="add-to-shelf">
                                        Add to Shelf
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <h3 class="tile-title">
                                        Batch No: 
                                        <strong id="detailsBatch"></strong>
                                    </h3>
                                    <div class="tile-body">
                                        <table class="table table-striped">
                                            <tbody>
                                                <tr>
                                                    <td>Remaining Quantity</td>
                                                    <td id="detailsQty"></td>
                                                </tr>
                                                <tr>
                                                    <td>Expiry Date</td>
                                                    <td>
                                                        <strong id="detailsExpiry"></strong>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="tile-footer">
                                        <button class="btn item-full-width" id="expiryDetails"></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <h3 class="tile-title">Shelf Locations</h3>
                                    <div class="tile-body">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Zone</th>
                                                    <th>Bay</th>
                                                    <th>Row</th>
                                                    <th>Cell</th>
                                                    <th>Quantity</th>
                                                    <th>
                                                        <i class="fa fa-undo"></i>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody id="allocationsBody">

                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="form-group">
                                            <div class="col-sm-12 text-right">
                                                <button type="button" class="btn btn-primary" id="saveShelvedItems">
                                                    Save Allocations
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
    </div>
</div>

<!--model Receive Items-->
<div class="">
    <div id="modalRecieveOrders" class="manageCellDialog modalReceiveOrders">
        <div class="">
            <div id="head">
                <h5 class="modal-title names" id="title"> Receive Orders </h5>
                <a href="#close" title="Close" class="close2">X</a>
                <hr>
            </div>
            <div class="row scrollbar" id="content">
                <div class="col-md-12" id="contentData">

                </div>
            </div>
        </div>
    </div>
</div>

<!--model Donated Items-->
<div class="">
    <div id="modalRecieveDonations" class="manageCellDialog modalReceiveDonations">
        <div class="">
            <div id="head">
                <h5 class="modal-title names" id="title"> Receive Donations </h5>
                <a href="#close" title="Close" class="close2">X</a>
                <hr>
            </div>
            <div class="row scrollbar" id="content">
                <div class="col-md-12" id="contentDonations">

                </div>
            </div>
        </div>
    </div>
</div>
<!--Out Of Stock Items Modal-->
<div class="">
    <div id="outOfStockOrderItemsModal" class="modalOrderitemsdialog">
        <div class="">
            <div id="head">
                <h3 class="modal-title" id="title" style="padding-left: 1%;"><font color="purple">Out Of Stock Order Items</font></h3>
                <a href="#close" title="Close" class="close2">X</a>
                <hr>
            </div>
            <div class="scrollbar" id="out-of-stock-order-items">

            </div>
        </div>
    </div>
</div>

<script>
    var serverDate = '${serverdate}';
    var count = 1000;
    var items = [];
    var shelfList = [];
    var shelfCells = new Set();
    var size = 1;
    var itemQty = 0;
    var packsQty = 1;
    var looseQty = 0;
    var totalItemQuantity = 0;
    var rowCount = 0; //
    $(document).ready(function () {

        var displayClassification = $('#displayClassification').val();
        ajaxSubmitData('store/fetchUnitClassificationStock.htm', 'stockItems', '&classid=' + displayClassification, 'GET');

        $('#displayClassification').change(function () {
            $('#stockItems').html('');
            displayClassification = $('#displayClassification').val();
            ajaxSubmitData('store/fetchUnitClassificationStock.htm', 'stockItems', '&classid=' + displayClassification, 'GET');
        });

        $('#expiryDate').datepicker({
            format: "dd-mm-yyyy",
            autoclose: true,
            todayHighlight: true
        });

        $('#expiryDate').focus(function () {
            $('.datepicker').css("z-index", 100000);
        });

        $('#enter-item').click(function () {
            window.location = '#enterItems';
            initDialog('supplierCatalogDialog');
            

        });

        $('#addItem').click(function () {
            var itemid = $('#itemid').val();
            var stockid = $('#stockid').val();
            var batch = $('#batch').val();
            var qty = totalItemQuantity;
            var expiry = $('#expiryDate').val();
            if (qty > 0) {
                if (batch === '' || expiry === '') {
                    if (batch === '' && expiry === '') {
                        $.confirm({
                            title: '<h3>Missing Fileds!</h3>',
                            content: '<h4 class="itemTitle">Item missing <strong>Batch No</strong> And <strong>Expiry Date.</strong></h4>',
                            type: 'orange',
                            icon: 'fa fa-warning',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Save Anyway',
                                    btnClass: 'btn-orange',
                                    action: function () {
                                        batch = generateBatchNumbers();
                                        $('#enteredItemsBody').append(
                                                '<tr id="row' + count + '">' +
                                                '<td>' + (++rowCount) + '</td>' +
                                                '<td>' + $('#itemname').val() + '</td>' +
                                                '<td class="right">' + batch + '</td>' +
                                                '<td class="right">' + $('#totalQty').val() + '</td>' +
                                                '<td>' + expiry + '</td>' +
                                                '<td class="center">' +
                                                '<span class="badge badge-danger icon-custom" onclick="remove(\'' + count + '\')">' +
                                                '<i class="fa fa-trash-o"></i></span></td>' +
                                                '</tr>'
                                                );
                                        $('#addadmintype').modal('hide');
                                        var data = {
                                            count: count,
                                            itemid: itemid,
                                            stockid: stockid,
                                            batch: batch,
                                            qty: qty,
                                            expiry: expiry,
                                            newqty: parseInt($('#totalQty').val())
                                        };
                                        var found = false;
                                        for (i in items) {
                                            if (items[i].batch === data.batch && items[i].itemid === data.itemid && items[i].expiry === data.expiry) {
                                                items[i].qty = items[i].qty + data.qty;
                                                found = true;
                                                break;
                                            }
                                        }
                                        if (!found) {
                                            items.push(data);
                                        }
                                        $('#batch').val('');
                                        $('#totalQty').val('');
                                        $('#expiryDate').val('');
                                        count = count + 1;
                                    }
                                },
                                close: {
                                    text: 'Add Missing Fields',
                                    btnClass: 'btn-purple',
                                    action: function () {
                                        requestFocus('batch');
                                    }
                                }
                            }
                        });
                    } else if (batch === '') {
                        $.confirm({
                            title: '<h3>Missing Fileds!</h3>',
                            content: '<h4 class="itemTitle">Item missing <strong>Batch No</strong></h4>',
                            type: 'orange',
                            icon: 'fa fa-warning',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Save Anyway',
                                    btnClass: 'btn-orange',
                                    action: function () {
                                        batch = generateBatchNumbers();
                                        $('#enteredItemsBody').append(
                                                '<tr id="row' + count + '">' +
                                                '<td>' + (++rowCount) + '</td>' +
                                                '<td>' + $('#itemname').val() + '</td>' +
                                                '<td class="right">' + batch + '</td>' +
                                                '<td class="right">' + $('#totalQty').val() + '</td>' +
                                                '<td>' + expiry + '</td>' +
                                                '<td class="center">' +
                                                '<span class="badge badge-danger icon-custom" onclick="remove(\'' + count + '\')">' +
                                                '<i class="fa fa-trash-o"></i></span></td>' +
                                                '</tr>'
                                                );
                                        $('#addadmintype').modal('hide');
                                        var data = {
                                            count: count,
                                            itemid: itemid,
                                            stockid: stockid,
                                            batch: batch,
                                            qty: qty,
                                            expiry: expiry
                                        };
                                        var found = false;
                                        for (i in items) {
                                            if (items[i].batch === data.batch && items[i].itemid === data.itemid && items[i].expiry === data.expiry) {
                                                items[i].qty = items[i].qty + data.qty;
                                                found = true;
                                                break;
                                            }
                                        }
                                        if (!found) {
                                            items.push(data);
                                        }
                                        $('#batch').val('');
                                        $('#totalQty').val('');
                                        $('#expiryDate').val('');
                                        count = count + 1;
                                    }
                                },
                                close: {
                                    text: 'Add Batch No.',
                                    btnClass: 'btn-purple',
                                    action: function () {
                                        requestFocus('batch');
                                    }
                                }
                            }
                        });
                    } else if (expiry === '') {
                        $.confirm({
                            title: '<h3>Missing Fileds!</h3>',
                            content: '<h4 class="itemTitle">Item missing <strong>Expiry Date.</strong></h4>',
                            type: 'orange',
                            icon: 'fa fa-warning',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Save Anyway',
                                    btnClass: 'btn-orange',
                                    action: function () {
                                        $('#enteredItemsBody').append(
                                                '<tr id="row' + count + '">' +
                                                '<td>' + (++rowCount) + '</td>' +
                                                '<td>' + $('#itemname').val() + '</td>' +
                                                '<td class="right">' + batch + '</td>' +
                                                '<td class="right">' + $('#totalQty').val() + '</td>' +
                                                '<td>' + expiry + '</td>' +
                                                '<td class="center">' +
                                                '<span class="badge badge-danger icon-custom" onclick="remove(\'' + count + '\')">' +
                                                '<i class="fa fa-trash-o"></i></span></td>' +
                                                '</tr>'
                                                );
                                        $('#addadmintype').modal('hide');
                                        var data = {
                                            count: count,
                                            itemid: itemid,
                                            stockid: stockid,
                                            batch: batch,
                                            qty: qty,
                                            expiry: expiry
                                        };
                                        var found = false;
                                        for (i in items) {
                                            if (items[i].batch === data.batch && items[i].itemid === data.itemid && items[i].expiry === data.expiry) {
                                                items[i].qty = items[i].qty + data.qty;
                                                found = true;
                                                break;
                                            }
                                        }
                                        if (!found) {
                                            items.push(data);
                                        }
                                        $('#batch').val('');
                                        $('#totalQty').val('');
                                        $('#expiryDate').val('');
                                        count = count + 1;
                                    }
                                },
                                close: {
                                    text: 'Add Expiry Date',
                                    btnClass: 'btn-purple',
                                    action: function () {
                                        requestFocus('expiryDate');
                                    }
                                }
                            }
                        });
                    }
                } else {
                    $('#enteredItemsBody').append(
                            '<tr id="row' + count + '">' +
                            '<td>' + (++rowCount) + '</td>' +
                            '<td>' + $('#itemname').val() + '</td>' +
                            '<td class="right">' + batch + '</td>' +
                            '<td class="right">' + $('#totalQty').val() + '</td>' +
                            '<td>' + expiry + '</td>' +
                            '<td class="center">' +
                            '<span class="badge badge-danger icon-custom" onclick="remove(\'' + count + '\')">' +
                            '<i class="fa fa-trash-o"></i></span></td>' +
                            '</tr>'
                            );
                    $('#addadmintype').modal('hide');
                    var data = {
                        count: count,
                        itemid: itemid,
                        stockid: stockid,
                        batch: batch,
                        qty: qty,
                        expiry: expiry
                    };
                    var found = false;
                    for (i in items) {
                        if (items[i].batch === data.batch && items[i].itemid === data.itemid && items[i].expiry === data.expiry) {
                            items[i].qty = items[i].qty + data.qty;
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        items.push(data);
                    }
                    $('#batch').val('');
                    $('#totalQty').val('');
                    $('#expiryDate').val('');
                    count = count + 1;
                }
            } else {
                $('#totalQty').css('border', '2px solid #f50808c4');
            }
        });

        $('#saveItems').click(function () {
            if (items.length > 0) {
                $('#saveItems').prop('disabled', true);
                var data = {
                    items: JSON.stringify(items)
                };
                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'store/captureStock.htm',
                    success: function (res) {
                        if (res === 'Saved') {
                            $('#saveItems').prop('disabled', true);
                            items = [];
                            ajaxSubmitData('store/inventoryPane.htm', 'workpane', '', 'GET');
                        }
                    }
                });
            }
        });

        $('#storageZone').change(function () {
            var isolated = $("#isolated").val();
            if (isolated === 'true') {
                var zoneid = parseInt($('#storageZone').val());
                $('#zoneBay').html('');
                if (zoneid > 0) {
                    $.ajax({
                        type: 'POST',
                        data: {zoneid: zoneid, isolated: true},
                        url: 'store/fetchStoreBays.htm',
                        success: function (response) {
                            if (response === 'refresh' || response === '' || response === '[]') {
                                if (response === 'refresh') {
                                    document.location.reload(true);
                                } else {
                                    $('#zoneBay').html('<option value="0">No Isolated Bays Set</option>');
                                }
                            } else {
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#zoneBay').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                                var bayid = parseInt($('#zoneBay').val());
                                $('#bayRow').html('');
                                if (bayid > 0) {
                                    $.ajax({
                                        type: 'POST',
                                        data: {bayid: bayid, isolated: true},
                                        url: 'store/fetchBayrows.htm',
                                        success: function (response) {
                                            if (response === 'refresh' || response === '' || response === '[]') {
                                                if (response === 'refresh') {
                                                    document.location.reload(true);
                                                } else {
                                                    $('#bayRow').html('<option value="0">No Isolated Rows Added</option>');
                                                }
                                            } else {
                                                var res = JSON.parse(response);
                                                for (i in res) {
                                                    $('#bayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                }
                                                var rowid = parseInt($('#bayRow').val());
                                                $('#rowCell').html('');
                                                if (rowid > 0) {
                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {rowid: rowid, isolated: true},
                                                        url: 'store/fetchRowCells.htm',
                                                        success: function (response) {
                                                            if (response === 'refresh' || response === '' || response === '[]') {
                                                                if (response === 'refresh') {
                                                                    document.location.reload(true);
                                                                } else {
                                                                    $('#rowCell').html('<option value="0">No Isolated Cells Found</option>');
                                                                }
                                                            } else {
                                                                $('#rowCell').css('border', '2px solid #6D0A70');
                                                                var res = JSON.parse(response);
                                                                for (i in res) {
                                                                    $('#rowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                                }
                                                            }
                                                        }
                                                    });
                                                }
                                            }
                                        }
                                    });
                                }
                            }
                        }
                    });
                }
            } else {
                var zoneid = parseInt($('#storageZone').val());
                $('#zoneBay').html('');
                if (zoneid > 0) {
                    $.ajax({
                        type: 'POST',
                        data: {zoneid: zoneid, isolated: false},
                        url: 'store/fetchStoreBays.htm',
                        success: function (response) {
                            if (response === 'refresh' || response === '' || response === '[]') {
                                if (response === 'refresh') {
                                    document.location.reload(true);
                                } else {
                                    $('#zoneBay').html('<option value="0">No Bays Set</option>');
                                }
                            } else {
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#zoneBay').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                                var bayid = parseInt($('#zoneBay').val());
                                $('#bayRow').html('');
                                if (bayid > 0) {
                                    $.ajax({
                                        type: 'POST',
                                        data: {bayid: bayid, isolated: false},
                                        url: 'store/fetchBayrows.htm',
                                        success: function (response) {
                                            if (response === 'refresh' || response === '' || response === '[]') {
                                                if (response === 'refresh') {
                                                    document.location.reload(true);
                                                } else {
                                                    $('#bayRow').html('<option value="0">No Rows Added</option>');
                                                }
                                            } else {
                                                var res = JSON.parse(response);
                                                for (i in res) {
                                                    $('#bayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                }
                                                var rowid = parseInt($('#bayRow').val());
                                                $('#rowCell').html('');
                                                if (rowid > 0) {
                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {rowid: rowid, isolated: false},
                                                        url: 'store/fetchRowCells.htm',
                                                        success: function (response) {
                                                            if (response === 'refresh' || response === '' || response === '[]') {
                                                                if (response === 'refresh') {
                                                                    document.location.reload(true);
                                                                } else {
                                                                    $('#rowCell').html('<option value="0">No Cells Found</option>');
                                                                }
                                                            } else {
                                                                $('#rowCell').css('border', '2px solid #6D0A70');
                                                                var res = JSON.parse(response);
                                                                for (i in res) {
                                                                    $('#rowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                                }
                                                            }
                                                        }
                                                    });
                                                }
                                            }
                                        }
                                    });
                                }
                            }
                        }
                    });
                }
            }
        });

        $('#zoneBay').change(function () {
            var isolated = $("#isolated").val();
            if (isolated === 'true') {
                var bayid = parseInt($('#zoneBay').val());
                $('#bayRow').html('');
                if (bayid > 0) {
                    $.ajax({
                        type: 'POST',
                        data: {bayid: bayid, isolated: true},
                        url: 'store/fetchBayrows.htm',
                        success: function (response) {
                            if (response === 'refresh' || response === '' || response === '[]') {
                                if (response === 'refresh') {
                                    document.location.reload(true);
                                } else {
                                    $('#bayRow').html('<option value="0">No Isolated Rows Added</option>');
                                }
                            } else {
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#bayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                                var rowid = parseInt($('#bayRow').val());
                                $('#rowCell').html('');
                                if (rowid > 0) {
                                    $.ajax({
                                        type: 'POST',
                                        data: {rowid: rowid, isolated: true},
                                        url: 'store/fetchRowCells.htm',
                                        success: function (response) {
                                            if (response === 'refresh' || response === '' || response === '[]') {
                                                if (response === 'refresh') {
                                                    document.location.reload(true);
                                                } else {
                                                    $('#rowCell').html('<option value="0">No Isolated Cells Found</option>');
                                                }
                                            } else {
                                                $('#rowCell').css('border', '2px solid #6D0A70');
                                                var res = JSON.parse(response);
                                                for (i in res) {
                                                    $('#rowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                }
                                            }
                                        }
                                    });
                                }
                            }
                        }
                    });
                }
            } else {
                var bayid = parseInt($('#zoneBay').val());
                $('#bayRow').html('');
                if (bayid > 0) {
                    $.ajax({
                        type: 'POST',
                        data: {bayid: bayid, isolated: false},
                        url: 'store/fetchBayrows.htm',
                        success: function (response) {
                            if (response === 'refresh' || response === '' || response === '[]') {
                                if (response === 'refresh') {
                                    document.location.reload(true);
                                } else {
                                    $('#bayRow').html('<option value="0">No Rows Added</option>');
                                }
                            } else {
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#bayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                                var rowid = parseInt($('#bayRow').val());
                                $('#rowCell').html('');
                                if (rowid > 0) {
                                    $.ajax({
                                        type: 'POST',
                                        data: {rowid: rowid, isolated: false},
                                        url: 'store/fetchRowCells.htm',
                                        success: function (response) {
                                            if (response === 'refresh' || response === '' || response === '[]') {
                                                if (response === 'refresh') {
                                                    document.location.reload(true);
                                                } else {
                                                    $('#rowCell').html('<option value="0">No Cells Found</option>');
                                                }
                                            } else {
                                                $('#rowCell').css('border', '2px solid #6D0A70');
                                                var res = JSON.parse(response);
                                                for (i in res) {
                                                    $('#rowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                }
                                            }
                                        }
                                    });
                                }
                            }
                        }
                    });
                }
            }
        });

        $('#bayRow').change(function () {
            var isolated = $("#isolated").val();
            if (isolated === 'true') {
                var rowid = parseInt($('#bayRow').val());
                $('#rowCell').html('');
                if (rowid > 0) {
                    $.ajax({
                        type: 'POST',
                        data: {rowid: rowid, isolated: true},
                        url: 'store/fetchRowCells.htm',
                        success: function (response) {
                            if (response === 'refresh' || response === '' || response === '[]') {
                                if (response === 'refresh') {
                                    document.location.reload(true);
                                } else {
                                    $('#rowCell').html('<option value="0">No Isolated Cells Found</option>');
                                }
                            } else {
                                $('#rowCell').css('border', '2px solid #6D0A70');
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#rowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                            }
                        }
                    });
                }
            } else {
                var rowid = parseInt($('#bayRow').val());
                $('#rowCell').html('');
                if (rowid > 0) {
                    $.ajax({
                        type: 'POST',
                        data: {rowid: rowid, isolated: false},
                        url: 'store/fetchRowCells.htm',
                        success: function (response) {
                            if (response === 'refresh' || response === '' || response === '[]') {
                                if (response === 'refresh') {
                                    document.location.reload(true);
                                } else {
                                    $('#rowCell').html('<option value="0">No Cells Found</option>');
                                }
                            } else {
                                $('#rowCell').css('border', '2px solid #6D0A70');
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#rowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                            }
                        }
                    });
                }
            }
        });

        $('#rowCell').change(function () {
            var cellid = parseInt($('#rowCell').val());
            if (cellid > 0) {
                $('#rowCell').css('border', '2px solid #6D0A70');
            }
        });

        //Add item to shelf.
        $('#add-to-shelf').click(function () {
            var qty = parseInt($('#qtyts').val());
            var cell = parseInt($('#rowCell').val());
            if (qty > 0 && cell > 0) {
                var rowId = (count++).toString() + cell.toString() + qty.toString();
                $('#allocationsBody').append(
                        '<tr data-qty="' + qty + '" id="' + rowId + '"><td>' + $('#zone' + $('#storageZone').val()).data('name') + '</td>' +
                        '<td>' + $('#bay' + $('#zoneBay').val()).data('name') + '</td>' +
                        '<td>' + $('#row' + $('#bayRow').val()).data('name') + '</td>' +
                        '<td>' + $('#cell' + $('#rowCell').val()).data('name') + '</td>' +
                        '<td>' + qty.toLocaleString() + ' Items</td>' +
                        '<td><span class="badge badge-danger icon-custom" onclick="removeShelfValue(\'' + rowId + '\', ' + cell + ', ' + qty + ')">' +
                        '<i class="fa fa-trash-o"></i></span></td></tr>'
                        );
                var initQty = parseInt($("#quantityStocked").val());
                initQty = initQty - qty;
                $("#qtyts").val(initQty);
                $("#qtyts").attr('max', initQty);
                $("#quantityStocked").val(initQty);
                if (shelfCells.has(cell)) {
                    for (i in shelfList) {
                        if (shelfList[i].cell === cell) {
                            shelfList[i].qty += qty;
                            break;
                        }
                    }
                } else {
                    var data = {
                        stockid: parseInt($('#selectedStock').val()),
                        cell: parseInt(cell),
                        qty: parseInt(qty)
                    };
                    shelfCells.add(cell);
                    shelfList.push(data);
                }
            } else {
                if (!(qty > 0)) {
                    $('#qtyts').focus();
                    $('#qtyts').css('border', '2px solid #f50808c4');
                }
                if (!(cell > 0)) {
                    $('#rowCell').focus();
                    $('#rowCell').css('border', '2px solid #f50808c4');
                }
            }
        });

        $('#saveShelvedItems').click(function () {
            if (shelfList.length > 0) {
                $('#saveShelvedItems').prop('disabled', true);
                $.ajax({
                    type: 'GET',
                    url: 'store/saveShelfStock.htm',
                    data: {shelves: JSON.stringify(shelfList), initialrequest: true},
                    success: function (data) {
                        data = JSON.parse(data);
                        var response = data.response;
                        var status = data.status;
                        var newQuantity = data.newquantity;
                        if (status === 'saved') {
                            shelfList = [];
                            shelfCells = new Set();
                            ajaxSubmitData('store/inventoryPane.htm', 'workpane', '', 'GET');
                        } else if (status === 'refresh') {
                            document.location.reload(true);
                        } else if (status === 'insufficient') {
                            $('#saveShelvedItems').prop('disabled', false);
                            $("#qtyts").val(newQuantity);
                            $.confirm({
                                title: '',
                                type: 'purple',
                                typeAnimated: true,
                                boxWidth: '30%',
                                closeIcon: true,
                                useBootstrap: false,
                                content: response,
                                buttons: {
                                    yes: {
                                        text: 'Yes',
                                        btnClass: 'btn btn-danger',
                                        action: function () {
                                            $.ajax({
                                                type: 'GET',
                                                url: 'store/saveShelfStock.htm',
                                                data: {shelves: JSON.stringify(shelfList), initialrequest: false},
                                                success: function (data, textStatus, jqXHR) {
                                                    data = JSON.parse(data);
                                                    var response = data.response;
                                                    var status = data.status;
                                                    var newQuantity = data.newquantity;
                                                    if (status === 'saved') {
                                                        shelfList = [];
                                                        shelfCells = new Set();
                                                        ajaxSubmitData('store/inventoryPane.htm', 'workpane', '', 'GET');
                                                    } else if (status === 'refresh') {
                                                        document.location.reload(true);
                                                    } else if (status === 'shelved') {
                                                        $('#saveShelvedItems').prop('disabled', false);
                                                        $.toast({
                                                            heading: 'Error',
                                                            text: response.toString(),
                                                            icon: 'error',
                                                            hideAfter: 5000,
                                                            position: 'mid-center'
                                                        });
                                                        //                            showToast('danger', 'Failed to Shelve Items');
                                                    }
                                                },
                                                error: function (jqXHR, textStatus, errorThrown) {

                                                }
                                            });
                                        }
                                    },
                                    no: {
                                        text: 'NO',
                                        btnClass: 'btn btn-purple',
                                        action: function () {

                                        }
                                    }
                                }
                            });
                        } else if (status === 'shelved') {
                            $('#saveShelvedItems').prop('disabled', false);
                            $.toast({
                                heading: 'Error',
                                text: response.toString(),
                                icon: 'error',
                                hideAfter: 5000,
                                position: 'mid-center'
                            });
//                            showToast('danger', 'Failed to Shelve Items');
                        }
                    }
                });
            } else {
                $('#saveShelvedItems').prop('disabled', false);
                $.toast({
                    heading: 'Error',
                    text: 'No Items added to Shelf',
                    icon: 'error',
                    hideAfter: 5000,
                    position: 'mid-center'
                });
//                showToast('danger', 'No Items added to Shelf');
            }
        });
    });

    function displaySearchResults() {
        document.getElementById("myDropdown").classList.add("showSearch");
    }

    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("search-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('showSearch')) {
                    openDropdown.classList.remove('showSearch');
                }
            }
        }
    };

    function searchItem() {
        displaySearchResults();
        var name = $('#itemSearch').val();
        if (name.length >= 3)
            ajaxSubmitDataNoLoader('store/searchItem.htm', 'myDropdown', '&name=' + name, 'GET');
        else
            $('#myDropdown').html('');
    }

    function remove(count) {
        $('#row' + count).remove();
        for (i in items) {
            if (items[i].count === count) {
                items[i].splice(i, 1);
                break;
            }
        }
        setRowItemCount(); //
        console.log(items);
    }

    function removeShelfValue(rowId, cell, qty) {
        var qtyOld = parseInt($("#quantityStocked").val());
        var qtyRemoved = parseInt($('#' + rowId).data('qty'));
        $("#qtyts").attr('max', qtyOld + qtyRemoved);
        $("#qtyts").val(qtyOld + qtyRemoved);
        $("#quantityStocked").val(qtyOld + qtyRemoved);
        $('#' + rowId).remove();
        for (i in shelfList) {
            if (shelfList[i].cell === cell) {
                shelfList[i].qty -= qty;
                if (shelfList[i].qty < 0 || shelfList[i].qty === 0) {
                    shelfCells.delete(cell);
                    shelfList.splice(i, 1);
                }
                break;
            }
        }
    }

    function flagQuantityEmpty() {
        var qty = parseInt($('#itemQty').val());
        if (qty > 0) {
            $('#itemQty').css('border', '2px solid #7d047d');
            itemQty = qty;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        } else {
            if ($('#itemQty').val() !== '') {
                $('#itemQty').val(1);
            }
            itemQty = 0;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        }

        if (totalItemQuantity > 0) {
            $('#addItem').prop('disabled', false);
        } else {
            $('#addItem').prop('disabled', true);
        }
    }

    function flagPacksEmpty() {
        var qty = parseInt($('#packsQty').val());
        if (qty > 0) {
            $('#packsQty').css('border', '2px solid #7d047d');
            packsQty = qty;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        } else {
            if ($('#packsQty').val() !== '') {
                $('#packsQty').val(1);
            }
            packsQty = 1;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        }

        if (totalItemQuantity > 0) {
            $('#addItem').prop('disabled', false);
        } else {
            $('#addItem').prop('disabled', true);
        }
    }

    function flaglooseEmpty() {
        var qty = parseInt($('#looseQty').val());
        if (qty > 0) {
            $('#looseQty').css('border', '2px solid #7d047d');
            looseQty = qty;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        } else {
            if ($('#looseQty').val() !== '') {
                $('#looseQty').val(1);
            }
            looseQty = 0;
            totalItemQuantity = size * itemQty * packsQty + looseQty;
            $('#totalQty').val(totalItemQuantity);
        }

        if (totalItemQuantity > 0) {
            $('#addItem').prop('disabled', false);
        } else {
            $('#addItem').prop('disabled', true);
        }
    }

    function requestFocus(id) {
        $('#' + id).focus();
    }

    function formatBatchNo() {
//        $('#batch').val(($('#batch').val()).toString().toUpperCase());
        $('#batch').val(($('#batch').val()).toString().toUpperCase().replace("/", "-"));
    }

    $('#receive-ordered-items').click(function () {
        $.ajax({
            type: 'GET',
            url: "ordersmanagement/receiveSentOrders.htm",
            success: function (data) {
                window.location = '#modalRecieveOrders';
                $('#contentData').html(data);
                initDialog('modalReceiveOrders');
            }
        });
    });

    $('#receive-donated-items').click(function () {
        $.ajax({
            type: 'GET',
            url: "internaldonorprogram/receiveSentDonations.htm",
            success: function (data) {
                window.location = '#modalRecieveDonations';
                $('#contentDonations').html(data);
                initDialog('modalReceiveDonations');
            }
        });
    });
    //
    var setRowItemCount = function () {
        var table = document.getElementById('newItemsTable'),
                rows = table.getElementsByTagName('tr'),
                i, j, cells, previousCells, count;
        rowCount = (rows.length - 1);
        for (i = 1, j = rows.length; i < j; ++i) {
            cells = rows[i].getElementsByTagName('td');
            if (!cells.length) {
                continue;
            }
            if (i === 1) {
                count = 1;
            }
            if (i > 1) {
                previousCells = (rows[(i - 1)].getElementsByTagName('td'));
                count = (parseInt(previousCells[0].innerHTML) + 1);
            }
            cells[0].innerHTML = count;
        }
    };
    $('#view-out-of-stock-items').on('click', function () {
        ajaxSubmitData('ordersmanagement/unservicedordersorderingunit.htm', 'out-of-stock-order-items', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        window.location = '#outOfStockOrderItemsModal';
        initDialog('modalOrderitemsdialog');
    });
    function getUnservicedOrders(date) {

        if (date === undefined || date === null || date.trim().length === 0) {
            date = new Date(serverDate).toISOString();
        } else {
            var v = date.split('-');
            date = new Date((v[2] + '-' + v[1] + '-' + v[0])).toISOString();
        }
        var selectedDate = date.substring(0, date.indexOf('T'));
        ajaxSubmitData('ordersmanagement/unservicedordersorderingunit.htm', 'out-of-stock-order-items', 'targetdate=' + selectedDate, 'GET');
    }

    function generateBatchNumbers() {
        debugger
        var result = "";
        $.ajax({
            type: 'POST',
            url: "stock/generatebatchnumbers.htm",
            async: false,
            success: function (data) {
                console.log(data);
                debugger
//                if(data ==="No records"){
//                    for(var i = 1; i<1000000; i++){
//                    var nextbatchnumber =  "IICS-00" + i;
//                    $('#batch').val(nextbatchnumber);
//                   } 
//                }else{
//                   
//                }
                var nextbatchnumber = "IICS-0000001"; 
                if (data !== "No records") { 
                    var nextbatchnumber = "IICS-";
                    var padLength = (7 - data.toString().length); 
                    for(var i=1; i <= padLength; i++){
                        nextbatchnumber += '0';
                    }
                    nextbatchnumber += (parseInt(data) + 1);
                }
               $('#batch').val(nextbatchnumber);
               result =  nextbatchnumber;
             
            }
        });
          return result;
    }
</script>
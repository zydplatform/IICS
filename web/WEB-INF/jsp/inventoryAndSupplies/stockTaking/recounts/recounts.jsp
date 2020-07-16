<%-- 
    Document   : recounts
    Created on : 19-Jun-2018, 11:29:40
    Author     : IICS
--%>
<div class="row">
    <div class="col-md-12" id="recountItems">

    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="recountItem" class="supplierCatalogDialog recountItem">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="recountTitle"></h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-4">
                        <div class="tile" id="searchTile">
                            <input type="hidden" value="0" id="recount-Item"/>
                            <h4 class="tile-title">Enter Item Details</h4>
                            <div class="tile-body">
                                <div class="form-group">
                                    <label for="batch">Batch Number</label>
                                    <input type="text" id="batchR" value="" placeholder="Batch Number" class="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label for="expiry">Expiry Date</label>
                                    <input type="text" id="expiryR" value="" placeholder="Expiry Date" class="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label for="quantity">Quantity</label>
                                    <input type="number" min="0" id="quantityR" value="" placeholder="Quantity" class="form-control"/>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-md-12 right">
                                        <button type="button" class="btn btn-primary" onclick="recountItemBatch()">
                                            Add Item
                                        </button>
                                    </div>
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
                                                <th class="no-wrap">Batch No.</th>
                                                <th class="no-wrap">Expiry Date</th>
                                                <th class="right">Quantity</th>
                                                <th class="center">
                                                    <i class="fa fa-undo"></i>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="recountedItemsBody">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12 text-right">
                                        <button type="button" class="btn btn-primary" id="saveRecount">
                                            Save Recount
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
        <div id="viewItemRecount" class="supplierCatalogDialog viewItemRecount">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="view-Recount"></h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12" id="recount-content">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var count = 1;
    var itemBatches = [];
    $(document).ready(function () {
        ajaxSubmitData('stock/fetchRecountItems.htm', 'recountItems', '', 'POST');

        $('#expiryR').datepicker({
            format: "dd-mm-yyyy",
            autoclose: true,
            todayHighlight: true
        });

        $('#batchR').on('input', function () {
            var batchNo = $('#batchR').val();
            $('#batchR').val(batchNo.toString().toUpperCase());
        });

        $('#saveRecount').click(function () {
            if (itemBatches.length > 0) {
                $.ajax({
                    type: 'POST',
                    url: 'stock/saveItemRecount.htm',
                    data: {items: JSON.stringify(itemBatches)},
                    success: function (responseBody) {
                        if (responseBody === 'saved') {
                            itemBatches = [];
                            $.toast({
                                heading: 'Alert',
                                text: 'Items Saved',
                                icon: 'info',
                                hideAfter: 2000,
                                position: 'mid-center'
                            });
                            $('#recountedItemsBody').html('');
                            ajaxSubmitData('stock/fetchRecountItems.htm', 'recountItems', '', 'POST');
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

    function recountCellItems(recountid, itemName) {
        $('#recountTitle').html(itemName);
        $('#recount-Item').val(recountid);
        initDialog('recountItem');
    }

    function removeRecount(count) {
        $('#recount' + count).remove();
        for (i in itemBatches) {
            if (itemBatches[i].count === count) {
                itemBatches.splice(i, 1);
                break;
            }
        }
    }

    function recountItemBatch() {
        var batch = $('#batchR').val();
        var exp = $('#expiryR').val();
        var qty = parseInt($('#quantityR').val());
        var recountid = parseInt($('#recount-Item').val());
        if (qty > 0 || qty === 0) {
            $('#quantityR').removeClass('error-field');
            var data = {
                count: count,
                recountid: recountid,
                expiry: exp,
                quantity: qty,
                batch: batch
            };
            $('#recountedItemsBody').append(
                    '<tr id="recount' + count + '">' +
                    '<td>' + data.batch + '</td>' +
                    '<td class="no-wrap">' + data.expiry + '</td>' +
                    '<td class="right">' + data.quantity + '</td>' +
                    '<td class="center">' +
                    '<span class="badge badge-danger icon-custom" onclick="removeRecount(' + count + ')">' +
                    '<i class="fa fa-close"></i></span></td>' +
                    '</tr>'
                    );
            itemBatches.push(data);
            count = count + 1;
            $('#batchR').val('');
            $('#expiryR').val('');
            $('#quantityR').val('');
        } else {
            $('#quantityR').addClass('error-field');
        }
    }

    function viewItemRecounts(recountid, cellName) {
        $('#view-Recount').html(cellName);
        initDialog('viewItemRecount');
        ajaxSubmitDataNoLoader('stock/fetchRecountedItems.htm', 'recount-content', '&recountid=' + recountid, 'GET');
    }

    function submitItemRecount(recountid, itemName) {
        $.confirm({
            title: '<h3>Submit ' + itemName + '</h3>',
            content: '<h4 class="itemTitle">' + itemName + ' will be submitted!<br><strong>No more counting will be done on this Item</strong></h4>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Submit',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {recountid: recountid},
                            url: 'stock/submitItemRecount.htm',
                            success: function (res) {
                                if (res === 'updated') {
                                    $('#recountStatus' + recountid).html('<span class="order-items-process span-size"><span class="badge badge-info">Submitted</span></span>');
                                    $('#manageR' + recountid).html('<a href="#viewItemRecount" onclick="viewItemRecounts(' + recountid + ', \'' + itemName + '\')" title="View Items"><i class="fa fa-fw fa-lg fa-dedent"></i></a>');
                                } else if (res === 'refresh') {
                                    document.location.reload(true);
                                } else {
                                    $.toast({
                                        heading: 'Warning',
                                        text: 'Failed to Submit Item.',
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
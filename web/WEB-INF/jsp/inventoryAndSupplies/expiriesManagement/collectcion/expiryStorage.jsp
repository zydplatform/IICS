<%-- 
    Document   : isolatedStorage
    Created on : Oct 4, 2018, 4:57:24 PM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty expiryZones}">
    <div class="tile">
        <div class="row">
            <div class="col-md-8"></div>
            <div class="col-md-4 right">
                <div class="form-group">
                    <label for="storageZone">Storage Zone</label>
                    <select class="form-control" id="expiryZone">
                        <c:forEach items="${expiryZones}" var="zone">
                            <option id="zone${zone.id}" data-name="${zone.zonename}" value="${zone.id}">${zone.zonename}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12" id="cellContent-expired">

            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="manageCellContentIsolate" class="manageCellDialog view-expired-items">
                <div>
                    <div id="head">
                        <div class="card-header">
                            <h5 class="card-title" id="cellTitleIsolate"></h5>
                            <a href="#close" title="Close" class="close2">
                                <i class="fa fa-close"></i>
                            </a>
                        </div>
                    </div>
                    <div class="row scrollbar" id="content">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile">
                                        <h4 class="tile-title">Items.</h4>
                                        <div id="cellExpiredItems">

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="transferItemIsolate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content" style="width: 100%;">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="title">Select New Location</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <form>
                                                <input id="curQtyIsolate" type="hidden" value="0"/>
                                                <input id="curCellIsolate" type="hidden" value="0"/>
                                                <input id="transferIdIsolate" type="hidden" value="0"/>
                                                <input id="transferStockIsolate" type="hidden" value="0"/>
                                                <input id="isolated-transfer2" type="hidden" value="false"/>
                                                <div class="form-group">
                                                    <label for="itemname">Item</label>
                                                    <input class="form-control" id="itemIsolate" type="text"  disabled="true">
                                                </div>
                                                <hr>
                                                <div class="form-group">
                                                    <label for="newStorageZone">Zone</label>
                                                    <select class="form-control" id="newStorageZoneIsolate">
                                                        <c:forEach items="${zones}" var="zone">
                                                            <option id="zone${zone.id}" data-name="${zone.zonename}" value="${zone.id}">${zone.zonename}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="newZoneBay">Bay</label>
                                                    <select class="form-control" id="newZoneBayIsolate">
                                                        <option value="0">Select Bay</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="newBayRow">Bay Row</label>
                                                    <select class="form-control" id="newBayRowIsolate">
                                                        <option value="0">Select Row</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="newRowCell">Cell</label>
                                                    <select class="form-control" id="newRowCellIsolate">
                                                        <option value="0">Select Cell</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="newQty">Quantity To Shelve</label>
                                                    <input class="form-control" id="newQtyIsolate" min="1" type="number" placeholder="Qauntity to Shelve">
                                                </div><hr>
                                            </form>
                                            <div class="form-group">
                                                <div class="col-sm-12 text-right">
                                                    <button type="button" class="btn btn-primary" id="transfer-item2">
                                                        Transfer Item
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
</c:if>
<c:if test="${empty expiryZones}">
    <div class="row">
        <div class="col-md-12 tile center">
            <h4>No Expired Items Pending Isolation</h4>
        </div>
    </div>
</c:if>
<script>
    var cellList = new Set();
    $(document).ready(function () {
        $('#expiryZone').select2();
        $('.select2').css('width', '100%');
        var zoneid = parseInt($('#expiryZone').val());
        if (zoneid > 0) {
            $.ajax({
                type: 'POST',
                data: {zoneid: zoneid},
                url: 'expiryAndDamages/fetchExpiryCellContent.htm',
                success: function (response) {
                    $('#cellContent-expired').html(response);
                }
            });
        }

        $('#expiryZone').change(function () {
            zoneid = parseInt($('#expiryZone').val());
            if (zoneid > 0) {
                $.ajax({
                    type: 'POST',
                    data: {zoneid: zoneid},
                    url: 'expiryAndDamages/fetchExpiryCellContent.htm',
                    success: function (response) {
                        $('#cellContent-expired').html(response);
                    }
                });
            }
        });

        //Fetch store bays
        $('#newStorageZoneIsolate').change(function () {
            var isolated = $("#isolated-transfer2").val();
            if (isolated === 'true') {
                var zoneid = parseInt($('#newStorageZoneIsolate').val());
                $('#newZoneBayIsolate').html('');
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
                                    $('#newZoneBayIsolate').html('<option value="0">No Isolated Bays Set</option>');
                                }
                            } else {
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#newZoneBayIsolate').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                                var bayid = parseInt($('#newZoneBayIsolate').val());
                                $('#newBayRowIsolate').html('');
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
                                                    $('#newBayRowIsolate').html('<option value="0">No Isolated Rows Added</option>');
                                                }
                                            } else {
                                                var res = JSON.parse(response);
                                                for (i in res) {
                                                    $('#newBayRowIsolate').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                }
                                                var rowid = parseInt($('#newBayRow').val());
                                                $('#newRowCellIsolate').html('');
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
                                                                    $('#newRowCellIsolate').html('<option value="0">No Isolated Cells Found</option>');
                                                                }
                                                            } else {
                                                                $('#newRowCellIsolate').css('border', '2px solid #6D0A70');
                                                                var res = JSON.parse(response);
                                                                for (i in res) {
                                                                    $('#newRowCellIsolate').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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
                var zoneid = parseInt($('#newStorageZoneIsolate').val());
                $('#newZoneBayIsolate').html('');
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
                                    $('#newZoneBayIsolate').html('<option value="0">No Bays Set</option>');
                                }
                            } else {
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#newZoneBayIsolate').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                                var bayid = parseInt($('#newZoneBayIsolate').val());
                                $('#newBayRowIsolate').html('');
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
                                                    $('#newBayRowIsolate').html('<option value="0">No Rows Added</option>');
                                                }
                                            } else {
                                                var res = JSON.parse(response);
                                                for (i in res) {
                                                    $('#newBayRowIsolate').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                }
                                                var rowid = parseInt($('#newBayRowIsolate').val());
                                                $('#newRowCellIsolate').html('');
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
                                                                    $('#newRowCellIsolate').html('<option value="0">No Cells Found</option>');
                                                                }
                                                            } else {
                                                                $('#newRowCellIsolate').css('border', '2px solid #6D0A70');
                                                                var res = JSON.parse(response);
                                                                for (i in res) {
                                                                    $('#newRowCellIsolate').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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

        $('#newZoneBayIsolate').change(function () {
            var isolated = $("#isolated-transfer2").val();
            if (isolated === 'true') {
                var bayid = parseInt($('#newZoneBayIsolate').val());
                $('#newBayRowIsolate').html('');
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
                                    $('#newBayRowIsolate').html('<option value="0">No Isolated Rows Added</option>');
                                }
                            } else {
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#newBayRowIsolate').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                                var rowid = parseInt($('#newBayRow').val());
                                $('#newRowCellIsolate').html('');
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
                                                    $('#newRowCellIsolate').html('<option value="0">No Isolated Cells Found</option>');
                                                }
                                            } else {
                                                $('#newRowCellIsolate').css('border', '2px solid #6D0A70');
                                                var res = JSON.parse(response);
                                                for (i in res) {
                                                    $('#newRowCellIsolate').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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
                var bayid = parseInt($('#newZoneBayIsolate').val());
                $('#newBayRowIsolate').html('');
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
                                    $('#newBayRowIsolate').html('<option value="0">No Rows Added</option>');
                                }
                            } else {
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#newBayRowIsolate').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                                var rowid = parseInt($('#newBayRowIsolate').val());
                                $('#newRowCellIsolate').html('');
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
                                                    $('#newRowCellIsolate').html('<option value="0">No Cells Found</option>');
                                                }
                                            } else {
                                                $('#newRowCellIsolate').css('border', '2px solid #6D0A70');
                                                var res = JSON.parse(response);
                                                for (i in res) {
                                                    $('#newRowCellIsolate').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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

        $('#newBayRowIsolate').change(function () {
            var isolated = $("#isolated-transfer2").val();
            if (isolated === 'true') {
                var rowid = parseInt($('#newBayRowIsolate').val());
                $('#newRowCellIsolate').html('');
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
                                    $('#newRowCellIsolate').html('<option value="0">No Isolated Cells Found</option>');
                                }
                            } else {
                                $('#newRowCellIsolate').css('border', '2px solid #6D0A70');
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#newRowCellIsolate').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                            }
                        }
                    });
                }
            } else {
                var rowid = parseInt($('#newBayRowIsolate').val());
                $('#newRowCellIsolate').html('');
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
                                    $('#newRowCellIsolate').html('<option value="0">No Cells Found</option>');
                                }
                            } else {
                                $('#newRowCellIsolate').css('border', '2px solid #6D0A70');
                                var res = JSON.parse(response);
                                for (i in res) {
                                    $('#newRowCellIsolate').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                            }
                        }
                    });
                }
            }
        });

        $('#newRowCellIsolate').change(function () {
            var cellid = parseInt($('#newRowCellIsolate').val());
            if (cellid > 0) {
                $('#newRowCellIsolate').css('border', '2px solid #6D0A70');
            }
        });

        $('#transfer-item2').click(function () {
            var qty = parseInt($('#newQtyIsolate').val());
            var curQty = parseInt($('#curQtyIsolate').val());
            var id = parseInt($('#transferIdIsolate').val());
            var cell = parseInt($('#newRowCellIsolate').val());
            var curCell = parseInt($('#curCellIsolate').val());
            var stockId = parseInt($('#transferStockIsolate').val());
            if (qty > 0 && !(qty > curQty) && cell > 0 && curCell !== cell) {
                $('#transfer-item2').prop('disabled', true);
                var data = {
                    id: id,
                    cell: cell,
                    qty: qty,
                    stock: stockId,
                    curcell: curCell,
                    curqty: curQty
                };
                $.ajax({
                    type: 'POST',
                    url: 'store/transferItem.htm',
                    data: data,
                    data_type: 'JSON',
                    success: function (response) {
                        if (response === 'saved') {
                            $('#transferItemIsolate').modal('hide');
                            ajaxSubmitData('expiryAndDamages/fetchCellExpiredItems.htm', 'cellExpiredItems', '&cellid=' + curCell, 'POST');
                            $('.active-li').click();
                        } else if (response === 'refresh') {
                            document.location.reload(true);
                        } else {
                            $.toast({
                                heading: 'Warning',
                                text: 'Failed To Transfer Item',
                                icon: 'warning'
                            });
                        }
                        $('#transfer-item2').prop('disabled', false);
                    }
                });
            } else {
                if (!(qty > 0) || qty > curQty) {
                    $('#newQtyIsolate').focus();
                    $('#newQtyIsolate').css('border', '2px solid #f50808c4');
                }
                if (!(cell > 0) || cell === curCell) {
                    $('#newRowCellIsolate').focus();
                    $('#newRowCellIsolate').css('border', '2px solid #f50808c4');
                }
            }
        });
    });

    function viewExpiredCellItems(id, name) {
        $('#cellTitleIsolate').html(name);
        $('#curCellIsolate').val(id);
        window.location = '#manageCellContentIsolate';
        initDialog('view-expired-items');
        ajaxSubmitData('expiryAndDamages/fetchCellExpiredItems.htm', 'cellExpiredItems', '&cellid=' + id, 'POST');
    }

    function isolateExpiredItem(id, name, qty, stockid, expiry) {
        if (expiry < 1 && expiry !== 0.5) {
            $("#isolated-transfer2").val('true');
        } else {
            $("#isolated-transfer2").val('false');
        }
        $('#itemIsolate').val(name);
        $('#transferIdIsolate').val(id);
        $('#transferStockIsolate').val(stockid);
        $("#newQtyIsolate").val(parseInt(qty.replace(',', '')));
        $("#curQtyIsolate").val(parseInt(qty.replace(',', '')));
        $("#newQtyIsolate").attr('max', parseInt(qty.replace(',', '')));
        $('#transferItemIsolate').modal('show');
        var isolated = $("#isolated-transfer2").val();
        $('#newStorageZoneIsolate').html('');
        if (isolated === 'true') {
            $.ajax({
                type: 'POST',
                data: {isolated: true},
                url: 'store/fetchStoreZones.htm',
                success: function (response) {
                    if (response === 'refresh' || response === '' || response === '[]') {
                        if (response === 'refresh') {
                            document.location.reload(true);
                        } else {
                            $('#newStorageZoneIsolate').html('<option value="0">No Isolated Storages Set</option>');
                        }
                    } else {
                        var res = JSON.parse(response);
                        for (i in res) {
                            $('#newStorageZoneIsolate').append('<option id="zon' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                        }
                        var zoneid = parseInt($('#newStorageZoneIsolate').val());
                        $('#newZoneBayIsolate').html('');
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
                                            $('#newZoneBayIsolate').html('<option value="0">No Isolated Bays Set</option>');
                                        }
                                    } else {
                                        var res = JSON.parse(response);
                                        for (i in res) {
                                            $('#newZoneBayIsolate').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                        }
                                        var bayid = parseInt($('#newZoneBayIsolate').val());
                                        $('#newBayRowIsolate').html('');
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
                                                            $('#newBayRowIsolate').html('<option value="0">No Isolated Rows Added</option>');
                                                        }
                                                    } else {
                                                        var res = JSON.parse(response);
                                                        for (i in res) {
                                                            $('#newBayRowIsolate').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                        }
                                                        var rowid = parseInt($('#newBayRowIsolate').val());
                                                        $('#newRowCellIsolate').html('');
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
                                                                            $('#newRowCellIsolate').html('<option value="0">No Isolated Cells Found</option>');
                                                                        }
                                                                    } else {
                                                                        $('#newRowCellIsolate').css('border', '2px solid #6D0A70');
                                                                        var res = JSON.parse(response);
                                                                        for (i in res) {
                                                                            $('#newRowCellIsolate').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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
                }
            });
        } else {
            $.ajax({
                type: 'POST',
                data: {isolated: false},
                url: 'store/fetchStoreZones.htm',
                success: function (response) {
                    if (response === 'refresh' || response === '' || response === '[]') {
                        if (response === 'refresh') {
                            document.location.reload(true);
                        } else {
                            $('#newStorageZoneIsolate').html('<option value="0">No Storage Zones Set</option>');
                        }
                    } else {
                        var res = JSON.parse(response);
                        for (i in res) {
                            $('#newStorageZoneIsolate').append('<option id="zon' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                        }
                        var zoneid = parseInt($('#newStorageZoneIsolate').val());
                        $('#newZoneBayIsolate').html('');
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
                                            $('#newZoneBayIsolate').html('<option value="0">No Bays Set</option>');
                                        }
                                    } else {
                                        var res = JSON.parse(response);
                                        for (i in res) {
                                            $('#newZoneBayIsolate').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                        }
                                        var bayid = parseInt($('#newZoneBayIsolate').val());
                                        $('#newBayRowIsolate').html('');
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
                                                            $('#newBayRowIsolate').html('<option value="0">No Rows Added</option>');
                                                        }
                                                    } else {
                                                        var res = JSON.parse(response);
                                                        for (i in res) {
                                                            $('#newBayRowIsolate').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                        }
                                                        var rowid = parseInt($('#newBayRowIsolate').val());
                                                        $('#newRowCellIsolate').html('');
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
                                                                            $('#newRowCellIsolate').html('<option value="0">No Cells Found</option>');
                                                                        }
                                                                    } else {
                                                                        $('#newRowCellIsolate').css('border', '2px solid #6D0A70');
                                                                        var res = JSON.parse(response);
                                                                        for (i in res) {
                                                                            $('#newRowCellIsolate').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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
                }
            });
        }
    }
</script>
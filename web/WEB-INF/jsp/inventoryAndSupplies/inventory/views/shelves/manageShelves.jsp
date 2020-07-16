<%-- 
    Document   : manageShelves
    Created on : Apr 17, 2018, 11:30:17 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<c:if test="${not empty storageZones}">
    <div class="row">
        <div class="col-md-8"></div>
        <div class="col-md-4">
            <form>
                <div class="form-group">
                    <label for="storageZone">Storage Zone</label>
                    <select class="form-control" id="shelfZone">
                        <c:forEach items="${storageZones}" var="zone">
                            <option id="zone${zone.id}" data-name="${zone.name}" value="${zone.id}">${zone.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8" id="cell-left">
            <div class="row">
                <input id="selectedRow" type="hidden" value="0"/>
                <div class="col-md-6">
                    <div class="messanger">
                        <div class="sender">
                            <input id="cellSearch" oninput="searchCellContents()" type="text" placeholder="Search ...">
                            <button class="btn btn-primary" type="button">
                                <i class="fa fa-lg fa-fw fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div id="cellContent">

            </div>
        </div>
        <div class="col-md-4" id="cell-right" align="right">
            <div class="row" id="shelfPane">

            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="manageCellContent" class="manageCellDialog view-shelf-items">
                <div>
                    <div id="head">
                        <div class="card-header">
                            <h5 class="card-title" id="cellTitle"></h5>
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
                                        <div id="cellItems">

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="transferItem" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
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
                                                <input id="curQty" type="hidden" value="0"/>
                                                <input id="curCell" type="hidden" value="0"/>
                                                <input id="transferId" type="hidden" value="0"/>
                                                <input id="transferStock" type="hidden" value="0"/>
                                                <input id="isolated-transfer" type="hidden" value="false"/>
                                                <div class="form-group">
                                                    <label for="itemname">Item</label>
                                                    <input class="form-control" id="item" type="text"  disabled="true">
                                                </div>
                                                <hr>
                                                <div class="form-group">
                                                    <label for="newStorageZone">Zone</label>
                                                    <select class="form-control" id="newStorageZone">
                                                        <option value="0">Select Zone</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="newZoneBay">Bay</label>
                                                    <select class="form-control" id="newZoneBay">
                                                        <option value="0">Select Bay</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="newBayRow">Bay Row</label>
                                                    <select class="form-control" id="newBayRow">
                                                        <option value="0">Select Row</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="newRowCell">Cell</label>
                                                    <select class="form-control" id="newRowCell">
                                                        <option value="0">Select Cell</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="newQty">Quantity To Shelve</label>
                                                    <input class="form-control" id="newQty" min="1" type="number" placeholder="Qauntity to Shelve">
                                                </div><hr>
                                            </form>
                                            <div class="form-group">
                                                <div class="col-sm-12 text-right">
                                                    <button type="button" class="btn btn-primary" id="transfer-item">
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
<c:if test="${empty storageZones}">
    <div class="row">
        <div class="col-md-12 tile center">
            <h4>No Storage Locations Set</h4>
        </div>
    </div>
</c:if>
<c:if test="${not empty storageZones}">
    <script>
        $(document).ready(function () {
            $('#shelfZone').select2();
            $('.select2').css('width', '100%');
            var zoneid = parseInt($('#shelfZone').val());
            if (zoneid > 0) {
                $.ajax({
                    type: 'POST',
                    data: {zoneid: zoneid},
                    url: 'store/initShelfPane.htm',
                    success: function (response) {
                        $('#shelfPane').html(response);
                    }
                });
            }

            $('#shelfZone').change(function () {
                zoneid = parseInt($('#shelfZone').val());
                if (zoneid > 0) {
                    $.ajax({
                        type: 'POST',
                        data: {zoneid: zoneid},
                        url: 'store/initShelfPane.htm',
                        success: function (response) {
                            $('#shelfPane').html(response);
                        }
                    });
                }
            });

            //Fetch store bays
            $('#newStorageZone').change(function () {
                var isolated = $("#isolated-transfer").val();
                if (isolated === 'true') {
                    var zoneid = parseInt($('#newStorageZone').val());
                    $('#newZoneBay').html('');
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
                                        $('#newZoneBay').html('<option value="0">No Isolated Bays Set</option>');
                                    }
                                } else {
                                    var res = JSON.parse(response);
                                    for (i in res) {
                                        $('#newZoneBay').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                    }
                                    var bayid = parseInt($('#newZoneBay').val());
                                    $('#newBayRow').html('');
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
                                                        $('#newBayRow').html('<option value="0">No Isolated Rows Added</option>');
                                                    }
                                                } else {
                                                    var res = JSON.parse(response);
                                                    for (i in res) {
                                                        $('#newBayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                    }
                                                    var rowid = parseInt($('#newBayRow').val());
                                                    $('#newRowCell').html('');
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
                                                                        $('#newRowCell').html('<option value="0">No Isolated Cells Found</option>');
                                                                    }
                                                                } else {
                                                                    $('#newRowCell').css('border', '2px solid #6D0A70');
                                                                    var res = JSON.parse(response);
                                                                    for (i in res) {
                                                                        $('#newRowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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
                    var zoneid = parseInt($('#newStorageZone').val());
                    $('#newZoneBay').html('');
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
                                        $('#newZoneBay').html('<option value="0">No Bays Set</option>');
                                    }
                                } else {
                                    var res = JSON.parse(response);
                                    for (i in res) {
                                        $('#newZoneBay').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                    }
                                    var bayid = parseInt($('#newZoneBay').val());
                                    $('#newBayRow').html('');
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
                                                        $('#newBayRow').html('<option value="0">No Rows Added</option>');
                                                    }
                                                } else {
                                                    var res = JSON.parse(response);
                                                    for (i in res) {
                                                        $('#newBayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                    }
                                                    var rowid = parseInt($('#newBayRow').val());
                                                    $('#newRowCell').html('');
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
                                                                        $('#newRowCell').html('<option value="0">No Cells Found</option>');
                                                                    }
                                                                } else {
                                                                    $('#newRowCell').css('border', '2px solid #6D0A70');
                                                                    var res = JSON.parse(response);
                                                                    for (i in res) {
                                                                        $('#newRowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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

            $('#newZoneBay').change(function () {
                var isolated = $("#isolated-transfer").val();
                if (isolated === 'true') {
                    var bayid = parseInt($('#newZoneBay').val());
                    $('#newBayRow').html('');
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
                                        $('#newBayRow').html('<option value="0">No Isolated Rows Added</option>');
                                    }
                                } else {
                                    var res = JSON.parse(response);
                                    for (i in res) {
                                        $('#newBayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                    }
                                    var rowid = parseInt($('#newBayRow').val());
                                    $('#newRowCell').html('');
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
                                                        $('#newRowCell').html('<option value="0">No Isolated Cells Found</option>');
                                                    }
                                                } else {
                                                    $('#newRowCell').css('border', '2px solid #6D0A70');
                                                    var res = JSON.parse(response);
                                                    for (i in res) {
                                                        $('#newRowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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
                    var bayid = parseInt($('#newZoneBay').val());
                    $('#newBayRow').html('');
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
                                        $('#newBayRow').html('<option value="0">No Rows Added</option>');
                                    }
                                } else {
                                    var res = JSON.parse(response);
                                    for (i in res) {
                                        $('#newBayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                    }
                                    var rowid = parseInt($('#newBayRow').val());
                                    $('#newRowCell').html('');
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
                                                        $('#newRowCell').html('<option value="0">No Cells Found</option>');
                                                    }
                                                } else {
                                                    $('#newRowCell').css('border', '2px solid #6D0A70');
                                                    var res = JSON.parse(response);
                                                    for (i in res) {
                                                        $('#newRowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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

            $('#newBayRow').change(function () {
                var isolated = $("#isolated-transfer").val();
                if (isolated === 'true') {
                    var rowid = parseInt($('#newBayRow').val());
                    $('#newRowCell').html('');
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
                                        $('#newRowCell').html('<option value="0">No Isolated Cells Found</option>');
                                    }
                                } else {
                                    $('#newRowCell').css('border', '2px solid #6D0A70');
                                    var res = JSON.parse(response);
                                    for (i in res) {
                                        $('#newRowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                    }
                                }
                            }
                        });
                    }
                } else {
                    var rowid = parseInt($('#newBayRow').val());
                    $('#newRowCell').html('');
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
                                        $('#newRowCell').html('<option value="0">No Cells Found</option>');
                                    }
                                } else {
                                    $('#newRowCell').css('border', '2px solid #6D0A70');
                                    var res = JSON.parse(response);
                                    for (i in res) {
                                        $('#newRowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                    }
                                }
                            }
                        });
                    }
                }
            });

            $('#newRowCell').change(function () {
                var cellid = parseInt($('#newRowCell').val());
                if (cellid > 0) {
                    $('#newRowCell').css('border', '2px solid #6D0A70');
                }
            });

            $('#transfer-item').click(function () {
                var qty = parseInt($('#newQty').val());
                var curQty = parseInt($('#curQty').val());
                var id = parseInt($('#transferId').val());
                var cell = parseInt($('#newRowCell').val());
                var curCell = parseInt($('#curCell').val());
                var stockId = parseInt($('#transferStock').val());
                if (qty > 0 && !(qty > curQty) && cell > 0 && curCell !== cell) {
                    $('#transfer-item').prop('disabled', true);
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
                                $('#transferItem').modal('hide');
                                ajaxSubmitData('store/fetchCellItems.htm', 'cellItems', '&cellid=' + curCell, 'POST');
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
                            $('#transfer-item').prop('disabled', false);
                        }
                    });
                } else {
                    if (!(qty > 0) || qty > curQty) {
                        $('#newQty').focus();
                        $('#newQty').css('border', '2px solid #f50808c4');
                    }
                    if (!(cell > 0) || cell === curCell) {
                        $('#newRowCell').focus();
                        $('#newRowCell').css('border', '2px solid #f50808c4');
                    }
                }
            });
        });

        function cellClick(id, name) {
            $('#cellTitle').html(name);
            $('#curCell').val(id);
            window.location = '#manageCellContent';
            initDialog('view-shelf-items');
            ajaxSubmitData('store/fetchCellItems.htm', 'cellItems', '&cellid=' + id, 'POST');
        }

        function transferItem(id, name, qty, stockid, expiry) {
            if (expiry < 1 && expiry !== 0.5) {
                $("#isolated-transfer").val('true');
            } else {
                $("#isolated-transfer").val('false');
            }
            $('#item').val(name);
            $('#transferId').val(id);
            $('#transferStock').val(stockid);
            $("#newQty").val(parseInt(qty.replace(',', '')));
            $("#curQty").val(parseInt(qty.replace(',', '')));
            $("#newQty").attr('max', parseInt(qty.replace(',', '')));
            $('#transferItem').modal('show');

            var isolated = $("#isolated-transfer").val();
            $('#newStorageZone').html('');
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
                                $('#newStorageZone').html('<option value="0">No Isolated Storages Set</option>');
                            }
                        } else {
                            var res = JSON.parse(response);
                            for (i in res) {
                                $('#newStorageZone').append('<option id="zon' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                            }
                            var zoneid = parseInt($('#newStorageZone').val());
                            $('#newZoneBay').html('');
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
                                                $('#newZoneBay').html('<option value="0">No Isolated Bays Set</option>');
                                            }
                                        } else {
                                            var res = JSON.parse(response);
                                            for (i in res) {
                                                $('#newZoneBay').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                            }
                                            var bayid = parseInt($('#newZoneBay').val());
                                            $('#newBayRow').html('');
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
                                                                $('#newBayRow').html('<option value="0">No Isolated Rows Added</option>');
                                                            }
                                                        } else {
                                                            var res = JSON.parse(response);
                                                            for (i in res) {
                                                                $('#newBayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                            }
                                                            var rowid = parseInt($('#newBayRow').val());
                                                            $('#newRowCell').html('');
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
                                                                                $('#newRowCell').html('<option value="0">No Isolated Cells Found</option>');
                                                                            }
                                                                        } else {
                                                                            $('#newRowCell').css('border', '2px solid #6D0A70');
                                                                            var res = JSON.parse(response);
                                                                            for (i in res) {
                                                                                $('#newRowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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
                                $('#newStorageZone').html('<option value="0">No Storage Zones Set</option>');
                            }
                        } else {
                            var res = JSON.parse(response);
                            for (i in res) {
                                $('#newStorageZone').append('<option id="zon' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                            }
                            var zoneid = parseInt($('#newStorageZone').val());
                            $('#newZoneBay').html('');
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
                                                $('#newZoneBay').html('<option value="0">No Bays Set</option>');
                                            }
                                        } else {
                                            var res = JSON.parse(response);
                                            for (i in res) {
                                                $('#newZoneBay').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                            }
                                            var bayid = parseInt($('#newZoneBay').val());
                                            $('#newBayRow').html('');
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
                                                                $('#newBayRow').html('<option value="0">No Rows Added</option>');
                                                            }
                                                        } else {
                                                            var res = JSON.parse(response);
                                                            for (i in res) {
                                                                $('#newBayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                            }
                                                            var rowid = parseInt($('#newBayRow').val());
                                                            $('#newRowCell').html('');
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
                                                                                $('#newRowCell').html('<option value="0">No Cells Found</option>');
                                                                            }
                                                                        } else {
                                                                            $('#newRowCell').css('border', '2px solid #6D0A70');
                                                                            var res = JSON.parse(response);
                                                                            for (i in res) {
                                                                                $('#newRowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
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

        function searchCellContents() {
            var name = $('#cellSearch').val();
            var zoneid = parseInt($('#shelfZone').val());
            if (name.length > 0 && zoneid > 0) {
                $('#cell-right').hide();
                $('#cell-left').removeClass('col-md-8');
                $('#cell-left').addClass('col-md-12');
                ajaxSubmitDataNoLoader('store/searchCells.htm', 'cellContent', '&zoneid=' + zoneid + '&name=' + name, 'POST');
            } else {
                $('.a-container li:first-child > label').click();
                $('.a-container li:first-child > .a-content > .items li:first-child').click();
                $('.a-container li:first-child > .a-content > .items li:first-child').addClass('active-li');
                $('#cell-left').removeClass('col-md-12');
                $('#cell-left').addClass('col-md-8');
                $('#cell-right').show();
            }
        }
    </script>
</c:if>
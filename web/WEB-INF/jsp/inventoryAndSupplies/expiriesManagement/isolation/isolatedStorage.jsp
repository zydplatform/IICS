<%-- 
    Document   : isolatedStorage
    Created on : Oct 4, 2018, 4:57:24 PM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty zones}">
    <div class="tile">
        <div class="row">
            <div class="col-md-8">
                <button class="btn btn-primary icon-btn" onclick="addIsolatedCells()">
                    <i class="fa fa-plus"></i>
                    Add Isolated Storages
                </button>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="storageZone">Storage Zone</label>
                    <select class="form-control" id="isolatedZone">
                        <c:forEach items="${zones}" var="zone">
                            <option id="zone${zone.id}" data-name="${zone.zonename}" value="${zone.id}">${zone.zonename}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12" id="cell-left">
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
                                                        <c:forEach items="${zones}" var="zone">
                                                            <option id="zone${zone.id}" data-name="${zone.zonename}" value="${zone.id}">${zone.zonename}</option>
                                                        </c:forEach>
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
<c:if test="${empty zones}">
    <div class="row">
        <div class="col-md-12 tile">
            <button class="btn btn-primary icon-btn" onclick="addIsolatedCells()">
                <i class="fa fa-plus"></i>
                Add Isolated Storages
            </button>
        </div>
    </div>
</c:if>
<div class="row">
    <div class="col-md-12">
        <div id="setActivityCells" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Set Isolated Cells Cells</h2>
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
<script>
    var cellList = new Set();
    $(document).ready(function () {
        $('#isolatedZone').select2();
        $('.select2').css('width', '100%');
        var zoneid = parseInt($('#isolatedZone').val());
        if (zoneid > 0) {
            $.ajax({
                type: 'POST',
                data: {zoneid: zoneid},
                url: 'expiryAndDamages/fetchIsolatedCellContent.htm',
                success: function (response) {
                    $('#cellContent').html(response);
                }
            });
        }

        $('#isolatedZone').change(function () {
            zoneid = parseInt($('#isolatedZone').val());
            if (zoneid > 0) {
                $.ajax({
                    type: 'POST',
                    data: {zoneid: zoneid},
                    url: 'expiryAndDamages/fetchIsolatedCellContent.htm',
                    success: function (response) {
                        $('#cellContent').html(response);
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

        $('#saveCells').click(function () {
            var cells = Array.from(cellList);
            if (cells.length > 0) {
                $('#saveCells').prop('disabled', true);
                var data = {
                    cells: JSON.stringify(cells)
                };
                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'expiryAndDamages/saveActivityCells.htm',
                    success: function (res) {
                        if (res === 'saved') {
                            cellList = new Set();
                            var zoneid = parseInt($('#isolatedZone').val());
                            if (zoneid > 0) {
                                $('#enteredItemsBody').html('');
                                $.ajax({
                                    type: 'POST',
                                    data: {zoneid: zoneid},
                                    url: 'expiryAndDamages/fetchIsolatedCellContent.htm',
                                    success: function (response) {
                                        $('#cellContent').html(response);
                                    }
                                });
                            }else{
                                ajaxSubmitData('expiryAndDamages/expiryAndDamagePane.htm', 'workpane', '', 'GET');
                            }
                        } else if (res === 'refresh') {
                            document.location.reload(true);
                        }
                        $('#saveCells').prop('disabled', false);
                    }
                });
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
        var zoneid = parseInt($('#isolatedZone').val());
        if (name.length > 0 && zoneid > 0) {
            ajaxSubmitDataNoLoader('expiryAndDamages/searchCells.htm', 'cellContent', '&zoneid=' + zoneid + '&name=' + name, 'POST');
        } else {
            var zoneid = parseInt($('#isolatedZone').val());
            if (zoneid > 0) {
                $.ajax({
                    type: 'POST',
                    data: {zoneid: zoneid},
                    url: 'expiryAndDamages/fetchIsolatedCellContent.htm',
                    success: function (response) {
                        $('#cellContent').html(response);
                    }
                });
            }
        }
    }

    function addIsolatedCells() {
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
        if (name.length > 0) {
            ajaxSubmitDataNoLoader('expiryAndDamages/searchUnisolatedCells.htm', 'searchResults', '&name=' + name, 'GET');
        } else
            $('#searchResults').html('');
    }

    function removeCell(rowId) {
        $('#cellrow' + rowId).remove();
        cellList.delete(rowId);
    }

    function unisolateCell(cellid, cellLabel) {
        $.confirm({
            title: '<h3>' + cellLabel + '</h3>',
            content: '<h4 class="itemTitle"> cell <font color="red">' + cellLabel + '</font> will Nolonger be Isolated.</h4>',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Remove',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {cellid: cellid},
                            url: 'expiryAndDamages/unisolateCell.htm',
                            success: function (res) {
                                if (res === 'saved') {
                                    var zoneid = parseInt($('#isolatedZone').val());
                                    if (zoneid > 0) {
                                        $.ajax({
                                            type: 'POST',
                                            data: {zoneid: zoneid},
                                            url: 'expiryAndDamages/fetchIsolatedCellContent.htm',
                                            success: function (response) {
                                                $('#cellContent').html(response);
                                            }
                                        });
                                    }
                                } else if (res === 'refresh') {
                                    document.location.reload(true);
                                }
                            }
                        });
                    }
                },
                close: {
                    text: 'Cancel',
                    btnClass: 'btn-info',
                    action: function () {

                    }
                }
            }
        });
    }
</script>
<%-- 
    Document   : manageItems
    Created on : 07-May-2018, 13:02:48
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<div class="row">
    <div class="col-md-3">
        <div class="btn-group">
            <button id="enter-Items" class="btn btn-primary" type="button">
                Add Items
            </button>
        </div>
    </div>
    <div class="col-md-5"></div>
    <div class="col-md-4">
        <form>
            <div class="form-group">
                <select class="form-control" id="unapprovedgroup">
                    <option value="0" selected="true">Medicines</option>
                    <option value="1">Supplies</option>
                </select>
            </div>
        </form>
    </div>
</div>
<fieldset>
    <div class="row" id="catItems">

    </div>
</fieldset>
<div class="row">
    <div class="col-md-12">
        <div id="enterMedicines" class="supplierCatalogDialog enterMedicines">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Manage Unit Catalogue</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-4">
                        <div class="tile" id="searchTile">
                            <div class="tile-body">
                                <div id="search-form_3">
                                    <input id="itemSearch" type="text" oninput="searchItem()" placeholder="Search Item" onfocus="setSearchPane()" class="search_3 dropbtn"/>
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
                                                <th class="right">Item Strength</th>
                                                <th class="right">Item Form</th>
                                                <th class="center">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody id="enteredItemsBody">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12 text-right">
                                        <button type="button" class="btn btn-primary saveCatItems">
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
        <div id="enterunitSupplies" class="supplierCatalogDialog enterunitSupplies">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Manage Unit Catalogue</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-4">
                        <div class="tile" id="searchTile">
                            <div class="tile-body">
                                <div id="search-form_3" class="search-form3">
                                    <input id="searchSupplies" type="text" oninput="searchSupplies()" placeholder="Search Item" onfocus="setSearchPaneSupplies()" class="search_3 dropbtn"/>
                                </div><br>
                                <div id="searchResultsSupplies" class="scrollbar">

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
                                                <th class="right">Item Specifications</th>
                                                <th class="center">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody id="enteredSuppliesBody">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12 text-right">
                                        <button type="button" class="btn btn-primary saveCatItems">
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
    var itemList = new Set();
    $(document).ready(function () {
        $('#unapprovedgroup').select2();
        $('.select2').css('width', '100%');
        var issupplies = parseInt($('#unapprovedgroup').val()) === 1;
        ajaxSubmitData('catalogue/fetchUnitCatalogueItems.htm', 'catItems', '&issupplies=' + issupplies, 'GET');
        $('#unapprovedgroup').change(function () {
            $('#catItems').html('');
            issupplies = parseInt($('#unapprovedgroup').val()) === 1;
            ajaxSubmitData('catalogue/fetchUnitCatalogueItems.htm', 'catItems', '&issupplies=' + issupplies, 'GET');
        });
        $('#enter-Items').click(function () {
            if (issupplies === false) {
                window.location = '#enterMedicines';
                initDialog('enterMedicines');
            } else {
                window.location = '#enterunitSupplies';
                initDialog('enterunitSupplies');
            }
        });

        $('.saveCatItems').click(function () {
            var items = Array.from(itemList);
            console.log(items);
            if (items.length > 0) {
                var data = {
                    items: JSON.stringify(items)
                };
                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'catalogue/saveCatalogItems.htm',
                    success: function (res) {
                        if (res === 'Saved') {
                            ajaxSubmitData('catalogue/loadUnitCatalogPane.htm', 'workpane', 'tab=1', 'GET');
                        }
                    }
                });
            }
        });
    });

    function setSearchPane() {
        var div = $('.enterMedicines > div').height();
        var divHead = $('.enterMedicines > div > #head').height();
        var searchForm = $('#search-form_3').height();
        $('#searchResults').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm));
        $(window).resize(function () {
            div = $('.enterMedicines > div').height();
            divHead = $('.enterMedicines > div > #head').height();
            searchForm = $('#search-form_3').height();
            $('#searchResults').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm));
        });
    }
    
    function setSearchPaneSupplies() {
        var div = $('.enterunitSupplies > div').height();
        var divHead = $('.enterunitSupplies > div > #head').height();
        var searchForm = $('.search-form3').height();
        $('#searchResultsSupplies').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm));
        $(window).resize(function () {
            div = $('.enterunitSupplies > div').height();
            divHead = $('.enterunitSupplies > div > #head').height();
            searchForm = $('#search-form3').height();
            $('#searchResultsSupplies').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm));
        });
    }

    function searchItem() {
        var name = $('#itemSearch').val();
        if (name.length >= 2) {
            ajaxSubmitDataNoLoader('catalogue/searchItem.htm', 'searchResults', '&name=' + name, 'GET');
        } else
            $('#searchResults').html('');
    }
    
    function searchSupplies() {
        var name = $('#searchSupplies').val();
        if (name.length >= 2) {
            ajaxSubmitDataNoLoader('catalogue/searchSupplies.htm', 'searchResultsSupplies', '&name=' + name, 'GET');
        } else
            $('#searchResultsSupplies').html('');
    }

    function remove(rowId) {
        $('#row' + rowId).remove();
        itemList.delete(rowId);
    }

    function deleteNewCatItem(id, itemName) {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Delete Item',
            content: '<strong>' + itemName + '</strong>',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Delete',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {id: id},
                            url: 'catalogue/deleteCatItem.htm',
                            success: function (res) {
                                if (res === 'deleted') {
                                    $('#itemRow' + id).remove();
                                    ajaxSubmitData('catalogue/loadUnitCatalogPane.htm', 'workpane', 'tab=1', 'GET');
                                } else if (res === 'refresh') {
                                    document.location.reload(true);
                                } else {
                                    $.toast({
                                        heading: 'Warning',
                                        text: 'Failed to Delete Item',
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
                    text: 'Cancel'
                }
            }
        });
    }

</script>

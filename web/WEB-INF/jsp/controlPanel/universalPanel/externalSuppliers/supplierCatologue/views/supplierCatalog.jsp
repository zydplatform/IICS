<%-- 
    Document   : supplierCatalog
    Created on : Apr 5, 2018, 3:10:50 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<div class="row">
    <br>
    <div class="col-md-8"></div>
    <div class="col-md-4" id="supplierDiv">
        <select class="form-control" id="supplierList">
            <c:forEach items="${suppliers}" var="supplier">
                <option id="sup${supplier.id}" data-name="${supplier.name}" value="${supplier.id}">${supplier.name}</option>
            </c:forEach>
        </select>
    </div>
</div>
<div class="row">
    <div class="col-md-2 col-sm-3">
        <button id="addCatalog" class="btn btn-primary icon-btn">
            <i class="fa fa-plus"></i>
            Add Items
        </button>
    </div>
    <div class="col-md-2 col-sm-3">
        <button class="btn btn-primary icon-btn" onclick="filterItemList($('#supplierList').val())">
            <i class="fa fa-filter" aria-hidden="true"></i>
            Filter Items
        </button>
    </div>
</div>
<div class="row">
    <div class="col-md-12 col-sm-12" id="catalogContent">

    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="enterItems" class="supplierCatalogDialog addCatItems">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2 closeAddItem">X</a>
                    <h2 class="modalDialog-title" id="supplierTitle"></h2>
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
                                                <th class="center">Restricted</th>
                                                <th class="right">Code</th>
                                                <th class="right">Pack Size</th>
                                                <th class="right">Unit Cost</th>
                                                <th class="center">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody id="enteredItemsBody">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12 text-right">
                                        <button type="button" class="btn btn-primary" id="saveCatItems">
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
    var items = [];
    $(document).ready(function () {
        $('#supplierList').select2();
        $('.select2').css('width', '100%');
        var supplier = $('#supplierList').val();

        ajaxSubmitData('externalsuppliers/fetchSupplierItems.htm', 'catalogContent', '&supplierid=' + supplier, 'GET');
        $('#supplierList').change(function () {
            $('#catalogContent').html('');
            supplier = $('#supplierList').val();
            ajaxSubmitData('externalsuppliers/fetchSupplierItems.htm', 'catalogContent', '&supplierid=' + supplier, 'GET');
        });
        $('#addCatalog').click(function () {
            $('#supplierDiv').hide();
            window.location = '#enterItems';
            $('#supplierTitle').html($('#sup' + $('#supplierList').val()).data('name'));
            initDialog('addCatItems');
        });

        $('.closeAddItem').click(function () {
            $('#supplierDiv').show();
        });

        $('#saveCatItems').click(function () {
            var supplierid = $('#supplierList').val();
            if (items.length > 0) {
                var data = {
                    supplierid: supplierid,
                    items: JSON.stringify(items)
                };
                items = [];
                itemList = new Set();
                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'externalsuppliers/saveSupplierCatalogue.htm',
                    success: function (res) {
                        if (res === 'saved') {
                            $('#catalogContent').html('');
                            $('#enteredItemsBody').html('');
                            supplier = $('#supplierList').val();
                            ajaxSubmitData('externalsuppliers/fetchSupplierItems.htm', 'catalogContent', '&supplierid=' + supplier, 'GET');
                            window.location = '#close';
                        } else if (res === 'refresh') {
                            document.location.reload(true);
                        } else {
                            $.toast({
                                heading: 'Warning',
                                text: 'Failed to Save Items',
                                icon: 'warning',
                                hideAfter: 2000,
                                position: 'mid-center'
                            });
                        }
                    }
                });
            } else {
                $.toast({
                    heading: 'Warning',
                    text: 'No Items Selected!',
                    icon: 'warning',
                    hideAfter: 2000,
                    position: 'mid-center'
                });
            }
        });
    });

    function setSearchPane() {
        var div = $('.supplierCatalogDialog > div').height();
        var divHead = $('.supplierCatalogDialog > div > #head').height();
        var searchForm = $('#search-form_3').height();
        $('#searchResults').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm));
        $(window).resize(function () {
            div = $('.supplierCatalogDialog > div').height();
            divHead = $('.supplierCatalogDialog > div > #head').height();
            searchForm = $('#search-form_3').height();
            $('#searchResults').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm));
        });
    }

    function searchItem() {
        var name = $('#itemSearch').val();
        if (name.length > 0) {
            ajaxSubmitDataNoLoader('externalsuppliers/searchItem.htm', 'searchResults', '&name=' + name, 'GET');
        } else
            $('#searchResults').html('');
    }

    function remove(rowId) {
        $('#row' + rowId).remove();
        itemList.delete(rowId);
        for (i in items) {
            if (items[i].id === rowId) {
                items.splice(i, 1);
                break;
            }
        }
    }

    function editItem(id, itemName, code, pack, cost, restricted) {
        $.confirm({
            title: '<h3 class="itemTitle">' + itemName + '</h3>',
            content: '<div class="form-group">' +
                    '<label>Item Code</label>' +
                    '<input type="text" id="code" value="' + code + '" placeholder="Item Code" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<label for="pack">Pack Size</label>' +
                    '<input type="number" min="1" id="pack" value="' + pack + '" placeholder="Pack Size" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<label for="cost">Unit Cost</label>' +
                    '<input type="number" min="1" id="cost" value="' + cost + '" placeholder="Unit Cost" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<div class="control-label required"><label>Restricted:</label></div>' +
                    '<div class="form-check"><label class="form-check-label">' +
                    '<input id="yes" value="Yes" class="form-check-input" type="radio" name="res"><span class="label-text">Yes</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
                    '</label>' +
                    '<label class="form-check-label">' +
                    '<input id="no" value="No" class="form-check-input" type="radio" name="res"><span class="label-text">No</span>' +
                    '</label></div></div>',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                formSubmit: {
                    text: 'Update Item',
                    btnClass: 'btn-purple',
                    action: function () {
                        var supplierid = $('#supplierList').val();
                        var itemcode = this.$content.find('#code');
                        var packsize = this.$content.find('#pack');
                        var unitcost = this.$content.find('#cost');
                        var res = this.$content.find('input:radio[name=res]:checked');
                        if (itemcode.val() !== '' && packsize.val() !== '' && unitcost.val() !== '') {
                            var data = {
                                id: id,
                                code: itemcode.val(),
                                pack: packsize.val(),
                                cost: (unitcost.val()).toString(),
                                res: (res.val() === 'Yes')
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'externalsuppliers/updateCatalogItem.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        ajaxSubmitData('externalsuppliers/fetchSupplierItems.htm', 'catalogContent', '&supplierid=' + supplierid, 'GET');
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Details Updated.',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    } else if (res === 'refresh') {
                                        document.location.reload(true);
                                    } else {
                                        $.toast({
                                            heading: 'Warning',
                                            text: 'Failed to Update Details',
                                            icon: 'warning',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                    }
                                }
                            });
                        } else {
                            if (itemcode.val() === '') {
                                $.alert('Please Provide Item Code');
                                return false;
                            }
                            if (packsize.val() === '') {
                                $.alert('Please Provide Package Size');
                                return false;
                            }
                            if (unitcost.val() === '') {
                                $.alert('Please Provide Unit Cost.');
                                return false;
                            }
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
                var no = this.$content.find('#no');
                var yes = this.$content.find('#yes');
                if (restricted === true) {
                    yes.click();
                } else {
                    no.click();
                }
            }
        });
    }
</script>
<%-- 
    Document   : items
    Created on : Mar 24, 2018, 5:59:06 AM
    Author     : IICS
--%>
<style>
    .select2-container{
        z-index: 9999999 !important;
    }
</style>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-2 col-sm-3">
        <button class="btn btn-primary icon-btn" id="addNewItem">
            <i class="fa fa-plus" aria-hidden="true"></i>
            Add New Items
        </button>
    </div>
    <div class="col-md-2 col-sm-3">
        <button class="btn btn-primary icon-btn" onclick="filterItemList()">
            <i class="fa fa-filter" aria-hidden="true"></i>
            Filter Items
        </button>
    </div>
</div>
<fieldset>
    <div id="tableItemsContent">

    </div>
</fieldset>
<div id="additem" class="supplierCatalogDialog">
    <div>
        <div id="head">
            <a href="#close" title="Close" class="close2">X</a>
            <h2 class="modalDialog-title">Add New Items</h2>
            <hr>
        </div>
        <div class="row scrollbar" id="content">
            <div class="col-md-4">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <h4 class="tile-title">Enter Item Details</h4>
                            <div class="tile-body">
                                <form id="entryform">
                                    <div class="form-group">
                                        <label class="control-label">Item Classification</label>
                                        <select class="form-control" id="newItemClassification">
                                            <c:forEach items="${classifications}" var="classification">
                                                <option id="class${classification.id}" data-name="${classification.name}" value="${classification.id}">${classification.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Item Category</label>
                                        <select class="form-control" id="newItemCategory">

                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Item Name</label>
                                        <input class="form-control" id="itemname" type="text" placeholder="Item Name">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Item Code</label>
                                        <input class="form-control" id="itemcode" type="text" placeholder="Item Code">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Item Form</label>
                                        <select class="form-control" id="newItemForm">
                                            <c:forEach items="${forms}" var="form">
                                                <option id="form${form.id}" data-name="${form.name}" value="${form.id}">${form.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Administering Type</label>
                                        <select class="form-control" id="newItemType">
                                            <c:forEach items="${types}" var="admintypes">
                                                <option id="type${admintypes.id}" data-name="${admintypes.name}" value="${admintypes.id}">${admintypes.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </form>
                            </div>
                            <div class="tile-footer">
                                <button class="btn btn-primary" id="captureItem" type="button">
                                    <i class="fa fa-fw fa-lg fa-plus-circle"></i>
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
                            <h4 class="tile-title">Entered Items.</h4>
                            <table class="table table-sm">
                                <thead>
                                    <tr>
                                        <th>Item Name</th>
                                        <th>Code</th>
                                        <th>Category</th>
                                        <th>Form</th>
                                        <th>Admin Type</th>
                                        <th>Remove</th>
                                    </tr>
                                </thead>
                                <tbody id="enteredItemsBody">

                                </tbody>
                            </table>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12 text-right">
                                <button type="button" class="btn btn-primary" id="saveItems">
                                    Finish
                                </button>
                            </div>
                        </div>
                        <div class="form-group"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var itemList = new Set();
    var itemObjectList = [];
    $(document).ready(function () {
        $('#newItemForm').select2();
        $('#newItemType').select2();
        $('#newItemCategory').select2();
        $('#newItemClassification').select2();
        $('.select2').css('width', '100%');
        $('#addNewItem').click(function () {
            window.location = '#additem';
            initDialog('supplierCatalogDialog');
        });
        $.ajax({
            type: 'POST',
            url: 'store/fetchItemList.htm',
            success: function (data) {
                $('#tableItemsContent').html(data);
            }
        });
        var classification = parseInt($('#newItemClassification').val());
        if (!(classification === 0)) {
            $.ajax({
                type: 'POST',
                data: {classification: classification},
                url: 'store/fetchClassificationCategories_json.htm',
                success: function (data) {
                    var res = JSON.parse(data);
                    if (res !== '' && res.length > 0) {
                        $('#newItemCategory').append('<option value="0">Select Category</option>').trigger('change');
                        for (i in res) {
                            $('#newItemCategory').append('<option id="newItemCat' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                        }
                    } else {
                        $('#newItemCategory').append('<option value="0">--No Categories Set--</option>');
                    }
                }
            });
        }

        $('#newItemClassification').change(function () {
            $('#newItemCategory').html('');
            var classification = parseInt($('#newItemClassification').val());
            if (!(classification === 0)) {
                $.ajax({
                    type: 'POST',
                    data: {classification: classification},
                    url: 'store/fetchClassificationCategories_json.htm',
                    success: function (data) {
                        var res = JSON.parse(data);
                        if (res !== '' && res.length > 0) {
                            $('#newItemCategory').append('<option value="0">Select Category</option>').trigger('change');
                            for (i in res) {
                                $('#newItemCategory').append('<option id="newItemCat' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                            }
                        } else {
                            $('#newItemCategory').append('<option value="0">--No Categories Set--</option>');
                        }
                    }
                });
            }
        });
        $('#captureItem').click(function () {
            var itemCat = parseInt($('#newItemCategory').val());
            var itemName = $('#itemname').val();
            var itemCode = $('#itemcode').val();
            var itemForm = parseInt($('#newItemForm').val());
            var itemType = parseInt($('#newItemType').val());
            if (itemCat > 0 && itemName !== '' && itemCode !== '' && itemForm > 0 && itemType > 0) {
                $('#enteredItemsBody').append(
                        '<tr id="row' + itemCode + '">' +
                        '<td>' + itemName + '</td>' +
                        '<td>' + itemCode + '</td>' +
                        '<td>' + $('#newItemCat' + itemCat).data('name') + '</td>' +
                        '<td>' + $('#form' + itemForm).data('name') + '</td>' +
                        '<td>' + $('#type' + itemType).data('name') + '</td>' +
                        '<td class="center">' +
                        '<span class="badge badge-danger icon-custom" onclick="remove(\'' + itemCode + '\')">' +
                        '<i class="fa fa-trash-o"></i></span></td></tr>'
                        );
                document.getElementById("entryform").reset();
                $('#itemname').css('border', '2px solid #6d0a70');
                $('#itemcode').css('border', '2px solid #6d0a70');
                $('#newItemForm').css('border', '2px solid #6d0a70');
                $('#newItemType').css('border', '2px solid #6d0a70');
                $('#newItemCategory').css('border', '2px solid #6d0a70');
                var data = {
                    name: itemName,
                    code: itemCode,
                    cat: itemCat,
                    form: itemForm,
                    type: itemType
                };
                itemList.add(itemCode);
                itemObjectList.push(data);
            } else {
                if (!(itemType > 0)) {
                    $('#newItemType').focus();
                    $('#newItemType').css('border', '2px solid #f50808c4');
                }
                if (!(itemForm > 0)) {
                    $('#newItemForm').focus();
                    $('#newItemForm').css('border', '2px solid #f50808c4');
                }
                if (itemCode === '') {
                    $('#itemcode').focus();
                    $('#itemcode').css('border', '2px solid #f50808c4');
                }
                if (itemName === '') {
                    $('#itemname').focus();
                    $('#itemname').css('border', '2px solid #f50808c4');
                }
                if (!(itemCat > 0) || itemCat === 0) {
                    $('#newItemCategory').focus();
                    $('#newItemCategory').css('border', '2px solid #f50808c4');
                }
            }
        });
        $('#saveItems').click(function () {
            if (itemList.size > 0) {
                var data = {
                    ids: JSON.stringify(Array.from(itemList)),
                    items: JSON.stringify(itemObjectList)
                };
                $.ajax({
                    type: 'POST',
                    data: data,
                    url: 'store/savenewitems.htm',
                    success: function (res) {
                        if (res === 'Saved') {
                            $('#enteredItemsBody').html('');
                            itemList = new Set();
                            itemObjectList = [];
                        }
                    }
                });
            }
        });
    });
    function remove(code) {
        $('#row' + code).remove();
        itemList.delete(code);
    }

    function filterItemList() {
        $.confirm({
            title: 'Filter Item List!',
            content: '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label for="itemClassificationSelect">Select Classification</label>' +
                    '<select class="form-control" id="itemClassificationSelect">' +
                    '<option value="0">All Classifications</option>' +
                    '<c:forEach items="${classifications}" var="classification">' +
                    '<option id="class${classification.id}" data-name="${classification.name}" value="${classification.id}">${classification.name}</option>' +
                    '</c:forEach></select></div>' +
                    '<div class="form-group" id="catGroup">' +
                    '<label for="filtercategory">Select Category</label>' +
                    '<select class="form-control" id="filtercategory">' +
                    '<option value="0">All Categories</option>' +
                    '</select></div>' +
                    '</form>',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                formSubmit: {
                    text: 'Filter Items',
                    btnClass: 'btn-purple',
                    action: function () {
                        $('#tableItemsContent').html('');
                        var cat = parseInt(this.$content.find('#filtercategory').val());
                        var cla = parseInt(this.$content.find('#itemClassificationSelect').val());
                        if (cla === 0) {
                            $.ajax({
                                type: 'POST',
                                url: 'store/fetchItemList.htm',
                                success: function (data) {
                                    $('#tableItemsContent').html(data);
                                }
                            });
                        } else {
                            if (cat > 0 || cat === 0) {
                                $.ajax({
                                    type: 'POST',
                                    data: {cla: cla, cat: cat},
                                    url: 'store/fetchFilteredItemList.htm',
                                    success: function (data) {
                                        $('#tableItemsContent').html(data);
                                    }
                                });
                            }
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
                var catgroup = this.$content.find('#catGroup');
                var cat = this.$content.find('#filtercategory');
                var cla = this.$content.find('#itemClassificationSelect');
                catgroup.hide();
                cla.change(function () {
                    var classification = parseInt(cla.val());
                    if (!(classification === 0)) {
                        catgroup.show();
                        $.ajax({
                            type: 'POST',
                            data: {classification: classification},
                            url: 'store/fetchClassificationCategories_json.htm',
                            success: function (data) {
                                var res = JSON.parse(data);
                                if (res !== '' && res.length > 0) {
                                    cat.html('<option value="0">All Categories</option>');
                                    for (i in res) {
                                        cat.append('<option id="cat' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                    }
                                } else {
                                    cat.html('<option value="-0">--No Categories Set--</option>');
                                }
                            }
                        });
                    } else {
                        catgroup.hide();
                    }
                });
            }
        });
    }

    function editItem(id, itemName, itemCode, formId, typeId, catId, classId) {
        $.confirm({
            title: '<h3 class="itemTitle">Edit Item</h3>',
            content: '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Item Name</label>' +
                    '<input type="text" id="name" value="' + itemName + '" placeholder="Item Name" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<label for="pack">Item Code</label>' +
                    '<input type="text" id="code" value="' + itemCode + '" placeholder="Item Code" class="form-control"/></div>' +
                    '<div class="form-group">' +
                    '<label for="editForm">Item Form</label>' +
                    '<select class="form-control" id="editForm">' +
                    '<c:forEach items="${forms}" var="form">' +
                    '<option id="form${form.id}" data-name="${form.name}" value="${form.id}">${form.name}</option>' +
                    '</c:forEach></select></div>' +
                    '<div class="form-group">' +
                    '<label for="editType">Administration Type</label>' +
                    '<select class="form-control" id="editType">' +
                    '<c:forEach items="${types}" var="type">' +
                    '<option value="${type.id}">${type.name}</option>' +
                    '</c:forEach></select></div>' +
                    '<label for="itemClassificationSelect">Classification</label>' +
                    '<select class="form-control" id="editClassification">' +
                    '<c:forEach items="${classifications}" var="classification">' +
                    '<option value="${classification.id}">${classification.name}</option>' +
                    '</c:forEach></select></div>' +
                    '<div class="form-group">' +
                    '<label for="editCategory">Category</label>' +
                    '<select class="form-control" id="editCategory"></select></div>' +
                    '</div>',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                formSubmit: {
                    text: 'Update Item',
                    btnClass: 'btn-purple',
                    action: function () {
                        var name = this.$content.find('#name');
                        var code = this.$content.find('#code');
                        var editForm = this.$content.find('#editForm');
                        var editType = this.$content.find('#editType');
                        var editCategory = this.$content.find('#editCategory');
                        var editClassification = this.$content.find('#editClassification');
                        var curForm = this.$content.find('#form' + id);
                        if (name.val() !== '' && code.val() !== '' && editForm.val() !== '' && editType.val() !== '' && parseInt(editCategory.val()) !== 0) {
                            var data = {
                                id: id,
                                name: name.val(),
                                code: code.val(),
                                form: parseInt(editForm.val()),
                                type: parseInt(editType.val()),
                                cat: parseInt(editCategory.val())
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'store/updateItemDetails.htm',
                                success: function (res) {
                                    if (res === 'updated') {
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Details Updated.',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'mid-center'
                                        });
                                        $('#tdname' + id).html(data.name);
                                        $('#tdcode' + id).html(data.code);
                                        $('#tdform' + id).html(curForm.data('name'));
                                        $('#tdmanage' + id).html(
                                                '<a href="#!" data-trigger="focus" data-toggle="popover" data-id="' + id + '" data-container="body" data-placement="right" data-html="true" data-original-title="' + data.name + '">' +
                                                '<i class="fa fa-fw fa-lg fa-dedent"></i></a>&nbsp;|&nbsp;' +
                                                '<a href="#!" onclick="editItem(' + id + ', \'' + data.name + '\', \'' + data.code + '\', ' + data.form + ', ' + data.type + ', ' + data.cat + ', ' + parseInt(editClassification.val()) + ')">' +
                                                '<i class="fa fa-fw fa-lg fa-edit"></i></a>'
                                                );
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
                            $.toast({
                                heading: 'Error',
                                text: 'Missing Fields,',
                                icon: 'warning',
                                hideAfter: 2000,
                                position: 'mid-center'
                            });
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
                var editForm = this.$content.find('#editForm');
                var editType = this.$content.find('#editType');
                var editCategory = this.$content.find('#editCategory');
                var editClassification = this.$content.find('#editClassification');
                editForm.val(formId);
                editType.val(typeId);
                editClassification.val(classId);
                var classification = parseInt(editClassification.val());
                if (!(classification === 0)) {
                    $.ajax({
                        type: 'POST',
                        data: {classification: classification},
                        url: 'store/fetchClassificationCategories_json.htm',
                        success: function (data) {
                            var res = JSON.parse(data);
                            if (res !== '' && res.length > 0) {
                                for (i in res) {
                                    editCategory.append('<option value="' + res[i].id + '">' + res[i].name + '</option>');
                                }
                            } else {
                                editCategory.html('<option value="0">--No Categories Set--</option>');
                            }
                            editCategory.val(catId);
                        }
                    });
                }
                editClassification.change(function () {
                    editCategory.html('');
                    classification = parseInt(editClassification.val());
                    if (!(classification === 0)) {
                        $.ajax({
                            type: 'POST',
                            data: {classification: classification},
                            url: 'store/fetchClassificationCategories_json.htm',
                            success: function (data) {
                                var res = JSON.parse(data);
                                if (res !== '' && res.length > 0) {
                                    editCategory.html('<option value="0">Select Category</option>');
                                    for (i in res) {
                                        editCategory.append('<option value="' + res[i].id + '">' + res[i].name + '</option>');
                                    }
                                } else {
                                    editCategory.html('<option value="0">--No Categories Set--</option>');
                                }
                                editCategory.val(0);
                            }
                        });
                    }
                });
            }
        });
    }
</script>
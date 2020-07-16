<%-- 
    Document   : itemForm
    Created on : Jul 19, 2018, 2:41:13 PM
    Author     : IICS
--%>

<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .focus {
        border-color:red;
    }
</style>
<style>
    #overlaydelete {
        background: rgba(0,0,0,0.5);
        color: #FFFFFF;
        position: fixed;
        height: 100%;
        width: 100%;
        z-index: 5000;
        top: 0;
        left: 0;
        float: left;
        text-align: center;
        padding-top: 25%;
    }
</style>
<div class="row">

    <div class="col-md-4"></div>
    <div class="col-md-8">
        <div class="form-group row">
            <label class="control-label col-md-4">Added Items In Category:</label>
            <div class="col-md-6">
                <button type="button" class="btn btn-primary" onclick="">
                    <i class="fa fa-dedent">
                        <input type="hidden" id="SuppliescategoryAddedItemsValues">
                        <span class="badge badge-light" id="SuppliescategoryAddedItemshtml">0</span>
                        Item(s)
                    </i>
                </button>
            </div>
        </div>
    </div>

</div>
<div class="row" >
    <div class="col-md-4">
        <div class="row" style="overflow: auto; height: 350px;" id="SuppscrollingItemDiv">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Enter Item Details</h4>
                    <div class="tile-body">

                        <div class="form-group">
                            <label class="control-label">Item Classification</label>
                            <input class="form-control" disabled="true" type="text" value="${classificationname}" >
                        </div>
                        <div class="form-group">
                            <label class="control-label">Item Category</label>
                            <input class="form-control" disabled="true"type="text" value="${categoryname}">
                        </div>
                        <form id="entrySuppCategoryItemform">
                            <div class="form-group">
                                <label class="control-label">Item Name</label>
                                <input class=" form-control" id="Suppliescategoryitemname" oninput="checksuppliesForExistingCategoryItem(this.value);" type="text" placeholder="Item Name">
                            </div>
                            <input type="hidden" id="SuppliesExistingCatItemid">
                            <p  id="SuppliesalreadyExistingParagraph" style="color: red; display: none;">Item Already Exists &nbsp;<i class="fa fa-fw fa-dedent icon-custom"  onclick="viewExistingSuppliesItem();"></i></p>
                            <div class="form-group">
                                <label class="control-label">Specification</label>
                                <input class=" form-control" id="Suppliescategoryitemspecification" type="text" placeholder="Item Specification">
                            </div>

                            <div class="form-group">
                                <label>Select Level here</label>
                                <select  id="Suppliescategoryuselevels" class=" form-control" required>
                                    <c:forEach items="${levelsFound}" var="c">
                                        <option id="SupOption${c.facilitylevelid}" data-name="${c.shortname}" value="${c.facilitylevelid}">${c.shortname}</option>   
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Select Class here</label>
                                <select id="Suppliescategoryuseclassform" class=" form-control" required>
                                    <option value="Vital">Vital(V)</option>
                                    <option value="Essential">Essential(E)</option>
                                    <option value="Necessary">Necessary(N)</option>
                                </select>
                            </div>  
                            <div class="form-group row">
                                <label class="control-label col-md-4">Is Special</label>
                                <div class="col-md-8">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" style="font-weight: normal !important;"  type="radio" name="inlineSuppliesRadioSpecial" id="inlinesupRadioisspecial1" value="true">
                                        <label class="form-check-label">Yes</label>
                                    </div>

                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" checked="true"  type="radio" name="inlineSuppliesRadioSpecial" id="inlinesupRadioisspecial2" value="false">
                                        <label class="form-check-label">No</label>
                                    </div>
                                </div>
                            </div> 
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="SuppliesdisablingTheItemAdd" onclick="addNewSuppliesCategorysItem();" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Add Item
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="overlaydelete" style="display: none;">
        <img src="static/img2/loader.gif" alt="Loading" /><br/>
        Please Wait...
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
                                <th>Specification</th>
                                <th>Level</th>
                                <th>Class</th>
                                <th>Is Special</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredSuppliesCategoryItemsBody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var number = 0;
    function addNewSuppliesCategorysItem() {
        var Itemcategoryid = $('#SuppliesItemclassificationcategoryid').val();
        var itemname = $('#Suppliescategoryitemname').val();
        var useclass = $('#Suppliescategoryuseclassform').val();
        var level = $('#Suppliescategoryuselevels').val();
        var specification = $('#Suppliescategoryitemspecification').val();
        var isspecial = $('input[name=inlineSuppliesRadioSpecial]:checked').val();
        if (!itemname) {
            $.alert('provide a valid Item Details');
            return false;
        }
        document.getElementById('SuppliesdisablingTheItemAdd').disabled = true;
        number++;
        $.ajax({
            type: 'POST',
            data: {itemname: itemname, Itemcategoryid: Itemcategoryid, useclass: useclass, level: level, specification: specification, isspecial: isspecial, type: 'item'},
            url: "essentialmedicinesandsupplieslist/savenewsuppliesclassification.htm",
            success: function (data, textStatus, jqXHR) {
                var ispc = "No";
                if (isspecial) {
                    ispc = "Yes";
                } else {
                    ispc = "No";
                }
                var levelname = $('#SupOption' + level).data('name');
                document.getElementById('entrySuppCategoryItemform').reset();
                $('#enteredSuppliesCategoryItemsBody').append('<tr id="SuppCatItm' + data + '"><td id="SupITM' + data + '">' + itemname + '</td>' +
                        '<td id="SupSpecification' + data + '">' + specification + '</td>' +
                        '<td id="Suplevelname' + data + '">' + levelname + '</td>' +
                        '<td id="Supuseclass' + data + '">' + useclass.charAt(0) + '</td>' +
                        '<td id="SupIsSpecial' + data + '">' + ispc + '</td>' +
                        '<td align="center"> <span onclick="editSupCategoryItem(' + data + ');" title="Edit Of This Item."  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>| <span  title="Delete Of This Item." onclick="deleteSupcategoryItem(' + data + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

                if (number === 10) {
                    number = 0;
                    var added = $('#SuppliescategoryAddedItemsValues').val();
                    if (added !== '') {
                        var newadded = parseInt(added) + 10;
                        document.getElementById('SuppliescategoryAddedItemsValues').value = newadded;
                        document.getElementById('SuppliescategoryAddedItemshtml').innerHTML = newadded;
                        document.getElementById('enteredSuppliesCategoryItemsBody').innerHTML = '';
                    } else {
                        document.getElementById('SuppliescategoryAddedItemsValues').value = 10;
                        document.getElementById('SuppliescategoryAddedItemshtml').innerHTML = 10;
                        document.getElementById('enteredSuppliesCategoryItemsBody').innerHTML = '';
                    }

                }
                $('#SuppscrollingItemDiv').scrollTop(0);
                document.getElementById('Suppliescategoryitemname').focus();
                document.getElementById('SuppliesdisablingTheItemAdd').disabled = false;
            }
        });
    }
    function editSupCategoryItem(itemid) {
        $.ajax({
            type: 'GET',
            data: {itemid: itemid},
            url: "essentialmedicinesandsupplieslist/editsuppliesclassificationcategoryitem.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'UpDate Item!',
                    content: '' + data,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Update',
                            btnClass: 'btn-purple',
                            action: function () {
                                var itemname = $('#updateSuppliesItemName').val();
                                var specification = $('#updateSuppliesItemspecification').val();
                                var useclass = $('#updateSuppliesItemClass').val();
                                var level = $('#updateSuppliesItemlevel').val();
                                var issundspecial = $('input[name=updateSuppliesInlineRadioSpecial]:checked').val();
                                if (!itemname || !specification) {
                                    $.alert('provide a valid Item Details');
                                    return false;
                                }
                                $.ajax({
                                    type: 'POST',
                                    url: "essentialmedicinesandsupplieslist/updatesuppliescategoryitem.htm",
                                    data: {itemname: itemname, specification: specification, useclass: useclass, level: level, itemid: itemid, isspecial: issundspecial},
                                    success: function (data, textStatus, jqXHR) {
                                        if (data === 'success') {
                                            var levlname = $('#UpdateSuppOption' + level).data('name');
                                            document.getElementById('SupITM' + itemid).innerHTML = itemname;
                                            document.getElementById('SupSpecification' + itemid).innerHTML = specification;
                                            document.getElementById('Suplevelname' + itemid).innerHTML = levlname;
                                            document.getElementById('Supuseclass' + itemid).innerHTML = useclass.charAt(0);
                                            if (issundspecial) {
                                                document.getElementById('SupIsSpecial' + itemid).innerHTML = "Yes";
                                            } else {
                                                document.getElementById('SupIsSpecial' + itemid).innerHTML = "No";
                                            }

                                        }
                                    }
                                });
                            }
                        },
                        close: function () {

                        }
                    }
                });
            }
        });
    }
    function deleteSupcategoryItem(itemid) {
        $.ajax({
            type: 'POST',
            url: "essentialmedicinesandsupplieslist/deletecategoryitem.htm",
            data: {itemid: itemid},
            success: function (data, textStatus, jqXHR) {
                if (data === 'deleted') {
                    number = number - 1;
                    $('#SuppCatItm' + itemid).remove();
                } else {
                    $.confirm({
                        title: 'Removing Item!',
                        content: 'Failed To Remove This Item',
                        type: 'purple',
                        typeAnimated: true,
                        buttons: {close: function () {

                            }
                        }
                    });
                }
            }
        });
    }
    function checksuppliesForExistingCategoryItem(value) {
        $.ajax({
            type: 'POST',
            data: {value: value},
            url: "essentialmedicinesandsupplieslist/checkexistingcategoryitemname.htm",
            success: function (data, textStatus, jqXHR) {
                if (data === 'success') {
                    $('#Suppliescategoryitemname').removeClass("focus");
                    document.getElementById('SuppliesalreadyExistingParagraph').style.display = 'none';
                } else {
                    $('#Suppliescategoryitemname').addClass("focus");
                    document.getElementById('SuppliesExistingCatItemid').value = parseInt(data);
                    document.getElementById('SuppliesalreadyExistingParagraph').style.display = 'block';
                }
            }
        });
    }
    function viewExistingSuppliesItem() {
        var itemid = $('#SuppliesExistingCatItemid').val();
        $.confirm({
            title: 'Item!',
            content: 'Under Implementation',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                close: function () {

                }
            }
        });
    }
</script>



<%-- 
    Document   : itemForm
    Created on : Jul 4, 2018, 5:06:32 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
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
                        <input type="hidden" id="categoryAddedItemsValues">
                        <span class="badge badge-light" id="categoryAddedItemshtml">0</span>
                        Item(s)
                    </i>
                </button>
            </div>
        </div>
    </div>

</div>
<div class="row" >
    <div class="col-md-4">
        <div class="row" style="overflow: auto; height: 350px;" id="scrollingItemDiv">
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
                        <form id="entryCategoryItemform">
                            <div class="form-group">
                                <label class="control-label">Item Name</label>
                                <input class=" form-control" id="categoryitemname" oninput="checkForExistingCategoryItem(this.value);" type="text" placeholder="Item Name">
                            </div>
                            <input type="hidden" id="ExistingCatItemid">
                            <p  id="alreadyExistingParagraph" style="color: red; display: none;">Item Already Exists &nbsp;<i class="fa fa-fw fa-dedent icon-custom"  onclick="viewExistingCategoryItem();"></i></p>
                            <div class="form-group">
                                <label class="control-label">Dosage Form</label>
                                <input class=" form-control" id="categoryitemform" type="text" placeholder="Item Form">
                            </div>
                            <div class="form-group">
                                <label>Item Strength</label>
                                <input type="text" placeholder="Item Strength" id="categoryitemstrength" class=" form-control" required />
                            </div>
                            <div class="form-group">
                                <label>Select Level here</label>
                                <select  id="categoryuselevels" class=" form-control" required>
                                    <c:forEach items="${levelsFound}" var="c">
                                        <option id="Option${c.facilitylevelid}" data-name="${c.shortname}" value="${c.facilitylevelid}">${c.shortname}</option>   
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Select Class here</label>
                                <select id="categoryuseclassform" class=" form-control" required>
                                    <option value="Vital">Vital(V)</option>
                                    <option value="Essential">Essential(E)</option>
                                    <option value="Necessary">Necessary(N)</option>
                                </select>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-md-4">Is Special</label>
                                <div class="col-md-8">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" style="font-weight: normal !important;"  type="radio" name="inlineRadioSpecial" id="inlineRadioisspecial1" value="Yes">
                                        <label class="form-check-label">Yes</label>
                                    </div>

                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" checked="true"  type="radio" name="inlineRadioSpecial" id="inlineRadioisspecial2" value="No">
                                        <label class="form-check-label">No</label>
                                    </div>
                                </div>
                            </div>       
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="disablingTheItemAdd" onclick="addNewCategorysItem();" type="button">
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
                                <th>Item Form</th>
                                <th>Item Strength</th>
                                <th>Level</th>
                                <th>Class</th>
                                <th>Is Special</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredCategoryItemsBody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var cnt = 0;
    function addNewCategorysItem() {
        var Itemcategoryid = $('#Itemclassificationcategoryid').val();
        var itemname = $('#categoryitemname').val();
        var dosageform = $('#categoryitemform').val();
        var useclass = $('#categoryuseclassform').val();
        var level = $('#categoryuselevels').val();
        var strength = $('#categoryitemstrength').val();
        var isspecial = $('input[name=inlineRadioSpecial]:checked').val();
        if (!itemname) {
            $.alert('provide a valid Item Details');
            return false;
        }
        document.getElementById('disablingTheItemAdd').disabled = true;
        cnt++;
        $.ajax({
            type: 'POST',
            data: {itemname: itemname, Itemcategoryid: Itemcategoryid, dosageform: dosageform, useclass: useclass, level: level, strength: strength, isspecial: isspecial, type: 'item'},
            url: "essentialmedicinesandsupplieslist/savenewitemclassification.htm",
            success: function (data, textStatus, jqXHR) {
                var levelname = $('#Option' + level).data('name');
                document.getElementById('entryCategoryItemform').reset();
                $('#enteredCategoryItemsBody').append('<tr id="CatItm' + data + '"><td id="ITM' + data + '">' + itemname + '</td>' +
                        '<td id="dosage' + data + '">' + dosageform + '</td>' +
                        '<td id="strength' + data + '">' + strength + '</td>' +
                        '<td id="levelname' + data + '">' + levelname + '</td>' +
                        '<td id="useclass' + data + '">' + useclass.charAt(0) + '</td>' +
                        '<td id="issspecialUpdte' + data + '">' + isspecial + '</td>' +
                        '<td align="center"> <span onclick="editCategoryItem(' + data + ');" title="Edit Of This Item."  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>| <span  title="Delete Of This Item." onclick="deletecategoryItem(' + data + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');

                if (cnt === 10) {
                    cnt = 0;
                    var added = $('#categoryAddedItemsValues').val();
                    if (added !== '') {
                        var newadded = parseInt(added) + 10;
                        document.getElementById('categoryAddedItemsValues').value = newadded;
                        document.getElementById('categoryAddedItemshtml').innerHTML = newadded;
                        document.getElementById('enteredCategoryItemsBody').innerHTML = '';
                    } else {
                        document.getElementById('categoryAddedItemsValues').value = 10;
                        document.getElementById('categoryAddedItemshtml').innerHTML = 10;
                        document.getElementById('enteredCategoryItemsBody').innerHTML = '';
                    }

                }
                $('#scrollingItemDiv').scrollTop(0);
                document.getElementById('categoryitemname').focus();
                document.getElementById('disablingTheItemAdd').disabled = false;
            }
        });
    }
    function deletecategoryItem(itemid) {
        $.ajax({
            type: 'POST',
            url: "essentialmedicinesandsupplieslist/deletecategoryitem.htm",
            data: {itemid: itemid},
            success: function (data, textStatus, jqXHR) {
                if (data === 'deleted') {
                    cnt = cnt - 1;
                    $('#CatItm' + itemid).remove();
                } else {
                    $.confirm({
                        title: 'Removing Item!',
                        content: 'Failed To Remove This Item',
                        type: 'purple',
                        typeAnimated: true,
                        buttons: {
                            close: function () {

                            }
                        }
                    });
                }
            }
        });
    }
    function editCategoryItem(itemid) {
        $.ajax({
            type: 'GET',
            data: {itemid: itemid},
            url: "essentialmedicinesandsupplieslist/editclassificationcategoryitem.htm",
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
                                var itemname = $('#updateItemName').val();
                                var dosageform = $('#updateItemForm').val();
                                var useclass = $('#updateItemClass').val();
                                var level = $('#updateItemlevel').val();
                                var strength = $('#updateItemstrength').val();
                                var isspecial = $('input[name=updateInlineRadioSpecial]:checked').val();
                                if (!itemname || !dosageform || !useclass || !strength) {
                                    $.alert('provide a valid Item Details');
                                    return false;
                                }
                                $.ajax({
                                    type: 'POST',
                                    url: "essentialmedicinesandsupplieslist/updatecategoryitem.htm",
                                    data: {itemname: itemname, dosageform: dosageform, useclass: useclass, level: level, strength: strength, isspecial: isspecial, itemid: itemid},
                                    success: function (data, textStatus, jqXHR) {
                                        if (data === 'success') {
                                            var levlname = $('#UpdateOption' + level).data('name');
                                            document.getElementById('ITM' + itemid).innerHTML = itemname;
                                            document.getElementById('dosage' + itemid).innerHTML = dosageform;
                                            document.getElementById('strength' + itemid).innerHTML = strength;
                                            document.getElementById('levelname' + itemid).innerHTML = levlname;
                                            document.getElementById('useclass' + itemid).innerHTML = useclass.charAt(0);
                                            document.getElementById('issspecialUpdte' + itemid).innerHTML = isspecial;
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
    function checkForExistingCategoryItem(value) {
        $.ajax({
            type: 'POST',
            data: {value: value},
            url: "essentialmedicinesandsupplieslist/checkexistingcategoryitemname.htm",
            success: function (data, textStatus, jqXHR) {
                if (data === 'success') {
                    $('#categoryitemname').removeClass("focus");
                    document.getElementById('alreadyExistingParagraph').style.display = 'none';
                } else {
                    $('#categoryitemname').addClass("focus");
                    document.getElementById('ExistingCatItemid').value = parseInt(data);
                    document.getElementById('alreadyExistingParagraph').style.display = 'block';
                }
            }
        });
    }
    function viewExistingCategoryItem() {
        var itemid = $('#ExistingCatItemid').val();
        $.confirm({
            title: 'Item!',
            content: '',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                close: function () {

                }
            }
        });
    }
</script>



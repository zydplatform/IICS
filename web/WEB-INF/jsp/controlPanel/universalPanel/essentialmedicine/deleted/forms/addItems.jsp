<%-- 
    Document   : addItems
    Created on : Aug 23, 2018, 2:29:49 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row" >
    <div class="col-md-4">
        <div class="row" style="overflow: auto; height: 350px;" id="scrollingItemDiv">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Enter Item Details</h4>
                    <div class="tile-body">

                        <form id="entryCategorydeletedItemform">
                            <div class="form-group">
                                <label class="control-label">Item Name</label>
                                <input class=" form-control" id="deletedcategoryitemname" oninput="checkforexistingdeleteditem(this.value);" type="text" placeholder="Item Name">
                                <p  id="alreadydeletedExistingParagraph" style="color: red; display: none;">Item Already Exists In Essential List &nbsp;<i class="fa fa-fw fa-dedent icon-custom"  onclick=""></i></p>
                            </div>

                            <div class="form-group">
                                <label class="control-label">Dosage Form</label>
                                <input class=" form-control" id="deletedcategoryitemform" type="text" placeholder="Item Form">
                            </div>
                            <div class="form-group">
                                <label>Item Strength</label>
                                <input type="text" placeholder="Item Strength" id="deletedcategoryitemstrength" class=" form-control" required />
                            </div>

                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" id="disablingdeletedTheItemAdd" onclick="addNewdeletedCategorysItem(${itemcategoryid});" type="button">
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
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredDeletedCategoryItemsBody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function addNewdeletedCategorysItem(itemcategoryid) {
        var name = $('#deletedcategoryitemname').val();
        var itemform = $('#deletedcategoryitemform').val();
        var strength = $('#deletedcategoryitemstrength').val();
        document.getElementById('disablingdeletedTheItemAdd').disabled = true;
        $.ajax({
            type: 'POST',
            data: {name: name, itemform: itemform, strength: strength, itemcategoryid: itemcategoryid},
            url: "essentialmedicinesandsupplieslist/savenewessentialistdeleteditems.htm",
            success: function (data, textStatus, jqXHR) {

                document.getElementById('disablingdeletedTheItemAdd').disabled = false;

                $('#enteredDeletedCategoryItemsBody').append('<tr id="deletedItemId' + data + '"><td>' + name + '</td>' +
                        '<td>' + itemform + '</td>' +
                        '<td>' + strength + '</td>' +
                        '<td align="center"><span  title="Delete Of This Item." onclick="deletedeletedcategoryItem(' + data + ');" class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');
                document.getElementById('entryCategorydeletedItemform').reset();

            }

        });
    }
//    function checkforexistingdeleteditem(item) {
//        $.ajax({
//            type: 'POST',
//            data: {item: item},
//            url: "essentialmedicinesandsupplieslist/checkforexistingdeleteditem.htm",
//            success: function (data, textStatus, jqXHR) {
//                if (data === "existing") {
//                    document.getElementById('alreadydeletedExistingParagraph').style.display = 'block';
//                } else {
//                    document.getElementById('alreadydeletedExistingParagraph').style.display = 'none';
//                }
//            }
//        });
//    }
    function deletedeletedcategoryItem(itemid) {
        $.ajax({
            type: 'POST',
            url: "essentialmedicinesandsupplieslist/deletedEssentialDeletedMedicinesListItems.htm",
            data: {itemid: itemid},
            success: function (data, textStatus, jqXHR) {
                if (data === 'deleted') {
                    $('#deletedItemId'+itemid).remove();
                } else {
                    $.confirm({
                        title: 'Encountered an error!',
                        content: 'Something went Wrong While Trying To Delete Item',
                        type: 'red',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Try again',
                                btnClass: 'btn-red',
                                action: function () {
                                    
                                }
                            },
                            close: function () {

                            }
                        }
                    });
                }
            }
        });
    }
</script>
<%-- 
    Document   : addMoreItems
    Created on : May 23, 2018, 8:23:47 AM
    Author     : IICS
--%>
<%@include file="../../../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<input id="pausedfacilityunitorderid" value="${facilityorderid}" type="hidden">
<input id="pausedfacilityunitordernum" value="${facilityorderno}" type="hidden">

<input id="addmorefacilitysuppliername" value="${facilitysuppliername}" type="hidden">
<input id="addmoreinternalordersitemscount" value="${internalordersitemscount}" type="hidden">
<input id="addmoredateneeded" value="${dateneeded}" type="hidden">
<input id="addmoredateprepared" value="${dateprepared}" type="hidden">
<input id="addmorepersonname" value="${personname}" type="hidden">
<input id="addmoreorderstage" value="${orderstage}" type="hidden">
<input id="addmorecriteria" value="${criteria}" type="hidden">
<style>
    .cl{color: #465cba;}
</style>
<div>
    <fieldset>
        <legend>An Internal Order</legend>
        <div class="container" id="firstdiv1">
            <div class="row">
                <table style="margin:  0px  10px  10px  80px;" width="90%" cellspacing="0px" cellpadding="10px" border="0" align="center">
                    <tbody><tr class="odd">
                            <td align="left"><span class="style101">Order Number:</span></td>
                            <td align="left"><b class="cl">${facilityorderno}</b></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Date Needed:</span></td>
                            <td align="left"><b class="cl">${dateneeded}</b></td>
                        </tr>
                        <tr class="even">
                            <td align="left"><span class="style101">Ref No.:</span></td>
                            <td align="left"><b class="cl"> 0540323</b></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Date Created:</span></td>
                            <td align="left"><b class="cl">${dateprepared}</b></td>
                        </tr>
                        <tr class="odd">
                            <td align="left"></td>
                            <td>
                                <b><span class="style101"></span></b>
                            </td>
                            <td align="left">&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Created By:</span></td>
                            <td align="left"><b class="cl">${personname}</b></td>
                        </tr>
                        <tr class="even">
                            <td align="left"><span class="style101">Order Origin:</span></td>
                            <td align="left"><b class="cl">${facilityunitname}</b></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Order stage:</span></td>
                            <td align="left"><b class="cl">${orderstage}</b></td>
                        </tr>
                        <tr class="odd">
                            <td align="left"><span class="style101">Order Destination:</span></td>
                            <td align="left"><b class="cl">${facilitysuppliername}</b></td>
                            <td align="left">&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Criteria:</span></td>
                            <td align="left">
                                <b class="cl" <c:if test="${criteria==true}">style="color: red;"</c:if>>
                                    <c:if test="${criteria==true}">Emergency Order</c:if>
                                    <c:if test="${criteria==false}">Normal Order</c:if>
                                    </b>
                                </td>
                            </tr>
                            <tr class="even">
                            </tr>
                        </tbody></table>

                </div>
                <div class="row">
                    <div class="col-md-4">

                    </div>
                    <div class="col-md-4">
                        <h5 style="color: #6e0610;">Total Items In Cart:<span class="badge badge-secondary"><strong>${internalordersitemscount} &nbsp;Item(s)</strong></span></h5>
                </div>
                <div class="col-md-4">

                </div>
            </div>
        </div>
    </fieldset>
</div>
<br>
<fieldset>
    <legend>Add Items</legend>
    <div class="row">
        <div class="col-md-4">
            <div class="tile" id="searchTile">
                <div class="tile-body">
                    <div id="search-form_31">
                        <input id="inputitemSearch1" type="text" oninput="inputsearchItem1(this.value,'${supplies}',${facilityorderid})" onfocus="searchpanesize();" placeholder="Search Item" class="search_3 dropbtn"/>
                    </div><br>
                    <div id="inputsearchResultspaused" class="scrollbar">

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
                                    <th>No</th>
                                    <th>Item</th>
                                    <th>Quantity</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody id="pausedsenteredItemsBody">

                            </tbody>
                        </table>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" id="pausedPauseOrderid" onclick="savepausedorsubmittedorderItems('pause',this.id);"class="btn btn-primary btn-block">Pause</button>
                            </div>
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" id="pausedSubmitOrderid" onclick="savepausedorsubmittedorderItems('submit',this.id);"class="btn btn-primary btn-block">Save</button>
                            </div>
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" onclick="canceladdpauseditemsdialog();" class="btn btn-secondary btn-block">Cancel</button>
                            </div>   
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<div class="modal fade" id="itemdetorderitemquatity" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 100%;">
            <div class="modal-header">
                <h5 class="modal-title" id="title"> Item</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <form class="form-horizontal">
                                    <div class="form-group row">
                                        <label class="control-label col-md-3">Item</label>
                                        <div class="col-md-8">
                                            <input class="form-control" type="text" id="pausitemgenericname" disabled="true">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="control-label col-md-3">Quantity</label>
                                        <div class="col-md-8">
                                            <input class="form-control" type="text" id="pausitemorderquantity">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" align="right">
                                <button class="btn btn-primary">
                                    <i class="fa fa-check-circle"></i>
                                    Save
                                </button>&nbsp;<a class="btn btn-secondary" href="#" data-dismiss="modal" ><i class="fa fa-fw fa-lg fa-times-circle"></i>Close</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function searchpanesize() {
        var div1 = $('.supplierCatalogDialog > div').height();
        var divHead1 = $('.supplierCatalogDialog > div > #head').height();
        var searchForm1 = $('#search-form_31').height();
        var details1 = $('#firstdiv1').height();
        $('#inputsearchResultspaused').height(parseInt(parseInt(div1) - parseInt(divHead1)) - parseInt(div1 * 0.14) - parseInt(searchForm1) - parseInt(details1));
        $(window).resize(function () {
            div1 = $('.supplierCatalogDialog > div').height();
            divHead1 = $('.supplierCatalogDialog > div > #head').height();
            searchForm1 = $('#search-form_31').height();
            details1 = $('#firstdiv1').height();
            $('#inputsearchResultspaused').height(parseInt(parseInt(div1) - parseInt(divHead1)) - parseInt(div1 * 0.14) - parseInt(searchForm1) - parseInt(details1));
        });
    }
    function canceladdpauseditemsdialog() {
        var facilityorderid = $('#pausedfacilityunitorderid').val();
        var facilityorderno = $('#pausedfacilityunitordernum').val();
        var facilitysuppliername = $('#addmorefacilitysuppliername').val();
        var internalordersitemscount = $('#addmoreinternalordersitemscount').val();
        var dateneeded = $('#addmoredateneeded').val();
        var dateprepared = $('#addmoredateprepared').val();
        var personname = $('#addmorepersonname').val();
        var orderstage = $('#addmoreorderstage').val();
        var criteria = $('#addmorecriteria').val();
        ajaxSubmitData('ordersmanagement/pausedfacilityorderitems.htm', 'orderitemsdiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&pgh=3', 'GET');
    }
    function savepausedorsubmittedorderItems(type,id) {
        var facilityunitorderid = $('#pausedfacilityunitorderid').val();
        if (type === 'pause') {
            if (pausedAddedItemsList.length > 0) {
                document.getElementById(id).disabled=true;
                $.ajax({
                    type: 'POST',
                    data: {values: JSON.stringify(pausedAddedItemsList), type: 'pause', facilityunitorderid: facilityunitorderid},
                    url: "ordersmanagement/saveorpausepausedfacilityorderitmz.htm",
                    success: function (data) {
                        $.confirm({
                            title: 'Saved And Paused',
                            content: 'Order Paused Successfully!!',
                            type: 'orange',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'OK',
                                    btnClass: 'btn-orange',
                                    action: function () {
                                        window.location = '#close';
                                        ajaxSubmitData('ordersmanagement/internalordersview.htm', 'createdordersdiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                }
                            }
                        });
                    }
                });
            }
        } else {
            if (pausedAddedItemsList.length > 0) {
                 document.getElementById(id).disabled=true;
                $.ajax({
                    type: 'POST',
                    data: {values: JSON.stringify(pausedAddedItemsList), type: 'submit', facilityunitorderid: facilityunitorderid},
                    url: "ordersmanagement/saveorpausepausedfacilityorderitmz.htm",
                    success: function (data, textStatus, jqXHR) {
                        $.confirm({
                            title: 'Saved And Submitted!',
                            content: 'Order Submitted For Approval !!',
                            type: 'orange',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'OK',
                                    btnClass: 'btn-orange',
                                    action: function () {
                                        window.location = '#close';
                                        ajaxSubmitData('ordersmanagement/internalordersview.htm', 'createdordersdiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                }
                            }
                        });
                    }
                });
            }
        }
    }
    var nm = 0;
    var pausedAddedItems = new Set();
    var pausedAddedItemsList = [];
    function addpausedorderitemquantity(itemname, itemid) {
        nm++;
        $.confirm({
            title: itemname,
            type: 'purple',
            typeAnimated: true,
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Quantity</label>' +
                    '<input type="number" placeholder="Your Quantity" class="itemsqty form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Add',
                    btnClass: 'btn-purple',
                    action: function () {
                        var qty = this.$content.find('.itemsqty').val();
                        if (!qty) {
                            $.alert('provide a valid Quantity');
                            return false;
                        }
                        $('#pausedsenteredItemsBody').append('<tr id="pausedRemv' + itemid + '"><td>' + nm + '</td>' +
                                '<td>' + itemname + '</td>' +
                                '<td>' + qty + '</td>' +
                                '<td align="center"><span class="badge badge-danger icon-custom" onclick="removepausorderitem(' + itemid + ')">' +
                                '<i class="fa fa-close"></i></span></td></tr>');
                        $('#li2' + itemid).remove();
                        pausedAddedItemsList.push({
                            itemid: itemid,
                            qty: qty
                        });
                        pausedAddedItems.add(itemid);
                    }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function inputsearchItem1(searchvalue, supplies, facilityorderid) {
        if (searchvalue !== '') {
            ajaxSubmitData('ordersmanagement/searchitemspausedorderitems.htm', 'inputsearchResultspaused', 'searchValue=' + searchvalue + '&supplies=' + supplies + '&itemsSet=' + JSON.stringify(Array.from(pausedAddedItems)) + '&facilityorderid=' + facilityorderid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    }
    function removepausorderitem(itemid) {
        for (i in pausedAddedItemsList) {
            if (parseInt(pausedAddedItemsList[i].itemid) === parseInt(itemid)) {
                pausedAddedItemsList.splice(i, 1);
                pausedAddedItems.delete(itemid);
                $('#pausedRemv' + itemid).remove();
                break;
            }
        }
    }
</script>
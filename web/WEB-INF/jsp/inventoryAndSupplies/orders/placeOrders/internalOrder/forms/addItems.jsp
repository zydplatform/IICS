<%-- 
    Document   : addItems
    Created on : May 15, 2018, 11:25:55 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../../include.jsp" %>
<style>
    .cl{color: #465cba;}
</style>
<div>
    <fieldset>
        <legend>An Internal Order</legend>
        <div class="container" id="firstdiv">
            <div class="row">
                <input id="orderdateneeded" value="${dateneeded}" type="hidden">
                <input id="ordernumber" value="${ordernumber}" type="hidden">
                <input id="orderdatecreated" value="${datecreated}" type="hidden">
                <input id="orderfacilityunitsupplierid" value="${facilityunitsupplierid}" type="hidden">
                <input id="ordercriteria" value="${criteria}" type="hidden">
                <input id="orderistopdown" value="${istopdown}" type="hidden">

                <table style="margin:  0px  10px  10px  80px;" width="90%" cellspacing="0px" cellpadding="10px" border="0" align="center">
                    <tbody><tr class="odd">
                            <td align="left"><span class="style101">Order Number:</span></td>
                            <td align="left"><b class="cl">${ordernumber}</b></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Date Needed:</span></td>
                            <td align="left"><b class="cl">${dateneeded}</b></td>
                        </tr>
                        <tr class="even">
                            <td align="left"><span class="style101">Ref No.:</span></td>
                            <td align="left"><b class="cl"> 0540323</b></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Date Created:</span></td>
                            <td align="left"><b class="cl">${datecreated}</b></td>
                        </tr>
                        <tr class="odd">
                            <td align="left"></td>
                            <td>
                                <b><span class="style101"></span></b>
                            </td>
                            <td align="left">&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Created By:</span></td>
                            <td align="left"><b class="cl">${firstname} ${lastname}</b></td>
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
                            <td align="left"><b class="cl">${supplierfacilityunitname}</b></td>
                            <td align="left">&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Criteria:</span></td>
                            <td align="left" >
                                <b class="cl" <c:if test="${criteria=='Emergency'}">style="color: red;"</c:if> >
                                    ${criteria} Order
                                </b>
                            </td>
                        </tr>
                        <tr class="even">
                        </tr>
                    </tbody></table>

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
                    <div id="search-form_3">
                        <input id="inputitemSearch" type="text" oninput="inputsearchItem('${supplies}',this.value);" onfocus="inputsearchItem('${supplies}', this.value);" placeholder="Search Item" class="search_3 dropbtn"/>
                    </div><br>
                    <div id="inputOrdersearchResults" class="scrollbar">

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
                                    <th class="right">Quantity</th>
                                    <th class="center">Remove</th>
                                </tr>
                            </thead>
                            <tbody id="inputenteredItemsBody">

                            </tbody>
                        </table>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" id="disablesavepausedorsubmittedorderp"  onclick="savepausedorsubmittedorder('pause',this.id); "class="btn btn-primary btn-block">Pause</button>
                            </div>
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" id="disablesavepausedorsubmittedorders"   onclick="savepausedorsubmittedorder('submit',this.id);"class="btn btn-primary btn-block">Submit For Approval</button>
                            </div>
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" onclick="canceladditemsdialog();" class="btn btn-secondary btn-block">Cancel</button>
                            </div>   
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</fieldset>

<script>
    var orderitems = [];
    var orderitemsSet=new Set();
    var updatedorderitems = [];
    var div = $('.modalDialog > div').height();
    var divHead = $('.modalDialog > div > #head').height();
    var searchForm = $('#search-form_3').height();
    var details = $('#firstdiv').height();
    $('#inputsearchResults').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm) - parseInt(details));
    $(window).resize(function () {
        div = $('.modalDialog > div').height();
        divHead = $('.modalDialog > div > #head').height();
        searchForm = $('#search-form_3').height();
        details = $('#firstdiv').height();
        $('#inputsearchResults').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm) - parseInt(details));
    });

    function inputsearchItem(supplies, searchValue) {
        if (searchValue !== '') {
            ajaxSubmitData('ordersmanagement/searchitemsinternalorder.htm', 'inputOrdersearchResults', 'searchValue=' + searchValue + '&supplies=' + supplies + '&itemsSet='+JSON.stringify(Array.from(orderitemsSet))+'&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    }
    var num = 0;
    function additemquantity(name, itemid) {
        $.confirm({
            title: name + ' ' + 'Quantity',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Quantity</label>' +
                    '<input type="text" placeholder="Enter Quantity" maxlength="7"  onkeypress="return isNumberKey(event)" class="name form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            buttons: {
                formSubmit: {
                    text: 'Add',
                    btnClass: 'btn-purple',
                    action: function () {
                        var qty = this.$content.find('.name').val();
                        if (!qty) {
                            $.alert('provide a valid Quantity');
                            return false;
                        }
                        orderitems.push({
                            itemid: itemid,
                            qty: qty
                        });
                        orderitemsSet.add(parseInt(itemid));
                        num++;
                        $('#inputenteredItemsBody').append(
                                '<tr id="rows' + itemid + '">' +
                                '<td>' + num + '</td>' +
                                '<td>' + name + '</td>' +
                                '<td class="right">' + qty + '</td>' +
                                '<td class="center">' +
                                '<span class="badge badge-danger icon-custom" onclick="removeorderitem(' + itemid + ')">' +
                                '<i class="fa fa-close"></i></span></td>' +
                                '</tr>'
                                );
                        $('#li' + itemid).remove();
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
    function removeorderitem(itemid) {
        $.confirm({
            title: 'Remove Item',
            icon: 'fa fa-warning',
            content: 'Your Removing Item From Order List !!',
            type: 'orange',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Remove',
                    btnClass: 'btn-orange',
                    action: function () {
                        orderitemsSet.delete(parseInt(itemid));
                        for (index in orderitems) {
                            var res = orderitems[index];
                            if (res["itemid"] === itemid) {
                            } else {
                                updatedorderitems.push({
                                    itemid: res["itemid"],
                                    qty: res["qty"]
                                });
                            }
                        }
                        orderitems = [];
                        for (indexs in updatedorderitems) {
                            var ress = updatedorderitems[indexs];
                            orderitems.push({
                                itemid: ress["itemid"],
                                qty: ress["qty"]
                            });
                        }
                        $('#rows' + itemid).remove();
                        updatedorderitems = [];
                    }
                },
                close: function () {

                }
            }
        });

    }
    function savepausedorsubmittedorder(type,id) {
        var dateneeded = $('#orderdateneeded').val();
        var ordernumber = $('#ordernumber').val();
        var orderdatecreated = $('#orderdatecreated').val();
        var orderfacilityunitsupplierid = $('#orderfacilityunitsupplierid').val();
        var ordercriteria = $('#ordercriteria').val();

        if (type === 'pause') {
            if (orderitems.length > 0) {
                document.getElementById(id).disabled=true;
                $.ajax({
                    type: 'POST',
                    data: {type: 'paused', dateneeded: dateneeded, ordernumber: ordernumber, orderdatecreated: orderdatecreated, facilityunitsupplierid: orderfacilityunitsupplierid, ordercriteria: ordercriteria, values: JSON.stringify(orderitems)},
                    url: "ordersmanagement/savepausedorsubmittedfacilityunitorder.htm",
                    success: function (data, textStatus, jqXHR) {
                        $.confirm({
                            title: 'Pause!',
                            content: 'Saved And paused Successfully !!!',
                            type: 'purple',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Ok',
                                    btnClass: 'btn-purple',
                                    action: function () {
                                        window.location = '#close';
                                        ajaxSubmitData('ordersmanagement/placeordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                },
                                close: function () {
                                    window.location = '#close';
                                    ajaxSubmitData('ordersmanagement/placeordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                });
            }

        } else {
            if (orderitems.length > 0) {
                document.getElementById(id).disabled=true;
                $.ajax({
                    type: 'POST',
                    data: {type: 'submitted', dateneeded: dateneeded, ordernumber: ordernumber, orderdatecreated: orderdatecreated, facilityunitsupplierid: orderfacilityunitsupplierid, ordercriteria: ordercriteria, values: JSON.stringify(orderitems)},
                    url: "ordersmanagement/savepausedorsubmittedfacilityunitorder.htm",
                    success: function (data) {
                        $.confirm({
                            title: 'Save!',
                            content: 'Saved And Submitted For Approval Successfully !!!',
                            type: 'purple',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Ok',
                                    btnClass: 'btn-purple',
                                    action: function () {
                                        window.location = '#close';
                                        ajaxSubmitData('ordersmanagement/placeordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                },
                                close: function () {
                                    window.location = '#close';
                                    ajaxSubmitData('ordersmanagement/placeordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                });
            }
        }
    }
    function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}
</script>

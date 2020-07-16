<%-- 
    Document   : addMoreRecalledItems
    Created on : May 24, 2018, 7:46:35 AM
    Author     : IICS
--%>
<%@include file="../../../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<input value="${facilityorderid}" id="recalledfacilityorderid" type="hidden">
<style>
    .cl{color: #465cba;}
</style>
<div>
    <fieldset>
        <legend>An Internal Order</legend>
        <div class="container" id="firstdiv11">
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
                        <h5 style="color: #6e0610;">Total Items In Cart:<span class="badge badge-secondary"><strong>${internalordersitemscount} &nbsp;Items(s)</strong></span></h5>
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
                    <div id="search-form_311">
                        <input id="inputitemSearch11" type="text" onfocus="inputsearchItemrecall(this.value, '${supplies}',${facilityorderid})" oninput="inputsearchItemrecall(this.value,'${supplies}',${facilityorderid})" placeholder="Search Item" class="search_3 dropbtn"/>
                    </div><br>
                    <div id="inputsearchResultsrecalled" class="scrollbar">

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
                            <tbody id="recalledsenteredItemsBody">

                            </tbody>
                        </table>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" id="recalledOrderPauseid" onclick="savepausedorsubmittedrecalledorderItems('pause',this.id);"class="btn btn-primary btn-block">Pause</button>
                            </div>
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" id="recalledOrderSubmitid"  onclick="savepausedorsubmittedrecalledorderItems('submit',this.id);"class="btn btn-primary btn-block">Submit For Approval</button>
                            </div>
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" onclick="canceladdrecaitemsdialog(${facilityorderid}, '${facilityorderno}', '${facilitysuppliername}',${internalordersitemscount}, '${dateneeded}', '${dateprepared}', '${personname}', '${orderstage}',${criteria});" class="btn btn-secondary btn-block">Cancel</button>
                            </div>   
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<script>
    function setSearchpanerecallsize() {
        var div11 = $('.prescriptionDiaolog > div').height();

        var divHead11 = $('#prescribeunprescribedpatientords > div > #head').height();
        var searchForm11 = $('#search-form_311').height();
        var details11 = $('#firstdiv11').height();
        console.log(parseInt(parseInt(div11) - parseInt(divHead11)) - parseInt(div11 * 0.14) - parseInt(searchForm11) - parseInt(details11));
        $('#inputsearchResultsrecalled').height(parseInt(parseInt(div11) - parseInt(divHead11)) - parseInt(div11 * 0.14) - parseInt(searchForm11) - parseInt(details11));
        $(window).resize(function () {
            div11 = $('#prescribeunprescribedpatientords > div').height();
            divHead11 = $('#prescribeunprescribedpatientords > div > #head').height();
            searchForm11 = $('#search-form_311').height();
            details11 = $('#firstdiv11').height();
            $('#inputsearchResultsrecalled').height(parseInt(parseInt(div11) - parseInt(divHead11)) - parseInt(div11 * 0.14) - parseInt(searchForm11) - parseInt(details11));
        });

    }

    function canceladdrecaitemsdialog(facilityorderid, facilityorderno, facilitysuppliername, internalordersitemscount, dateneeded, dateprepared, personname, orderstage, criteria) {
        document.getElementById('titleoraldivreadyheading').innerHTML = facilityorderno + ' ' + 'Items';
        ajaxSubmitData('ordersmanagement/recalledorderitems.htm', 'additemstoorderrecalldiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&pgh=3', 'GET');

    }
    function inputsearchItemrecall(searchValue, supplies, facilityorderid) {
        setSearchpanerecallsize();
        if (searchValue !== '') {
            ajaxSubmitData('ordersmanagement/searchrecalleditems.htm', 'inputsearchResultsrecalled', 'itemsSet=' + JSON.stringify(Array.from(recallItemSet)) + '&supplies=' + supplies + '&facilityorderid=' + facilityorderid + '&searchValue=' + searchValue + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }

    }
    var numb = 0;
    var recallItems = [];
    var recallItemSet = new Set();
    function addrecalledorderitemquantity(itemname, itemid) {
        $.confirm({
            title: itemname,
            type: 'purple',
            typeAnimated: true,
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Item Quantity</label>' +
                    '<input type="number" placeholder="Your Quantity" class="recalleditemqty form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Add',
                    btnClass: 'btn-purple',
                    action: function () {
                        var qty = this.$content.find('.recalleditemqty').val();
                        if (!qty) {
                            $.alert('provide a valid qty');
                            return false;
                        }
                        numb++;
                        $('#recalledsenteredItemsBody').append('<tr id="recalleditemqtyedit' + itemid + '"><td>' + numb + '</td>' +
                                '<td>' + itemname + '</td>' +
                                '<td>' + qty + '</td>' +
                                '<td align="center"><span class="badge badge-danger icon-custom" onclick="removerecalledorderitem(' + itemid + ')">' +
                                '<i class="fa fa-close"></i></span></td></tr>');
                        recallItems.push({
                            itemid: itemid,
                            qty: qty
                        });
                        recallItemSet.add(itemid);
                        $('#itemidli2' + itemid).remove();
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
    function savepausedorsubmittedrecalledorderItems(type,id) {
        var facilityorderid = $('#recalledfacilityorderid').val();
        if (type === 'pause') {
            if (recallItems.length > 0) {
                document.getElementById(id).disabled=true;
                $.ajax({
                    type: 'POST',
                    data: {values: JSON.stringify(recallItems), type: 'pause', facilityorderid: facilityorderid},
                    url: "ordersmanagement/savepausedorsubmittedrecalledorderItems.htm",
                    success: function (data, textStatus, jqXHR) {
                        $.confirm({
                            title: 'Order Paused!',
                            content: 'Order Saved And Paused',
                            type: 'purple',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Ok',
                                    btnClass: 'btn-purple',
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
            if (recallItems.length > 0) {
                document.getElementById(id).disabled=true;
                $.ajax({
                    type: 'POST',
                    data: {values: JSON.stringify(recallItems), type: 'save', facilityorderid: facilityorderid},
                    url: "ordersmanagement/savepausedorsubmittedrecalledorderItems.htm",
                    success: function (data, textStatus, jqXHR) {
                        $.confirm({
                            title: 'Order Saved!',
                            content: 'Order Saved And Submitted For Approval',
                            type: 'orange',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Ok',
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
    function removerecalledorderitem(itemid) {
        for (i in recallItems) {
            if (parseInt(recallItems[i].itemid) === parseInt(itemid)) {
                recallItems.splice(i, 1);
                recallItemSet.delete(itemid);
                $('#recalleditemqtyedit' + itemid).remove();
                break;
            }
        }
    }
</script>
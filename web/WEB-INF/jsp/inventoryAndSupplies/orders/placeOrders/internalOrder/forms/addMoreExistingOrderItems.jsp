<%-- 
    Document   : addMoreExistingOrderItems
    Created on : May 24, 2018, 6:07:15 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .cl{color: #465cba;}
</style>
<div>
    <fieldset>
        <legend>An Internal Order</legend>
        <div class="container" id="firstdive">
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
                            <td align="left"><b class="cl">${originstore}</b></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Order stage:</span></td>
                            <td align="left"><b class="cl"> <c:if test="${status=='SUBMITTED'}">RE-CALLED</c:if><c:if test="${status=='PAUSED'}">PAUSED</c:if></b></td>
                            </tr>
                            <tr class="odd">
                                <td align="left"><span class="style101">Order Destination:</span></td>
                                    <td align="left"><b class="cl">${facilityunitname}</b></td>
                            <td align="left">&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Criteria:</span></td>
                            <td align="left" >
                                <b class="cl" <c:if test="${criteria=='Emergency'}">style="color: red;"</c:if> >
                                    <c:if test="${isemergency==true}">Emergency Order</c:if> 
                                    <c:if test="${isemergency==false}">Normal Order</c:if>
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
                        <h5 style="color: #6e0610;">Total Items In Cart:<span class="badge badge-secondary"><strong>${totaladdeditems} &nbsp;Items(s)</strong></span></h5>
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
                    <div id="search-form_3e">
                        <input id="inputitemSearche" type="text" oninput="inputsearchIteme(${facilityunitsupplierid},this.value,'${supplies}',${facilityorderid})" onfocus="oninputfocus();" placeholder="Search Item" class="search_3 dropbtn"/>
                    </div><br>
                    <div id="inputsearchResultsediv" class="scrollbar">

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
                                    <th>Quantity</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody id="inputenteredItemsBodye">

                            </tbody>
                        </table>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" id="addingMoresItmPausedid"  onclick="savepausedexitorsubmittedorder('pause',${facilityorderid}, '${status}', '${dateneeded}', '${criteria}',${facilityunitsupplierid}, '${facilityunitname}', this.id);"class="btn btn-primary btn-block">Pause</button>
                            </div>
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" id="addingMoresItmSubmitid" onclick="savepausedexitorsubmittedorder('submit',${facilityorderid}, '${status}', '${dateneeded}', '${criteria}',${facilityunitsupplierid}, '${facilityunitname}', this.id);"class="btn btn-primary btn-block">Submit For Approval</button>
                            </div>
                            <div class="col-md-4">
                                <hr style="border:1px dashed #dddddd;">
                                <button type="button" onclick="concaldialogclose('${dateneeded}', '${criteria}',${facilityunitsupplierid}, '${facilityunitname}');" class="btn btn-secondary btn-block">Cancel</button>
                            </div>   
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</fieldset>
<script>
    function concaldialogclose(dateneeded, criteria, facilityunitsupplierid, facilityunitname) {
        ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilityunitsupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&sStr=', 'GET');
    }
    var adedordersitemsSet = new Set();
    function inputsearchIteme(facilityunitsupplierid, searchValue, supplies, facilityorderid) {
        if (searchValue !== '') {
            ajaxSubmitData('ordersmanagement/searchitemsexistinginternalorder.htm', 'inputsearchResultsediv', 'searchValue=' + searchValue + '&supplies=' + supplies + '&facilityunitsupplierid=' + facilityunitsupplierid + '&items=' + JSON.stringify(Array.from(adedordersitemsSet)) + '&facilityorderid=' + facilityorderid + '&ofst=1&maxR=100&sStr=', 'GET');
        }
    }
    function oninputfocus() {
        var div = $('.modalDialog > div').height();
        var divHead = $('.modalDialog > div > #head').height();
        var searchForm = $('#search-form_3e').height();
        var details = $('#firstdiv').height();
        $('#inputsearchResultsediv').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm) - parseInt(details));
        $(window).resize(function () {
            div = $('.modalDialog > div').height();
            divHead = $('.modalDialog > div > #head').height();
            searchForm = $('#search-form_3e').height();
            details = $('#firstdiv').height();
            $('#inputsearchResultsediv').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.14) - parseInt(searchForm) - parseInt(details));
        });
    }
    var coun = 0;
    var existingaddItMs = [];
    function addexititemquantity(itemname, itemid) {
        $.confirm({
            title: itemname,
            type: 'purple',
            typeAnimated: true,
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Quantity</label>' +
                    '<input type="text" placeholder="Enter Quantity" maxlength="7"  onkeypress="return isNumberKey3(event)" class="name form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Add',
                    btnClass: 'btn-purple',
                    action: function () {
                        var qty = this.$content.find('.name').val();
                        if (!qty) {
                            $.alert('provide a valid qty');
                            return false;
                        }
                        coun++;
                        $('#inputenteredItemsBodye').append('<tr id="rwoRemov' + itemid + '"><td>' + itemname + '</td>' +
                                '<td>' + qty + '</td>' +
                                '<td><span class="badge badge-danger icon-custom" onclick="removeexitsorderitem(' + itemid + ')">' +
                                '<i class="fa fa-close"></i></span></td></tr>');
                        $('#li33' + itemid).remove();
                        existingaddItMs.push({
                            itemid: itemid,
                            qty: qty
                        });
                        adedordersitemsSet.add(parseInt(itemid));
                        $('#lisearch' + itemid).remove();
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
    function removeexitsorderitem(itemid) {
        for (i in existingaddItMs) {
            if (parseInt(existingaddItMs[i].itemid) === parseInt(itemid)) {
                existingaddItMs.splice(i, 1);
                adedordersitemsSet.delete(parseInt(itemid));
                $('#rwoRemov' + itemid).remove();
                break;
            }
        }
    }
    function savepausedexitorsubmittedorder(type, facilityorderid, status, dateneeded, criteria, facilityunitsupplierid, facilityunitname, id) {
        if (existingaddItMs.length > 0) {
            if (type === 'pause') {
                if (status === 'SUBMITTED') {
                    $.confirm({
                        title: 'Pause Order',
                        content: 'Are You Sure You Want To Pause Order ?',
                        type: 'red',
                        icon: 'fa fa-warning',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Yes, Pause',
                                btnClass: 'btn-red',
                                action: function () {
                                    document.getElementById(id).disabled = true;
                                    $.ajax({
                                        type: 'POST',
                                        data: {facilityorderid: facilityorderid, values: JSON.stringify(existingaddItMs), type: 'pause'},
                                        url: "ordersmanagement/savepausedorsubmittedrecalledorderItems.htm",
                                        success: function (data) {
                                            $.confirm({
                                                title: 'Pause Order!',
                                                content: 'Order Paused Successfully',
                                                type: 'orange',
                                                typeAnimated: true,
                                                buttons: {
                                                    tryAgain: {
                                                        text: 'OK',
                                                        btnClass: 'btn-orange',
                                                        action: function () {
                                                            ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilityunitsupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&sStr=', 'GET');
                                                        }
                                                    }
                                                }
                                            });
                                        }
                                    });
                                }
                            },
                            close: function () {
                            }
                        }
                    });
                } else {
                    $.confirm({
                        title: 'Pause Order',
                        content: 'Are You Sure You Want To Pause Order ?',
                        type: 'red',
                        icon: 'fa fa-warning',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Yes, Pause',
                                btnClass: 'btn-red',
                                action: function () {
                                    document.getElementById(id).disabled = true;
                                    $.ajax({
                                        type: 'POST',
                                        data: {values: JSON.stringify(existingaddItMs), facilityunitorderid: facilityorderid, type: 'pause'},
                                        url: "ordersmanagement/saveorpausepausedfacilityorderitmz.htm",
                                        success: function (data) {
                                            $.confirm({
                                                title: 'Pause Order',
                                                content: 'Order Paused Successfully',
                                                type: 'orange',
                                                typeAnimated: true,
                                                buttons: {
                                                    tryAgain: {
                                                        text: 'OK',
                                                        btnClass: 'btn-orange',
                                                        action: function () {
                                                            ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilityunitsupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&sStr=', 'GET');
                                                        }
                                                    }
                                                }
                                            });
                                        }
                                    });
                                }
                            },
                            close: function () {
                            }
                        }
                    });
                }
            } else {
                if (status === 'SUBMITTED') {
                    $.confirm({
                        title: 'Submit Order!',
                        content: 'Are You Sure You Want To Submit Order For Approval?',
                        type: 'red',
                        icon: 'fa fa-warning',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Yes, Submit',
                                btnClass: 'btn-red',
                                action: function () {
                                    document.getElementById(id).disabled = true;
                                    $.ajax({
                                        type: 'POST',
                                        data: {values: JSON.stringify(existingaddItMs), facilityunitorderid: facilityorderid, type: 'save'},
                                        url: "ordersmanagement/saveorpausepausedfacilityorderitmz.htm",
                                        success: function (data, textStatus, jqXHR) {
                                            $.confirm({
                                                title: 'Submit Order',
                                                content: 'Order Submitted For Approval Successfully !!',
                                                type: 'orange',
                                                typeAnimated: true,
                                                buttons: {
                                                    tryAgain: {
                                                        text: 'OK',
                                                        btnClass: 'btn-orange',
                                                        action: function () {
                                                            ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilityunitsupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&sStr=', 'GET');
                                                        }
                                                    }
                                                }
                                            });
                                        }
                                    });
                                }
                            },
                            close: function () {
                            }
                        }
                    });
                } else {
                    $.confirm({
                        title: 'Submit Order!',
                        content: 'Are You Sure You Want To Submit Order For Approval?',
                        type: 'red',
                        icon: 'fa fa-warning',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Yes, Submit',
                                btnClass: 'btn-red',
                                action: function () {
                                    document.getElementById(id).disabled = true;
                                    $.ajax({
                                        type: 'POST',
                                        data: {values: JSON.stringify(existingaddItMs), facilityunitorderid: facilityorderid, type: 'save'},
                                        url: "ordersmanagement/saveorpausepausedfacilityorderitmz.htm",
                                        success: function (data, textStatus, jqXHR) {
                                            $.confirm({
                                                title: 'Submit Order',
                                                content: 'Order Submitted For Approval Successfully !!',
                                                type: 'orange',
                                                typeAnimated: true,
                                                buttons: {
                                                    tryAgain: {
                                                        text: 'OK',
                                                        btnClass: 'btn-orange',
                                                        action: function () {
                                                            ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilityunitsupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&sStr=', 'GET');
                                                        }
                                                    }
                                                }
                                            });
                                        }
                                    });
                                }
                            },
                            close: function () {
                            }
                        }
                    });
                }
            }
        }
    }
    function isNumberKey3(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
</script>
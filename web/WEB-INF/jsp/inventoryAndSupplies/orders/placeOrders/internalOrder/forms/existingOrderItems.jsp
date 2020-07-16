<%-- 
    Document   : existingOrderItems
    Created on : May 21, 2018, 12:53:00 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    .cl{color: #465cba;}
</style>
<div>
    <fieldset>
        <legend>An Internal Order</legend>
        <div class="container" id="firstdiv">
            <div class="row">

                <input id="alrorderdateneeded" value="${dateneeded}" type="hidden">
                <input id="alrordernumber" value="${facilityorderno}" type="hidden">
                <input id="alrorderdatecreated" value="${dateprepared}" type="hidden">
                <input id="alrorderfacilityunitsupplierid" value="${facilityunitsupplierid}" type="hidden">
                <input id="alrordercriteria" value="<c:if test="${isemergency==true}">Emergency</c:if><c:if test="${isemergency==false}">Normal</c:if>" type="hidden">
                <input id="alrorderfacilityunitname" value="${facilityunitname}" type="hidden">

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
                            <td align="left"><b class="cl"><c:if test="${status=='PAUSED'}">PAUSED</c:if><c:if test="${status=='SUBMITTED'}">RE-CALLED</c:if></b></td>
                            </tr>
                            <tr class="odd">
                                <td align="left"><span class="style101">Order Destination:</span></td>
                                    <td align="left"><b class="cl">${facilityunitname}</b></td>
                            <td align="left">&nbsp;&nbsp;&nbsp;</td>
                            <td align="left"><span class="style101">Criteria:</span></td>
                            <td align="left" >
                                <b class="cl" <c:if test="${isemergency==true}">style="color: red;"</c:if> >
                                    <c:if test="${isemergency==true}">Emergency</c:if><c:if test="${isemergency==false}">Normal</c:if> Order
                                    </b>
                                </td>
                            </tr>
                            <tr class="even">
                            </tr>
                        </tbody>
                    </table>

                </div>
                <div class="row">
                    <div class="col-md-4">

                    </div>
                    <div class="col-md-4">

                    </div>
                    <div class="col-md-4">

                    </div>
                </div>
            </div>
        </fieldset>
    </div>
    <br>
    <fieldset>
        <legend>Order Item(s)</legend>
        <table class="table table-hover table-bordered col-md-12" id="orderalreadyexistingitemstable">
            <thead class="col-md-12">
                <tr>
                    <th class="center">No</th>
                    <th>Items</th>
                    <th class="">Quantity Ordered</th>
                    <th class="">Edit | Discard</th>
                </tr>
            </thead>
            <tbody class="col-md-12">
            <% int y = 1;%>
            <c:forEach items="${itemsFound}" var="a">
                <tr>
                    <td class="center"><%=y++%></td>
                    <td class="">${a.genericname}</td>
                    <td class="">${a.qtyordered}</td>
                    <td align="center">
                        <button onclick="editexistingorderitem(${a.facilityorderitemsid},${a.qtyordered}, '${a.genericname}',${facilityorderid}, '${facilityorderno}', '${dateneeded}', '${facilityunitname}', '${personname}', '${dateprepared}', '${status}',${facilityunitsupplierid},${isemergency});"  title="Edit Order Item" class="btn btn-primary btn-sm add-to-shelf">
                            <i class="fa fa-edit"></i>
                        </button>
                        |
                        <button onclick="discardexistingorderitem(${a.facilityorderitemsid},${facilityorderid}, '${facilityorderno}', '${dateneeded}', '${facilityunitname}', '${personname}', '${dateprepared}', '${status}',${facilityunitsupplierid},${isemergency});"  title="Delete Order Item" class="btn btn-primary btn-sm add-to-shelf">
                            <i class="fa fa-remove"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table> 
    <div class="form-group">
        <div class="row">
            <div class="col-md-3">
                <hr style="border:1px dashed #dddddd;">
                <button type="button"  onclick="pauseorsaveexistingFacilityInternalOrder('pause',${facilityorderid}, '${status}');"class="btn btn-primary btn-block">pause</button>
            </div>
            <div class="col-md-3">
                <hr style="border:1px dashed #dddddd;">
                <button type="button"  onclick="pauseorsaveexistingFacilityInternalOrder('save',${facilityorderid}, '${status}');"class="btn btn-primary btn-block">Submit For Approval</button>
            </div>
            <div class="col-md-3">
                <hr style="border:1px dashed #dddddd;">
                <button type="button"  onclick="existingOrdAddMrItms(${facilityorderid}, '${facilityorderno}', '${dateneeded}', '${facilityunitname}', '${personname}', '${dateprepared}', '${status}',${facilityunitsupplierid},${isemergency}, '${originstore}',${totalcost}, '${supplies}');"class="btn btn-primary btn-block">Add More Items</button>
            </div>
            <div class="col-md-3">
                <hr style="border:1px dashed #dddddd;">
                <button type="button" onclick="cancelextitemsdialog();" class="btn btn-secondary btn-block">Cancel</button>
            </div>   
        </div>
    </div>         
</fieldset>

<script>
    document.getElementById('titleoralreadyheading').innerHTML = 'Manage Existing Order !!!';
    $('#orderalreadyexistingitemstable').DataTable();
    function cancelextitemsdialog() {
        var dateneeded = $('#alrorderdateneeded').val();
        var criteria = $('#alrordercriteria').val();
        var facilitysupplierid = $('#alrorderfacilityunitsupplierid').val();
        var facilityunitname = $('#alrorderfacilityunitname').val();
        var facilityunitfinancialyearid = $('#alrorderfacilityunitfinancialyearid').val();
        ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilitysupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&sStr=', 'GET');
    }
    function discardexistingorderitem(facilityorderitemsid, facilityorderid, facilityorderno, dateneeded, facilityunitname, personname, dateprepared, status, facilityunitsupplierid, isemergency) {
        $.confirm({
            title: 'Discard Item!',
            content: 'Are You Sure You Want To Delete Item ??',
            type: 'red',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes,Delete',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityorderitemsid: facilityorderitemsid},
                            url: "ordersmanagement/removeitemfromfacilityunitorder.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    ajaxSubmitData('ordersmanagement/manageexistingfacilityunitorderitems.htm', 'additemstoorderdiv', 'facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&dateneeded=' + dateneeded + '&facilityunitname=' + facilityunitname + '&personname=' + personname + '&dateprepared=' + dateprepared + '&status=' + status + '&isemergency=' + isemergency + '&facilityunitsupplierid=' + facilityunitsupplierid, 'GET');
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
    function pauseorsaveexistingFacilityInternalOrder(type, facilityorderid, status) {
        var dateneeded = $('#alrorderdateneeded').val();
        var criteria = $('#alrordercriteria').val();
        var facilitysupplierid = $('#alrorderfacilityunitsupplierid').val();
        var facilityunitname = $('#alrorderfacilityunitname').val();
        var facilityunitfinancialyearid = $('#alrorderfacilityunitfinancialyearid').val();

        if (type === 'pause') {
            if (status === 'SUBMITTED') {
                $.confirm({
                    title: 'Pause Order!',
                    content: 'Are You Sure To Pause This Order ??',
                    type: 'red',
                    icon: 'fa fa-warning',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes, Pause',
                            btnClass: 'btn-red',
                            action: function () {
                                $.ajax({
                                    type: 'POST',
                                    data: {facilityorderid: facilityorderid},
                                    url: "ordersmanagement/pausercalledorder.htm",
                                    success: function (data, textStatus, jqXHR) {
                                        if (data === 'success') {
                                            $.confirm({
                                                title: 'Order Paused!',
                                                content: 'This Order Has Been Paused !!',
                                                type: 'orange',
                                                typeAnimated: true,
                                                buttons: {
                                                    tryAgain: {
                                                        text: 'OK',
                                                        btnClass: 'btn-orange',
                                                        action: function () {
                                                            ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilitysupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&sStr=', 'GET');
                                                        }
                                                    }
                                                }
                                            });
                                        }
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
                    title: 'Pause Order!',
                    content: 'Are You Sure To Pause This Order ??',
                    type: 'red',
                    icon: 'fa fa-warning',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes, Pause',
                            btnClass: 'btn-red',
                            action: function () {
                                $.confirm({
                                    title: 'Pause Order!',
                                    content: 'Order Paused !!',
                                    type: 'orange',
                                    typeAnimated: true,
                                    buttons: {
                                        tryAgain: {
                                            text: 'OK',
                                            btnClass: 'btn-orange',
                                            action: function () {
                                                ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilitysupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&sStr=', 'GET');
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
        } else {
            if (status === 'SUBMITTED') {
                $.confirm({
                    title: 'Re-Submit Order!',
                    content: 'Are You Sure To Re-Submit This Order For Approval ??',
                    type: 'red',
                    icon: 'fa fa-warning',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes, Submit',
                            btnClass: 'btn-red',
                            action: function () {
                                $.confirm({
                                    title: 'Re-Submit Order!',
                                    content: 'Order Re-submitted For Approval',
                                    type: 'orange',
                                    typeAnimated: true,
                                    buttons: {
                                        tryAgain: {
                                            text: 'Ok',
                                            btnClass: 'btn-orange',
                                            action: function () {
                                                ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilitysupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&sStr=', 'GET');
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

            } else {
                $.confirm({
                    title: 'Submit Order!',
                    content: 'Are You Sure To Submit Order For Approval ??',
                    type: 'red',
                    icon: 'fa fa-warning',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes, Submit',
                            btnClass: 'btn-red',
                            action: function () {
                                $.ajax({
                                    type: 'POST',
                                    data: {facilityorderid: facilityorderid, type: 'save'},
                                    url: "ordersmanagement/saveorsubmitpausedfacilityunitorders.htm",
                                    success: function (data, textStatus, jqXHR) {
                                        if (data === 'success') {
                                            $.confirm({
                                                title: 'Submit Order!',
                                                content: 'Order Submitted For Approval !!',
                                                type: 'orange',
                                                typeAnimated: true,
                                                buttons: {
                                                    tryAgain: {
                                                        text: 'Ok',
                                                        btnClass: 'btn-orange',
                                                        action: function () {
                                                            ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilitysupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&sStr=', 'GET');
                                                        }
                                                    }
                                                }
                                            });
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
        }
    }
    function existingOrdAddMrItms(facilityorderid, facilityorderno, dateneeded, facilityunitname, personname, dateprepared, status, facilityunitsupplierid, isemergency, originstore, totalcost, supplies) {
        ajaxSubmitData('ordersmanagement/existingordsaddmoritms.htm', 'additemstoorderdiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&personname=' + personname + '&dateprepared=' + dateprepared + '&status=' + status + '&facilityunitsupplierid=' + facilityunitsupplierid + '&isemergency=' + isemergency + '&originstore=' + originstore + '&totalcost=' + totalcost + '&supplies=' + supplies, 'GET');
    }
    function editexistingorderitem(facilityorderitemsid, qtyordered, genericname, facilityorderid, facilityorderno, dateneeded, facilityunitname, personname, dateprepared, status, facilityunitsupplierid, isemergency) {
        $.confirm({
            title: 'EDIT ITEM QTY',
            type: 'purple',
            typeAnimated: true,
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Item</label>' +
                    '<input type="text" value="' + genericname + '" disabled="true" class="form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Quantity</label>' +
                    '<input type="text" value="' + qtyordered + '" class="editteditemqty form-control" maxlength="7"  onkeypress="return isNumberKey2(event)" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var qty = this.$content.find('.editteditemqty').val();
                        if (!qty) {
                            $.alert('provide a valid Quantity');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            url: "ordersmanagement/editexistingorderitem.htm",
                            data: {qty: qty, facilityorderitemsid: facilityorderitemsid},
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('ordersmanagement/manageexistingfacilityunitorderitems.htm', 'additemstoorderdiv', 'facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&dateneeded=' + dateneeded + '&facilityunitname=' + facilityunitname + '&personname=' + personname + '&dateprepared=' + dateprepared + '&status=' + status + '&isemergency=' + isemergency + '&facilityunitsupplierid=' + facilityunitsupplierid, 'GET');
                            }
                        });
                    }
                },
                cancel: function () {

                },
            }
        });
    }
    function isNumberKey2(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
</script>
<%-- 
    Document   : items
    Created on : May 17, 2018, 5:03:55 PM
    Author     : IICS
--%>
<%@include file="../../../../.../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<input id="vieworderfacilityorderid" value="${facilityorderid}" type="hidden">
<input id="vieworderordernumber" value="${facilityorderno}" type="hidden">

<input id="vieworderfacilitysuppliername" value="${facilitysuppliername}" type="hidden">
<input id="viewinternalordersitemscount" value="${internalordersitemscount}" type="hidden">
<input id="viewdateneeded" value="${dateneeded}" type="hidden">
<input id="viewdateprepared" value="${dateprepared}" type="hidden">
<input id="viewpersonname" value="${personname}" type="hidden">
<input id="vieworderstage" value="${orderstage}" type="hidden">
<input id="viewcriteria" value="${criteria}" type="hidden">
<input id="viewfacilityunitfinancialyearid" value="${facilityunitfinancialyearid}" type="hidden">
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
                            <td align="left"><b class="cl">${originorder}</b></td>
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
                    </div>
                    <div class="col-md-4">

                    </div>
                </div>
            </div>
        </fieldset>
    </div><br>
    <fieldset>
        <table class="table table-hover table-bordered" id="facilityunitorderitemsstable">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Item</th>
                    <th>Quantity Ordered</th>
                    <th>Edit | Remove</th>
                </tr>
            </thead>
            <tbody>
            <% int j = 1;%>
            <c:forEach items="${itemsFound}" var="a">
                <tr>
                    <td><%=j++%></td>
                    <td>${a.genericname}</td>
                    <td>${a.qtyordered}</td>
                    <td align="center"> 
                        <button onclick="editorderitem(${a.facilityorderitemsid},${a.itemid},${a.qtyordered}, '${a.genericname}',${facilityorderid},'${facilityorderno}','${facilitysuppliername}',${internalordersitemscount},'${dateneeded}','${dateprepared}','${personname}','${orderstage}',${criteria});"  title="Edit Order Item" class="btn btn-primary btn-sm add-to-shelf">
                            <i class="fa fa-edit"></i>
                        </button>
                        |
                        <button onclick="removeitemfromorder(${a.facilityorderitemsid},${a.itemid});"  title="Delete Item From Order" class="btn btn-primary btn-sm add-to-shelf">
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
                <button type="button"  onclick="saveorsubpausedfacilityunitorders('pause');" class="btn btn-primary btn-block">Pause</button>
            </div>
            <div class="col-md-3">
                <hr style="border:1px dashed #dddddd;">
                <button type="button"  onclick="saveorsubpausedfacilityunitorders('save');"class="btn btn-primary btn-block">Submit For Approval</button>
            </div>
            <div class="col-md-3">
                <hr style="border:1px dashed #dddddd;">
                <button type="button"  onclick="addmoreitemstopausedfacilityunitorder();"class="btn btn-primary btn-block">Add More Items</button>
            </div>
            <div class="col-md-3">
                <hr style="border:1px dashed #dddddd;">
                <button type="button" onclick="clsemodaldialog();" class="btn btn-secondary btn-block">close</button>
            </div>   
        </div>
    </div> 
</fieldset>    
<script>
    $('#facilityunitorderitemsstable').DataTable();
    function editorderitem(facilityorderitemsid, itemid, qtyordered, genericname,facilityorderid,facilityorderno,facilitysuppliername,internalordersitemscount,dateneeded,dateprepared,personname,orderstage,criteria) {
        $.confirm({
            title: 'Edit Item Quantity',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Item Name</label>' +
                    '<input type="text" value="' + genericname + '" disabled="true" class="name form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Quantity Ordered</label>' +
                    '<input type="text" value="' + qtyordered + '" maxlength="7"  onkeypress="return isNumberKeyedit(event)" class="itemquantityordered form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Save',
                    btnClass: 'btn-purple',
                    action: function () {
                        var qty = this.$content.find('.itemquantityordered').val();
                        if (!qty) {
                            $.alert('provide a valid Quantity');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {qty:qty,facilityorderitemsid:facilityorderitemsid},
                            url: "ordersmanagement/editexistingorderitem.htm",
                            success: function (data) {
                                 ajaxSubmitData('ordersmanagement/pausedfacilityorderitems.htm', 'orderitemsdiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&pgh=3', 'GET');
                            }
                        });
                    }
                },
                close: function () {

                }
            }
        });
    }
    function removeitemfromorder(facilityorderitemsid, itemid) {
        var facilityorderid = $('#vieworderfacilityorderid').val();
        var facilityorderno = $('#vieworderordernumber').val();
        var facilitysuppliername = $('#vieworderfacilitysuppliername').val();
        var internalordersitemscount = $('#viewinternalordersitemscount').val();
        var dateneeded = $('#viewdateneeded').val();
        var dateprepared = $('#viewdateprepared').val();
        var personname = $('#viewpersonname').val();
        var orderstage = $('#vieworderstage').val();
        var criteria = $('#viewcriteria').val();
        $.confirm({
            title: 'Remove Item!',
            icon: 'fa fa-warning',
            content: 'Will Be Removed From Order !!',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Remove',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityorderitemsid: facilityorderitemsid, itemid: itemid},
                            url: "ordersmanagement/removeitemfromfacilityunitorder.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    $.confirm({
                                        title: 'Removed!',
                                        content: 'Successfully !!!',
                                        type: 'orange',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'Ok',
                                                btnClass: 'btn-orange',
                                                action: function () {

                                                    ajaxSubmitData('ordersmanagement/pausedfacilityorderitems.htm', 'orderitemsdiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&pgh=3', 'GET');
                                                }
                                            },
                                            close: function () {
                                                ajaxSubmitData('ordersmanagement/pausedfacilityorderitems.htm', 'orderitemsdiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&pgh=3', 'GET');
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
    function saveorsubpausedfacilityunitorders(type) {
        if (type === 'save') {
            var facilityorderid = $('#vieworderfacilityorderid').val();
            $.ajax({
                type: 'POST',
                data: {facilityorderid: facilityorderid, type: 'save'},
                url: "ordersmanagement/saveorsubmitpausedfacilityunitorders.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'success') {
                        $.confirm({
                            title: 'Submitted!',
                            content: 'Successfully !!!',
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
                                },
                                close: function () {
                                    window.location = '#close';
                                    ajaxSubmitData('ordersmanagement/internalordersview.htm', 'createdordersdiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                }
            });

        } else {
            var facilityorderid = $('#vieworderfacilityorderid').val();
            $.ajax({
                type: 'POST',
                data: {facilityorderid: facilityorderid, type: 'pause'},
                url: "ordersmanagement/saveorsubmitpausedfacilityunitorders.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'success') {
                        $.confirm({
                            title: 'Order Paused!',
                            content: 'Successfully !!!',
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
                                },
                                close: function () {
                                    window.location = '#close';
                                    ajaxSubmitData('ordersmanagement/internalordersview.htm', 'createdordersdiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                }
            });
        }
    }
    function clsemodaldialog() {
        window.location = '#close';
    }
    function addmoreitemstopausedfacilityunitorder() {
        var facilityorderid = $('#vieworderfacilityorderid').val();
        var facilityorderno = $('#vieworderordernumber').val();
        var facilitysuppliername = $('#vieworderfacilitysuppliername').val();
        var internalordersitemscount = $('#viewinternalordersitemscount').val();
        var dateneeded = $('#viewdateneeded').val();
        var dateprepared = $('#viewdateprepared').val();
        var personname = $('#viewpersonname').val();
        var orderstage = $('#vieworderstage').val();
        var criteria = $('#viewcriteria').val();
        var facilityunitfinancialyearid = $('#viewfacilityunitfinancialyearid').val();
        ajaxSubmitData('ordersmanagement/pausedfacilityorderadditems.htm', 'orderitemsdiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&nbs=0', 'GET');
    }

    function isNumberKeyedit(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
</script>
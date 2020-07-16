<%-- 
    Document   : orderItems
    Created on : May 23, 2018, 4:59:18 PM
    Author     : IICS
--%>
<%@include file="../../../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                            <td align="left"><b class="cl"><c:if test="${orderstage=='SUBMITTED'}">RE-CALLED</c:if>
                                    <c:if test="${orderstage=='PAUSED'}">PAUSED</c:if>
                                    <c:if test="${orderstage=='RECEIVED'}"> SERVICED</c:if>
                                    </b></td>
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
    </div>
    <br>
    <fieldset>
        <table class="table table-hover table-bordered" id="facilityrecallunitorderitemsstable">
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
                        <button onclick="editrecalledorderitem(${a.facilityorderitemsid},${a.qtyordered}, '${a.genericname}',${facilityorderid}, '${facilityorderno}', '${facilitysuppliername}',${internalordersitemscount}, '${dateneeded}', '${dateprepared}', '${personname}', '${orderstage}',${criteria});"  title="Edit Order Item" class="btn btn-primary btn-sm add-to-shelf">
                            <i class="fa fa-edit"></i>
                        </button>
                        |
                        <button onclick="removerecalleditemfromorder(${a.facilityorderitemsid},${facilityorderid}, '${facilityorderno}', '${facilitysuppliername}',${internalordersitemscount}, '${dateneeded}', '${dateprepared}', '${personname}', '${orderstage}',${criteria});"  title="Delete Item From Order" class="btn btn-primary btn-sm add-to-shelf">
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
                <button type="button"  onclick="saveOrpauserecOrd('pause',${facilityorderid});"class="btn btn-primary btn-block">Pause</button>
            </div>
            <div class="col-md-3">
                <hr style="border:1px dashed #dddddd;">
                <button type="button"  onclick="saveOrpauserecOrd('save',${facilityorderid});"class="btn btn-primary btn-block">Submit Fro Approval</button>
            </div>
            <div class="col-md-3">
                <hr style="border:1px dashed #dddddd;">
                <button type="button"  onclick="recalledordersaddMoreitems(${facilityorderid}, '${facilityorderno}', '${facilitysuppliername}',${internalordersitemscount}, '${dateneeded}', '${dateprepared}', '${personname}', '${orderstage}',${criteria}, '${facilityunitname}');"class="btn btn-primary btn-block">Add More Items</button>

            </div>
            <div class="col-md-3">
                <hr style="border:1px dashed #dddddd;">
                <button type="button" onclick="clserecallmodaldialog();" class="btn btn-secondary btn-block">close</button>
            </div>   
        </div>
    </div> 
</fieldset> 
<script>
    $('#facilityrecallunitorderitemsstable').DataTable();
    function clserecallmodaldialog() {
        window.location = '#close';
    }
    function recalledordersaddMoreitems(facilityorderid, facilityorderno, facilitysuppliername, internalordersitemscount, dateneeded, dateprepared, personname, orderstage, criteria, facilityunitname) {
        document.getElementById('titleoraldivreadyheading').innerHTML = facilityorderno + ' ' + 'Add More Items';
        ajaxSubmitData('ordersmanagement/recalledordersaddmoreitems.htm', 'additemstoorderrecalldiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&facilityunitname=' + facilityunitname + '&rec=0', 'GET');
    }
    function removerecalleditemfromorder(facilityorderitemsid, facilityorderid, facilityorderno, facilitysuppliername, internalordersitemscount, dateneeded, dateprepared, personname, orderstage, criteria) {
        $.confirm({
            title: 'Delete Item!',
            content: 'Are You Sure You Want To Delete Item From Order ??',
            type: 'red',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes, Delete',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityorderitemsid: facilityorderitemsid},
                            url: "ordersmanagement/removeitemfromfacilityunitorder.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    ajaxSubmitData('ordersmanagement/recalledorderitems.htm', 'additemstoorderrecalldiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&pgh=3', 'GET');
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
    function saveOrpauserecOrd(type, facilityorderid) {
        if (type === 'save') {
            $.confirm({
                title: 'Re-Submitting Order!',
                content: 'Your Re-Submitting Order For Approval ??',
                type: 'red',
                icon: 'fa fa-warning',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes, Submit',
                        btnClass: 'btn-red',
                        action: function () {
                            $.confirm({
                                title: 'Order Submitted!',
                                content: 'Order Submitted For Approval',
                                type: 'orange',
                                typeAnimated: true,
                                buttons: {
                                    tryAgain: {
                                        text: 'Ok',
                                        btnClass: 'btn-orange',
                                        action: function () {
                                            window.location = '#close';
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
                title: 'Pausing Order!',
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
                                            content: 'Order Paused Until Next Submission',
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
    function editrecalledorderitem(facilityorderitemsid, quantityordered, genericname,facilityorderid,facilityorderno,facilitysuppliername,internalordersitemscount,dateneeded,dateprepared,personname,orderstage,criteria) {
        $.confirm({
            title: 'Edit Item Quantity',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Item Name</label>' +
                    '<input type="text" value="' + genericname + '" disabled="true" class="name form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Item Name</label>' +
                    '<input type="text" value="' + quantityordered + '" maxlength="7"  onkeypress="return isNumberKeyrecall(event)" class="editrecalledqtyordered form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Save',
                    btnClass: 'btn-purple',
                    action: function () {
                        var qty = this.$content.find('.editrecalledqtyordered').val();
                        if (!qty) {
                            $.alert('provide a valid Quantity');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {qty: qty, facilityorderitemsid: facilityorderitemsid},
                            url: "ordersmanagement/editexistingorderitem.htm",
                            success: function (data) {
                                ajaxSubmitData('ordersmanagement/recalledorderitems.htm', 'additemstoorderrecalldiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&pgh=3', 'GET');
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function isNumberKeyrecall(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
</script>
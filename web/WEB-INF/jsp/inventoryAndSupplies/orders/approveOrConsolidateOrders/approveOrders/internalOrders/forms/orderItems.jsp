<%-- 
    Document   : orderItems
    Created on : May 18, 2018, 12:29:24 PM
    Author     : IICS
--%>
<style>
    #overlayapprv {
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
<%@include file="../../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<input id="approvefacilityorditemsid" value="${facilityorderid}" type="hidden">
<table class="table table-hover table-bordered col-md-12" id="tableapproveOrdersItems">
    <thead class="col-md-12">
        <tr>
            <th class="center">No</th>
            <th>Item</th>
            <th>Quantity Ordered</th>
            <th>Current Stock</th>
            <th>Approved?</th>
            <th>Update Qty</th>
        </tr>
    </thead>
    <tbody class="col-md-12">
        <% int y = 1;%>
        <% int t = 1;%>
        <c:forEach items="${internalOrdersitems}" var="a">
            <tr>
                <td class="center"><%=y++%></td>
                <td class="">${a.genericname}</td>
                <td class="center">${a.qtyordered}</td>
                <td class="center">${a.stockbalance}</td>
                <td align="center">
                    <div class="toggle-flip">
                        <label>
                            <input  <c:if test="${a.approved ==true}">checked="checked"</c:if>  value="${a.facilityorderitemsid}" id="vorapp<%=t++%>p" type="checkbox" onchange="if (this.checked) {
                                        approveorunapproveorderitems(this.value, 'checked', ${facilityorderid});
                                    } else {
                                        approveorunapproveorderitems(${a.facilityorderitemsid}, 'unchecked', ${facilityorderid});
                                    }" class="item-approval-input" /><span class="flip-indecator"  style="height: 10px !important;width:  32px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                        </label>
                    </div>
                </td>
                <td align="center">
                    <span onclick="editOrderItemQty(${a.facilityorderitemsid},${a.qtyordered}, '${a.genericname}',${facilityorderid}, '${facilityorderno}', '${destinationfacilityunit}',${isemergency}, '${personname}', '${dateneeded}', '${dateprepared}');" title="Edit Of This Item."  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<div id="overlayapprv" style="display: none;">
    <img src="static/img2/loader.gif" alt="Loading" /><br/>
    Please Wait...
</div>
<div class="form-group">
    <div class="row">
        <div class="col-md-4">
            <hr style="border:1px dashed #dddddd;">
            <button type="button"  onclick="submitosavepausefacilityuntord('pause');" class="btn btn-primary btn-block">Pause</button>
        </div>
        <div class="col-md-4">
            <hr style="border:1px dashed #dddddd;">
            <button type="button"  onclick="submitosavepausefacilityuntord('submit');"class="btn btn-primary btn-block">Submit</button>
        </div>
        <div class="col-md-4">
            <hr style="border:1px dashed #dddddd;">
            <button type="button" onclick="closedlg();" class="btn btn-secondary btn-block">close</button>
        </div>   
    </div>
</div> 
<script>
    var table = $('#tableapproveOrdersItems').DataTable();
    function closedlg() {
        window.location = '#close';
    }
    function approveorunapproveorderitems(facilityorderitemsid, type, facilityorderid) {
        if (type === 'checked') {
            document.getElementById('overlayapprv').style.display = 'block';
            $.ajax({
                type: 'POST',
                data: {facilityorderitemsid: facilityorderitemsid, type: 'approve'},
                url: "ordersmanagement/approveorunapprovefacilityunitorderitems.htm",
                success: function (data) {
                    if (data === 'success') {
                        document.getElementById('overlayapprv').style.display = 'none';
                        // ajaxSubmitData('ordersmanagement/verifyfacilityunitorders.htm', 'verifyorderitemsandsubdiv', 'act=a&facilityorderid=' + facilityorderid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    } else {
                        document.getElementById('overlayapprv').style.display = 'none';
                    }
                }
            });
        } else {
            document.getElementById('overlayapprv').style.display = 'block';
            $.ajax({
                type: 'POST',
                data: {facilityorderitemsid: facilityorderitemsid, type: 'unapprove'},
                url: "ordersmanagement/approveorunapprovefacilityunitorderitems.htm",
                success: function (data) {
                    if (data === 'success') {
                        document.getElementById('overlayapprv').style.display = 'none';
                        //ajaxSubmitData('ordersmanagement/verifyfacilityunitorders.htm', 'verifyorderitemsandsubdiv', 'act=a&facilityorderid=' + facilityorderid + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    } else {
                        document.getElementById('overlayapprv').style.display = 'none';
                    }
                }
            });
        }

    }
    function submitosavepausefacilityuntord(type) {        
        var facilityorderid = $('#approvefacilityorditemsid').val();
        //
        var allApproved = false;
        table.rows().iterator('row', function(context, index){ //
            var node = $(this.row(index).node());            
            node.each(function (e) {
                var cell = $(this).children('td')[4];                
                var checked = $($(cell).children('.toggle-flip').children('label')[0]).children('.item-approval-input').prop('checked');
                allApproved = (checked === true);
            });
        });
        //
//        if (type === 'submit') {
        if (type === 'submit' && allApproved) {
            submitOrderItemsForApproval(facilityorderid);
//            $.ajax({
//                type: 'POST',
//                data: {type: 'submit', facilityorderid: facilityorderid},
//                url: "ordersmanagement/submitosavepausefacilityuntord.htm",
//                success: function (data, textStatus, jqXHR) {
//                    if (data === 'success') {
//                        $.confirm({
//                            title: 'Submitted!',
//                            content: 'Successfully !!!',
//                            type: 'orange',
//                            typeAnimated: true,
//                            buttons: {
//                                tryAgain: {
//                                    text: 'Ok',
//                                    btnClass: 'btn-orange',
//                                    action: function () {
//                                        ajaxSubmitData('ordersmanagement/approveorconsolidateordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                                    }
//                                },
//                                close: function () {
//                                    ajaxSubmitData('ordersmanagement/approveorconsolidateordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                                }
//                            }
//                        });
//                    } else if (data === 'nothing') {
//                        $.confirm({
//                            title: 'Approve!',
//                            content: 'Approve Items To Submit Order !!!',
//                            type: 'red',
//                            typeAnimated: true,
//                            buttons: {
//                                tryAgain: {
//                                    text: 'Ok',
//                                    btnClass: 'btn-red',
//                                    action: function () {
//
//                                    }
//                                },
//                                close: function () {
//
//                                }
//                            }
//                        });
//                    }
//                }
//            });
        } else if(type === 'pause') {
            $.ajax({
                type: 'POST',
                data: {type: 'pause', facilityorderid: facilityorderid},
                url: "ordersmanagement/submitosavepausefacilityuntord.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'success') {
                        $.confirm({
                            title: 'Order Approval!',
                            content: 'Order Items Approval Paused!!!',
                            type: 'orange',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Ok',
                                    btnClass: 'btn-orange',
                                    action: function () {
                                        window.location = '#close';
                                    }
                                },
                                close: function () {
                                    window.location = '#close';
                                }
                            }
                        });
                    }

                }
            });
        } else if(type === 'submit' && allApproved === false){
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Warning',
                type: 'orange',
                typeAnimated: true,
                boxWidth: '30%',
                closeIcon: true,
                useBootstrap: false,
                content: 'Some order items have not been approved. Do you want to proceed?',
                buttons: {
                    proceed: {
                        text: 'Proceed',
                        btnClass: 'btn btn-warning',
                        action: function () {
                            submitOrderItemsForApproval(facilityorderid);
                        }
                    },
                    cancel: {
                        text: 'Cancel',
                        btnClass: 'btn btn-primary',
                        action: function(){
                            
                        }
                    }
                }
            });
        }
    }
    function editOrderItemQty(facilityorderitemsid, qtyordered, genericname, facilityorderid, facilityorderno, destinationfacilityunit, isemergency, personname, dateneeded, dateprepared) {
        $.confirm({
            title: 'Edit Item Quantity',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Item Name</label>' +
                    '<input type="text" value="' + genericname + '" disabled="true" class="form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Quantity Ordered</label>' +
                    '<input type="text" value="' + qtyordered + '" class="itemqtyordered form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Save',
                    btnClass: 'btn-purple',
                    action: function () {
                        var qty = this.$content.find('.itemqtyordered').val();
                        if (!qty) {
                            $.alert('provide a valid Quantity');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {qty: qty, facilityorderitemsid: facilityorderitemsid},
                            url: "ordersmanagement/editexistingorderitem.htm",
                            success: function (data) {
                                ajaxSubmitData('ordersmanagement/verifyfacilityunitorders.htm', 'verifyorderitemsandsubdiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&destinationfacilityunit=' + destinationfacilityunit + '&isemergency=' + isemergency + '&personname=' + personname + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&nbs=8&dtf=', 'GET');
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function submitOrderItemsForApproval(facilityorderid){
        $.ajax({
            type: 'POST',
            data: {type: 'submit', facilityorderid: facilityorderid},
            url: "ordersmanagement/submitosavepausefacilityuntord.htm",
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
                                    ajaxSubmitData('ordersmanagement/approveorconsolidateordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            },
                            close: function () {
                                ajaxSubmitData('ordersmanagement/approveorconsolidateordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        }
                    });
                } else if (data === 'nothing') {
                    $.confirm({
                        title: 'Approve!',
                        content: 'Approve Items To Submit Order !!!',
                        type: 'red',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Ok',
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
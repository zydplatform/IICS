<%-- 
    Document   : approveOderItems
    Created on : Sep 1, 2018, 11:15:01 PM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="approvingFacilityOrdersSpno">
    <input type="hidden" value="${approved}" id="internalorderitemsapprovedId">
    <input type="hidden" value="${unapproved}" id="internalorderitemsunapprovedId">
    <fieldset style="min-height:100px;">
        <table class="table table-hover table-bordered" id="approveFacilityOrderItem">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Item Name</th>
                    <th>Quantity Ordered</th>
                    <th>Quantity Approved</th>
                    <th>Current Stock</th>
                    <th>Update</th>
                    <th>Approved</th>
                </tr>
            </thead>
            <tbody>
                <% int i = 1;%>
                <c:forEach items="${facilityorderitemsList}" var="a">
                    <tr>
                        <td align="center"><%=i++%></td>
                        <td>${a.itemname}</td>
                        <td>${a.qtyonorder}</td>
                        <td>${a.qtyapprove}</td>
                        <td>${a.stockbalance}</td>
                        <td align="center">
                            <span onclick="editOrderItemQuantity(${a.facilityorderitemsid},${a.qtyordered}, '${a.itemname}',${facilityorderid},${a.approved});" title="Edit Of This Item."  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                        </td>
                        <td align="center">
                            <div class="toggle-flip">
                                <label>
                                    <input id="apprdItm${a.facilityorderitemsid}" value="2" <c:if test="${a.approved==true}">checked="true"</c:if> type="checkbox" onchange="if (this.checked) {
                                                approveFacilityOrderItm(${a.facilityorderitemsid}, 'checked',${facilityorderid});
                                                this.value = 1;
                                            } else {
                                                approveFacilityOrderItm(${a.facilityorderitemsid}, 'unchecked',${facilityorderid});
                                                this.value = 2;
                                            }
                                           "><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                                </label>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table> <br>
        <div class="row">
            <div class="col-md-12 right">
                <button type="button" class="btn btn-secondary" onclick="printapprovedorderitemspno(${facilityorderid});">
                    <i class="fa fa-print"></i>  Print
                </button>
            </div>
        </div> 
    </fieldset> 
</div>
<script>
    var unapprovedItems =${size};
    var apprItems2 =${approved};
    if (unapprovedItems === apprItems2) {
        $.confirm({
            title: 'Approving Order Items',
            content: 'All Items On Order Have Been Approved, Can Now Be Submitted Fo Servicing.',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                ok: function () {

                }
            }
        });
    }
    $('#approveFacilityOrderItem').DataTable();
    function approveFacilityOrderItm(facilityorderitemsid, type, facilityorderid) {
        if (type === 'checked') {
            $.ajax({
                type: 'POST',
                data: {facilityorderitemsid, type: 'approved'},
                url: "approvefacilityorders/approvedfalityorderitem.htm",
                success: function (data) {
                    ajaxSubmitData('approvefacilityorders/viewfacilityapproveorderitems.htm', 'approvingFacilityOrdersSpno', 'facilityorderid=' + facilityorderid, 'GET');
                }
            });
        } else {
            $.ajax({
                type: 'POST',
                data: {facilityorderitemsid, type: 'unapproved'},
                url: "approvefacilityorders/approvedfalityorderitem.htm",
                success: function (data, textStatus, jqXHR) {
                    ajaxSubmitData('approvefacilityorders/viewfacilityapproveorderitems.htm', 'approvingFacilityOrdersSpno', 'facilityorderid=' + facilityorderid, 'GET');
                }
            });
        }
    }
    function editOrderItemQuantity(facilityorderitemsid, quantityordered, itemname, facilityorderid, approved) {
        if (approved === false) {
            $.confirm({
                title: 'EDIT ITEM QTY',
                type: 'purple',
                typeAnimated: true,
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group">' +
                        '<label>Item</label>' +
                        '<input type="text" value="' + itemname + '" disabled="true" class="form-control" required />' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label>Quantity</label>' +
                        '<input type="text" value="' + quantityordered + '" class="editteditemqty form-control" maxlength="7"  onkeypress="return isNumberKey2(event)" required />' +
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
                                success: function (data) {
                                    $.ajax({
                                        type: 'POST',
                                        data: {facilityorderitemsid, type: 'approved'},
                                        url: "approvefacilityorders/approvedfalityorderitem.htm",
                                        success: function (response) {
                                            ajaxSubmitData('approvefacilityorders/viewfacilityapproveorderitems.htm', 'approvingFacilityOrdersSpno', 'facilityorderid=' + facilityorderid, 'GET');
                                        }
                                    });
                                }
                            });
                        }
                    },
                    cancel: function () {

                    },
                }
            });
        } else {
            $.ajax({
                type: 'POST',
                data: {facilityorderitemsid, type: 'unapproved'},
                url: "approvefacilityorders/approvedfalityorderitem.htm",
                success: function (res) {
                    $('#apprdItm' + facilityorderitemsid).prop('checked', false);

                    $.confirm({
                        title: 'EDIT ITEM QTY',
                        type: 'purple',
                        typeAnimated: true,
                        content: '' +
                                '<form action="" class="formName">' +
                                '<div class="form-group">' +
                                '<label>Item</label>' +
                                '<input type="text" value="' + itemname + '" disabled="true" class="form-control" required />' +
                                '</div>' +
                                '<div class="form-group">' +
                                '<label>Quantity</label>' +
                                '<input type="text" value="' + quantityordered + '" class="editteditemqty form-control" maxlength="7"  onkeypress="return isNumberKey2(event)" required />' +
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
                                        success: function (data) {
                                            $.ajax({
                                                type: 'POST',
                                                data: {facilityorderitemsid, type: 'approved'},
                                                url: "approvefacilityorders/approvedfalityorderitem.htm",
                                                success: function (response) {
                                                    ajaxSubmitData('approvefacilityorders/viewfacilityapproveorderitems.htm', 'approvingFacilityOrdersSpno', 'facilityorderid=' + facilityorderid, 'GET');
                                                }
                                            });
                                        }
                                    });
                                }
                            },
                            cancel: function () {
                                $.ajax({
                                    type: 'POST',
                                    data: {facilityorderitemsid, type: 'approved'},
                                    url: "approvefacilityorders/approvedfalityorderitem.htm",
                                    success: function (app) {
                                        ajaxSubmitData('approvefacilityorders/viewfacilityapproveorderitems.htm', 'approvingFacilityOrdersSpno', 'facilityorderid=' + facilityorderid, 'GET');
                                    }
                                });
                            }
                        }
                    });
                }
            });
        }

    }
    function printapprovedorderitemspno(facilityorderid) {
        $.ajax({
            type: 'POST',
            url: "approvefacilityorders/printapprovedorderitemspno.htm",
            data: {facilityorderid: facilityorderid},
            success: function (data, textStatus, jqXHR) {
                if (data === 'zero') {
                    $.confirm({
                        title: '<h3>Missing Items Approval</h3>',
                        content: '<h4 class="itemTitle">Order missing <strong>Approved Items</strong></h4>',
                        type: 'orange',
                        icon: 'fa fa-warning',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Print Anyway',
                                btnClass: 'btn-orange',
                                action: function () {
                                    $.confirm({
                                        icon: 'fa fa-warning',
                                        title: 'Print Order Items',
                                        content: '<div id="printordersBox" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
                                        type: 'purple',
                                        typeAnimated: true,
                                        boxWidth: '70%',
                                        useBootstrap: false,
                                        buttons: {
                                            close: {
                                                text: 'Close',
                                                action: function () {

                                                }
                                            }
                                        },
                                        onContentReady: function () {
                                            var printBox = this.$content.find('#printordersBox');
//                $.ajax({
//                    type: 'GET',
//                    data: {patientVisitsid: patientVisitsid, patientid: patientid, prescriptionid: prescriptionid},
//                    url: 'doctorconsultation/printPatientPrescription.htm',
//                    success: function (res) {
//                        if (res !== '') {
//                            var objbuilder = '';
//                            objbuilder += ('<object width="100%" height="500px" data="data:application/pdf;base64,');
//                            objbuilder += (res);
//                            objbuilder += ('" type="application/pdf" class="internal">');
//                            objbuilder += ('<embed src="data:application/pdf;base64,');
//                            objbuilder += (res);
//                            objbuilder += ('" type="application/pdf"/>');
//                            objbuilder += ('</object>');
//                            printBox.html(objbuilder);
//                        } else {
//                            printBox.html('<div class="bs-component">' +
//                                    '<div class="alert alert-dismissible alert-warning">' +
//                                    '<h4>Warning!</h4>' +
//                                    '<p>Error generating PDF. Please <strong>Refresh</strong> & Try Again.</p></div></div>'
//                                    );
//                        }
//                    }
//                });
                                        }
                                    });
                                }
                            },
                            close: {
                                text: 'Approve Items',
                                btnClass: 'btn-purple',
                                action: function () {

                                }
                            }
                        }
                    });
                } else {
                    $.confirm({
                        icon: 'fa fa-warning',
                        title: 'Print Order Items',
                        content: '<div id="printordersBox" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
                        type: 'purple',
                        typeAnimated: true,
                        boxWidth: '70%',
                        useBootstrap: false,
                        buttons: {
                            close: {
                                text: 'Close',
                                action: function () {

                                }
                            }
                        },
                        onContentReady: function () {
                            var printBox = this.$content.find('#printordersBox');
//                $.ajax({
//                    type: 'GET',
//                    data: {patientVisitsid: patientVisitsid, patientid: patientid, prescriptionid: prescriptionid},
//                    url: 'doctorconsultation/printPatientPrescription.htm',
//                    success: function (res) {
//                        if (res !== '') {
//                            var objbuilder = '';
//                            objbuilder += ('<object width="100%" height="500px" data="data:application/pdf;base64,');
//                            objbuilder += (res);
//                            objbuilder += ('" type="application/pdf" class="internal">');
//                            objbuilder += ('<embed src="data:application/pdf;base64,');
//                            objbuilder += (res);
//                            objbuilder += ('" type="application/pdf"/>');
//                            objbuilder += ('</object>');
//                            printBox.html(objbuilder);
//                        } else {
//                            printBox.html('<div class="bs-component">' +
//                                    '<div class="alert alert-dismissible alert-warning">' +
//                                    '<h4>Warning!</h4>' +
//                                    '<p>Error generating PDF. Please <strong>Refresh</strong> & Try Again.</p></div></div>'
//                                    );
//                        }
//                    }
//                });
                        }
                    });
                }
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
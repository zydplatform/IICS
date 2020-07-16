<%-- 
    Document   : approvePrescriptionItems
    Created on : Apr 12, 2019, 9:44:38 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp" %>
<style>
    .out-of-stock {
        color: #FF0000;
    }
</style>
<c:if test="${prescriptionItems.size() > 0}">
<div class="card">
    <header class="card-header">
        <a href="#" data-toggle="collapse" data-target="#approve-collapse" aria-expanded="true" class="">
            <i class="icon-action fa fa-chevron-down"></i>
            <span class="title badge badge-patientinfo patientConfirmFont">${name}  [ <strong> AGE:${estimatedage}</strong> ]</span>
        </a>
    </header>
    <div class="collapse colapse" id="approve-collapse" style="">
        <article class="card-body">
            <fieldset>
                <table class="col-md-12">
                    <tbody>
                        <tr class="row">
                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Patient No:</label>
                                    <input class="form-control form-control-sm" value="${patientno}" type="text" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Visit No:</label>
                                    <input class="form-control form-control-sm col-md-12" type="text" id="newpatientvisitnumber" value="${visitnumber}" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm">Gender:</label>
                                    <input class="form-control form-control-sm" value="${gender}" name="" disabled="">
                                </div>
                            </td>
                            
                            <td class="col-md-2">
                                <div class="form-group">
                                    <!--
                                    <label class="col-form-label col-form-label-sm" for="">Weight:</label>
                                    <input class="form-control form-control-sm" value="${weight}" type="text" disabled="">
                                    -->
                                    <label class="col-form-label col-form-label-sm" for="">BMI <strong>(kg/m<sup>2</sup>):</strong></label>
                                    <input class="form-control form-control-sm" value="${patientBMI}" type="text" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">TEL:</label>
                                    <input class="form-control form-control-sm" value="${telephone}" type="text" name="" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="">Current Address:</label>
                                    <input class="form-control form-control-sm" value="${village}" type="text" disabled="">
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="row" <c:if test="${observations == null || observations.size() == 0}">style="display: none;"</c:if>>
                    <div class="col-md-12">
                        <hr />
                            <h6>Observations/Diagnosis</h6>
                        <hr />
                    </div>
                    <div class="col-md-4">                        
                        <c:forEach items="${observations}" var="observation">
                            <span class="form-control disabled">${observation}</span>
                        </c:forEach>
                    </div>
                </div>
                <br />
            </fieldset>
        </article>
    </div>
</div>
</c:if>
<div class="row">
    <c:if test="${prescriptionItems.size() > 0}">
    <div class="col-sm-12 col-md-12" style="overflow: auto; margin-top: 1%;">
        <table class="table table-hover table-bordered " id="approvePrescriptionTable">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Item Name</th>
                    <th>Dosage</th>
                    <th>QTY In Stock</th>
                    <th>QTY Booked</th>
                    <th>Qty Available</th>
                    <th>To Pick</th>
                    <th class="center">Approve</th>
                </tr>
            </thead>
            <tbody>
                <% int x = 1;%>
                <c:forEach items="${prescriptionItems}" var="item">
                    <tr <c:if test="${item.outofstock == true}">class="out-of-stock"</c:if>>
                        <td><%=x++%></td>
                        <td>${item.itemname}</td>
                        <td>${item.strength}</td>
                        <td>${item.qtyinstock}</td>
                        <td>${item.qtybooked}</td>                        
                        <td>${item.qtyavailable}</td>
                        <td>
                            ${item.qtytopick}
                            <input type="hidden" class="quantity-approved-to-issue" name="quantityApprovedToIssue${item.itemid}" value="${item.qtytopick}"/>
                        </td>
                        <td class="center">                            
                            <div class="toggle-flip">
                                <label>
                                    <input id="itemcheckbox${item.itemid}" class="form-check-input approve-item" 
                                           type="checkbox" name="prescriptioncheckboxname" value="2" 
                                           data-prescription-id="${item.prescriptionid}"
                                           data-prescriptionitemid="${item.prescriptionitemsid}" 
                                           data-itemid="${item.itemid}" data-item-package-id="${item.itempackageid}" 
                                           data-quantity-approved="${item.qtytopick}"
                                           <c:if test="${item.isapproved == Boolean.TRUE}">checked="checked"</c:if>
                                           <c:if test="${item.outofstock == true}">disabled="true"</c:if> />
                                           <span class="flip-indecator text-black" style="height: 10px !important; margin-top: -13px !important;"  
                                                 data-toggle-on="Yes" data-toggle-off="No"></span>
                                    </label>
                                </div>
                            </td>
                        </tr>
                </c:forEach>
            </tbody>
            <tfoot></tfoot>
        </table>
    </div>
    </c:if>
    <c:if test="${prescriptionItems.size() <= 0}">
        <div class="col-md-12 center">
            <h3>No Items To Approve.</h3>
        </div>
    </div>
    </c:if>
</div>
<br /> 
<c:if test="${prescriptionItems.size() > 0}">
    <div class="col-md-12 right" style="font-size: 110%;">
        <a href="#" id="prescriber-details-btn2">
            <span class="text-bold-500">
                <i class="">Prescribed By: </i>
                <span class="badge badge-patientinfo">${prescriber}</span>
            </span>
        </a>
    </div>
    <div class="row">        
        <div class="col-md-12 clearfix"><hr/>
            <button id="btnSaveApprovedPrescriptions" class="btn btn-primary pull-right text-white" type="button"  style="margin-left: 0.91%"
                    data-patient-visit-id="${patientvisitid}"
                    data-prescription-id="${prescriptionid}" data-staff-id="${staffid}" 
                    data-facility-unit-id="${facilityunitid}"
                    data-all-out-of-stock="${outOfStockCount == prescriptionItems.size()}"
                    <c:if test="${prescriptionItems.size() <= 0}">disabled="disabled"</c:if>>
                <c:if test="${outOfStockCount == prescriptionItems.size()}">Close</c:if>
                <c:if test="${outOfStockCount != prescriptionItems.size()}">
                    <i class="fa fa-floppy-o"></i> Approve
                </c:if>
            </button>
            <button id="print-prescription-approve" class="btn btn-primary pull-right text-white" 
                style="margin-left: 0.91%" data-patient-visit-id="${patientvisitid}"
                data-prescription-id="${prescriptionid}" data-origin-unit-id="${originunitid}"
                data-prescriber-id="${prescriberid}"><i class="fa fa-print"></i> Print</button>
            <button id="add-to-queue-from-approval" class="btn btn-warning pull-right text-white" 
                style="margin-left: 0.91%" data-patient-visit-id="${patientvisitid}"
                data-prescription-id="${prescriptionid}" data-origin-unit-id="${originunitid}"
                data-prescriber-id="${prescriberid}">Return To Queue</button>
        </div>
    </div>
</c:if>
<div class="modal fade" id="staff-details-modal2" tabindex="-1" role="dialog" aria-labelledby="staff-details-modal2" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staff-details-modal-title">Prescriber Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="prescriber-details-2" style="width:auto; padding: 1%;">

                </div>
            </div>
        </div>
    </div>
</div>

<div class="">
    <div id="picklistitems" class="modalOrderitemsdialog">
        <div class="">
            <div id="head">
                <h3 class="modal-title" id="title"><font color="purple"></font></h3>
                <a href="#close" title="Close" class="close2">X</a>
                <hr>
            </div>
            <div class="scrollbar row" id="content">

            </div>
        </div>
    </div>
</div>                                        
<script>
    var qtyapprovedtoissueList = [];
    var tableNumberItems = ${patientPrescriptionListsize};
    var patientprescriptionid = ${prescriptionid};
    var patientvisitid = ${patientvisitid};
    var originunitid = ${originunitid};
    var prescriberid = ${prescriberid};
    var unitId = ${facilityunitid};
    var approvedPrescriptionItemsCount = ${approvedprescriptionitemscount};
    var noAvailableItems = ${outOfStockCount == prescriptionItems.size()};
    $(function () {
        toggleApproveButton();
        breadCrumb();
        if (!$.fn.DataTable.isDataTable('#approvePrescriptionTable')) {
            var table = $('#approvePrescriptionTable').DataTable({
                "lengthMenu": [5, 10, 25, 50, 100],
                "pageLength": 5
            });
            table.on('order.dt search.dt', function () {
                table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                    cell.innerHTML = i + 1;
                });
            }).draw();
        }
        $('#btnSaveApprovedPrescriptions').click(function (e) {
            $('#btnSaveApprovedPrescriptions').prop('disabled', true);
            var caller = $(this);
            var prescriptionId = caller.data('prescription-id');
            var patientVisitId = caller.data('patient-visit-id');
            var staffId = caller.data('staff-id');
            var facilityUnitId = caller.data('facility-unit-id');
            var allOutOfOstock = $(this).data('all-out-of-stock');
            if(allOutOfOstock === true){
                recordUnservicedPrescription(prescriptionId);
                serviceprescription(patientVisitId);
                closePoppedPrescription({ prescriptionid: prescriptionId });
            } else {
                $.ajax({
                type: 'GET',
                data: { patientprescriptionid: patientprescriptionid, qtyapprovedtoissueList: JSON.stringify(qtyapprovedtoissueList) },
                url: 'dispensing/submitApprovedPrescriptions.htm',
                success: function (data) {
                    var items = JSON.parse(data);
                    var result = items.result;
                    if (result.toString().toLowerCase() === "success".toLowerCase()) {
//                        ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        pushPrescription('dispensing/pushprescription.htm', { patientvisitid: patientVisitId, prescriptionid: prescriptionId, staffid: staffId, facilityunitid: facilityUnitId, queuestage: 'picking' });
                    } else {
                        $('#btnSaveApprovedPrescriptions').prop("disabled", false);
                        $.toast({
                            heading: 'Error',
                            text: 'Operation Failed. Please Try Again',
                            icon: 'error',
                            hideAfter: 2000,
                            position: 'mid-center'
                        });
                    }
                }
            });
            }
//            $.ajax({
//                type: 'GET',
//                data: {patientprescriptionid: patientprescriptionid, qtyapprovedtoissueList: JSON.stringify(qtyapprovedtoissueList)},
//                url: 'dispensing/submitApprovedPrescriptions.htm',
//                success: function (data) {
//                    var items = JSON.parse(data);
//                    var result = items.result;
//                    if (result.toString().toLowerCase() === "success".toLowerCase()) {
////                        ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                        pushPrescription('dispensing/pushprescription.htm', { patientvisitid: patientVisitId, prescriptionid: prescriptionId, staffid: staffId, facilityunitid: facilityUnitId, queuestage: 'picking' });
//                    } else {
//                        $('#btnSaveApprovedPrescriptions').prop("disabled", false);
//                        $.toast({
//                            heading: 'Error',
//                            text: 'Operation Failed. Please Try Again',
//                            icon: 'error',
//                            hideAfter: 2000,
//                            position: 'mid-center'
//                        });
//                    }
//                }
//            });
        });
    });
    $('.approve-item').on('change', function (e) {
        var prescriptionItemsId = $(this).data('prescriptionitemid');
        var itemPackageId = $(this).data('item-package-id');
        var quantityApproved = $(this).data('quantity-approved');
        if (e.currentTarget.checked === true) {
            $.ajax({
                type: 'POST',
                url: 'dispensing/approveprescriptionitem.htm',
                data: {
                    prescriptionitemid: prescriptionItemsId,
                    itempackageid: itemPackageId,
                    quantityapproved: quantityApproved
                },
                success: function (data, textStatus, jqXHR) {
                    console.log(data);
                    approvedPrescriptionItemsCount += 1;
                    toggleApproveButton();
                },
                error: function (jqXHR, textStatus, errorThrown) {                    
                    console.log(jqXHR);
                }
            });
        } else {
            $.ajax({
                type: 'POST',
                url: 'dispensing/unapproveprescriptionitem.htm',
                data: {
                    prescriptionitemid: prescriptionItemsId,
                    itempackageid: itemPackageId
                },
                success: function (data, textStatus, jqXHR) {
                    console.log(data);
                    approvedPrescriptionItemsCount -= 1;
                    toggleApproveButton();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR);
                }
            });
        }
    });
    function functionManagePrescriptionItem(itemid, prescriptionitemsid) {
        var checkBox = document.getElementById("itemcheckbox" + itemid);
        if (checkBox.checked === true) {
            $('#itemcheckbox' + itemid).prop('checked', false);
            $.ajax({
                type: 'GET',
                data: {itemid: itemid, prescriptionitemsid: prescriptionitemsid},
                url: 'dispensing/managePrescribedDrug.htm',
                success: function (report) {
                    $.confirm({
                        title: 'Approve Drugs',
                        content: '' + report,
                        type: 'purple',
                        boxWidth: '90%',
                        useBootstrap: false,
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Submit',
                                btnClass: 'btn-purple',
                                action: function () {

                                }
                            },
                            close: function () {
                                $('#itemcheckbox' + itemid).prop('checked', false);
                            }
                        }
                    });
                }
            });
        } else {
            $('#quantityApprovedToIssue' + itemid).text('NOT SET');
        }
    }
    function functionvalidatedenteredqtys(itemPackageId, itemid) {
        var approvdqty2 = parseInt($('#approveInputfield' + itemPackageId).val());
        if (!$("input[name='packageitemsoptions']:checked").val()) {
            $('#itemcheckbox' + itemid).prop('checked', false);
            $('#errorwronginput' + itemPackageId).hide();
            $('#erroremptyfield' + itemPackageId).show();
            return false;
        } else {
            var itemPackageId = $("input[name='packageitemsoptions']:checked").val();
            var approveInput = $('#approveInputfield' + itemPackageId).val();
            $('#approveInputfield' + itemPackageId).css({"border": '2px solid #ced4da'});
            $('#erroremptyfield' + itemPackageId).hide();

            if (approveInput === null || approveInput === '' || typeof approveInput === 'undefined') {
                $('#itemcheckbox' + itemid).prop('checked', false);
                $('#approveInputfield' + itemPackageId).css({"border": '2px solid #ba0713'});
                $('#errorwronginput' + itemPackageId).hide();
                $('#erroremptyfield' + itemPackageId).show();
                $('#shelvedstock' + itemPackageId).css("color", "black");
                return false;
            } else {
                $('#erroremptyfield' + itemPackageId).hide();
                var shelvedstock = $('#shelvedstockvalue' + itemPackageId).val();
                $('#approveInputfield' + itemPackageId).css({"border": '2px solid #ced4da'});
                if (parseInt($('#approveInputfield' + itemPackageId).val()) > shelvedstock) {
                    $('#erroremptyfield' + itemPackageId).hide();

                    //reduce shelved stock
                    $('#shelvedstock' + itemPackageId).text((shelvedstock - approvdqty2).toLocaleString());
                    $('#shelvedstock' + itemPackageId).css("color", "red");
                    $('#errorwronginput' + itemPackageId).show();
                    $('#itemcheckbox' + itemid).prop('checked', false);
                    return false;
                } else {
                    $('#shelvedstock' + itemPackageId).text((shelvedstock - approvdqty2).toLocaleString());
                    $('#shelvedstock' + itemPackageId).css("color", "blue");
                    $('#quantityApprovedToIssue' + itemid).text($('#approveInputfield' + itemPackageId).val());
                    $('#itemcheckbox' + itemid).prop('checked', true);
                    $('#itemcheckbox' + itemid).val($("input[name='packageitemsoptions']:checked").val());
                }
            }
        }
    }
    $('#prescriber-details-btn2').on('click', function (e) {
        e.preventDefault();
        e.stopPropagation();
        $('#prescriber-details-2').html('');
        ajaxSubmitData('dispensing/prescriberdetails.htm', 'prescriber-details-2', 'originunitid=' + originunitid + '&prescriberid=' + prescriberid, 'GET');
        $('#staff-details-modal2').modal('show');
    });
    $('#add-to-queue-from-approval').on('click', function(){
        var prescriptionId = $(this).data('prescription-id');
        addBackToQueue(prescriptionId, 'approval');
    });
    $('#print-prescription-approve').on('click', function (e) {
        var button = $(this);
        button.prop('disabled', true);
        var prescriptionid = $(this).data('prescription-id');
        var prescriberid = $(this).data('prescriber-id');
        var patientVisitId = $(this).data('patient-visit-id');
        $.confirm({
            title: 'Print',
            type: 'purple',
            typeAnimated: true,
            boxWidth: '30%',
            closeIcon: true,
            useBootstrap: false,
            content: '<select id="prescription-print-type" class="form-control">' +
                    '<option value="outofstock">Out Of Stock Items</option>' +
                    '<option value="all">All Items</option>' +
                    +'</select>',
            buttons: {
                ok: {
                    text: 'Ok',
                    btnClass: 'btn btn-purple',
                    action: function () {
                        var selectElemet = this.$content.find('#prescription-print-type');
                        printPrescription(selectElemet.val(), prescriptionid, prescriberid, patientVisitId);
                    }
                }
            }
        });
        button.prop('disabled', false);
    });
    function toggleApproveButton(){
        var approveButton = $('#btnSaveApprovedPrescriptions');
        if(approvedPrescriptionItemsCount <= 0 && noAvailableItems === false){
            approveButton.prop('disabled', true);
        } else {
            approveButton.prop('disabled', false);
        }
    }
</script>

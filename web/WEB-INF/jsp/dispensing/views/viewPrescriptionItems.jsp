<%-- 
    Document   : viewPrescriptionItems
    Created on : Apr 12, 2019, 10:02:43 AM
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

<c:if test="${patientPrescriptionList.size() > 0}">
<div class="card">
    <header class="card-header">
        <a href="#" data-toggle="collapse" data-target="#view-collapse" aria-expanded="true" class="">
            <i class="icon-action fa fa-chevron-down"></i>
            <span class="title badge badge-patientinfo patientConfirmFont">${name}  [ <strong> AGE:${estimatedage}</strong> ]</span>
        </a>
    </header>
    <div class="collapse colapse" id="view-collapse" style="">
        <article class="card-body">
            <fieldset>
                <table class="col-md-12">
                    <tbody>
                        <tr class="row">
                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="patientno">Patient No:</label>
                                    <input class="form-control form-control-sm" value="${patientno}" type="text" disabled="disabled" name="patientno" id="patientno" />
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="newpatientvisitnumber">Visit No:</label>
                                    <input class="form-control form-control-sm col-md-12" type="text" id="newpatientvisitnumber" value="${visitnumber}" disabled="disabled" name="newpatientvisitnumber" />
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="gender">Gender:</label>
                                    <input class="form-control form-control-sm" value="${gender}" name="gender" id="gender" disabled="disabled">
                                </div>
                            </td>
                            
                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="bmi">BMI <strong>(kg/m<sup>2</sup>):</strong></label>
                                    <input class="form-control form-control-sm" value="${patientBMI}" type="text" id="bmi" name="bmi" disabled="disabled">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="tel">TEL:</label>
                                    <input class="form-control form-control-sm" value="${telephone}" type="text" name="tel" id="tel" disabled="">
                                </div>
                            </td>

                            <td class="col-md-2">
                                <div class="form-group">
                                    <label class="col-form-label col-form-label-sm" for="village">Current Address:</label>
                                    <input class="form-control form-control-sm" value="${village}" type="text" disabled="disabled" id="village" name="village">
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

<div class="row">    
        <div class="col-sm-12 col-md-12" style="overflow: auto; margin-top: 1%;">  
            <input type="hidden" name="_patientvisitid" value="${patientvisitid}" />
            <table class="table table-hover table-bordered " id="tableRegisteredPatients">
                <thead>
                    <tr>
                        <th style="width:4%;">No</th>
                        <th>Item Name</th>
                        <th style="width:6%;">Dosage</th>
                        <th title="Alternate Dosage" width="8%;">Alt Dosage</th>
                        <th style="width:12%;">Frequency</th>
                        <th>Duration</th>
                        <th>Comment</th>
                        <th class="center">Modify</th>
                    </tr>
                </thead>
                <tbody>
                    <% int x = 1;%>
                    <c:forEach items="${patientPrescriptionList}" var="des">
                        <tr>
                            <td><%=x++%></td>
                            <td>                            
                                <span class="span-prev-item-name" <c:if test="${des.isAvailable == Boolean.FALSE && des.isoutofstock == Boolean.FALSE}">style="color:#4169E1;"</c:if>>${des.genericname}</span>
                                </td>
                                <td>
                                    <span class="span-prev-dose">${des.dose}</span>
                            </td>
                            <td class="center">
                                <c:if test="${des.isAvailable == Boolean.FALSE && des.isoutofstock == Boolean.FALSE}">
                                    <button class="btn btn-primary btn-sm alt-dose-btn"  title="Alternate Dosage" 
                                            data-item-id="${des.genericname}" data-item-name="${des.genericname}" 
                                            data-current-dosage="${des.dose}" data-presccription-items-id="${des.prescriptionitemsid}">
                                        <i class="fa fa-dedent"></i>
                                    </button>
                                </c:if>
                                <c:if test="${des.isAvailable == Boolean.TRUE}">
                                    <button class="btn btn-success btn-sm" title="Available">
                                        <i class="fa fa-check"></i>
                                    </button>
                                </c:if>
                                <c:if test="${des.isAvailable == Boolean.FALSE && des.isoutofstock == Boolean.TRUE}">
                                    <button class="btn btn-danger btn-sm" title="Out Of Stock">
                                        OS
                                    </button>
                                </c:if>
                            </td>
                            <td>
                                <span class="span-prev-dosage">${des.dosage}</span>                            
                            </td>
                            <td>
                                <span class="span-prev-days">${des.days} ${des.daysname}</span>
                            </td>
                            <td>
                                <span class="span-comment">${des.reason}</span>
                            </td>
                            <td class="center" >
                                <div class="toggle-flip">
                                    <label>
                                        <input class="item-toggle modify-item" value="2" type="checkbox" 
                                               data-prescription-id="${prescriptionid}" data-generic-name="${des.genericname}"
                                               data-prescription-items-id="${des.prescriptionitemsid}" 
                                               data-patient-visit-id="${patientvisitid}">
                                        <span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                                    </label>
                                </div>
                            </td>                        
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
</div>
                    
<div class="row">                
    <div class="col-md-12 right" style="font-size: 110%; padding-top: 1%;">
        <a href="#" id="prescriber-details-btn" data-origin-unit-id="${originunitid}"
           data-prescriber-id="${prescriberid}">
            <span class="text-bold-500">
                <i class="">Prescriber: </i>
                <span class="badge badge-patientinfo">${prescriber}</span>
            </span>
        </a>
    </div>  
</div>
<div class="row">            
    <div class="col-md-12 clearfix"><hr/>  
        <button id="review-prescription" class="btn btn-success pull-right text-white" style="margin-left: 0.91%" 
                type="button" data-patient-visit-id="${patientvisitid}" data-all-out-of-stock="${outofstockcount == patientPrescriptionList.size()}"
                data-prescription-id="${prescriptionid}" data-staff-id="${staffid}" 
                data-facility-unit-id="${facilityunitid}"
                data-available-count="${availablecount}"
                data-alternate-count="${alternatecount}"><i class="fa fa-floppy-o"></i> 
                <c:if test="${outofstockcount != patientPrescriptionList.size()}">Proceed</c:if>
                <c:if test="${outofstockcount == patientPrescriptionList.size()}">Close</c:if>
                </button>
        <button id="print-prescription" class="btn btn-primary pull-right text-white" 
                style="margin-left: 0.91%" data-patient-visit-id="${patientvisitid}"
                data-prescription-id="${prescriptionid}" data-origin-unit-id="${originunitid}"
                data-prescriber-id="${prescriberid}"><i class="fa fa-print"></i> Print</button>
        <button id="add-to-queue-from-review" class="btn btn-warning pull-right text-white" 
                style="margin-left: 0.91%" data-patient-visit-id="${patientvisitid}"
                data-prescription-id="${prescriptionid}" data-origin-unit-id="${originunitid}"
                data-prescriber-id="${prescriberid}">Return To Queue</button>
    </div>
</div>  
</c:if>
<c:if test="${patientPrescriptionList.size() <= 0 || patientPrescriptionList == null}">
    <div class="row">
        <div class="col-md-12 center">
            <h3>No Items To Review.</h3>
        </div>
    </div>
</c:if>    
<div class="modal fade" id="staff-details-modal" tabindex="-1" role="dialog" aria-labelledby="staff-details-modal" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staff-details-modal-title">Prescriber Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="prescriber-details-1" style="width:auto; padding: 1%;">

                </div>
            </div>
        </div>
    </div>
</div>


<script>
    $(document).ready(function () {
        breadCrumb(); 
        if (!$.fn.DataTable.isDataTable('#tableRegisteredPatients')) {
            var table = $('#tableRegisteredPatients').DataTable({
                "lengthMenu": [5, 10, 25, 50, 100],
                "pageLength": 5
            });
            table.on('order.dt search.dt', function () {
                table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                    cell.innerHTML = i + 1;
                });
            }).draw();
        }
    });
    $('input.item-toggle').on('change', function (e) {
        modifyPrescriptionItem($(this));
    });
    $('button#review-prescription').on('click', function () {
        reviewPrescription($(this));
    });
    $('.alt-dose-btn').on('click', function (e) {
        console.log($(this).data("item-id"));
        console.log($(this).data("item-name"));
        var itemId = $(this).data("item-id");
        var itemName = $(this).data("item-name");
        var currentDosage = $(this).data("current-dosage");
        var prescriptionItemsId = $(this).data('presccription-items-id');
        var data = {itemid: itemId, itemname: itemName, currentdosage: currentDosage, prescriptionitemsid: prescriptionItemsId};
        $.ajax({
            type: 'GET',
            data: data,
            url: 'dispensing/getaltdosages.htm',
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    icon: '',
                    title: 'Alternate Dosages',
                    content: '' + data,
                    boxWidth: '70%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    buttons: {
                        OK: {
                            text: 'OK',
                            btnClass: 'btn-purple',
                            action: function () {

                            }
                        }
                    }
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {

            }
        });
    });
    $('#prescriber-details-btn').on('click', function (e) {
        var originunitid = $(this).data('origin-unit-id');
        var prescriberid = $(this).data('prescriber-id');
        e.preventDefault();
        e.stopPropagation();
        $('#prescriber-details-1').html('');
        ajaxSubmitData('dispensing/prescriberdetails.htm', 'prescriber-details-1', 'originunitid=' + originunitid + '&prescriberid=' + prescriberid, 'GET');
        $('#staff-details-modal').modal('show');
    });
    $('#print-prescription').on('click', function (e) {
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
    function modifyPrescriptionItem(caller) {
        var prescriptionId = caller.data('prescription-id');
        var prescriptionItemsId = caller.data('prescription-items-id');
        var patientVisitId = caller.data('patient-visit-id');
        $.ajax({
            type: 'GET',
            url: 'dispensing/modifyprescriptionitemform.htm',
            data: {prescriptionid: prescriptionId.toString(), prescriptionitemsid: prescriptionItemsId.toString()},
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    icon: '',
                    title: 'MODIFY PRESCRIPTION',
                    content: data,
                    type: 'purple',
                    typeAnimated: true,
                    boxWidth: '30%',
                    useBootstrap: false,
                    onContentReady: function () {
                        this.$content.find('#item-name').select2({dropdownParent: $('#prescription-item-container')});
                        this.$content.find('#dosage').select2({dropdownParent: $('#prescription-item-container')});
                    },
                    buttons: {
                        save: {
                            text: 'Save',
                            btnClass: 'btn btn-success',
                            action: function () {
                                var itemName = this.$content.find("#item-name").val().trim();
                                var dose = this.$content.find('#dose').val().trim();
                                var dosage = this.$content.find('#dosage').val().trim();
                                var days = this.$content.find('#days').val().trim();
                                var daysName = this.$content.find('#daysname').text().trim();
                                var reason = this.$content.find('#reason').val().trim();

                                if (itemName === '') {
                                    this.$content.find("#item-name").css('border-color', '#ff0000');
                                    return false;
                                }
                                if (dose === '') {
                                    this.$content.find('#dose').css('border-color', '#ff0000');
                                    return false;
                                }
                                if (dosage === '') {
                                    this.$content.find('#dosage').css('border-color', '#ff0000');
                                    return false;
                                }
                                if (days === '') {
                                    this.$content.find('#days').css('border-color', '#ff0000');
                                    return false;
                                }
                                if (daysName === '') {
                                    this.$content.find('#daysname').css('border-color', '#ff0000');
                                    return false;
                                }
                                if (reason === '') {
                                    this.$content.find('#reason').css('border-color', '#ff0000');
                                    return false;
                                }
                                this.buttons.save.disable();
                                data = {
                                    prescriptionid: prescriptionId,
                                    prescriptionitemsid: prescriptionItemsId,
                                    itemname: itemName,
                                    dose: dose,
                                    dosage: dosage,
                                    days: days,
                                    daysname: daysName,
                                    reason: reason
                                };
                                $.ajax({
                                    type: 'POST',
                                    url: 'dispensing/modifyprescriptionitem.htm',
                                    data: data,
                                    success: function (result, textStatus, jqXHR) {
                                        if (result.toString().toLowerCase() === 'success') {
                                            navigateTo('view-prescription-items', patientVisitId);
                                        } else {
                                            $.toast({
                                                heading: 'Error',
                                                text: 'Operation Failed. Please Try Again',
                                                icon: 'error',
                                                hideAfter: 2000,
                                                position: 'mid-center'
                                            });
                                        }
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        console.log(jqXHR);
                                        console.log(textStatus);
                                        console.log(errorThrown);
                                    }
                                });
                            }
                        },
                        cancel: {
                            text: 'Cancel',
                            btnClass: 'btn-purple',
                            action: function () {
                                caller.prop('checked', false);
                            }
                        }
                    }
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    }
    function reviewPrescription(caller) {
        var prescriptionId = caller.data('prescription-id');
        var patientVisitId = caller.data('patient-visit-id');
        var staffId = caller.data('staff-id');
        var facilityUnitId = caller.data('facility-unit-id');
        var availableCount = caller.data('available-count');
        var allOutOfStock = caller.data('all-out-of-stock');
        var alternateCount = caller.data("alternate-count");
        caller.prop('disabled', true);
        if(allOutOfStock === true){
            recordUnservicedPrescription(prescriptionId);
//            recordUnResolvedPrescriptions(prescriptionId, patientVisitId);
            serviceprescription(patientVisitId);
            closePoppedPrescription({ prescriptionid: prescriptionId });
//        } else if(alternateCount > 0){ 
//            $.confirm({
//            title: 'Warning',
//            type: 'purple',
//            typeAnimated: true,
//            boxWidth: '30%',
//            closeIcon: true,
//            useBootstrap: false,
//            content: 'One or more items have alternate dosage(s). Please select alternate dosage(s). If you do not, the item(s) will be deemed out of stock.',
//            buttons: {
//                OK: {
//                    text: 'Continue',
//                    btnClass: 'btn btn-purple',
//                    action: function () {
//                        $.ajax({
//                            type: 'GET',
//                            data: {prescriptionid: prescriptionId, patientvisitid:patientVisitId},
//                            url: 'dispensing/reviewprescription.htm',
//                            success: function (data) {
//                                var d = JSON.parse(data);
//                                var result = d.result;
//                                var hasApprovables = d.hasapprovables;
//                                if (result.toString().toLowerCase() === "success") {
//                                    $.toast({
//                                        heading: 'Success',
//                                        text: 'Operation Successful.',
//                                        icon: 'success',
//                                        hideAfter: 2000,
//                                        position: 'mid-center'
//                                    });   
//                                    if(availableCount > 0 || hasApprovables === true){
//                                        pushPrescription('dispensing/pushprescription.htm', { patientvisitid: patientVisitId, prescriptionid: prescriptionId, staffid: staffId, facilityunitid: facilityUnitId, queuestage: 'approval' });                    
//                                    }else {
////                                        recordUnservicedPrescription(prescriptionId);
//                                        serviceprescription(patientVisitId);
//                                        closePoppedPrescription({ prescriptionid: prescriptionId });                                        
//                                    }
//                                } else {
//                                    caller.prop("disabled", false);
//                                    $.toast({
//                                        heading: 'Error',
//                                        text: 'Operation Failed. Please Try Again',
//                                        icon: 'error',
//                                        hideAfter: 2000,
//                                        position: 'mid-center'
//                                    });
//                                }
//                            }
//                        });
//                    }
//                },
//                NO: {
//                    text: 'Cancel',
//                    btnClass: 'btn btn-warning',
//                    action: function(){
//                        caller.prop("disabled", false);
//                    }
//                }
//            }
//        });
        } else {
            $.ajax({
                type: 'GET',
                data: {prescriptionid: prescriptionId, patientvisitid: patientVisitId},
                url: 'dispensing/reviewprescription.htm',
                success: function (data) {
                    var d = JSON.parse(data);
                    var result = d.result;
                    var hasApprovables = d.hasapprovables;
                    if ((result.toString().toLowerCase() === "success" && hasApprovables === true)) {
                        $.toast({
                            heading: 'Success',
                            text: 'Operation Successful.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'mid-center'
                        }); 
                        pushPrescription('dispensing/pushprescription.htm', { patientvisitid: patientVisitId, prescriptionid: prescriptionId, staffid: staffId, facilityunitid: facilityUnitId, queuestage: 'approval' });
                    } else if((result.toString().toLowerCase() === "success" && hasApprovables === false)){
                        $.toast({
                            heading: 'Success',
                            text: 'Operation Successful.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'mid-center'
                        }); 
                        closePoppedPrescription({ prescriptionid: prescriptionId, isunresolved: true }, hasApprovables);
//                        unServicePrescription({ prescriptionid: prescriptionId });
//                        ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    } else {
                        caller.prop("disabled", false);
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
    }
    $('#add-to-queue-from-review').on('click', function(e){
        var patientVisitId = $(this).data('patient-visit-id');
        var prescriptionId = $(this).data('prescription-id');
        unPopPatient(patientVisitId);
        addBackToQueue(prescriptionId, 'review');
    });
</script>

<%-- 
    Document   : readyToIssueItems
    Created on : Apr 12, 2019, 9:57:39 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp"%>
<c:if test="${readyToIssueItems.size() > 0}">
<div class="card">
    <header class="card-header">
        <a href="#" data-toggle="collapse" data-target="#issue-collapse" aria-expanded="true" class="">
            <i class="icon-action fa fa-chevron-down"></i>
            <span class="title badge badge-patientinfo patientConfirmFont">${name}  [ <strong> AGE:${estimatedage}</strong> ]</span>
        </a>
    </header>
    <div class="collapse colapse" id="issue-collapse" style="">
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
<div class="row pt-3"> 
    <div class="col-md-1"></div>
    <div class="col-md-10">
        <c:if test="${readyToIssueItems.size() > 0}">
            <table class="table table-bordered" id="ready-to-issue-items-table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th style="width: 25%;">Item</th>
                        <th style="width: 20%;">Regimen</th>
                        <th style="width: 50%;">Special Instructions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${readyToIssueItems}" var="item">
                        <tr>
                            <td></td>
                            <td>${item.medicine}</td>
                            <td>${item.frequency} For ${item.duration}</td>
                            <td>${item.specialinstructions}</td>
                        </tr>
                    </c:forEach>                
                </tbody>
            </table>
        </c:if>
        <c:if test="${readyToIssueItems.size() <= 0}">
            <div class="center">
                <h3>No Items To Dispense.</h3>
            </div>
        </c:if>
        <c:if test="${readyToIssueItems.size() > 0}">
            <div class="tile-footer">
                <button class="btn btn-default btn-primary pull-right" id="issue-medicine-btn"  style="margin-left: 0.91%"
                        data-prescription-id="${prescriptionid}" data-facility-unit-id="${facilityunitid}" 
                        data-patient-visit-id="${patientvisitid}"
                        data-origin-unit-id="${originunitid}" data-reference-number="${referencenumber}"> <i class="fa fa-fw fa-lg fa-share"></i> Dispense </button>
                <button id="add-to-queue-from-dispensing" class="btn btn-warning pull-right text-white" 
                    style="margin-left: 0.91%" data-patient-visit-id="${patientvisitid}"
                    data-prescription-id="${prescriptionid}" data-origin-unit-id="${originunitid}"
                    data-prescriber-id="${prescriberid}">Return To Queue</button>
            </div>
        </c:if>
    </div>
</div>

<script>
    $(function () {
        if (!$.fn.DataTable.isDataTable('#ready-to-issue-items-table')) {
            var table = $('#ready-to-issue-items-table').DataTable({
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
    $('#issue-medicine-btn').on('click', function (e) {
        var button = e.currentTarget;
        button.disabled = true;
        var prescriptionId = $(this).data('prescription-id');
        var facilityUnitId = $(this).data('facility-unit-id');
        var patientVisitId = $(this).data('patient-visit-id');
        var originUnitId = $(this).data('origin-unit-id');
        var referenceNumber = $(this).data('reference-number');
        $.ajax({
            type: 'GET',
            data: {prescriptionid: prescriptionId, initialrequest: true, originunitid: originUnitId, referencenumber: referenceNumber},
            url: 'dispensing/issuereadyitems.htm',
            success: function (data) {
                var items = JSON.parse(data);
                var result = items.result;                
                if (result.toString().toLowerCase() === "success".toLowerCase()) {
                    serviceprescription(patientVisitId);
                    closePoppedPrescription({ prescriptionid: prescriptionId });
                    fetchCount({ facilityunitid: facilityUnitId, queuestage: 'serviced' }, '/app/prescriptioncount');
                } else if(result.toString().toLowerCase() === "failure".toLowerCase()) {
                    button.disabled = false;
                    $.toast({
                        heading: 'Error',
                        text: 'Operation Failed. Please Try Again',
                        icon: 'error',
                        hideAfter: 2000,
                        position: 'mid-center'
                    });
                } else {
                    button.disabled = false;
                    $.confirm({
                        title: '',
                        content: result.toString(),
                        boxWidth: '35%',
                        useBootstrap: false,
                        type: 'purple',
                        typeAnimated: true,
                        closeIcon: true,
                        theme: 'modern',
                        buttons:{
                            Yes:{
                            text: 'Yes',
                            btnClass: 'btn-red',
                            keys: ['enter', 'shift'],
                            action: function (){
                               $.ajax({
                                    type: 'GET',
                                    data: {prescriptionid: prescriptionId, initialrequest: false},
                                    url: 'dispensing/issuereadyitems.htm',
                                    success: function (data){
                                        serviceprescription(patientVisitId);
                                        closePoppedPrescription({ prescriptionid: prescriptionId });
                                        fetchCount({ facilityunitid: facilityUnitId, queuestage: 'serviced' }, '/app/prescriptioncount');
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        console.log(jqXHR);
                                        console.log(textStatus);
                                        console.log(errorThrown);
                                    }
                                });
                            } 
                        },
                        No:{
                            text: 'No',
                            btnClass: 'btn-purple',
                            keys: ['enter', 'shift'],
                            action: function (){                                    
                            }
                        }
                    }
                   });                    
                }
            }
        });
    });
    $('#add-to-queue-from-dispensing').on('click', function(){
        var prescriptionId = $(this).data('prescription-id');
        addBackToQueue(prescriptionId, 'despensing');
    });
</script>    


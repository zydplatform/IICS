<%-- 
    Document   : servicedPrescriptions
    Created on : Apr 12, 2019, 9:59:50 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp"%>
<style>
    a.patient-details {
        color: #007bff;
    }
</style>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-5 col-sm-6 text-right"  style="line-height: 2.50em;">                
                <label for="date-serviced">Date Serviced: </label>
            </div>
            <div class="col-md-2 col-sm-4">
                <form>
                    <div class="form-group">
                        <input class="form-control" id="date-serviced" name="date-serviced" type="text" placeholder="DD-MM-YYYY">
                    </div>
                </form>
            </div>
            <div class="col-md-2 col-sm-1">
                <button class="btn btn-primary" id="search-serviced-prescriptions" type="button" style="margin-top: auto; margin-bottom: auto;">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>    
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <table id="table-serviced-prescriptions" class="table table-bordered">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Prescription</th>
                            <th>Serviced Items</th>
                            <th>Not Issued Items</th>
                            <th>Serviced By</th>
                            <th>Date Received</th>
                            <th>Date Serviced</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${items}" var="item">
                            <tr>
                                <td></td>
                                <td>
                                    <a href="#" data-patient-visit-id="${item.patientvisitid}" data-patient-name="${item.patientname}" class="patient-details">${item.patientname}</a>
                                </td>
                                <td>
                                    <button class="btn btn-success btn-sm serviced-items" data-prescription-id="${item.prescriptionid}"  data-patient-name="${item.patientname}" <c:if test="${item.serviceditemsnumeric <= 0}">disabled="disabled"</c:if>>
                                        ${item.serviceditems}
                                    </button>                                    
                                </td>
                                <td>
                                    <button class="btn btn-danger btn-sm unserviced-items" data-prescription-id="${item.prescriptionid}"  data-patient-name="${item.patientname}" <c:if test="${item.notissueditemsnumeric <= 0}">disabled="disabled"</c:if>>
                                        ${item.notissueditems}
                                    </button>                                    
                                </td>
                                <td>
                                    ${item.servicedby}
                                </td>
                                <td>${item.datereceived}</td> 
                                <td>${item.dateserviced}</td>   
                                <td>
                                    <button class="btn btn-primary btn-sm text-white print-prescription-serviced"
                                            data-patient-visit-id="${item.patientvisitid}"
                                            data-prescription-id="${item.prescriptionid}" data-origin-unit-id="${item.originunitid}"
                                            data-prescriber-id="${item.prescriberid}"><i class="fa fa-print"></i> Print</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    var serverDate = '${serverdate}';
    $(function() {
        var dateissued = '${dateissued}';
        $('span.serviced-prescription-count').html(${items.size()});
        $("#date-serviced").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(dateissued)            
        });
        if (!$.fn.DataTable.isDataTable('#table-serviced-prescriptions')) {
            var table = $('#table-serviced-prescriptions').DataTable();
            table.on( 'order.dt search.dt', function () {
                table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
                   cell.innerHTML = i+1;
               } );
            } ).draw();
        }
    });
    $('#search-serviced-prescriptions').on('click', function(){
        var v = $('#date-serviced').val().split('-');
        var date = v[2] + '-' + v[1] + '-' + v[0];
        navigateTo('serviced-prescriptions', null, new Date(date));               
        $('#tab6').prop('checked', true);
        $('#content6').attr('display', 'block');
    });
    $('#table-serviced-prescriptions').on('click', 'button.serviced-items', function(e){
        var button = e.currentTarget;
        button.disabled = true;
        var prescriptionid = $(this).data('prescription-id');
        var patientName = $(this).data('patient-name');
        $.ajax({
            type: 'GET',
            data: { prescriptionid: prescriptionid },
            url: 'dispensing/servicedprescriptionitems.htm',
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    icon: '',
                    title: 'Serviced Items For <u sytle="color: #0000ff;">' + patientName + '</u>',
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
                                button.disabled = false;
                            }
                        }
                    }
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                button.disabled = false;
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    });
    $('#table-serviced-prescriptions').on('click', 'button.unserviced-items', function(e){
        var button = e.currentTarget;
        button.disabled = true;
        var prescriptionid = $(this).data('prescription-id');
        var patientName = $(this).data('patient-name');
        $.ajax({
            type: 'GET',
            data: { prescriptionid: prescriptionid },
            url: 'dispensing/unservicedprescriptionitems.htm',
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    icon: '',
                    title: 'Unserviced Items For <u sytle="color: #0000ff;">' + patientName + '</u>',
                    content: '' + data,
                    boxWidth: '65%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    buttons: {
                        OK: {
                            text: 'OK',
                            btnClass: 'btn-purple',
                            action: function () {
                                button.disabled = false;
                            }
                        }
                    }
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                button.disabled = false;
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    });
    $('#table-serviced-prescriptions').on('click', 'a.patient-details', function(e){
        e.preventDefault();
        e.stopPropagation();
        var patientVisitId = $(this).data('patient-visit-id');
        var patientName = $(this).data('patient-name');
        $.ajax({
            type: 'GET',
            url: 'dispensing/servicedpatientdetails',
            data: { patientvisitid: patientVisitId },
            success: function (data, textStatus, jqXHR) {
              $.confirm({
                icon: '',
                title: 'SERVICED PATIENT DETAILS',
                content: '' + data,
                boxWidth: '70%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                closeIcon: true,
                onContentReady: function() {
                    this.$content.find('.patient-name').text(patientName);
                      this.$content.find('#prescription-items-table').DataTable({
                          "lengthMenu": [5, 10, 25, 50, 100],
                          "pageLength": 5
                      });
                      this.$content.find('#prescription-items-table').on('order.dt search.dt', function () {
                          table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                              cell.innerHTML = i + 1;
                          });
                      }).draw();
                },
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
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    });
    $('.print-prescription-serviced').on('click', function (e) {
        var button = $(this);
        button.prop('disabled', true);
        var prescriptionid = $(this).data('prescription-id');
        var prescriberid = $(this).data('prescriber-id');
        var patientVisitId = $(this).data('patient-visit-id');
        printPrescription('all', prescriptionid, prescriberid, patientVisitId);
//        $.confirm({
//            title: 'Print',
//            type: 'purple',
//            typeAnimated: true,
//            boxWidth: '30%',
//            closeIcon: true,
//            useBootstrap: false,
//            content: '<select id="prescription-print-type" class="form-control">' +
//                    '<option value="outofstock">Out Of Stock Items</option>' +
//                    '<option value="all">All Items</option>' +
//                    +'</select>',
//            buttons: {
//                ok: {
//                    text: 'Ok',
//                    btnClass: 'btn btn-purple',
//                    action: function () {
//                        var selectElemet = this.$content.find('#prescription-print-type');
//                        printPrescription(selectElemet.val(), prescriptionid, prescriberid, patientVisitId);
//                    }
//                }
//            }
//        });
        button.prop('disabled', false);
    });
</script>

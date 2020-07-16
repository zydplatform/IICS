<%-- 
    Document   : patientPrescriptions
    Created on : Nov 2, 2018, 12:02:13 PM
    Author     : IICS
--%>

<%@include file="../../../../include.jsp" %>
<fieldset>
    <div class="row">
        <div class="col-md-4">
            <div class="form-group bs-component">
                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Prescribed By:</strong></span>&nbsp;
                <strong >
                    <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${addedby}</strong></span>
                </strong>
            </div> 
        </div>
        <div class="col-md-4">
            <div class="form-group bs-component">
                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Dispensing Unit:</strong></span>&nbsp;
                <strong >
                    <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${facilityunitname}</strong></span>
                </strong>
            </div>   
        </div>
        <div class="col-md-4">
            <div class="form-group bs-component">
                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Date:</strong></span>&nbsp;
                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${date}</strong></span>
            </div> 
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col-md-12">
            <div >
                <table class="table table-hover table-bordered" id="lbpatientPrescriptions">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Dug Name</th>
                            <th>Active Dose</th>
                            <th>Dosage</th>
                            <th>Duration</th>
                            <th>Comment</th>
                        </tr>
                    </thead>
                    <tbody >
                        <% int j = 1;%>
                        <c:forEach items="${prescriptionsFound}" var="a">
                            <tr>
                                <td><%=j++%></td>
                                <td>${a.fullname}</td>
                                <td>${a.dose}</td>
                                <td>${a.dosage}</td>
                                <td>${a.days} &nbsp; ${a.daysname}</td>
                                <td>${a.notes}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div> 
    </div>
    <div class="row">
        <div class="col-md-12">
            <button type="button"  id="closePatientBtn" onclick="closelabactivatepatientstab();" class="btn btn-danger pull-right">
                <i class="fa fa-print"></i> Close Patient
            </button>
            <button type="button" style="margin-right: 100px !important;"  onclick="printinglabPatientPrescriptions(${prescriptionid});" class="btn btn-secondary pull-right">
                <i class="fa fa-print"></i> Print
            </button>    
        </div>
    </div>  
</fieldset>
<script>
    $('#lbpatientPrescriptions').DataTable();
    $(function(){
        var patientvisitid = $('#facilitylabvisitPatientvisitid').val();
        $.ajax({
            type: 'GET',
            data: {patientvisitid: patientvisitid},
            url: "doctorconsultation/patientobservationcount.htm",
            success: function (data) {
                console.log('data: ' + data);
                if(parseInt(data) !== 0){
                    $('#closeOrUnPauseApatientid').show();
                    $('#closePatientBtn').show();
                    $('#pauseOrUnPauseApatientid').hide();
                }else {
                    $('#closeOrUnPauseApatientid').hide();
                    $('#closePatientBtn').hide(); 
                    $('#pauseOrUnPauseApatientid').show();
                }

            }
        });
    });
    function printinglabPatientPrescriptions(prescriptionids) {
        var patientVisitsid = $('#facilitylabvisitPatientvisitid').val();
        var patientid = $('#facilitylabvisitedPatientid').val();
        var prescriptionid = prescriptionids;
        if (prescriptionid !== '') {
            $.confirm({
                icon: 'fa fa-warning',
                title: 'Print Patient Prescriptions',
                content: '<div id="printlbPrescriptionsBox" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
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
                    var printBox = this.$content.find('#printlbPrescriptionsBox');
                    $.ajax({
                        type: 'GET',
                        data: {patientVisitsid: patientVisitsid, patientid: patientid, prescriptionid: prescriptionid},
                        url: 'doctorconsultation/printPatientPrescription.htm',
                        success: function (res) {
                            if (res !== '') {
                                var objbuilder = '';
                                objbuilder += ('<object width="100%" height="500px" data="data:application/pdf;base64,');
                                objbuilder += (res);
                                objbuilder += ('" type="application/pdf" class="internal">');
                                objbuilder += ('<embed src="data:application/pdf;base64,');
                                objbuilder += (res);
                                objbuilder += ('" type="application/pdf"/>');
                                objbuilder += ('</object>');
                                printBox.html(objbuilder);
                            } else {
                                printBox.html('<div class="bs-component">' +
                                        '<div class="alert alert-dismissible alert-warning">' +
                                        '<h4>Warning!</h4>' +
                                        '<p>Error generating PDF. Please <strong>Refresh</strong> & Try Again.</p></div></div>'
                                        );
                            }
                        }
                    });
                }
            });
        } else {
            $.confirm({
                title: 'PRINT PRESCRIPTION',
                content: 'First Submit Prescription Before Printing',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'ok',
                        btnClass: 'btn-purple',
                        action: function () {

                        }
                    },
                    close: function () {

                    }
                }
            });
        }
    }
    function closelabactivatepatientstab() {        
        var patientvisitid = $('#facilitylabvisitPatientvisitid').val();                                        
        $.ajax({
            type: 'POST',
            data: {patientvisitid: patientvisitid},
            url: "doctorconsultation/closelaboratorypatient.htm",
            async: false,
            success: function (data) {
                $.ajax({
                    type: 'GET',
                    data: {},
                    url: "doctorconsultation/viewpatientslabrequests.htm",
                    success: function (response) {                         
                        $('#lab-request-btn').css('display', 'block');
                        $('#lab-request-btn2').css('display', 'block');
                        $('#patientstolaboratorysdiv').html(response);
                    }
                });
            }
        });
    }
</script>
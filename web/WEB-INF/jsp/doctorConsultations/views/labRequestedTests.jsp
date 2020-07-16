<%-- 
    Document   : labRequestedTests
    Created on : Oct 28, 2018, 10:38:28 AM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<br><div class="row">
    <div class="col-md-4">
        <div class="form-group bs-component">
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Request Number:</strong></span>&nbsp;
            <strong >
                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${laboratoryrequestnumber}</strong></span>
            </strong>
        </div> 
    </div>
    <div class="col-md-4">
        <div class="form-group bs-component">
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Laboratory Unit:</strong></span>&nbsp;
            <strong >
                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${facilityunitname}</strong></span>
            </strong>
        </div>   
    </div>
    <div class="col-md-4">
        <div class="form-group bs-component">
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Requested By:</strong></span>&nbsp;
            <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${addedby}</strong></span>
        </div> 
    </div>
</div>
<hr>
<div class="row">
    <div class="col-md-12">
        <div >
            <table class="table table-hover table-bordered" id="sentlaboratoryrequettestsTable">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Test Name</th>
                        <th>Specimen</th>
                        <th>Tested</th>
                    </tr>
                </thead>
                <tbody >
                    <% int j = 1;%>
                    <c:forEach items="${labtestsFound}" var="a">
                        <tr>
                            <td><%=j++%></td>
                            <td>${a.testname}</td>
                            <td>${a.specimen}</td>
                            <td align="center"><img src="static/images/noaccesssmall.png"></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div> 
</div>
<div class="row">
    <div class="col-md-12">
        <button type="button" id="closePatientBtn"  onclick="closelabpatientstab();" class="btn btn-danger pull-right">
            <i class="fa fa-print"></i> Close Patient
        </button>
        <button type="button" style="margin-right: 100px !important;"  onclick="" class="btn btn-secondary pull-right">
            <i class="fa fa-print"></i> Print
        </button>    
    </div>
</div>
<script>
    $('#sentlaboratoryrequettestsTable').DataTable();
    $(function(){
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
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
    function closelabpatientstab() {
        window.location = '#close';
        $('.todayspatients').prop('checked', true);
        var patientvisitid=$('#facilityvisitPatientvisitid').val();
        $.ajax({
            type: 'POST',
            data: {patientvisitid:patientvisitid},
            url: "doctorconsultation/closepausedpatient.htm",
            success: function (data) {
                //
                $.ajax({
                    type: 'GET',
                    url: 'queuingSystem/servicePoppedPatient',
                    data: { visitid: patientvisitid, serviceid: staff.serviceid, staffid: staff.staffid },
                    success: function (data, textStatus, jqXHR) {
                        fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid }, '/app/servicedpatientscount');
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR);
                        console.log(textStatus);
                        console.log(errorThrown);
                    }
                });
                //
            }
        });
    }
</script>
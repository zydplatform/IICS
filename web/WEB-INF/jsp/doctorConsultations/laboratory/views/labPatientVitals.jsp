<%-- 
    Document   : labPatientVitals
    Created on : Oct 6, 2018, 12:20:28 PM
    Author     : HP
--%>
<%@include file="../../../include.jsp" %>
<input id="facilityLabvisitPatientvisitid" value="${patientvisitid}" type="hidden">
<input id="facilityLabvisitedPatientid" value="${patientid}" type="hidden">
<div class="card">
    <header class="card-header">
        <a href="#" data-toggle="collapse" data-target="#collapse11" aria-expanded="false" class="">
            <i class="icon-action fa fa-chevron-down"></i>
            <span class="title badge badge-patientinfo patientConfirmFont">${name}( Age:&nbsp; ${estimatedage}) </span>
        </a>
    </header>
    <div class="collapse" id="collapse11" style="">
        <article class="card-body">
            <div class="row" style="margin-top: 0em">
                <div class="col-md-2">
                    <fieldset style="margin-top: 1.5em">
                        <img class="app-sidebar__user-avatar img-responsive" src="static/images/profile-picture-placeholder.jpg" style="height: 65%;width: 60%;margin-left: 3em;" alt="User Image">
                    </fieldset><br>

                </div>
                <div class="col-md-5">
                    <fieldset>
                        <legend><strong>Basic Details</strong></legend>
                        <div>
                            <div class="form-group bs-component">
                                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Patient Visit Number:</strong></span>&nbsp;
                                <strong >
                                    <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${visitnumber}</strong></span>
                                </strong>
                            </div>
                            <div class="form-group bs-component">
                                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Patient Number:</strong></span>&nbsp;
                                <strong >
                                    <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${patientno}</strong></span>
                                </strong>
                            </div>
                            <div class="form-group bs-component">
                                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Patient Name:</strong></span>&nbsp;
                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${name}</strong></span>
                            </div>
                            <div class="form-group bs-component">
                                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Contact:</strong></span>&nbsp;
                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${telephone}</strong></span>
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="col-md-5">
                    <fieldset>
                        <legend>Other Details</legend>
                        <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Date Of Birth:</strong></span>&nbsp;
                            <strong >
                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${dob}</strong></span>
                            </strong>
                        </div>
                        <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Age:</strong></span>&nbsp;
                            <strong >
                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${estimatedage}</strong></span>
                            </strong>
                        </div>
                        <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Sex:</strong></span>&nbsp;
                            <strong >
                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${gender}</strong></span>
                            </strong>
                        </div>
                        <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Next Of Kin:</strong></span>&nbsp;
                            <strong >
                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${nextofkin}</strong></span>
                            </strong>
                        </div>
                    </fieldset>
                </div>
            </div>	
        </article> <!-- card-body.// -->
    </div> <!-- collapse .// -->
</div> <!-- card.// -->
<br>
<div class="tabsSec">
    <div class="tabsnew row">
        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-1" checked class="tab-switch">
            <label for="tab-1" class="tab-label">Lab Results</label>
            <div class="tab-content" style="margin-left: -10px"><br>
                <fieldset >
                    <%@include file="labTestResults.jsp" %>    
                </fieldset>
            </div>
        </div>
        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-2" class="tab-switch" >
            <label for="tab-2" class="tab-label">Vitals & Allergies </label>
            <div class="tab-content" style="margin-left: -140px">
                <fieldset >
                    <div class="" id="vitalsandallergiesdiv6">

                    </div> 
                </fieldset>
            </div>
        </div>

        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-3" class="tab-switch" >
            <label for="tab-3" class="tab-label">Clinical Notes </label>
            <div class="tab-content" style="margin-left: -288px">
                <div class="" id="patientclinicalnoteslab">
                        
                </div>
            </div>
        </div>

        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-4" class="tab-switch"onclick="ajaxSubmitData('doctorconsultation/internalreferral.htm', 'sendPatientToclinician', 'act=b&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label for="tab-4" class="tab-label">Internal Referrals</label>
            <div class="tab-content" style="margin-left: -429px">
                <fieldset >
                    <div class="" id="sendPatientToclinician"><br><br>
                        
                    </div>   
                </fieldset>
            </div>
        </div>
        <div class="tab">
            <input type="radio" name="css-tabs" id="tab-5" class="tab-switch" >
            <label for="tab-5" class="tab-label">Prescription</label>
            <div class="tab-content" style="margin-left: -590px">
                <div class="" id="labPatientPrescriptiondiv">

                </div>  
            </div>
        </div>

    </div>
</div>
<script>
    $('#laboratoryresultstestsTable').DataTable();
    $(document).ready(function () {
        var patientvisitsid = $('#facilityLabvisitPatientvisitid').val();
        var patientsid = $('#facilityLabvisitedPatientid').val();
        
        ajaxSubmitData('doctorconsultation/labpatientclinicalnotesform.htm', 'patientclinicalnoteslab', 'patientid='+patientsid+'&patientvisitid='+patientvisitsid+'&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        
        $.ajax({
            type: 'GET',
            data: {patientvisitid: patientvisitsid},
            url: "doctorconsultation/patientsvitalsandallergies.htm",
            success: function (data) {
                $('#vitalsandallergiesdiv6').html(data);
                ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'labpatientIssuesAndAllergiesDiv', 'patientid=' + patientsid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            }
        });
        $.ajax({
            type: 'GET',
            data: {patientid: patientsid, patientvisitid: patientvisitsid},
            url: "doctorconsultation/labprescriptionhome.htm",
            success: function (response) {
                $('#labPatientPrescriptiondiv').html(response);
            }
        });
    });

</script>
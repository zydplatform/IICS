<%-- 
    Document   : patientLabRequests
    Created on : Sep 27, 2018, 2:40:50 PM
    Author     : HP
--%>

<%@include file="../../include.jsp" %>
<input id="facilityvisitPatientLabvisitid" value="${patientvisitid}" type="hidden">
<input id="facilityvisitedPatientLabid" value="${patientid}" type="hidden">
<div class="card">
    <header class="card-header">
        <a href="#" data-toggle="collapse" data-target="#collapse11" aria-expanded="true" class="">
            <i class="icon-action fa fa-chevron-down"></i>
            <span class="title badge badge-patientinfo patientConfirmFont">${name}( Age:&nbsp; ${estimatedage}) </span>
        </a>
    </header>
    <div class="collapse show" id="collapse11" style="">
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
<div class="row">
    <div class="col-md-12">
        <fieldset>
            <legend><strong>Lab Request Details</strong></legend>
            <div id="laboratoryPatientsTestsDiv">

            </div>
        </fieldset>
    </div>
</div>
<script>
    var patientidlab = $('#facilityvisitedPatientLabid').val();
    var patientvisitlabid = $('#facilityvisitPatientLabvisitid').val();
    ajaxSubmitData('laboratory/laboratorypatientstests.htm', 'laboratoryPatientsTestsDiv', 'patientid='+patientidlab+'&i=0&patientvisitid='+patientvisitlabid+'&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
</script>

<%-- 
    Document   : labRequestPrescriptionHome
    Created on : Oct 26, 2018, 8:04:44 AM
    Author     : IICS
--%>
<style>
    .focus {
        border-color:red;
    }
</style>
<%@include file="../../../../include.jsp" %>
<input id="facilitylabvisitPatientvisitid" value="${patientvisitid}" type="hidden">
<input id="facilitylabvisitedPatientid" value="${patientid}" type="hidden">
<div class="card">
    <header class="card-header">
        <a href="#" data-toggle="collapse" data-target="#collapse12" aria-expanded="false" class="">
            <i class="icon-action fa fa-chevron-down"></i>
            <span class="title badge badge-patientinfo patientConfirmFont">${name}( Age:&nbsp; ${estimatedage}) </span>
        </a>
    </header>
    <div class="collapse" id="collapse12" style="">
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
        </article>
    </div>
</div>
<br>
<div id="menu">
    <main id="main">
        <input id="tab10" class="tabCheck" type="radio" name="tabs" checked >
        <label class="tabLabels" for="tab10">Vitals & Allergies</label>

        <input id="tab11" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab11">Clinical Notes</label>

        <input id="tab12" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab12">Laboratory Request</label>

        <input id="tab13" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab13">Internal Referrals</label>

        <input id="tab14" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab14">Prescription</label>

        <section class="tabContent" id="content10">
            <%@include file="patientVitalsAndAllergies.jsp" %>
        </section>

        <section class="tabContent" id="content11">
            <div id="patientsenttolabnotesdiv">

            </div>
        </section>
        <section class="tabContent" id="content12">
            <fieldset>
                <div id="labpatientssentdivs">

                </div>
            </fieldset>
        </section>

        <section class="tabContent" id="content13">
            <div id="labinternallabReferralsdiv">

            </div>
        </section>
        <section class="tabContent" id="content14">
            <div id="labprescriptionsDiv">

            </div>
        </section>
    </main>
</div>
<script>
    $(document).ready(function () {
        var patientvisitsid = $('#facilitylabvisitPatientvisitid').val();
        ajaxSubmitData('doctorconsultation/labpatientclinicalnotesform.htm', 'patientsenttolabnotesdiv', 'patientvisitid=' + patientvisitsid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        ajaxSubmitData('doctorconsultation/labpatientsentlabaratory.htm', 'labpatientssentdivs', 'patientvisitid=' + patientvisitsid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        ajaxSubmitData('doctorconsultation/labinternallabReferrals.htm', 'labinternallabReferralsdiv', 'patientvisitid=' + patientvisitsid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        ajaxSubmitData('doctorconsultation/laboratorypatientprescription.htm', 'labprescriptionsDiv', 'patientid=${patientid}&i=0&patientvisitid=${patientvisitid}&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
</script>
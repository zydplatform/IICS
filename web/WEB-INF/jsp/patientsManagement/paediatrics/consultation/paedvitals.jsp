<%-- 
    Document   : paedvitals
    Created on : Nov 5, 2018, 12:10:06 PM
    Author     : user
--%>

<%@include file="../../../include.jsp" %>
<input id="facilityvisitPatientvisitid" value="${patientvisitid}" type="hidden">
<input id="facilityvisitedPatientid" value="${patientid}" type="hidden">
<input id="consultationtotalmonths" value="${consultationtotalmonths}" type="hidden">
<input type="hidden" id="consultationgender" value="${gender}">
<input type="hidden" id="years" value="${years}">
<input type="hidden" id="zscoresid" value="${zscoresid}">
<div class="card">
    <header class="card-header">
        <a href="#" data-toggle="collapse" data-target="#collapse11" aria-expanded="false" class="">
            <i class="icon-action fa fa-chevron-down"></i>
            <c:if test="${years == 0}">
                <span class="title badge badge-patientinfo patientConfirmFont"><span>Name:${name}</span>&nbsp;&nbsp;&nbsp;<span>Age:${months}&nbsp;Month(s)</span></span>
            </c:if>
            <c:if test="${years > 0}">
                <c:if test="${months == 0}">
                    <span class="title badge badge-patientinfo patientConfirmFont"><span>Name:${name}</span>&nbsp;&nbsp;&nbsp;<span>Age:${years}&nbsp;year(s)</span></span>
                </c:if>
                <c:if test="${months != 0}">
                    <span class="title badge badge-patientinfo patientConfirmFont"><span>Name:${name}</span>&nbsp;&nbsp;&nbsp;<span>Age:${years}&nbsp;year(s),${months}&nbsp;Month(s)</span></span>
                </c:if>

            </c:if>

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
                                <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Next of kin:</strong></span>&nbsp;
                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${nextofkin}</strong></span>
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="col-md-5">
                    <fieldset>
                        <legend>Other Details</legend>

                        <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Next Of Kin Contact:</strong></span>&nbsp;
                            <strong >
                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${telephone}</strong></span>
                            </strong>
                        </div>
                        <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Date Of Birth:</strong></span>&nbsp;
                            <strong >
                                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${dob}</strong></span>
                            </strong>
                        </div>

                        <div class="form-group bs-component">
                            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Sex:</strong></span>&nbsp;
                            <strong >
                                <span class="badge badge-patientinfo patientConfirmFont" ><strong class="fname">${gender}</strong></span>
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
        <input id="tab4" class="tabCheck" type="radio" name="tabs" checked>
        <label class="tabLabels" for="tab4">Vitals & Allergies</label>

        <input id="tab5" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab5">Clinical Notes</label>

        <input id="tab9" class="tabCheck" type="radio" name="tabs" style="">
        <label class="tabLabels" for="tab9" style="">Diagnosis</label>

        <input id="tab8" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab8">Laboratory Request</label>

        <input id="tab6" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('doctorconsultation/internalreferral.htm', 'internalReferralsdiv', 'act=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab6">Internal Referrals</label>

        <input id="tab7" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab7">Prescription</label>

        <section class="tabContent" id="content4">
            <%@include file="paedvitalsandalergies.jsp" %>
        </section>
        <section class="tabContent" id="content5">
            <div id="patientsclinicalNotesdiv">

            </div>
        </section>
        <section class="tabContent" id="content8">
            <div id="sendPatientToLabDiv">

            </div>
        </section>
        <section class="tabContent" id="content9">
            <div id="diagnosisPatientDiv">
                <%@include file="../../../doctorConsultations/forms/patientDiagnosis.jsp" %>
            </div>
        </section>
        <section class="tabContent" id="content6">
            <div id="internalReferralsdiv">

            </div>
        </section>
        <section class="tabContent" id="content7">
            <div id="prescriptionsDiv">

            </div>
        </section>
    </main>
</div>
<script>
    var patientLabTests = new Set();
    $(document).ready(function () {
        ajaxSubmitData('doctorconsultation/prescriptionhome.htm', 'prescriptionsDiv', 'patientid=${patientid}&i=0&patientvisitid=${patientvisitid}&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        ajaxSubmitData('doctorconsultation/patientclinicalnotesform.htm', 'patientsclinicalNotesdiv', 'patientid=${patientid}&patientvisitid=${patientvisitid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        ajaxSubmitData('doctorconsultation/sendpatienttothelabaratory.htm', 'sendPatientToLabDiv', 'patientid=${patientid}&patientvisitid=${patientvisitid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        var consultationgender = $('#consultationgender').val();
        var consultationtotalmonths = $('#consultationtotalmonths').val();
        var zscoresid =$('#zscoresid').val();
        document.getElementById('paedgender').value = consultationgender;
        document.getElementById('zscoresidpaed').value = zscoresid;
        document.getElementById('paedconsultationtotalmonths').value = consultationtotalmonths;
        var years = $('#years').val();
       
        if(years<=5){
            $('#consultationbelow5').show();
        }
        if(years>5){
            $('#consultationabove5').show();
        }
    });
    
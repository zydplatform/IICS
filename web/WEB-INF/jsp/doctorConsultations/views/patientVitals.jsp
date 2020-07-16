<%-- 
    Document   : patientVitals
    Created on : Aug 13, 2018, 4:48:51 PM
    Author     : HP
--%>
<style>
    .focus {
        border-color:red;
    }
</style>
<%@include file="../../include.jsp" %>
<input id="facilityvisitPatientvisitid" value="${patientvisitid}" type="hidden">
<input id="facilityvisitedPatientid" value="${patientid}" type="hidden">
<input id="facilityvisitedPatientname" value="${name}" type="hidden">

<div class="card">
    <header class="card-header">
        <a href="#" data-toggle="collapse" data-target="#collapse11" aria-expanded="false" class="">
            <i class="icon-action fa fa-chevron-down"></i>
            <span class="title badge badge-patientinfo patientConfirmFont">${name}( Age:&nbsp; ${estimatedage}) </span>
        </a>
        &nbsp;
        <c:if test="${referralDetails != null}">
            <a href="#" data-toggle="collapse" data-target="#referralInfo" aria-expanded="true"> 
                <i class="icon-action fa fa-chevron-down"></i>
                <span class="title badge badge-success patientConfirmFont">Internal Referral</span>                
            </a>
        </c:if>
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
        </article>
    </div>
    <!---->
    <c:if test="${referralDetails != null}">
        <div class="collapse" id="referralInfo">
            <article class="card-body">
                    <fieldset>
                        <div>
                            <label for="referringUnit" class="control-label"> Referring Unit:
                                <span class="form-control" id="referringUnit" name="referringUnit">${referralDetails.referringUnit}</span>
                            </label>
                        </div>
                        <div>
                            <label for="addedby" class="control-label"> Referred By:
                                <span class="form-control" id="addedby" name="addedby">${referralDetails.addedby}</span>
                            </label>
                        </div>
                        <div>
                            <label for="referralnotes" class="control-label"> Referral Notes:
                                <span type="text" class="form-control" id="referralnotes" name="referralnotes">
                                    ${referralDetails.referralnotes}
                                </span>
                            </label>
                        </div>
                    </fieldset>
            </article>
        </div>
    </c:if>
    <!---->
</div>
<br>
<div id="menu">
    <main id="main">
        <!---->
        <!--<input id="tab4" class="tabCheck" type="radio" name="tabs" checked onclick="toggleCloseButton(${patientvisitid})">-->
        <input id="tab4" class="tabCheck" type="radio" name="tabs" <c:if test="${referralDetails == null}">checked="checked"</c:if> onclick="toggleCloseButton(${patientvisitid})">
        <label class="tabLabels" for="tab4">Vitals & Allergies</label>

        <input id="tab5" class="tabCheck" type="radio" name="tabs" <c:if test="${referralDetails != null}">checked="checked"</c:if> onclick="toggleCloseButton(${patientvisitid})">
        <label class="tabLabels" for="tab5">Clinical Notes</label>

        <!--        <input id="tab9" class="tabCheck" type="radio" name="tabs" style="">
                <label class="tabLabels" for="tab9" style="">Diagnosis</label>-->

        <input id="tab8" class="tabCheck labReqTab" type="radio" name="tabs" onclick="toggleCloseButton(${patientvisitid})" 
               disabled="disabled"  title="Enter Clinical Notes To View This Section." />
        <label class="tabLabels" for="tab8" disabled="disabled" title="Enter Clinical Notes To View This Section.">Laboratory Request</label>

        <!-- <input id="tab6" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('doctorconsultation/internalreferral.htm', 'internalReferralsdiv', 'act=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab6">Internal Referrals</label> -->
        
        <input id="tab6" class="tabCheck refsTab" type="radio" name="tabs" onclick="naviateToReferrals();" disabled="disabled"
                title="Enter Clinical Notes To View This Section.">
        <label class="tabLabels" for="tab6" disabled="disabled" title="Enter Clinical Notes To View This Section.">Referrals</label>

        <input id="tab7" class="tabCheck prespTab" type="radio" name="tabs" onclick="toggleCloseButton(${patientvisitid})" 
               disabled="disabled" title="Enter Clinical Notes To View This Section.">
        <label class="tabLabels" for="tab7" disabled="disabled" title="Enter Clinical Notes To View This Section.">Prescription</label>

        <input id="tab15" class="tabCheck" type="radio" name="tabs" onclick="toggleCloseButton(${patientvisitid})">
        <label class="tabLabels" for="tab15" id="patientHistoryCount">History (${prevousvisits})</label>

        <section class="tabContent" id="content4">
            <%@include file="patientVitalsAndAllergies.jsp" %>
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

            </div>
        </section>
        <section class="tabContent" id="content6">
            <!--<div id="internalReferralsdiv">

            </div>-->
            <div id="referralsdiv">

            </div>
        </section>
        <section class="tabContent" id="content7">
            <div id="prescriptionsDiv">

            </div>
        </section>
        <section class="tabContent" id="content15">
            <div id="historyDiv">

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
        ajaxSubmitData('doctorconsultation/patienthistory.htm', 'historyDiv', 'patientid=${patientid}&i=0&patientvisitid=${patientvisitid}&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        ajaxSubmitData('doctorconsultation/patientdiagnosis.htm', 'diagnosisPatientDiv', 'patientid=${patientid}&i=0&patientvisitid=${patientvisitid}&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

        $.ajax({
            type: 'POST',
            data: {patientid:${patientid}, patientvisitid:${patientvisitid}},
            url: "doctorconsultation/patienthistorycount.htm",
            success: function (data) {
                $('#patientHistoryCount').html('History (' + data + ')');
            }
        });
    });
    function naviateToReferrals(){
        var destination = "internal";
        $.confirm({
            title: 'SELECT TYPE OF REFERRAL',
                content: '<label for="referralType" class="control-label"> Referral Type: </label><br/>' + 
                         '<select id="referralType" class="form-control">' +
                            '<option value="internal"> Internal Referral </option>' + 
                            '<option value="external"> External Referral </option>' +
                         '</select>',
                type: 'purple',
                boxWidth: '50%',
                useBootstrap: true,
                typeAnimated: true,
                buttons:{
                    tryAgain:{
                        text: 'Ok',
                        btnClass: 'btn-purple',
                        action: function(){
                            destination = $('#referralType').val();
                            switch(destination.toString().toLowerCase()){
                                case "internal" :
                                    ajaxSubmitData('doctorconsultation/internalreferral.htm', 'referralsdiv', 'act=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    break;
                                case "external":
                                    ajaxSubmitData('doctorconsultation/externalreferral.htm', 'referralsdiv', 'act=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    break;
                                default:
                                    ajaxSubmitData('doctorconsultation/internalreferral.htm', 'referralsdiv', 'act=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    break;
                            }
                        }
                    }
                }
        });            
    }
</script>
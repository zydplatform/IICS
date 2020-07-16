<%@include file="../../include.jsp"%>
<style>
    .order-items-process:hover{
        text-decoration: underline !important;
        cursor: pointer;
        color: blue;
    }
    .select2-container{
        z-index: 999999999 !important;
    }
</style>
<div class="app-title">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>

    <div class="">
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                    <li><a href="#" onclick="ajaxSubmitData('patient/patientmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Patient Management</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('patient/patientvisits.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Search Patient</a></li>
                    <li class="last active"><a href="#">Manage Patient</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<h3 class="center text-muted">Manage Patient Details</h3>
<div class="tile">
    <div class="page-header">
        <div class="row">
            <div class="col-md-12 mb-3 line-head">
                <strong  style="font-size: 20px" class="">${patientfullnames}</strong>
                <span class="float-right">
                    <strong>
                        <a onclick="ajaxSubmitData('patient/patientvisits.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" style="margin-left: 10px">
                            <img src="static/img/closeicon.png" width="42" height="35">
                        </a>
                    </strong>
                </span>
                <button class ="btn btn-outline-primary float-right" type="button" onclick="ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + '${patientid}' + '&pfirstname=' + '${firstname}' + '&plastname=' + '${lastname}' + '&pothername=' + '${othername}' + '&pin=' + '${patPin}' + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');"> 
                    <i class="fa fa-hospital-o"></i><span><strong>Create Patient Visit</strong></span>
                </button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <fieldset>
                <legend><strong>Basic Details</strong></legend>
                <div>
                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Patient Number(PIN):</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-pin">${patPin}</strong></span>
                        <span><a href="#" onclick="functionEditPin()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>First Name:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-fname">${firstname}</strong></span>
                        <span><a href="#" onclick="functionEditFirstname()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Last Name:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-lname">${lastname}</strong></span>
                        <span><a href="#" onclick="functionEditLastname()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a></span>
                    </div>

                    <div class="form-group bs-component" id="old-patient-othername">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Other Name:</strong></span>&nbsp;
                        <c:choose>
                            <c:when test="${othername == 'novalue'}">
                                <strong onclick="functionaddothername()">
                                    <a href="#"><font color="blue">Pending</font></a>
                                </strong>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-patientinfo patientConfirmFont" id=""><strong id="patient-edit-oname">${othername}</strong></span>
                                <span>
                                    <a href="#" onclick="functionEditOthername()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="form-group bs-component" id="new-patient-othername">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Other Name:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont" id=""><strong id="patient-edit-oname2">${othername}</strong></span>
                        <span>
                            <a href="#" onclick="functionEditOthername2()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                        </span>
                    </div>

                    <div class="form-group bs-component" id="old-patient-gender">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Gender:</strong></span>&nbsp;
                        <c:choose>
                            <c:when test="${gender == 'novalue'}">
                                <strong onclick="functionaddgender()">
                                    <a href="#"><font color="blue">Pending</font></a>
                                </strong>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-patientinfo patientConfirmFont" id=""><strong id="patient-edit-gender">${gender}</strong></span>
                                <span>
                                    <a href="#" onclick="functionEditGender()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div id="new-patient-gender">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Gender:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont" id=""><strong id="patient-edit-gender2">${gender}</strong></span>
                        <span>
                            <a href="#" onclick="functionEditGender2()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                        </span>
                    </div>

                    <div class="form-group bs-component" id="old-patient-phone">
                        <span class="control-label pat-form-heading patientConfirmFont" for="phoneno2"><strong>Phone No:</strong></span>&nbsp;
                        <c:choose>
                            <c:when test="${pContact == 'novalue'}">
                                <strong onclick="functionaddPhone()">
                                    <a href="#"><font color="blue">Pending</font></a>
                                </strong>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-phone">${pContact}</strong></span>
                                <span>
                                    <a href="#" onclick="functionEditPhone()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div id="new-patient-phone">
                        <span class="control-label pat-form-heading patientConfirmFont" for="phoneno2"><strong>Phone No:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-phone2">${pContact}</strong></span>
                        <span>
                            <a href="#" onclick="functionEditPhone2()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                        </span>
                    </div>

                    <div class="form-group bs-component" id=old-patient-village">
                        <input type="hidden" value="" id="residenceid"/>
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Current Address:</strong></span>&nbsp;
                        <c:choose>
                            <c:when test="${residenceVill == 'novalue'}">
                                <strong onclick="functionaddresidence()">
                                    <a href="#"><font color="blue">Pending</font></a>
                                </strong>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-village">${residenceVill} ${residenceparish}</strong></span>
                                <span>
                                    <a href="#" onclick="functionEditResidence()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="form-group bs-component" id="new-patient-village">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Current Address:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-village2">${residenceVill}</strong></span>
                        <span>
                            <a href="#" onclick="functionEditResidence2()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                        </span>
                    </div>

                    <div class="form-group bs-component" id="old-patient-phone">
                        <span class="control-label pat-form-heading patientConfirmFont" for="phoneno2"><strong>D.O.B:</strong></span>&nbsp;
                        <c:choose>
                            <c:when test="${dob == 'novalue'}">
                                <strong onclick="functionaddDOB()">
                                    <a href="#"><font color="blue">Pending</font></a>
                                </strong>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-dob">${dob}</strong></span>
                                <span>
                                    <a href="#" onclick="functionEditDOB()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                                <p style="margin-top: 6px !important">
                                    <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Current Age:</strong></span>
                                    <span class="badge badge-patientinfo patientConfirmFont">
                                        <strong>
                                            ${estimatedage}
                                            <%--
                                            <c:if test="${days >= 365}">
                                                <fmt:formatNumber var="years" value="${days/365}" maxFractionDigits="0"/>
                                                ${years} Years
                                            </c:if>
                                            <c:if test="${days < 365}">
                                                <c:if test="${days >= 30}">
                                                    <fmt:formatNumber var="months" value="${days/30}" maxFractionDigits="0"/>
                                                    ${months} Months
                                                </c:if>
                                                <c:if test="${days < 30}">
                                                    <c:if test="${days >= 1}">
                                                        ${days} Days
                                                    </c:if>
                                                </c:if>
                                            </c:if>--%>
                                        </strong>
                                    </span>
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div id="new-patient-dob">
                        <span class="control-label pat-form-heading patientConfirmFont" for="phoneno2"><strong>D.O.B:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-dob2">${dob}</strong></span>
                        <span>
                            <a href="#" onclick="functionEditDOB2()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                        </span>
                    </div></br>
                </div>
            </fieldset>
        </div>
        <div class="col-md-6">
            <fieldset>
                <legend><strong>Other Details</strong></legend>
                <div>
                    <div class="form-group bs-component" id="old-patient-nationality">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Nationality:</strong></span>&nbsp;
                        <c:choose>
                            <c:when test="${pNationality == 'novalue'}">
                                <strong onclick="functionaddNationality()">
                                    <a href="#"><font color="blue">Pending</font></a>
                                </strong>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-patientinfo patientConfirmFont" id="firstname2"><strong id="patient-edit-nationality">${pNationality}</strong></span>
                                <span>
                                    <a href="#" onclick="functionEditNationality()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="form-group bs-component" id="new-patient-nationality">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Nationality:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-nationality2">${pNationality}</strong></span>
                        <span>
                            <a href="#" onclick="functionEditNationality2()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                        </span>
                    </div>

                    <div class="form-group bs-component" id="old-patient-maritalstatus">
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Marital Status:</strong></span>&nbsp;
                        <c:choose>
                            <c:when test="${pMaritalstatus == 'novalue'}">
                                <strong onclick="functionAddMaritalstatus()">
                                    <a href="#"><font color="blue">Pending</font></a>
                                </strong>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-maritalstatus">${pMaritalstatus}</strong></span>
                                <span>
                                    <a href="#" onclick="functionEditMaritalstatus()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="form-group bs-component" id="new-patient-maritalstatus">
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Marital Status:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-maritalstatus2">${pMaritalstatus}</strong></span>
                        <span>
                            <a href="#" onclick="functionEditMaritalstatus2()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                        </span>
                    </div>

                    <div class="form-group bs-component" id="old-nxt-of-kin">
                        <input type="hidden" value="${pNxtofkinphonecontact}"/>
                        <c:choose>
                            <c:when test="${pNxtfullname == 'novalue'}">
                                <span class="control-label pat-form-heading patientConfirmFont"><strong>Next Of Kin:</strong></span>&nbsp;
                                <strong onclick="functionaddnextofkin()">
                                    <a href="#"><font color="blue">Pending</font></a>
                                </strong>
                            </c:when>
                            <c:otherwise>
                                <span class="control-label pat-form-heading patientConfirmFont"><strong id="patient-edit-nxtrelationship">${pRelationship}</strong>:</span>&nbsp;
                                <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-nxtofkinfullname">${pNxtfullname}</strong>&nbsp;&nbsp;[ Tel : <span><strong id="patient-edit-nxtofkinphone">${pNxtofkinphonecontact}</strong></span>&nbsp;]</span>
                                <span>
                                    <a href="#" onclick="functionEditNxtofkin()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="form-group bs-component" id="new-nxt-of-kin">
                        <span class="control-label pat-form-heading patientConfirmFont"><strong id="patient-edit-nxtrelationship2">${pRelationship}</strong>:</span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-nxtofkinfullname2">${pNxtfullname}&nbsp;&nbsp;</strong>&nbsp;&nbsp;[ Tel : <span><strong id="patient-edit-nxtofkinphone2">${pNxtofkinphonecontact}</strong></span>&nbsp;]</span>
                        <span>
                            <a href="#" onclick="functionEditNxtofkin2()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                        </span>
                    </div>

                    <div class="form-group bs-component" id="old-patient-nin">
                        <span class="control-label pat-form-heading patientConfirmFont"><strong>NIN:</strong></span>&nbsp;
                        <c:choose>
                            <c:when test="${pNin == 'novalue'}">
                                <strong onclick="functionaddNIN()">
                                    <a href="#"><font color="blue">Pending</font></a>
                                </strong>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-NIN">${pNin}</strong></span>
                                <span>
                                    <a href="#" onclick="functionEditNIN()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="form-group bs-component" id="new-patient-nin">
                        <span class="control-label pat-form-heading patientConfirmFont"><strong>NIN:</strong></span>&nbsp;

                        <span class="badge badge-patientinfo patientConfirmFont"><strong id="patient-edit-NIN2">${pNin}</strong></span>
                        <span>
                            <a href="#" onclick="functionEditNIN2()"><font color="#054afc"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></font></a>
                        </span>
                    </div>
                </div>
            </fieldset>

            <fieldset>
                <legend><strong>First Registration</strong></legend>
                <div>
                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Date:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont" id=""><strong>${datecreated}</strong></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Registration Unit:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont" id=""><strong>${registrationpoint}</strong></span>
                    </div>
                                        
                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Hospital:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont" id=""><strong>${facilityname}</strong></span>
                    </div>
                    
                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>Registered By:</strong></span>&nbsp;
                        <span class="badge badge-patientinfo patientConfirmFont" id=""><strong>${createdby}</strong></span>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
</div>

<script>
    breadCrumb();
    $("#new-nxt-of-kin").hide();
    $("#new-patient-nin").hide();
    $("#new-patient-nationality").hide();
    $("#new-patient-village").hide();
    $("#new-patient-othername").hide();
    $("#new-patient-maritalstatus").hide();
    $("#new-patient-dob").hide();
    $("#new-patient-phone").hide();
    $("#new-patient-gender").hide();
    var patientPersonid = ${personid};
    var patientid = ${patientid};

    function functionEditPin() {
        var editpin = $('#patient-edit-pin').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Patient PIN:</label>' +
                    '<input type="text" class="form-control" value="' + editpin + '" id="pinedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var pinedit = this.$content.find('#pinedit').val();

                        var data = {
                            updatepin: pinedit,
                            patientid: patientid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updatePin.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-pin").text(pinedit);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditFirstname() {
        var editfname = $('#patient-edit-fname').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>First Name:</label>' +
                    '<input type="text" class="form-control" value="' + editfname + '" id="fnameedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var fnameedit = this.$content.find('#fnameedit').val();

                        var data = {
                            updatefname: fnameedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updateFname.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-fname").text(fnameedit);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditLastname() {
        var editfname = $('#patient-edit-lname').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Last Name:</label>' +
                    '<input type="text" class="form-control" value="' + editfname + '" id="lnameedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var lnameedit = this.$content.find('#lnameedit').val();

                        var data = {
                            updatelname: lnameedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updateLname.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-lname").text(lnameedit);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionaddothername() {
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Other Name:</label>' +
                    '<input type="text" class="form-control" value="" id="othernameedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var othernameedit = this.$content.find('#othernameedit').val();

                        var data = {
                            updateOname: othernameedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updateOname.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-oname2").text(othernameedit);
                                $("#old-patient-othername").hide();
                                $("#new-patient-othername").show();
                            }
                        });

                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditOthername() {
        var editoname = $('#patient-edit-oname').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Other Name:</label>' +
                    '<input type="text" class="form-control" value="' + editoname + '" id="othernameedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var othernameedit = this.$content.find('#othernameedit').val();

                        var data = {
                            updateOname: othernameedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updateOname.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-oname").text(othernameedit);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditOthername2() {
        var editoname = $('#patient-edit-oname2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Other Name:</label>' +
                    '<input type="text" class="form-control" value="' + editoname + '" id="othernameedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var othernameedit = this.$content.find('#othernameedit').val();

                        var data = {
                            updateOname: othernameedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updateOname.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-oname2").text(othernameedit);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditGender() {
        var editgender = $('#patient-edit-gender').text();
        if (editgender === 'Female') {
            $.confirm({
                title: 'Prompt!',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group required village">' +
                        ' <label class="control-label">Gender:</label>' +
                        ' <select class="form-control patientgenderedit" id="patientgenderedit">' +
                        '<option value="Female">Female</option>' +
                        '<option value="Male">Male</option>' +
                        ' </select>' +
                        '</div>' +
                        '</form>',
                boxWidth: '30%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                closeIcon: true,
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn-blue',
                        action: function () {
                            var patientgenderedit = this.$content.find('.patientgenderedit').val();

                            var data = {
                                updateGender: patientgenderedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updateGender.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-gender").text(patientgenderedit);
                                }
                            });

                        }
                    },
                    cancel: function () {
                        //close
                    }
                },
                onContentReady: function () {
                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                }
            });
        } else {
            $.confirm({
                title: 'Prompt!',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group required village">' +
                        ' <label class="control-label">Gender:</label>' +
                        ' <select class="form-control patientgenderedit" id="patientgenderedit">' +
                        '<option value="Male">Male</option>' +
                        '<option value="Female">Female</option>' +
                        ' </select>' +
                        '</div>' +
                        '</form>',
                boxWidth: '30%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                closeIcon: true,
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn-blue',
                        action: function () {
                            var patientgenderedit = this.$content.find('.patientgenderedit').val();

                            var data = {
                                updateGender: patientgenderedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updateGender.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-gender").text(patientgenderedit);
                                }
                            });
                        }
                    },
                    cancel: function () {
                        //close
                    }
                },
                onContentReady: function () {
                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                }
            });
        }
    }

    function functionEditGender2() {
        var editgender = $('#patient-edit-gender2').text();
        if (editgender === 'Female') {
            $.confirm({
                title: 'Prompt!',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group required village">' +
                        ' <label class="control-label">Gender:</label>' +
                        ' <select class="form-control patientgenderedit" id="patientgenderedit">' +
                        '<option value="Female">Female</option>' +
                        '<option value="Male">Male</option>' +
                        ' </select>' +
                        '</div>' +
                        '</form>',
                boxWidth: '30%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                closeIcon: true,
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn-blue',
                        action: function () {
                            var patientgenderedit = this.$content.find('.patientgenderedit').val();

                            var data = {
                                updateGender: patientgenderedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updateGender.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-gender2").text(patientgenderedit);
                                }
                            });

                        }
                    },
                    cancel: function () {
                        //close
                    }
                },
                onContentReady: function () {
                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                }
            });
        } else {
            $.confirm({
                title: 'Prompt!',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group required village">' +
                        ' <label class="control-label">Gender:</label>' +
                        ' <select class="form-control patientgenderedit" id="patientgenderedit">' +
                        '<option value="Male">Male</option>' +
                        '<option value="Female">Female</option>' +
                        ' </select>' +
                        '</div>' +
                        '</form>',
                boxWidth: '30%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                closeIcon: true,
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn-blue',
                        action: function () {
                            var patientgenderedit = this.$content.find('.patientgenderedit').val();

                            var data = {
                                updateGender: patientgenderedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updateGender.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-gender2").text(patientgenderedit);
                                }
                            });
                        }
                    },
                    cancel: function () {
                        //close
                    }
                },
                onContentReady: function () {
                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                }
            });
        }
    }

    function functionaddgender() {
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required village">' +
                    ' <label class="control-label">Gender:</label>' +
                    ' <select class="form-control patientgenderedit" id="patientgenderedit">' +
                    '<option value="Male">Male</option>' +
                    '<option value="Female">Female</option>' +
                    ' </select>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var patientgenderedit = this.$content.find('.patientgenderedit').val();
                        var data = {
                            updateGender: patientgenderedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updateGender.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-gender2").text(patientgenderedit);
                                $("#old-patient-gender").hide();
                                $("#new-patient-gender").show();
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionaddPhone() {
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Phone No:</label>' +
                    '<input type="text" class="form-control" value="" id="phonenoedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var phonenoedit = this.$content.find('#phonenoedit').val();

                        if (!phonenoedit) {
                            $.alert('Please provide a valid Phone Contact');
                            return false;
                        } else {
                            //...SUBMIT PHONE
                            var data = {
                                patientContact: phonenoedit,
                                patientid: patientid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updatecontact.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-phone2").text(phonenoedit);
                                    $("#old-patient-phone").hide();
                                    $("#new-patient-phone").show();
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#phonenoedit').usPhoneFormat({
                    format: '(xxx) xxx-xxxx'
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditPhone() {
        var editphone = $('#patient-edit-phone').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Phone No:</label>' +
                    '<input type="text" class="form-control" value="' + editphone + '" id="phonenoedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var phonenoedit = this.$content.find('#phonenoedit').val();
                        $("#patient-edit-phone").text(phonenoedit);

                        if (!phonenoedit) {
                            $.alert('Please provide a valid Phone Contact');
                            return false;
                        } else {
                            //...SUBMIT PHONE
                            var data = {
                                patientContact: phonenoedit,
                                patientid: patientid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updatecontact.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-phone").text(phonenoedit);
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#phonenoedit').usPhoneFormat({
                    format: '(xxx) xxx-xxxx'
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditPhone2() {
        var editphone = $('#patient-edit-phone2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Phone No:</label>' +
                    '<input type="text" class="form-control" value="' + editphone + '" id="phonenoedit"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var phonenoedit = this.$content.find('#phonenoedit').val();
                        $("#patient-edit-phone").text(phonenoedit);

                        if (!phonenoedit) {
                            $.alert('Please provide a valid Phone Contact');
                            return false;
                        } else {
                            //...SUBMIT PHONE
                            var data = {
                                patientContact: phonenoedit,
                                patientid: patientid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updatecontact.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-phone2").text(phonenoedit);
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#phonenoedit').usPhoneFormat({
                    format: '(xxx) xxx-xxxx'
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

//    function functionEditResidence() {
//        var editvillage = $('#patient-edit-village').text();
//        $.confirm({
//            icon: 'fa fa-warning',
//            title: 'Please select Current Address!',
//            content: '' +
//                    '<h5><span class="text-muted">Previous Address : </span><span><strong>' + editvillage + '</strong></span></h5>' +
//                    '<form action="" class="formName">' +
//                    '<div class="form-group required">' +
//                    '<label class="control-label">District</label>' +
//                    '<select class="form-control" id="editdistrict22">' +
//                    ' </select>' +
//                    '</div>' +
//                    '<div class="form-group required village">' +
//                    ' <label class="control-label">Village</label>' +
//                    ' <select class="form-control" id="editvillage">' +
//                    ' </select>' +
//                    '</div>' +
//                    '</form>',
//            boxWidth: '30%',
//            useBootstrap: false,
//            type: 'purple',
//            typeAnimated: true,
//            closeIcon: true,
//            buttons: {
//                formSubmit: {
//                    text: 'Submit',
//                    btnClass: 'btn-blue',
//                    action: function () {
//                        var editvillage3 = this.$content.find('#editvillage').val();
//                        var villageEdited = $("#" + editvillage3).data("villagename24");
//                        $("#residenceid").val(editvillage3);
//
//                        var data = {
//                            village: editvillage3,
//                            personid: patientPersonid
//                        };
//                        $.ajax({
//                            type: "POST",
//                            cache: false,
//                            url: "patient/updatevillage.htm",
//                            data: data,
//                            success: function (rep) {
//                                $("#patient-edit-village").text(villageEdited);
//                            }
//                        });
//                    }
//                },
//                cancel: function () {
//                    //close
//                }
//            },
//            onContentReady: function () {
//
//                $.ajax({
//                    type: 'POST',
//                    url: 'locations/fetchDistricts.htm',
//                    success: function (data) {
//                        var res = JSON.parse(data);
//                        if (res !== '' && res.length > 0) {
//                            for (i in res) {
//                                $('#editdistrict22').append('<option class="textbolder" id="' + res[i].id + '" data-districtname22="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
//                            }
//                            var districtid = parseInt($('#editdistrict22').val());
//                            $.ajax({
//                                type: 'POST',
//                                url: 'locations/fetchDistrictVillages.htm',
//                                data: {districtid: districtid},
//                                success: function (data) {
//                                    var res = JSON.parse(data);
//                                    if (res !== '' && res.length > 0) {
//                                        for (i in res) {
//                                            $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
//                                        }
//                                    }
//                                }
//                            });
//                        }
//                    }
//                });
//                $('#editdistrict22').change(function () {
//                    $('#editvillage').val(null).trigger('change');
//                    var districtid = parseInt($('#editdistrict22').val());
//                    $.ajax({
//                        type: 'POST',
//                        url: 'locations/fetchDistrictVillages.htm',
//                        data: {districtid: districtid},
//                        success: function (data) {
//                            var res = JSON.parse(data);
//                            if (res !== '' && res.length > 0) {
//                                $('#editvillage').html('');
//                                for (i in res) {
//                                    console.log(res[i].village);
//                                    $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
//                                }
//                            }
//                        }
//                    });
//                });
//                // bind to events
//                var jc = this;
//                this.$content.find('form').on('submit', function (e) {
//                    // if the user submits the form by pressing enter in the field.
//                    e.preventDefault();
//                    jc.$$formSubmit.trigger('click'); // reference the button and click it
//                });
//            }
//        });
//    }

    function functionEditResidence() {
        var editvillage = $('#patient-edit-village').text();
        //
        var editParish = $('#patient-edit-parish').text();
        //
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Please select Current Address!',
            content: '<div id="parent-container">' +
                    '<h5><span class="text-muted">Previous Address : </span><span><strong>' + editvillage + editParish +'</strong></span></h5>' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '<label class="control-label">District</label>' +
                    '<select class="form-control" id="editdistrict22">' +
                    ' </select>' +
                    '</div>' +
                    '<div class="form-group required village">' +
                    ' <label class="control-label">Village</label>' +
                    ' <select class="form-control" id="editvillage">' +
                    ' </select>' +
                    '</div>' +
                    '</form></div>',
            boxWidth: '30%',
            minHeight: '100%',
            maxHeight: '100%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {                        
                        var editvillage3 = this.$content.find('#editvillage').val();
                        var villageEdited = $("#" + editvillage3).data("villagename24");
                        $("#residenceid").val(editvillage3);

                        var data = {
                            village: editvillage3,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updatevillage.htm",
                            data: data,
                            success: function (rep) {                                
                                $("#patient-edit-village").text(villageEdited);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {                
                $.ajax({
                    type: 'POST',
                    url: 'locations/fetchDistricts.htm',
                    success: function (data) {
                        var res = JSON.parse(data);
                        if (res !== '' && res.length > 0) {
                            for (i in res) {
                                $('#editdistrict22').append('<option class="textbolder" id="' + res[i].id + '" data-districtname22="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                            }
                            var districtid = parseInt($('#editdistrict22').val());
                            $.ajax({
                                type: 'POST',
                                url: 'locations/fetchDistrictVillages.htm',
                                data: {districtid: districtid},
                                success: function (data) {                                    
                                    var res = JSON.parse(data);
                                    if (res !== '' && res.length > 0) {
                                        for (i in res) {
//                                            $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village + ' ' + res[i].parish + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                            $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village + ' ' + res[i].parish + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                        }
                                    }
                                }
                            });
                        }
                    }
                });
                $('#editdistrict22').change(function () {
                    $('#editvillage').val(null).trigger('change');
                    var districtid = parseInt($('#editdistrict22').val());
                    $.ajax({
                        type: 'POST',
                        url: 'locations/fetchDistrictVillages.htm',
                        data: {districtid: districtid},
                        success: function (data) {                            
                            var res = JSON.parse(data);
                            if (res !== '' && res.length > 0) {
                                $('#editvillage').html('');
                                for (i in res) {
                                    console.log(res[i].village);
//                                    $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village +  ' ' +  res[i].parish + ' ">' + res[i].village  +' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                    $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village +  ' ' +  res[i].parish + ' ">' + res[i].village  +' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                }
                            }
                        }
                    });
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
                this.$content.find('#editdistrict22').select2();
                this.$content.find('#editvillage').select2();
                $('.select2').css('width', '100%');
            }
        });
    }

    function functionEditResidence2() {
        var editvillage = $('#patient-edit-village2').text();
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Please select Current Address!',
            content: '<div id="parent-container">' +
                    '<h5><span class="text-muted">Previous Address : </span><span><strong>' + editvillage + '</strong></span></h5>' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '<label class="control-label">District</label>' +
                    '<select class="form-control" id="editdistrict22">' +
                    ' </select>' +
                    '</div>' +
                    '<div class="form-group required village">' +
                    ' <label class="control-label">Village</label>' +
                    ' <select class="form-control" id="editvillage">' +
                    ' </select>' +
                    '</div>' +
                    '</form></div>',
            boxWidth: '30%',
            minHeight: '100%',
            maxHeight: '100%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {                        
                        var editvillage3 = this.$content.find('#editvillage').val();
                        var villageEdited = $("#" + editvillage3).data("villagename24");
                        $("#residenceid").val(editvillage3);

                        var data = {
                            village: editvillage3,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updatevillage.htm",
                            data: data,
                            success: function (rep) {                                
                                $("#patient-edit-village2").text(villageEdited);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {                
                $.ajax({
                    type: 'POST',
                    url: 'locations/fetchDistricts.htm',
                    success: function (data) {
                        var res = JSON.parse(data);
                        if (res !== '' && res.length > 0) {
                            for (i in res) {
                                $('#editdistrict22').append('<option class="textbolder" id="' + res[i].id + '" data-districtname22="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                            }
                            var districtid = parseInt($('#editdistrict22').val());
                            $.ajax({
                                type: 'POST',
                                url: 'locations/fetchDistrictVillages.htm',
                                data: {districtid: districtid},
                                success: function (data) {                                    
                                    var res = JSON.parse(data);
                                    if (res !== '' && res.length > 0) {
                                        for (i in res) {
                                            $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village  + ' ' +  res[i].parish + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                        }
                                    }
                                }
                            });
                        }
                    }
                });
                $('#editdistrict22').change(function () {
                    $('#editvillage').val(null).trigger('change');
                    var districtid = parseInt($('#editdistrict22').val());
                    $.ajax({
                        type: 'POST',
                        url: 'locations/fetchDistrictVillages.htm',
                        data: {districtid: districtid},
                        success: function (data) {                            
                            var res = JSON.parse(data);
                            if (res !== '' && res.length > 0) {
                                $('#editvillage').html('');
                                for (i in res) {
                                    console.log(res[i].village);
//                                    $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village  + ' ' +  res[i].parish + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                    $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village  + ' ' +  res[i].parish + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                }
                            }
                        }
                    });
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
                this.$content.find('#editdistrict22').select2();
                this.$content.find('#editvillage').select2();
                $('.select2').css('width', '100%');
            }
        });
    }

    function functionaddResidence() {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Please select Current Address!',
            content: '<div id="parent-container">' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '<label class="control-label">District</label>' +
                    '<div id="district-select-parent"><select class="form-control" id="editdistrict22">' +
                    ' </select></div>' +
                    '</div>' +
                    '<div class="form-group required village">' +
                    ' <label class="control-label">Village</label>' +
                    ' <div id="village-select-parent"><select class="form-control" id="editvillage">' +
                    ' </select></div>' +
                    '</div>' +
                    '</form></div>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        
                        var editvillage3 = this.$content.find('#editvillage').val();
                        var villageEdited = $("#" + editvillage3).data("villagename24");
                        $("#patient-edit-village").text(villageEdited);
                        $("#residenceid").val(editvillage3);

                        var data = {
                            village: editvillage3,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updatevillage.htm",
                            data: data,
                            success: function (rep) {                                
                                $("#patient-edit-village").text(villageEdited);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $.ajax({
                    type: 'POST',
                    url: 'locations/fetchDistricts.htm',
                    success: function (data) {
                        var res = JSON.parse(data);
                        if (res !== '' && res.length > 0) {
                            for (i in res) {
                                $('#editdistrict22').append('<option class="textbolder" id="' + res[i].id + '" data-districtname22="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                            }
                            var districtid = parseInt($('#editdistrict22').val());
                            $.ajax({
                                type: 'POST',
                                url: 'locations/fetchDistrictVillages.htm',
                                data: {districtid: districtid},
                                success: function (data) {                                    
                                    var res = JSON.parse(data);
                                    if (res !== '' && res.length > 0) {
                                        for (i in res) {
//                                            $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village  + ' ' +  res[i].parish + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                            $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village  + ' ' +  res[i].parish + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                        }
                                    }
                                }
                            });
                        }
                    }
                });
                $('#editdistrict22').change(function () {
                    $('#editvillage').val(null).trigger('change');
                    var districtid = parseInt($('#editdistrict22').val());
                    $.ajax({
                        type: 'POST',
                        url: 'locations/fetchDistrictVillages.htm',
                        data: {districtid: districtid},
                        success: function (data) {                            
                            var res = JSON.parse(data);
                            if (res !== '' && res.length > 0) {
                                $('#editvillage').html('');
                                for (i in res) {
                                    console.log(res[i].village);
//                                    $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village + ' ' +  res[i].parish + ' ">' + res[i].village  + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                    $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename24="' + res[i].village + ' ' +  res[i].parish + ' ">' + res[i].village  + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                }
                            }
                        }
                    });
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
                this.$content.find('#editdistrict22').select2();
                this.$content.find('#editvillage').select2();
                $('.select2').css('width', '100%');
            }
        });
    }

    function functionaddDOB() {
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    ' <div class="form-group required">' +
                    '<label class="control-label" for="dateOfBirth">D.O.B</label>' +
                    '<input class="form-control" id="patientdobedit" value="">' +
                    ' </div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var patientdobedit = this.$content.find('#patientdobedit').val();

                        if (!patientdobedit) {
                            $.alert('provide valid D.O.B');
                            return false;
                        } else {
                            var data = {
                                patientdobedit: patientdobedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updatedob.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-dob2").text(patientdobedit);
                                    $("#old-patient-dob").hide();
                                    $("#new-patient-dob").show();
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#patientdobedit').datepicker({
                    format: "dd/mm/yyyy",
                    autoclose: true
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditDOB() {
        var editdob = $('#patient-edit-dob').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    ' <div class="form-group required">' +
                    '<label class="control-label" for="dateOfBirth">D.O.B</label>' +
                    '<input class="form-control" id="patientdobedit" value="' + editdob + '">' +
                    ' </div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var patientdobedit = this.$content.find('#patientdobedit').val();

                        if (!patientdobedit) {
                            $.alert('provide valid D.O.B');
                            return false;
                        } else {
                            var data = {
                                patientdobedit: patientdobedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updatedob.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-dob").text(patientdobedit);
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#patientdobedit').datepicker({
                    format: "dd/mm/yyyy",
                    autoclose: true
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditDOB2() {
        var editdob = $('#patient-edit-dob2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    ' <div class="form-group required">' +
                    '<label class="control-label" for="dateOfBirth">D.O.B</label>' +
                    '<input class="form-control" id="patientdobedit" value="' + editdob + '">' +
                    ' </div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var patientdobedit = this.$content.find('#patientdobedit').val();

                        if (!patientdobedit) {
                            $.alert('Please Provide valid D.O.B');
                            return false;
                        } else {
                            var data = {
                                patientdobedit: patientdobedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updatedob.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-dob2").text(patientdobedit);
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#patientdobedit').datepicker({
                    format: "dd/mm/yyyy",
                    autoclose: true
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionaddNationality() {
        $.confirm({

            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '  <label class="control-label">Nationality:</label>' +
                    '  <div>' +
                    ' <div class="form-group">' +
                    '<option selected disabled>-- Select Nationality--</option>' +
                    ' <option class="textbolder" value="ugandan">Ugandan</option>' +
                    '  <select class="form-control"  id="nationalityedit" name="country" >' +
                    ' <option class="textbolder" value="afghan">Afghan</option>' +
                    ' <option class="textbolder" value="albanian">Albanian</option>' +
                    ' <option class="textbolder" value="algerian">Algerian</option>' +
                    ' <option class="textbolder" value="american">American</option>' +
                    ' <option class="textbolder" value="andorran">Andorran</option>' +
                    ' <option class="textbolder" value="angolan">Angolan</option>' +
                    '  <option class="textbolder" value="antiguans">Antiguans</option>' +
                    '  <option class="textbolder" value="argentinean">Argentinean</option>' +
                    ' <option class="textbolder" value="armenian">Armenian</option>' +
                    ' <option class="textbolder" value="australian">Australian</option>' +
                    ' <option class="textbolder" value="austrian">Austrian</option>' +
                    ' <option class="textbolder" value="azerbaijani">Azerbaijani</option>' +
                    ' <option class="textbolder" value="bahamian">Bahamian</option>' +
                    ' <option class="textbolder" value="bahraini">Bahraini</option>' +
                    ' <option class="textbolder" value="bangladeshi">Bangladeshi</option>' +
                    '   <option class="textbolder" value="barbadian">Barbadian</option>' +
                    '   <option class="textbolder" value="barbudans">Barbudans</option>' +
                    '   <option class="textbolder" value="batswana">Batswana</option>' +
                    '  <option class="textbolder" value="belarusian">Belarusian</option>' +
                    '  <option class="textbolder" value="belgian">Belgian</option>' +
                    '  <option class="textbolder" value="belizean">Belizean</option>' +
                    ' <option class="textbolder" value="beninese">Beninese</option>' +
                    '  <option class="textbolder" value="bhutanese">Bhutanese</option>' +
                    ' <option class="textbolder" value="bolivian">Bolivian</option>' +
                    ' <option class="textbolder" value="bosnian">Bosnian</option>' +
                    ' <option class="textbolder" value="brazilian">Brazilian</option>' +
                    ' <option class="textbolder" value="british">British</option>' +
                    ' <option class="textbolder" value="bruneian">Bruneian</option>' +
                    ' <option class="textbolder" value="bulgarian">Bulgarian</option>' +
                    ' <option class="textbolder" value="burkinabe">Burkinabe</option>' +
                    '<option class="textbolder" value="burmese">Burmese</option>' +
                    ' <option class="textbolder" value="burundian">Burundian</option>' +
                    ' <option class="textbolder" value="cambodian">Cambodian</option>' +
                    '  <option class="textbolder" value="cameroonian">Cameroonian</option>' +
                    '  <option class="textbolder" value="canadian">Canadian</option>' +
                    ' <option class="textbolder" value="cape verdean">Cape Verdean</option>' +
                    ' <option class="textbolder" value="central african">Central African</option>' +
                    ' <option class="textbolder" value="chadian">Chadian</option>' +
                    ' <option class="textbolder" value="chilean">Chilean</option>' +
                    ' <option class="textbolder" value="chinese">Chinese</option>' +
                    ' <option class="textbolder" value="colombian">Colombian</option>' +
                    ' <option class="textbolder" value="comoran">Comoran</option>' +
                    ' <option class="textbolder" value="congolese">Congolese</option>' +
                    ' <option class="textbolder" value="costa rican">Costa Rican</option>' +
                    '  <option class="textbolder" value="croatian">Croatian</option>' +
                    '  <option class="textbolder" value="cuban">Cuban</option>' +
                    '  <option class="textbolder" value="cypriot">Cypriot</option>' +
                    '  <option class="textbolder" value="czech">Czech</option>' +
                    '  <option class="textbolder" value="danish">Danish</option>' +
                    '  <option class="textbolder" value="djibouti">Djibouti</option>' +
                    '  <option class="textbolder" value="dominican">Dominican</option>' +
                    '  <option class="textbolder" value="dutch">Dutch</option>' +
                    '  <option class="textbolder" value="east timorese">East Timorese</option>' +
                    '  <option class="textbolder" value="ecuadorean">Ecuadorean</option>' +
                    ' <option class="textbolder" value="egyptian">Egyptian</option>' +
                    ' <option class="textbolder" value="emirian">Emirian</option>' +
                    ' <option class="textbolder" value="equatorial guinean">Equatorial Guinean</option>' +
                    ' <option class="textbolder" value="eritrean">Eritrean</option>' +
                    ' <option class="textbolder" value="estonian">Estonian</option>' +
                    ' <option class="textbolder" value="ethiopian">Ethiopian</option>' +
                    '<option class="textbolder" value="fijian">Fijian</option>' +
                    '<option class="textbolder" value="filipino">Filipino</option>' +
                    ' <option class="textbolder" value="finnish">Finnish</option>' +
                    ' <option class="textbolder" value="french">French</option>' +
                    '  <option class="textbolder" value="gabonese">Gabonese</option>' +
                    ' <option class="textbolder" value="gambian">Gambian</option>' +
                    ' <option class="textbolder" value="georgian">Georgian</option>' +
                    ' <option class="textbolder" value="german">German</option>' +
                    ' <option class="textbolder" value="ghanaian">Ghanaian</option>' +
                    '  <option class="textbolder" value="greek">Greek</option>' +
                    ' <option class="textbolder" value="grenadian">Grenadian</option>' +
                    '<option class="textbolder" value="guatemalan">Guatemalan</option>' +
                    ' <option class="textbolder" value="guinea-bissauan">Guinea-Bissauan</option>' +
                    ' <option class="textbolder" value="guinean">Guinean</option>' +
                    ' <option class="textbolder" value="guyanese">Guyanese</option>' +
                    ' <option class="textbolder" value="haitian">Haitian</option>' +
                    '  <option class="textbolder" value="herzegovinian">Herzegovinian</option>' +
                    '  <option class="textbolder" value="honduran">Honduran</option>' +
                    ' <option class="textbolder" value="hungarian">Hungarian</option>' +
                    '<option class="textbolder" value="icelander">Icelander</option>' +
                    '  <option class="textbolder" value="indian">Indian</option>' +
                    '  <option class="textbolder" value="indonesian">Indonesian</option>' +
                    ' <option class="textbolder" value="iranian">Iranian</option>' +
                    ' <option class="textbolder" value="iraqi">Iraqi</option>' +
                    ' <option class="textbolder" value="irish">Irish</option>' +
                    ' <option class="textbolder" value="israeli">Israeli</option>' +
                    ' <option class="textbolder" value="italian">Italian</option>' +
                    '   <option class="textbolder" value="ivorian">Ivorian</option>' +
                    '   <option class="textbolder" value="jamaican">Jamaican</option>' +
                    '   <option class="textbolder" value="japanese">Japanese</option>' +
                    '  <option class="textbolder" value="jordanian">Jordanian</option>' +
                    '  <option class="textbolder" value="kazakhstani">Kazakhstani</option>' +
                    ' <option class="textbolder" value="kenyan">Kenyan</option>' +
                    ' <option class="textbolder" value="kittian and nevisian">Kittian and Nevisian</option>' +
                    '  <option class="textbolder" value="kuwaiti">Kuwaiti</option>' +
                    ' <option class="textbolder" value="kyrgyz">Kyrgyz</option>' +
                    '<option class="textbolder" value="laotian">Laotian</option>' +
                    ' <option class="textbolder" value="latvian">Latvian</option>' +
                    ' <option class="textbolder" value="lebanese">Lebanese</option>' +
                    ' <option class="textbolder" value="liberian">Liberian</option>' +
                    '<option class="textbolder" value="libyan">Libyan</option>' +
                    ' <option class="textbolder" value="liechtensteiner">Liechtensteiner</option>' +
                    ' <option class="textbolder"value="lithuanian">Lithuanian</option>' +
                    ' <option class="textbolder" value="luxembourger">Luxembourger</option>' +
                    '  <option class="textbolder" value="macedonian">Macedonian</option>' +
                    ' <option class="textbolder" value="malagasy">Malagasy</option>' +
                    ' <option class="textbolder" value="malawian">Malawian</option>' +
                    ' <option class="textbolder" value="malaysian">Malaysian</option>' +
                    ' <option class="textbolder" value="maldivan">Maldivan</option>' +
                    ' <option class="textbolder" value="malian">Malian</option>' +
                    ' <option class="textbolder" value="maltese">Maltese</option>' +
                    ' <option class="textbolder" value="marshallese">Marshallese</option>' +
                    ' <option class="textbolder" value="mauritanian">Mauritanian</option>' +
                    '  <option class="textbolder" value="mauritian">Mauritian</option>' +
                    ' <option class="textbolder" value="mexican">Mexican</option>' +
                    ' <option class="textbolder" value="micronesian">Micronesian</option>' +
                    ' <option class="textbolder" value="moldovan">Moldovan</option>' +
                    ' <option class="textbolder" value="monacan">Monacan</option>' +
                    ' <option class="textbolder" value="mongolian">Mongolian</option>' +
                    ' <option class="textbolder" value="moroccan">Moroccan</option>' +
                    ' <option class="textbolder" value="mosotho">Mosotho</option>' +
                    ' <option class="textbolder" value="motswana">Motswana</option>' +
                    ' <option class="textbolder" value="mozambican">Mozambican</option>' +
                    ' <option class="textbolder" value="namibian">Namibian</option>' +
                    ' <option class="textbolder" value="nauruan">Nauruan</option>' +
                    ' <option class="textbolder" value="nepalese">Nepalese</option>' +
                    ' <option class="textbolder" value="new zealander">New Zealander</option>' +
                    ' <option class="textbolder" value="ni-vanuatu">Ni-Vanuatu</option>' +
                    ' <option class="textbolder" value="nicaraguan">Nicaraguan</option>' +
                    ' <option class="textbolder" value="nigerien">Nigerien</option>' +
                    '  <option class="textbolder" value="north korean">North Korean</option>' +
                    '  <option class="textbolder" value="northern irish">Northern Irish</option>' +
                    '  <option class="textbolder" value="norwegian">Norwegian</option>' +
                    '  <option class="textbolder" value="omani">Omani</option>' +
                    '  <option class="textbolder" value="pakistani">Pakistani</option>' +
                    ' <option class="textbolder" value="palauan">Palauan</option>' +
                    ' <option class="textbolder" value="panamanian">Panamanian</option>' +
                    '<option class="textbolder" value="papua new guinean">Papua New Guinean</option>' +
                    '<option class="textbolder" value="paraguayan">Paraguayan</option>' +
                    ' <option class="textbolder" value="peruvian">Peruvian</option>' +
                    '  <option class="textbolder" value="polish">Polish</option>' +
                    '  <option class="textbolder" value="portuguese">Portuguese</option>' +
                    '  <option class="textbolder" value="qatari">Qatari</option>' +
                    '<option class="textbolder" value="romanian">Romanian</option>' +
                    '<option class="textbolder" value="russian">Russian</option>' +
                    ' <option class="textbolder" value="rwandan">Rwandan</option>' +
                    ' <option class="textbolder" value="saint lucian">Saint Lucian</option>' +
                    ' <option class="textbolder" value="salvadoran">Salvadoran</option>' +
                    ' <option class="textbolder" value="samoan">Samoan</option>' +
                    ' <option class="textbolder" value="san marinese">San Marinese</option>' +
                    ' <option class="textbolder" value="sao tomean">Sao Tomean</option>' +
                    '  <option class="textbolder" value="saudi">Saudi</option>' +
                    ' <option class="textbolder" value="scottish">Scottish</option>' +
                    ' <option class="textbolder" value="senegalese">Senegalese</option>' +
                    '<option class="textbolder" value="serbian">Serbian</option>' +
                    '  <option class="textbolder" value="seychellois">Seychellois</option>' +
                    '  <option class="textbolder" value="sierra leonean">Sierra Leonean</option>' +
                    '  <option class="textbolder" value="singaporean">Singaporean</option>' +
                    '  <option class="textbolder" value="slovakian">Slovakian</option>' +
                    '  <option class="textbolder" value="slovenian">Slovenian</option>' +
                    '  <option class="textbolder" value="solomon islander">Solomon Islander</option>' +
                    ' <option class="textbolder" value="somali">Somali</option>' +
                    '  <option class="textbolder" value="south african">South African</option>' +
                    '  <option class="textbolder" value="south korean">South Korean</option>' +
                    ' <option class="textbolder" value="spanish">Spanish</option>' +
                    ' <option class="textbolder" value="sri lankan">Sri Lankan</option>' +
                    ' <option class="textbolder" value="sudanese">Sudanese</option>' +
                    ' <option class="textbolder" value="surinamer">Surinamer</option>' +
                    ' <option class="textbolder" value="swazi">Swazi</option>' +
                    ' <option class="textbolder" value="swedish">Swedish</option>' +
                    ' <option class="textbolder" value="swiss">Swiss</option>' +
                    ' <option class="textbolder" value="syrian">Syrian</option>' +
                    ' <option class="textbolder" value="taiwanese">Taiwanese</option>' +
                    ' <option class="textbolder" value="tajik">Tajik</option>' +
                    '  <option class="textbolder" value="tanzanian">Tanzanian</option>' +
                    ' <option class="textbolder" value="thai">Thai</option>' +
                    '<option class="textbolder" value="togolese">Togolese</option>' +
                    '<option class="textbolder" value="tongan">Tongan</option>' +
                    '<option class="textbolder" value="trinidadian or tobagonian">Trinidadian or Tobagonian</option>' +
                    '  <option class="textbolder" value="tunisian">Tunisian</option>' +
                    '  <option class="textbolder" value="turkish">Turkish</option>' +
                    '<option class="textbolder" value="tuvaluan">Tuvaluan</option>' +
                    ' <option class="textbolder" value="ukrainian">Ukrainian</option>' +
                    ' <option class="textbolder" value="uruguayan">Uruguayan</option>' +
                    '  <option class="textbolder" value="uzbekistani">Uzbekistani</option>' +
                    ' <option class="textbolder" value="venezuelan">Venezuelan</option>' +
                    '  <option class="textbolder" value="vietnamese">Vietnamese</option>' +
                    ' <option class="textbolder" value="welsh">Welsh</option>' +
                    '  <option class="textbolder" value="yemenite">Yemenite</option>' +
                    '  <option class="textbolder" value="zambian">Zambian</option>' +
                    '  <option class="textbolder" value="zimbabwean">Zimbabwean</option>' +
                    '</select>' +
                    '</div>' +
                    ' </div>' +
                    ' </div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var nationalityedit = this.$content.find('#nationalityedit').val();
                        if (!nationalityedit) {
                            $.alert('Please Select Valid Nationality!');
                            return false;

                        } else {
                            var data = {
                                nationalityedit: nationalityedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updatenationality.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-nationality2").text(nationalityedit);
                                    $("#old-patient-nationality").hide();
                                    $("#new-patient-nationality").show();
                                }
                            });
                        }

                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditNationality() {
        var editNationality = $('#patient-edit-nationality').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '  <label class="control-label">Nationality:</label>' +
                    '  <div>' +
                    ' <div class="form-group">' +
                    '  <select class="form-control"  id="nationalityedit" name="country" >' +
                    ' <option class="textbolder" value="' + editNationality + '">' + editNationality + '</option>' +
                    ' <option class="textbolder" value="afghan">Afghan</option>' +
                    ' <option class="textbolder" value="albanian">Albanian</option>' +
                    ' <option class="textbolder" value="algerian">Algerian</option>' +
                    ' <option class="textbolder" value="american">American</option>' +
                    ' <option class="textbolder" value="andorran">Andorran</option>' +
                    ' <option class="textbolder" value="angolan">Angolan</option>' +
                    '  <option class="textbolder" value="antiguans">Antiguans</option>' +
                    '  <option class="textbolder" value="argentinean">Argentinean</option>' +
                    ' <option class="textbolder" value="armenian">Armenian</option>' +
                    ' <option class="textbolder" value="australian">Australian</option>' +
                    ' <option class="textbolder" value="austrian">Austrian</option>' +
                    ' <option class="textbolder" value="azerbaijani">Azerbaijani</option>' +
                    ' <option class="textbolder" value="bahamian">Bahamian</option>' +
                    ' <option class="textbolder" value="bahraini">Bahraini</option>' +
                    ' <option class="textbolder" value="bangladeshi">Bangladeshi</option>' +
                    '   <option class="textbolder" value="barbadian">Barbadian</option>' +
                    '   <option class="textbolder" value="barbudans">Barbudans</option>' +
                    '   <option class="textbolder" value="batswana">Batswana</option>' +
                    '  <option class="textbolder" value="belarusian">Belarusian</option>' +
                    '  <option class="textbolder" value="belgian">Belgian</option>' +
                    '  <option class="textbolder" value="belizean">Belizean</option>' +
                    ' <option class="textbolder" value="beninese">Beninese</option>' +
                    '  <option class="textbolder" value="bhutanese">Bhutanese</option>' +
                    ' <option class="textbolder" value="bolivian">Bolivian</option>' +
                    ' <option class="textbolder" value="bosnian">Bosnian</option>' +
                    ' <option class="textbolder" value="brazilian">Brazilian</option>' +
                    ' <option class="textbolder" value="british">British</option>' +
                    ' <option class="textbolder" value="bruneian">Bruneian</option>' +
                    ' <option class="textbolder" value="bulgarian">Bulgarian</option>' +
                    ' <option class="textbolder" value="burkinabe">Burkinabe</option>' +
                    '<option class="textbolder" value="burmese">Burmese</option>' +
                    ' <option class="textbolder" value="burundian">Burundian</option>' +
                    ' <option class="textbolder" value="cambodian">Cambodian</option>' +
                    '  <option class="textbolder" value="cameroonian">Cameroonian</option>' +
                    '  <option class="textbolder" value="canadian">Canadian</option>' +
                    ' <option class="textbolder" value="cape verdean">Cape Verdean</option>' +
                    ' <option class="textbolder" value="central african">Central African</option>' +
                    ' <option class="textbolder" value="chadian">Chadian</option>' +
                    ' <option class="textbolder" value="chilean">Chilean</option>' +
                    ' <option class="textbolder" value="chinese">Chinese</option>' +
                    ' <option class="textbolder" value="colombian">Colombian</option>' +
                    ' <option class="textbolder" value="comoran">Comoran</option>' +
                    ' <option class="textbolder" value="congolese">Congolese</option>' +
                    ' <option class="textbolder" value="costa rican">Costa Rican</option>' +
                    '  <option class="textbolder" value="croatian">Croatian</option>' +
                    '  <option class="textbolder" value="cuban">Cuban</option>' +
                    '  <option class="textbolder" value="cypriot">Cypriot</option>' +
                    '  <option class="textbolder" value="czech">Czech</option>' +
                    '  <option class="textbolder" value="danish">Danish</option>' +
                    '  <option class="textbolder" value="djibouti">Djibouti</option>' +
                    '  <option class="textbolder" value="dominican">Dominican</option>' +
                    '  <option class="textbolder" value="dutch">Dutch</option>' +
                    '  <option class="textbolder" value="east timorese">East Timorese</option>' +
                    '  <option class="textbolder" value="ecuadorean">Ecuadorean</option>' +
                    ' <option class="textbolder" value="egyptian">Egyptian</option>' +
                    ' <option class="textbolder" value="emirian">Emirian</option>' +
                    ' <option class="textbolder" value="equatorial guinean">Equatorial Guinean</option>' +
                    ' <option class="textbolder" value="eritrean">Eritrean</option>' +
                    ' <option class="textbolder" value="estonian">Estonian</option>' +
                    ' <option class="textbolder" value="ethiopian">Ethiopian</option>' +
                    '<option class="textbolder" value="fijian">Fijian</option>' +
                    '<option class="textbolder" value="filipino">Filipino</option>' +
                    ' <option class="textbolder" value="finnish">Finnish</option>' +
                    ' <option class="textbolder" value="french">French</option>' +
                    '  <option class="textbolder" value="gabonese">Gabonese</option>' +
                    ' <option class="textbolder" value="gambian">Gambian</option>' +
                    ' <option class="textbolder" value="georgian">Georgian</option>' +
                    ' <option class="textbolder" value="german">German</option>' +
                    ' <option class="textbolder" value="ghanaian">Ghanaian</option>' +
                    '  <option class="textbolder" value="greek">Greek</option>' +
                    ' <option class="textbolder" value="grenadian">Grenadian</option>' +
                    '<option class="textbolder" value="guatemalan">Guatemalan</option>' +
                    ' <option class="textbolder" value="guinea-bissauan">Guinea-Bissauan</option>' +
                    ' <option class="textbolder" value="guinean">Guinean</option>' +
                    ' <option class="textbolder" value="guyanese">Guyanese</option>' +
                    ' <option class="textbolder" value="haitian">Haitian</option>' +
                    '  <option class="textbolder" value="herzegovinian">Herzegovinian</option>' +
                    '  <option class="textbolder" value="honduran">Honduran</option>' +
                    ' <option class="textbolder" value="hungarian">Hungarian</option>' +
                    '<option class="textbolder" value="icelander">Icelander</option>' +
                    '  <option class="textbolder" value="indian">Indian</option>' +
                    '  <option class="textbolder" value="indonesian">Indonesian</option>' +
                    ' <option class="textbolder" value="iranian">Iranian</option>' +
                    ' <option class="textbolder" value="iraqi">Iraqi</option>' +
                    ' <option class="textbolder" value="irish">Irish</option>' +
                    ' <option class="textbolder" value="israeli">Israeli</option>' +
                    ' <option class="textbolder" value="italian">Italian</option>' +
                    '   <option class="textbolder" value="ivorian">Ivorian</option>' +
                    '   <option class="textbolder" value="jamaican">Jamaican</option>' +
                    '   <option class="textbolder" value="japanese">Japanese</option>' +
                    '  <option class="textbolder" value="jordanian">Jordanian</option>' +
                    '  <option class="textbolder" value="kazakhstani">Kazakhstani</option>' +
                    ' <option class="textbolder" value="kenyan">Kenyan</option>' +
                    ' <option class="textbolder" value="kittian and nevisian">Kittian and Nevisian</option>' +
                    '  <option class="textbolder" value="kuwaiti">Kuwaiti</option>' +
                    ' <option class="textbolder" value="kyrgyz">Kyrgyz</option>' +
                    '<option class="textbolder" value="laotian">Laotian</option>' +
                    ' <option class="textbolder" value="latvian">Latvian</option>' +
                    ' <option class="textbolder" value="lebanese">Lebanese</option>' +
                    ' <option class="textbolder" value="liberian">Liberian</option>' +
                    '<option class="textbolder" value="libyan">Libyan</option>' +
                    ' <option class="textbolder" value="liechtensteiner">Liechtensteiner</option>' +
                    ' <option class="textbolder"value="lithuanian">Lithuanian</option>' +
                    ' <option class="textbolder" value="luxembourger">Luxembourger</option>' +
                    '  <option class="textbolder" value="macedonian">Macedonian</option>' +
                    ' <option class="textbolder" value="malagasy">Malagasy</option>' +
                    ' <option class="textbolder" value="malawian">Malawian</option>' +
                    ' <option class="textbolder" value="malaysian">Malaysian</option>' +
                    ' <option class="textbolder" value="maldivan">Maldivan</option>' +
                    ' <option class="textbolder" value="malian">Malian</option>' +
                    ' <option class="textbolder" value="maltese">Maltese</option>' +
                    ' <option class="textbolder" value="marshallese">Marshallese</option>' +
                    ' <option class="textbolder" value="mauritanian">Mauritanian</option>' +
                    '  <option class="textbolder" value="mauritian">Mauritian</option>' +
                    ' <option class="textbolder" value="mexican">Mexican</option>' +
                    ' <option class="textbolder" value="micronesian">Micronesian</option>' +
                    ' <option class="textbolder" value="moldovan">Moldovan</option>' +
                    ' <option class="textbolder" value="monacan">Monacan</option>' +
                    ' <option class="textbolder" value="mongolian">Mongolian</option>' +
                    ' <option class="textbolder" value="moroccan">Moroccan</option>' +
                    ' <option class="textbolder" value="mosotho">Mosotho</option>' +
                    ' <option class="textbolder" value="motswana">Motswana</option>' +
                    ' <option class="textbolder" value="mozambican">Mozambican</option>' +
                    ' <option class="textbolder" value="namibian">Namibian</option>' +
                    ' <option class="textbolder" value="nauruan">Nauruan</option>' +
                    ' <option class="textbolder" value="nepalese">Nepalese</option>' +
                    ' <option class="textbolder" value="new zealander">New Zealander</option>' +
                    ' <option class="textbolder" value="ni-vanuatu">Ni-Vanuatu</option>' +
                    ' <option class="textbolder" value="nicaraguan">Nicaraguan</option>' +
                    ' <option class="textbolder" value="nigerien">Nigerien</option>' +
                    '  <option class="textbolder" value="north korean">North Korean</option>' +
                    '  <option class="textbolder" value="northern irish">Northern Irish</option>' +
                    '  <option class="textbolder" value="norwegian">Norwegian</option>' +
                    '  <option class="textbolder" value="omani">Omani</option>' +
                    '  <option class="textbolder" value="pakistani">Pakistani</option>' +
                    ' <option class="textbolder" value="palauan">Palauan</option>' +
                    ' <option class="textbolder" value="panamanian">Panamanian</option>' +
                    '<option class="textbolder" value="papua new guinean">Papua New Guinean</option>' +
                    '<option class="textbolder" value="paraguayan">Paraguayan</option>' +
                    ' <option class="textbolder" value="peruvian">Peruvian</option>' +
                    '  <option class="textbolder" value="polish">Polish</option>' +
                    '  <option class="textbolder" value="portuguese">Portuguese</option>' +
                    '  <option class="textbolder" value="qatari">Qatari</option>' +
                    '<option class="textbolder" value="romanian">Romanian</option>' +
                    '<option class="textbolder" value="russian">Russian</option>' +
                    ' <option class="textbolder" value="rwandan">Rwandan</option>' +
                    ' <option class="textbolder" value="saint lucian">Saint Lucian</option>' +
                    ' <option class="textbolder" value="salvadoran">Salvadoran</option>' +
                    ' <option class="textbolder" value="samoan">Samoan</option>' +
                    ' <option class="textbolder" value="san marinese">San Marinese</option>' +
                    ' <option class="textbolder" value="sao tomean">Sao Tomean</option>' +
                    '  <option class="textbolder" value="saudi">Saudi</option>' +
                    ' <option class="textbolder" value="scottish">Scottish</option>' +
                    ' <option class="textbolder" value="senegalese">Senegalese</option>' +
                    '<option class="textbolder" value="serbian">Serbian</option>' +
                    '  <option class="textbolder" value="seychellois">Seychellois</option>' +
                    '  <option class="textbolder" value="sierra leonean">Sierra Leonean</option>' +
                    '  <option class="textbolder" value="singaporean">Singaporean</option>' +
                    '  <option class="textbolder" value="slovakian">Slovakian</option>' +
                    '  <option class="textbolder" value="slovenian">Slovenian</option>' +
                    '  <option class="textbolder" value="solomon islander">Solomon Islander</option>' +
                    ' <option class="textbolder" value="somali">Somali</option>' +
                    '  <option class="textbolder" value="south african">South African</option>' +
                    '  <option class="textbolder" value="south korean">South Korean</option>' +
                    ' <option class="textbolder" value="spanish">Spanish</option>' +
                    ' <option class="textbolder" value="sri lankan">Sri Lankan</option>' +
                    ' <option class="textbolder" value="sudanese">Sudanese</option>' +
                    ' <option class="textbolder" value="surinamer">Surinamer</option>' +
                    ' <option class="textbolder" value="swazi">Swazi</option>' +
                    ' <option class="textbolder" value="swedish">Swedish</option>' +
                    ' <option class="textbolder" value="swiss">Swiss</option>' +
                    ' <option class="textbolder" value="syrian">Syrian</option>' +
                    ' <option class="textbolder" value="taiwanese">Taiwanese</option>' +
                    ' <option class="textbolder" value="tajik">Tajik</option>' +
                    '  <option class="textbolder" value="tanzanian">Tanzanian</option>' +
                    ' <option class="textbolder" value="thai">Thai</option>' +
                    '<option class="textbolder" value="togolese">Togolese</option>' +
                    '<option class="textbolder" value="tongan">Tongan</option>' +
                    '<option class="textbolder" value="trinidadian or tobagonian">Trinidadian or Tobagonian</option>' +
                    '  <option class="textbolder" value="tunisian">Tunisian</option>' +
                    '  <option class="textbolder" value="turkish">Turkish</option>' +
                    '<option class="textbolder" value="tuvaluan">Tuvaluan</option>' +
                    ' <option class="textbolder" value="ugandan">Ugandan</option>' +
                    ' <option class="textbolder" value="ukrainian">Ukrainian</option>' +
                    ' <option class="textbolder" value="uruguayan">Uruguayan</option>' +
                    '  <option class="textbolder" value="uzbekistani">Uzbekistani</option>' +
                    ' <option class="textbolder" value="venezuelan">Venezuelan</option>' +
                    '  <option class="textbolder" value="vietnamese">Vietnamese</option>' +
                    ' <option class="textbolder" value="welsh">Welsh</option>' +
                    '  <option class="textbolder" value="yemenite">Yemenite</option>' +
                    '  <option class="textbolder" value="zambian">Zambian</option>' +
                    '  <option class="textbolder" value="zimbabwean">Zimbabwean</option>' +
                    '</select>' +
                    '</div>' +
                    ' </div>' +
                    ' </div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var nationalityedit = this.$content.find('#nationalityedit').val();

                        var data = {
                            nationalityedit: nationalityedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updatenationality.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-nationality").text(nationalityedit);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditNationality2() {
        var editNationality = $('#patient-edit-nationality2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '  <label class="control-label">Nationality:</label>' +
                    '  <div>' +
                    ' <div class="form-group">' +
                    '  <select class="form-control"  id="nationalityedit" name="country" >' +
                    ' <option class="textbolder" value="' + editNationality + '">' + editNationality + '</option>' +
                    ' <option class="textbolder" value="afghan">Afghan</option>' +
                    ' <option class="textbolder" value="albanian">Albanian</option>' +
                    ' <option class="textbolder" value="algerian">Algerian</option>' +
                    ' <option class="textbolder" value="american">American</option>' +
                    ' <option class="textbolder" value="andorran">Andorran</option>' +
                    ' <option class="textbolder" value="angolan">Angolan</option>' +
                    '  <option class="textbolder" value="antiguans">Antiguans</option>' +
                    '  <option class="textbolder" value="argentinean">Argentinean</option>' +
                    ' <option class="textbolder" value="armenian">Armenian</option>' +
                    ' <option class="textbolder" value="australian">Australian</option>' +
                    ' <option class="textbolder" value="austrian">Austrian</option>' +
                    ' <option class="textbolder" value="azerbaijani">Azerbaijani</option>' +
                    ' <option class="textbolder" value="bahamian">Bahamian</option>' +
                    ' <option class="textbolder" value="bahraini">Bahraini</option>' +
                    ' <option class="textbolder" value="bangladeshi">Bangladeshi</option>' +
                    '   <option class="textbolder" value="barbadian">Barbadian</option>' +
                    '   <option class="textbolder" value="barbudans">Barbudans</option>' +
                    '   <option class="textbolder" value="batswana">Batswana</option>' +
                    '  <option class="textbolder" value="belarusian">Belarusian</option>' +
                    '  <option class="textbolder" value="belgian">Belgian</option>' +
                    '  <option class="textbolder" value="belizean">Belizean</option>' +
                    ' <option class="textbolder" value="beninese">Beninese</option>' +
                    '  <option class="textbolder" value="bhutanese">Bhutanese</option>' +
                    ' <option class="textbolder" value="bolivian">Bolivian</option>' +
                    ' <option class="textbolder" value="bosnian">Bosnian</option>' +
                    ' <option class="textbolder" value="brazilian">Brazilian</option>' +
                    ' <option class="textbolder" value="british">British</option>' +
                    ' <option class="textbolder" value="bruneian">Bruneian</option>' +
                    ' <option class="textbolder" value="bulgarian">Bulgarian</option>' +
                    ' <option class="textbolder" value="burkinabe">Burkinabe</option>' +
                    '<option class="textbolder" value="burmese">Burmese</option>' +
                    ' <option class="textbolder" value="burundian">Burundian</option>' +
                    ' <option class="textbolder" value="cambodian">Cambodian</option>' +
                    '  <option class="textbolder" value="cameroonian">Cameroonian</option>' +
                    '  <option class="textbolder" value="canadian">Canadian</option>' +
                    ' <option class="textbolder" value="cape verdean">Cape Verdean</option>' +
                    ' <option class="textbolder" value="central african">Central African</option>' +
                    ' <option class="textbolder" value="chadian">Chadian</option>' +
                    ' <option class="textbolder" value="chilean">Chilean</option>' +
                    ' <option class="textbolder" value="chinese">Chinese</option>' +
                    ' <option class="textbolder" value="colombian">Colombian</option>' +
                    ' <option class="textbolder" value="comoran">Comoran</option>' +
                    ' <option class="textbolder" value="congolese">Congolese</option>' +
                    ' <option class="textbolder" value="costa rican">Costa Rican</option>' +
                    '  <option class="textbolder" value="croatian">Croatian</option>' +
                    '  <option class="textbolder" value="cuban">Cuban</option>' +
                    '  <option class="textbolder" value="cypriot">Cypriot</option>' +
                    '  <option class="textbolder" value="czech">Czech</option>' +
                    '  <option class="textbolder" value="danish">Danish</option>' +
                    '  <option class="textbolder" value="djibouti">Djibouti</option>' +
                    '  <option class="textbolder" value="dominican">Dominican</option>' +
                    '  <option class="textbolder" value="dutch">Dutch</option>' +
                    '  <option class="textbolder" value="east timorese">East Timorese</option>' +
                    '  <option class="textbolder" value="ecuadorean">Ecuadorean</option>' +
                    ' <option class="textbolder" value="egyptian">Egyptian</option>' +
                    ' <option class="textbolder" value="emirian">Emirian</option>' +
                    ' <option class="textbolder" value="equatorial guinean">Equatorial Guinean</option>' +
                    ' <option class="textbolder" value="eritrean">Eritrean</option>' +
                    ' <option class="textbolder" value="estonian">Estonian</option>' +
                    ' <option class="textbolder" value="ethiopian">Ethiopian</option>' +
                    '<option class="textbolder" value="fijian">Fijian</option>' +
                    '<option class="textbolder" value="filipino">Filipino</option>' +
                    ' <option class="textbolder" value="finnish">Finnish</option>' +
                    ' <option class="textbolder" value="french">French</option>' +
                    '  <option class="textbolder" value="gabonese">Gabonese</option>' +
                    ' <option class="textbolder" value="gambian">Gambian</option>' +
                    ' <option class="textbolder" value="georgian">Georgian</option>' +
                    ' <option class="textbolder" value="german">German</option>' +
                    ' <option class="textbolder" value="ghanaian">Ghanaian</option>' +
                    '  <option class="textbolder" value="greek">Greek</option>' +
                    ' <option class="textbolder" value="grenadian">Grenadian</option>' +
                    '<option class="textbolder" value="guatemalan">Guatemalan</option>' +
                    ' <option class="textbolder" value="guinea-bissauan">Guinea-Bissauan</option>' +
                    ' <option class="textbolder" value="guinean">Guinean</option>' +
                    ' <option class="textbolder" value="guyanese">Guyanese</option>' +
                    ' <option class="textbolder" value="haitian">Haitian</option>' +
                    '  <option class="textbolder" value="herzegovinian">Herzegovinian</option>' +
                    '  <option class="textbolder" value="honduran">Honduran</option>' +
                    ' <option class="textbolder" value="hungarian">Hungarian</option>' +
                    '<option class="textbolder" value="icelander">Icelander</option>' +
                    '  <option class="textbolder" value="indian">Indian</option>' +
                    '  <option class="textbolder" value="indonesian">Indonesian</option>' +
                    ' <option class="textbolder" value="iranian">Iranian</option>' +
                    ' <option class="textbolder" value="iraqi">Iraqi</option>' +
                    ' <option class="textbolder" value="irish">Irish</option>' +
                    ' <option class="textbolder" value="israeli">Israeli</option>' +
                    ' <option class="textbolder" value="italian">Italian</option>' +
                    '   <option class="textbolder" value="ivorian">Ivorian</option>' +
                    '   <option class="textbolder" value="jamaican">Jamaican</option>' +
                    '   <option class="textbolder" value="japanese">Japanese</option>' +
                    '  <option class="textbolder" value="jordanian">Jordanian</option>' +
                    '  <option class="textbolder" value="kazakhstani">Kazakhstani</option>' +
                    ' <option class="textbolder" value="kenyan">Kenyan</option>' +
                    ' <option class="textbolder" value="kittian and nevisian">Kittian and Nevisian</option>' +
                    '  <option class="textbolder" value="kuwaiti">Kuwaiti</option>' +
                    ' <option class="textbolder" value="kyrgyz">Kyrgyz</option>' +
                    '<option class="textbolder" value="laotian">Laotian</option>' +
                    ' <option class="textbolder" value="latvian">Latvian</option>' +
                    ' <option class="textbolder" value="lebanese">Lebanese</option>' +
                    ' <option class="textbolder" value="liberian">Liberian</option>' +
                    '<option class="textbolder" value="libyan">Libyan</option>' +
                    ' <option class="textbolder" value="liechtensteiner">Liechtensteiner</option>' +
                    ' <option class="textbolder"value="lithuanian">Lithuanian</option>' +
                    ' <option class="textbolder" value="luxembourger">Luxembourger</option>' +
                    '  <option class="textbolder" value="macedonian">Macedonian</option>' +
                    ' <option class="textbolder" value="malagasy">Malagasy</option>' +
                    ' <option class="textbolder" value="malawian">Malawian</option>' +
                    ' <option class="textbolder" value="malaysian">Malaysian</option>' +
                    ' <option class="textbolder" value="maldivan">Maldivan</option>' +
                    ' <option class="textbolder" value="malian">Malian</option>' +
                    ' <option class="textbolder" value="maltese">Maltese</option>' +
                    ' <option class="textbolder" value="marshallese">Marshallese</option>' +
                    ' <option class="textbolder" value="mauritanian">Mauritanian</option>' +
                    '  <option class="textbolder" value="mauritian">Mauritian</option>' +
                    ' <option class="textbolder" value="mexican">Mexican</option>' +
                    ' <option class="textbolder" value="micronesian">Micronesian</option>' +
                    ' <option class="textbolder" value="moldovan">Moldovan</option>' +
                    ' <option class="textbolder" value="monacan">Monacan</option>' +
                    ' <option class="textbolder" value="mongolian">Mongolian</option>' +
                    ' <option class="textbolder" value="moroccan">Moroccan</option>' +
                    ' <option class="textbolder" value="mosotho">Mosotho</option>' +
                    ' <option class="textbolder" value="motswana">Motswana</option>' +
                    ' <option class="textbolder" value="mozambican">Mozambican</option>' +
                    ' <option class="textbolder" value="namibian">Namibian</option>' +
                    ' <option class="textbolder" value="nauruan">Nauruan</option>' +
                    ' <option class="textbolder" value="nepalese">Nepalese</option>' +
                    ' <option class="textbolder" value="new zealander">New Zealander</option>' +
                    ' <option class="textbolder" value="ni-vanuatu">Ni-Vanuatu</option>' +
                    ' <option class="textbolder" value="nicaraguan">Nicaraguan</option>' +
                    ' <option class="textbolder" value="nigerien">Nigerien</option>' +
                    '  <option class="textbolder" value="north korean">North Korean</option>' +
                    '  <option class="textbolder" value="northern irish">Northern Irish</option>' +
                    '  <option class="textbolder" value="norwegian">Norwegian</option>' +
                    '  <option class="textbolder" value="omani">Omani</option>' +
                    '  <option class="textbolder" value="pakistani">Pakistani</option>' +
                    ' <option class="textbolder" value="palauan">Palauan</option>' +
                    ' <option class="textbolder" value="panamanian">Panamanian</option>' +
                    '<option class="textbolder" value="papua new guinean">Papua New Guinean</option>' +
                    '<option class="textbolder" value="paraguayan">Paraguayan</option>' +
                    ' <option class="textbolder" value="peruvian">Peruvian</option>' +
                    '  <option class="textbolder" value="polish">Polish</option>' +
                    '  <option class="textbolder" value="portuguese">Portuguese</option>' +
                    '  <option class="textbolder" value="qatari">Qatari</option>' +
                    '<option class="textbolder" value="romanian">Romanian</option>' +
                    '<option class="textbolder" value="russian">Russian</option>' +
                    ' <option class="textbolder" value="rwandan">Rwandan</option>' +
                    ' <option class="textbolder" value="saint lucian">Saint Lucian</option>' +
                    ' <option class="textbolder" value="salvadoran">Salvadoran</option>' +
                    ' <option class="textbolder" value="samoan">Samoan</option>' +
                    ' <option class="textbolder" value="san marinese">San Marinese</option>' +
                    ' <option class="textbolder" value="sao tomean">Sao Tomean</option>' +
                    '  <option class="textbolder" value="saudi">Saudi</option>' +
                    ' <option class="textbolder" value="scottish">Scottish</option>' +
                    ' <option class="textbolder" value="senegalese">Senegalese</option>' +
                    '<option class="textbolder" value="serbian">Serbian</option>' +
                    '  <option class="textbolder" value="seychellois">Seychellois</option>' +
                    '  <option class="textbolder" value="sierra leonean">Sierra Leonean</option>' +
                    '  <option class="textbolder" value="singaporean">Singaporean</option>' +
                    '  <option class="textbolder" value="slovakian">Slovakian</option>' +
                    '  <option class="textbolder" value="slovenian">Slovenian</option>' +
                    '  <option class="textbolder" value="solomon islander">Solomon Islander</option>' +
                    ' <option class="textbolder" value="somali">Somali</option>' +
                    '  <option class="textbolder" value="south african">South African</option>' +
                    '  <option class="textbolder" value="south korean">South Korean</option>' +
                    ' <option class="textbolder" value="spanish">Spanish</option>' +
                    ' <option class="textbolder" value="sri lankan">Sri Lankan</option>' +
                    ' <option class="textbolder" value="sudanese">Sudanese</option>' +
                    ' <option class="textbolder" value="surinamer">Surinamer</option>' +
                    ' <option class="textbolder" value="swazi">Swazi</option>' +
                    ' <option class="textbolder" value="swedish">Swedish</option>' +
                    ' <option class="textbolder" value="swiss">Swiss</option>' +
                    ' <option class="textbolder" value="syrian">Syrian</option>' +
                    ' <option class="textbolder" value="taiwanese">Taiwanese</option>' +
                    ' <option class="textbolder" value="tajik">Tajik</option>' +
                    '  <option class="textbolder" value="tanzanian">Tanzanian</option>' +
                    ' <option class="textbolder" value="thai">Thai</option>' +
                    '<option class="textbolder" value="togolese">Togolese</option>' +
                    '<option class="textbolder" value="tongan">Tongan</option>' +
                    '<option class="textbolder" value="trinidadian or tobagonian">Trinidadian or Tobagonian</option>' +
                    '  <option class="textbolder" value="tunisian">Tunisian</option>' +
                    '  <option class="textbolder" value="turkish">Turkish</option>' +
                    '<option class="textbolder" value="tuvaluan">Tuvaluan</option>' +
                    ' <option class="textbolder" value="ugandan">Ugandan</option>' +
                    ' <option class="textbolder" value="ukrainian">Ukrainian</option>' +
                    ' <option class="textbolder" value="uruguayan">Uruguayan</option>' +
                    '  <option class="textbolder" value="uzbekistani">Uzbekistani</option>' +
                    ' <option class="textbolder" value="venezuelan">Venezuelan</option>' +
                    '  <option class="textbolder" value="vietnamese">Vietnamese</option>' +
                    ' <option class="textbolder" value="welsh">Welsh</option>' +
                    '  <option class="textbolder" value="yemenite">Yemenite</option>' +
                    '  <option class="textbolder" value="zambian">Zambian</option>' +
                    '  <option class="textbolder" value="zimbabwean">Zimbabwean</option>' +
                    '</select>' +
                    '</div>' +
                    ' </div>' +
                    ' </div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var nationalityedit = this.$content.find('#nationalityedit').val();

                        var data = {
                            nationalityedit: nationalityedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updatenationality.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-nationality2").text(nationalityedit);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditMaritalstatus() {
        var editMaritalstatus = $('#patient-edit-maritalstatus').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label class="control-label" for="">Marital Status</label>' +
                    '<select class="form-control" id="maritalstatusedit">' +
                    '<option class="textbolder">' + editMaritalstatus + '</option>' +
                    '<option class="textbolder">Annulled</option>' +
                    '<option class="textbolder">Divorced</option>' +
                    '<option class="textbolder">Interlocutory</option>' +
                    '<option class="textbolder">Legally Separated</option>' +
                    '<option class="textbolder">Married</option>' +
                    ' <option class="textbolder">Polygamous</option>' +
                    '<option class="textbolder">Never Married</option>' +
                    ' <option class="textbolder">Domestic Partner</option>' +
                    ' <option class="textbolder">Widowed</option>' +
                    '</select>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var maritalstatusedit = this.$content.find('#maritalstatusedit').val();

                        var data = {
                            maritalstatusedit: maritalstatusedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updatemaritalstatus.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-maritalstatus").text(maritalstatusedit);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditMaritalstatus2() {
        var editMaritalstatus = $('#patient-edit-maritalstatus2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label class="control-label" for="">Marital Status</label>' +
                    '<select class="form-control" id="maritalstatusedit">' +
                    '<option class="textbolder">' + editMaritalstatus + '</option>' +
                    '<option class="textbolder">Annulled</option>' +
                    '<option class="textbolder">Divorced</option>' +
                    '<option class="textbolder">Interlocutory</option>' +
                    '<option class="textbolder">Legally Separated</option>' +
                    '<option class="textbolder">Married</option>' +
                    ' <option class="textbolder">Polygamous</option>' +
                    '<option class="textbolder">Never Married</option>' +
                    ' <option class="textbolder">Domestic Partner</option>' +
                    ' <option class="textbolder">Widowed</option>' +
                    '</select>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var maritalstatusedit = this.$content.find('#maritalstatusedit').val();

                        var data = {
                            maritalstatusedit: maritalstatusedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updatemaritalstatus.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-maritalstatus2").text(maritalstatusedit);
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionAddMaritalstatus() {
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label class="control-label" for="">Marital Status</label>' +
                    '<select class="form-control" id="maritalstatusedit">' +
                    '<option class="textbolder">Annulled</option>' +
                    '<option class="textbolder">Divorced</option>' +
                    '<option class="textbolder">Interlocutory</option>' +
                    '<option class="textbolder">Legally Separated</option>' +
                    '<option class="textbolder">Married</option>' +
                    ' <option class="textbolder">Polygamous</option>' +
                    '<option class="textbolder">Never Married</option>' +
                    ' <option class="textbolder">Domestic Partner</option>' +
                    ' <option class="textbolder">Widowed</option>' +
                    '</select>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var maritalstatusedit = this.$content.find('#maritalstatusedit').val();

                        var data = {
                            maritalstatusedit: maritalstatusedit,
                            personid: patientPersonid
                        };
                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "patient/updatemaritalstatus.htm",
                            data: data,
                            success: function (rep) {
                                $("#patient-edit-maritalstatus2").text(maritalstatusedit);
                                $("#old-patient-maritalstatus").hide();
                                $("#new-patient-maritalstatus").show();
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionaddnextofkin() {
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '<label>Enter Next Of Kin: Full Name</label>' +
                    '<input type="text" class="form-control" id="nextofkinnameedit" value=""/>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="relationship">Relationship</label>' +
                    '<select class="form-control" id="nextofkinrelationshipedit">' +
                    '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                    '<option>Aunt</option><option>Uncle</option><option>Friend</option>' +
                    '<option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option></select></div>' +
                    '<div class="form-group required">' +
                    '<label>Enter Next Of Kin: Phone No</label>' +
                    '<input type="text" class="form-control" id="nextofkinphoneedit" value=""/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var nextOfKinFullName = this.$content.find('#nextofkinnameedit').val();
                        var nextofkinrelationship = this.$content.find('#nextofkinrelationshipedit').val();
                        var nextOfKinPhoneUpdt = this.$content.find('#nextofkinphoneedit').val();
                        if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhoneUpdt) {
                            if (!nextOfKinFullName) {
                                $.alert('Please Enter Next Of kin Full Name!');
                                return false;
                            }
                            if (!nextofkinrelationship) {
                                $.alert('Please select Next Of Kin Relationship');
                                return false;
                            }

                            if (!nextOfKinPhoneUpdt) {
                                $.alert('Please Enter Phone No.');
                                return false;
                            }

                        } else {
                            //SUBMIT NEXT OF KIN
                            var data = {
                                nextofkinrelationship: nextofkinrelationship,
                                nextOfKinFullName: nextOfKinFullName,
                                nextOfKinPhone: nextOfKinPhoneUpdt,
                                patientid: patientid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updatenextofkin.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-nxtofkinfullname2").text(nextOfKinFullName);
                                    $("#patient-edit-nxtrelationship2").text(nextofkinrelationship);
                                    $("#patient-edit-nxtofkinphone2").text(nextOfKinPhoneUpdt);
                                    $("#old-nxt-of-kin").hide();
                                    $("#new-nxt-of-kin").show();
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#nextofkinphoneedit').usPhoneFormat({
                    format: '(xxx) xxx-xxxx'
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditNxtofkin() {
        var editNextOfKinName = $('#patient-edit-nxtofkinfullname').text();
        var editNextOfKinPhone = $('#patient-edit-nxtofkinphone').text();
        var editNextOfKinRelationship = $('#patient-edit-nxtrelationship').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '<label>Enter Next Of Kin: Full Name</label>' +
                    '<input type="text" class="form-control" id="nextofkinnameedit" value="' + editNextOfKinName + '"/>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="relationship">Relationship</label>' +
                    '<select class="form-control" id="nextofkinrelationshipedit">' +
                    '<option>' + editNextOfKinRelationship + '</option>' +
                    '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                    '<option>Aunt</option><option>Uncle</option><option>Friend</option>' +
                    '<option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option></select></div>' +
                    '<div class="form-group required">' +
                    '<label>Enter Next Of Kin: Phone No</label>' +
                    '<input type="text" class="form-control" id="nextofkinphoneedit" value="' + editNextOfKinPhone + '"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var nextOfKinFullName = this.$content.find('#nextofkinnameedit').val();
                        var nextofkinrelationship = this.$content.find('#nextofkinrelationshipedit').val();
                        var nextOfKinPhoneUpdt = this.$content.find('#nextofkinphoneedit').val();
                        if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhoneUpdt) {
                            if (!nextOfKinFullName) {
                                $.alert('Please Enter Next Of kin Full Name!');
                                return false;
                            }
                            if (!nextofkinrelationship) {
                                $.alert('Please select Next Of Kin Relationship');
                                return false;
                            }

                            if (!nextOfKinPhoneUpdt) {
                                $.alert('Please Enter Phone No.');
                                return false;
                            }

                        } else {
                            //SUBMIT NEXT OF KIN
                            var data = {
                                nextofkinrelationship: nextofkinrelationship,
                                nextOfKinFullName: nextOfKinFullName,
                                nextOfKinPhoneUpdt: nextOfKinPhoneUpdt,
                                patientid: patientid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updatenextofkin.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-nxtofkinfullname").text(nextOfKinFullName);
                                    $("#patient-edit-nxtrelationship").text(nextofkinrelationship);
                                    $("#patient-edit-nxtofkinphone").text(nextOfKinPhoneUpdt);
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#nextofkinphoneedit').usPhoneFormat({
                    format: '(xxx) xxx-xxxx'
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditNxtofkin2() {
        var editNextOfKinName = $('#patient-edit-nxtofkinfullname2').text();
        var editNextOfKinPhone = $('#patient-edit-nxtofkinphone2').text();
        var editNextOfKinRelationship = $('#patient-edit-nxtrelationship2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '<label>Enter Next Of Kin: Full Name</label>' +
                    '<input type="text" class="form-control" id="nextofkinnameedit" value="' + editNextOfKinName + '"/>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="relationship">Relationship</label>' +
                    '<select class="form-control" id="nextofkinrelationshipedit">' +
                    '<option>' + editNextOfKinRelationship + '</option>' +
                    '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                    '<option>Aunt</option><option>Uncle</option><option>Friend</option>' +
                    '<option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option></select></div>' +
                    '<div class="form-group required">' +
                    '<label>Enter Next Of Kin: Phone No</label>' +
                    '<input type="text" class="form-control" id="nextofkinphoneedit" value="' + editNextOfKinPhone + '"/>' +
                    '</div>' +
                    '</form>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var nextOfKinFullName = this.$content.find('#nextofkinnameedit').val();
                        var nextofkinrelationship = this.$content.find('#nextofkinrelationshipedit').val();
                        var nextOfKinPhoneUpdt = this.$content.find('#nextofkinphoneedit').val();
                        if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhoneUpdt) {
                            if (!nextOfKinFullName) {
                                $.alert('Please Enter Next Of kin Full Name!');
                                return false;
                            }
                            if (!nextofkinrelationship) {
                                $.alert('Please select Next Of Kin Relationship');
                                return false;
                            }

                            if (!nextOfKinPhoneUpdt) {
                                $.alert('Please Enter Phone No.');
                                return false;
                            }

                        } else {
                            //SUBMIT NEXT OF KIN
                            var data = {
                                nextofkinrelationship: nextofkinrelationship,
                                nextOfKinFullName: nextOfKinFullName,
                                nextOfKinPhoneUpdt: nextOfKinPhoneUpdt,
                                patientid: patientid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updatenextofkin.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-nxtofkinfullname2").text(nextOfKinFullName);
                                    $("#patient-edit-nxtrelationship2").text(nextofkinrelationship);
                                    $("#patient-edit-nxtofkinphone2").text(nextOfKinPhoneUpdt);
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#nextofkinphoneedit').usPhoneFormat({
                    format: '(xxx) xxx-xxxx'
                });
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionaddNIN() {
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>NIN:</label>' +
                    '<input type="text" class="form-control" value="" id="ninedit"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var ninedit = this.$content.find('#ninedit').val();
                        if (!ninedit) {
                            $.alert('Please provide your valid NIN');
                            return false;
                        } else {
                            var data = {
                                ninedit: ninedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updateNIN.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-NIN2").text(ninedit);
                                    $("#old-patient-nin").hide();
                                    $("#new-patient-nin").show();
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditNIN() {
        var editPatientPIN = $('#patient-edit-NIN').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>NIN:</label>' +
                    '<input type="text" class="form-control" value="' + editPatientPIN + '" id="ninedit"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var ninedit = this.$content.find('#ninedit').val();
                        if (!ninedit) {
                            $.alert('Please provide your valid NIN');
                            return false;
                        } else {
                            var data = {
                                ninedit: ninedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updateNIN.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-NIN").text(ninedit);
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

    function functionEditNIN2() {
        var editPatientPIN = $('#patient-edit-NIN2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>NIN:</label>' +
                    '<input type="text" class="form-control" value="' + editPatientPIN + '" id="ninedit"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var ninedit = this.$content.find('#ninedit').val();
                        if (!ninedit) {
                            $.alert('Please provide your valid NIN');
                            return false;
                        } else {
                            var data = {
                                ninedit: ninedit,
                                personid: patientPersonid
                            };
                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "patient/updateNIN.htm",
                                data: data,
                                success: function (rep) {
                                    $("#patient-edit-NIN2").text(ninedit);
                                }
                            });
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }

</script>
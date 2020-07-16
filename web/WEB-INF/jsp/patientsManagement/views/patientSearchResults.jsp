<%@include file="../../include.jsp"%>
<input type="hidden" value="${searchValue}" id="patientSearchValue"/>
<c:if test="${not empty patients}">
    <ul class="items scrollbar" id="patientSearchScroll">
        <c:forEach items="${patients}" var="p">
            <!---->
           <!-- <li class="classItem" onclick="functionCreatPatientVisit(${p.patientid}, '${p.pin}', '${p.contact}', '${p.nxtofkin}', ${p.personid}, '${p.firstname}', '${p.othernames}', '${p.lastname}', '${p.nxtofkincontact}')"> -->
            <li class="classItem" onclick="CheckPatientQueue(${p.patientid}, '${p.pin}', '${p.contact}', '${p.nxtofkin}', ${p.personid}, '${p.firstname}', '${p.othernames}', '${p.lastname}', '${p.nxtofkincontact}')">
                <div>
                    <div class="partientsearchcard">
                        <div class="firstinfo">
                            <img src="static/images/profile-picture-placeholder.jpg"/>&nbsp;&nbsp;&nbsp;
                            <div class="profileinfo">
                                <h7 style="font-weight: bolder"><span style="color: graytext">NAME: </span> <span style="color: blueviolet; text-transform: uppercase;">${p.firstname} ${p.lastname} ${p.othernames}</span></h7><br>
                                <span><span style="font-weight: bolder; color: graytext">PIN: </span>00${p.pin}</span><br>
                                <c:choose>
                                    <c:when test="${p.contact != null and p.contact != ''}">
                                        <span class="bio" style="white-space: nowrap;">PHONE: </span>
                                        <span style="font-weight: bolder; color: graytext; ">${p.contact}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="bio" style="white-space: nowrap;">
                                            <span style="font-weight: bolder; color: graytext; ">${p.nxtofkin}</span>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>
<div class="center consentForm register">
    <span class="">
        Click <strong style="color: red !important; text-decoration: underline; cursor: pointer" onclick="confirmPatientConsent()"><i>Here</i></strong> To Register <i style="color: blue !important;">${name}</i> As a New Patient.
    </span>
    <span class="badge badge-pill badge-default badge-success text-white">${resultsCount} Result(s) Found.</span>
</div>
<script>
	//
    function CheckPatientQueue(patientid, patPin, pContact, pNxtOfKin, personid, pFirstName, pOtherName, pLastName, pNxtofkinphonecontact){
        $.ajax({
            type: 'GET',
            data: {patientid: patientid},
            dataType: 'JSON',
            url: 'patient/checkpatientinqueue.htm',
            success: function(data){
                console.log('data: ' + data);
                if(data !== null){
                    $.confirm({
                        title: 'Patient Already Queued.',
                        content: '<div style="overflow: auto; width: 100%; padding-right: 1%;">' +
                                    '<div class="text-left"><label><b>By:</b></label> <span class="form-control text-left">' + data.addedby + '</span></div>' +
                                    '<div class="text-left"><label><b>Facility:</b></label> <span class="form-control text-left">' + data.facilityname + '</span></div>' +
                                    '<div class="text-left"><label><b>Facility Contact:</b></label> <span class="form-control text-left">' + (data.contact || "Not Available") + '</span></div>' +
                                    '<div class="text-left"><label><b>Unit:</b></label> <span class="form-control text-left">' + data.unit + '</span></div>' +
                                    '<div class="text-left"><label><b>Service:</b></label> <span class="form-control text-left">' + data.unitservice + '</span></div>' +
                                    '<div class="text-left"><label><b>At:</b></label> <span class="form-control text-left">' + data.timein + '</span></div>' +
                                    '<p style="color: #000000;"><br /><i>Please advise the patient to go to the <u>'+ data.unit + '</u> unit for <u>' + data.unitservice +'.</i></p>' + 
                                 '</div>',
                        boxWidth: '35%',
                        useBootstrap: false,
                        type: 'purple',
                        typeAnimated: true,
                        closeIcon: true,
                        theme: 'modern',
                        buttons:{
                            Okay:{
                               text: 'Okay',
                               btnClass: 'btn-purple',
                               keys: ['enter', 'shift'],
                               action: function (){} 
                            }
                        }
                    });
                }else{
                   functionCreatPatientVisit(patientid, patPin, pContact, pNxtOfKin, personid, pFirstName, pOtherName, pLastName, pNxtofkinphonecontact); 
                }
            }
        });
    }
    function functionCreatPatientVisit(patientid, patPin, pContact, pNxtOfKin, personid, pFirstName, pOtherName, pLastName, pNxtofkinphonecontact) {
        var pRelationship = pNxtOfKin.split(':')[0];
        var pNxtfullname = pNxtOfKin.split(':')[1];

        var pNin, pNationality, pMaritalstatus, dob, residenceVill, pDistrict, gender, residenceParish;
        $.ajax({
            type: 'GET',
            data: {personid: personid},
            dataType: 'JSON',
            url: 'patient/searchedPatientDetails.htm',
            success: function (patientdetailslist) {                
                var patientData = patientdetailslist;
                pNin = patientData.nin;
                pNationality = patientData.nationality;
                pMaritalstatus = patientData.maritalstatus;
                residenceVill = patientData.village;
                pDistrict = patientData.districtname;
                gender = patientData.gender;
                dob = patientData.dob;
                //
                residenceParish = patientData.parish;
                //
                //Patient Details
                var patientFullNames = pFirstName + ' ' + pLastName + ' ' + pOtherName;
                $.confirm({
                    title: '',
                    content: '<h4><strong><font color="#054afc">' + patientFullNames + '</font></strong></h4>',
                    boxWidth: '40%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    theme: 'modern',
                    icon: 'fa fa-question-circle',
                    buttons: {
                        createvisit: {
                            text: 'Create Visit',
                            btnClass: 'btn-purple',
                            keys: ['enter', 'shift'],
                            action: function () {
                                //CREATION OF PATIENT VISIT
                                if (residenceVill === '' || typeof residenceVill === 'undefined') {
                                    //ENTER LOCATION Details
                                    $.confirm({
                                        title: 'Enter Residence Details!',
                                        content: '' +
                                                '<style>.select2-container{z-index: 999999999 !important;}</style>' +
                                                '<form action="" class="formName required">' +
                                                '<div class="form-group"><label class="control-label">Select District</label>' +
                                                '<select class="form-control" id="district2" value=""></select></div>' +
                                                '<div class="form-group"><label class="control-label">Select Village</label>' +
                                                '<select class="form-control required" id="village2" value=""></select></div>' +
                                                '</form>',
                                        boxWidth: '30%',
                                        useBootstrap: false,
                                        type: 'purple',
                                        typeAnimated: true,
                                        closeIcon: true,
                                        buttons: {
                                            //Submit VILLAGE
                                            formSubmit: {
                                                text: 'Submit Residence',
                                                btnClass: 'btn-purple',
                                                action: function () {
                                                    //save location detalis
                                                    var district2 = this.$content.find('#district2').val();
                                                    var village2 = this.$content.find('#village2').val();
                                                    if (!village2 || !district2) {
                                                        if (!district2) {
                                                            $.alert('Please select patient District');
                                                            return false;
                                                        }
                                                        if (!village2) {
                                                            $.alert('Please select patient Village');
                                                            return false;
                                                        }
                                                    } else {
                                                        //Submit village
                                                        var data = {
                                                            village: village2,
                                                            personid: personid
                                                        };
                                                        $.ajax({
                                                            type: "POST",
                                                            cache: false,
                                                            url: "patient/updatevillage.htm",
                                                            data: data,
                                                            success: function (rep) {

                                                            }
                                                        });

                                                        //PHONE DETAILS IF NULL
                                                        if (pContact === '') {
                                                            $.confirm({
                                                                title: 'Enter Contact Details!',
                                                                content: '' +
                                                                        '<form action="" class="formName">' +
                                                                        '<div class="form-group required">' +
                                                                        '<label>Enter Phone Contact</label>' +
                                                                        '<input type="text" class="form-control patientContact" id="patientContact" placeholder="" />' +
                                                                        '</div>' +
                                                                        '</form>',
                                                                boxWidth: '30%',
                                                                useBootstrap: false,
                                                                type: 'purple',
                                                                typeAnimated: true,
                                                                closeIcon: true,
                                                                buttons: {
                                                                    formSubmit: {
                                                                        text: 'Submit Contact',
                                                                        btnClass: 'btn-purple',
                                                                        action: function () {

                                                                            //SAVE PHONE details
                                                                            var patientContact = this.$content.find('#patientContact').val();
                                                                            if (!patientContact) {
                                                                                $.alert('Please provide a valid Phone Contact');
                                                                                return false;
                                                                            } else {
                                                                                //...SUBMIT PHONE
                                                                                var data = {
                                                                                    patientContact: patientContact,
                                                                                    patientid: patientid
                                                                                };
                                                                                $.ajax({
                                                                                    type: "POST",
                                                                                    cache: false,
                                                                                    url: "patient/updatecontact.htm",
                                                                                    data: data,
                                                                                    success: function (rep) {

                                                                                    }
                                                                                });
                                                                                //ADD NEXT OF KIN DETAILS
                                                                                if (pNxtfullname === '') {
                                                                                    $.confirm({
                                                                                        title: 'Enter Next Of Kin Details!',
                                                                                        content: '' +
                                                                                                '<form action="" class="formName">' +
                                                                                                '<div class="form-group required">' +
                                                                                                '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                                '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                                '</div>' +
                                                                                                '<div class="form-group">' +
                                                                                                '<label for="relationship">Relationship</label>' +
                                                                                                '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                '<option selected disabled>-- Select marital status--</option>' +
                                                                                                '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                '<option>Aunt</option><option>Uncle</option>' +
                                                                                                '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' +
                                                                                                '</select></div>' +
                                                                                                '<div class="form-group required">' +
                                                                                                '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                                '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                                '</div>' +
                                                                                                '</form>',
                                                                                        boxWidth: '30%',
                                                                                        useBootstrap: false,
                                                                                        type: 'purple',
                                                                                        typeAnimated: true,
                                                                                        closeIcon: true,
                                                                                        buttons: {
                                                                                            formSubmit: {
                                                                                                text: 'Save & Create Visit',
                                                                                                btnClass: 'btn-purple',
                                                                                                action: function () {

                                                                                                    //ADD NEXT OF KIN
                                                                                                    var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                    var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                    var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                                    if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                                        if (!nextOfKinFullName) {
                                                                                                            $.alert('Please Enter Next Of kin Full Name!');
                                                                                                            return false;
                                                                                                        }
                                                                                                        if (!nextofkinrelationship) {
                                                                                                            $.alert('Please select Next Of Kin Relationship');
                                                                                                            return false;
                                                                                                        }
                                                                                                        if (!nextOfKinPhone) {
                                                                                                            $.alert('Please Enter Phone No.');
                                                                                                            return false;
                                                                                                        }

                                                                                                    } else {
                                                                                                        //SUBMIT NEXT OF KIN
                                                                                                        var data = {
                                                                                                            nextofkinrelationship: nextofkinrelationship,
                                                                                                            nextOfKinFullName: nextOfKinFullName,
                                                                                                            nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                                            patientid: patientid
                                                                                                        };
                                                                                                        $.ajax({
                                                                                                            type: "POST",
                                                                                                            cache: false,
                                                                                                            url: "patient/updatenextofkin.htm",
                                                                                                            data: data,
                                                                                                            success: function (rep) {
                                                                                                                ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin, 'GET');
                                                                                                            }
                                                                                                        });

                                                                                                    }
                                                                                                },
                                                                                                skip: {
                                                                                                    text: 'SKIP!', // With spaces and symbols
                                                                                                    action: function () {
                                                                                                        ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin, 'GET');
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        },
                                                                                        onContentReady: function () {
                                                                                            $('.nextOfKinPhone').usPhoneFormat({
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
                                                                                } else {
                                                                                    //UPDATE NEXT OF KIN DETAILS
                                                                                    $.confirm({
                                                                                        title: 'Update Next Of Kin Details!',
                                                                                        content: '' +
                                                                                                '<form action="" class="formName">' +
                                                                                                '<div class="form-group">' +
                                                                                                '<label>Update Next Of Kin: Full Name</label>' +
                                                                                                '<input type="text" placeholder="" class="form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                                '</div>' +
                                                                                                '<div class="form-group">' +
                                                                                                '<label for="relationship">Update Relationship</label>' +
                                                                                                '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                '<option>Aunt</option><option>Uncle</option>' +
                                                                                                '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' +
                                                                                                '</select></div>' +
                                                                                                '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                                '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                                '</div>' +
                                                                                                '</form>',
                                                                                        boxWidth: '30%',
                                                                                        useBootstrap: false,
                                                                                        type: 'purple',
                                                                                        typeAnimated: true,
                                                                                        closeIcon: true,
                                                                                        buttons: {
                                                                                            formSubmit: {
                                                                                                text: 'Create Visit',
                                                                                                btnClass: 'btn-purple',
                                                                                                action: function () {

                                                                                                    //UPDATE NEXT OF KIN
                                                                                                    var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                    var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                    var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                                                ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                            }
                                                                                                        });
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        },
                                                                                        onContentReady: function () {
                                                                                            $('.nextOfKinPhoneupt').usPhoneFormat({
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
                                                                            }
                                                                        }
                                                                    },
                                                                    Skip: function () {
                                                                        //ADD NEXT OF KIN DETAILS
                                                                        if (pNxtfullname === '') {
                                                                            $.confirm({
                                                                                title: 'Enter Next Of Kin Details!',
                                                                                content: '' +
                                                                                        '<form action="" class="formName">' +
                                                                                        '<div class="form-group required">' +
                                                                                        '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                        '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                        '</div>' +
                                                                                        '<div class="form-group">' +
                                                                                        '<label for="relationship">Relationship</label>' +
                                                                                        '<select class="form-control" id="nextofkinrelationship">' +
                                                                                        '<option selected disabled>-- Select marital status--</option>' +
                                                                                        '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                        '<option>Aunt</option><option>Uncle</option>' +
                                                                                        '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' +
                                                                                        '</select></div>' +
                                                                                        '<div class="form-group required">' +
                                                                                        '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                        '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                        '</div>' +
                                                                                        '</form>',
                                                                                boxWidth: '30%',
                                                                                useBootstrap: false,
                                                                                type: 'purple',
                                                                                typeAnimated: true,
                                                                                closeIcon: true,
                                                                                buttons: {
                                                                                    formSubmit: {
                                                                                        text: 'Save & Create Visit',
                                                                                        btnClass: 'btn-purple',
                                                                                        action: function () {

                                                                                            //ADD NEXT OF KIN
                                                                                            var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                            var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                            var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                            if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                                if (!nextOfKinFullName) {
                                                                                                    $.alert('Please Enter Next Of kin Full Name!');
                                                                                                    return false;
                                                                                                }
                                                                                                if (!nextofkinrelationship) {
                                                                                                    $.alert('Please select Next Of Kin Relationship');
                                                                                                    return false;
                                                                                                }

                                                                                                if (!nextofkinrelationship) {
                                                                                                    $.alert('Please Enter Phone No.');
                                                                                                    return false;
                                                                                                }

                                                                                            } else {
                                                                                                //SUBMIT NEXT OF KIN
                                                                                                var data = {
                                                                                                    nextofkinrelationship: nextofkinrelationship,
                                                                                                    nextOfKinFullName: nextOfKinFullName,
                                                                                                    nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                                    patientid: patientid
                                                                                                };
                                                                                                $.ajax({
                                                                                                    type: "POST",
                                                                                                    cache: false,
                                                                                                    url: "patient/updatenextofkin.htm",
                                                                                                    data: data,
                                                                                                    success: function (rep) {
                                                                                                        ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                    }
                                                                                                });
                                                                                            }
                                                                                        }
                                                                                    },
                                                                                    skip: {
                                                                                        text: 'SKIP!', // With spaces and symbols
                                                                                        action: function () {
                                                                                            ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                        }
                                                                                    }
                                                                                },
                                                                                onContentReady: function () {
                                                                                    $('.nextOfKinPhone').usPhoneFormat({
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
                                                                        } else {
                                                                            //UPDATE NEXT OF KIN DETAILS
                                                                            $.confirm({
                                                                                title: 'Update Next Of Kin Details!',
                                                                                content: '' +
                                                                                        '<form action="" class="formName">' +
                                                                                        '<div class="form-group">' +
                                                                                        '<label>Update Next Of Kin: Full Name</label>' +
                                                                                        '<input type="text" placeholder="" class="form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                        '</div>' +
                                                                                        '<div class="form-group">' +
                                                                                        '<label for="relationship">Update Relationship</label>' +
                                                                                        '<select class="form-control" id="nextofkinrelationship">' +
                                                                                        '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                        '<option>Aunt</option><option>Uncle</option>' +
                                                                                        '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' +
                                                                                        '</select></div>' +
                                                                                        '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                        '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                        '</div>' +
                                                                                        '</form>',
                                                                                boxWidth: '30%',
                                                                                useBootstrap: false,
                                                                                type: 'purple',
                                                                                typeAnimated: true,
                                                                                closeIcon: true,
                                                                                buttons: {
                                                                                    formSubmit: {
                                                                                        text: 'Create Visit',
                                                                                        btnClass: 'btn-purple',
                                                                                        action: function () {

                                                                                            //UPDATE NEXT OF KIN
                                                                                            var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                            var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                            var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                                    $.alert('Please Enter Valid Next Of Kin Contact');
                                                                                                    return false;
                                                                                                }

                                                                                            } else {
                                                                                                //UPDATE NEXT OF KIN
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
                                                                                                        ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                    }
                                                                                                });
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                },
                                                                                onContentReady: function () {
                                                                                    $('.nextOfKinPhoneupt').usPhoneFormat({
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
                                                                    }
                                                                },
                                                                onContentReady: function () {
                                                                    $('.patientContact').usPhoneFormat({
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
                                                        } else {
                                                            //UPDATE PHONE DETAILS
                                                            $.confirm({
                                                                title: 'Update Phone Details!',
                                                                content: '<h5>Do you still use Tel: <strong style="font-size: 15px; text-transform: uppercase; color: blue; text-decoration: underline;">' + pContact + '</strong></h5>',
                                                                boxWidth: '30%',
                                                                useBootstrap: false,
                                                                type: 'purple',
                                                                typeAnimated: true,
                                                                closeIcon: true,
                                                                buttons: {
                                                                    //YES NEVER CHANGED TEL PHONE
                                                                    YES: function () {

                                                                        //ADD NEXT OF KIN DETAILS
                                                                        if (pNxtfullname === '') {
                                                                            $.confirm({
                                                                                title: 'Enter Next Of Kin Details!',
                                                                                content: '' +
                                                                                        '<form action="" class="formName">' +
                                                                                        '<div class="form-group required">' +
                                                                                        '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                        '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                        '</div>' +
                                                                                        '<div class="form-group">' +
                                                                                        '<label for="relationship">Relationship</label>' +
                                                                                        '<select class="form-control" id="nextofkinrelationship">' +
                                                                                        '<option selected disabled>-- Select marital status--</option>' +
                                                                                        '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                        '<option>Aunt</option><option>Uncle</option>' +
                                                                                        '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' +
                                                                                        '</select></div>' +
                                                                                        '<div class="form-group required">' +
                                                                                        '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                        '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                        '</div>' +
                                                                                        '</form>',
                                                                                boxWidth: '30%',
                                                                                useBootstrap: false,
                                                                                type: 'purple',
                                                                                typeAnimated: true,
                                                                                closeIcon: true,
                                                                                buttons: {
                                                                                    formSubmit: {
                                                                                        text: 'Save & Create Visit',
                                                                                        btnClass: 'btn-purple',
                                                                                        action: function () {

                                                                                            //ADD NEXT OF KIN
                                                                                            var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                            var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                            var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                            if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                                if (!nextOfKinFullName) {
                                                                                                    $.alert('Please Enter Next Of kin Full Name!');
                                                                                                    return false;
                                                                                                }
                                                                                                if (!nextofkinrelationship) {
                                                                                                    $.alert('Please select Next Of Kin Relationship');
                                                                                                    return false;
                                                                                                }
                                                                                                if (!nextOfKinPhone) {
                                                                                                    $.alert('Please Enter Phone No.');
                                                                                                    return false;
                                                                                                }

                                                                                            } else {
                                                                                                //SUBMIT NEXT OF KIN
                                                                                                var data = {
                                                                                                    nextofkinrelationship: nextofkinrelationship,
                                                                                                    nextOfKinFullName: nextOfKinFullName,
                                                                                                    nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                                    patientid: patientid
                                                                                                };
                                                                                                $.ajax({
                                                                                                    type: "POST",
                                                                                                    cache: false,
                                                                                                    url: "patient/updatenextofkin.htm",
                                                                                                    data: data,
                                                                                                    success: function (rep) {
                                                                                                        ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                    }
                                                                                                });
                                                                                            }
                                                                                        }
                                                                                    },
                                                                                    skip: {
                                                                                        text: 'SKIP!', // With spaces and symbols
                                                                                        action: function () {
                                                                                            ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                        }
                                                                                    }
                                                                                },
                                                                                onContentReady: function () {
                                                                                    $('.nextOfKinPhone').usPhoneFormat({
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
                                                                        } else {
                                                                            //UPDATE NEXT OF KIN DETAILS
                                                                            $.confirm({
                                                                                title: 'Update Next Of Kin Details!',
                                                                                content: '' +
                                                                                        '<form action="" class="formName">' +
                                                                                        '<div class="form-group">' +
                                                                                        '<label>Update Next Of Kin: Full Name</label>' +
                                                                                        '<input type="text" placeholder="" class="form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                        '</div>' +
                                                                                        '<div class="form-group">' +
                                                                                        '<label for="relationship">Update Relationship</label>' +
                                                                                        '<select class="form-control" id="nextofkinrelationship">' +
                                                                                        '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                        '<option>Aunt</option><option>Uncle</option>' +
                                                                                        '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' +
                                                                                        '</select></div>' +
                                                                                        '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                        '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                        '</div>' +
                                                                                        '</form>',
                                                                                boxWidth: '30%',
                                                                                useBootstrap: false,
                                                                                type: 'purple',
                                                                                typeAnimated: true,
                                                                                closeIcon: true,
                                                                                buttons: {
                                                                                    formSubmit: {
                                                                                        text: 'Create Visit',
                                                                                        btnClass: 'btn-purple',
                                                                                        action: function () {

                                                                                            //UPDATE NEXT OF KIN
                                                                                            var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                            var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                            var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                                    $.alert('Please Enter Valid Contact');
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
                                                                                                        ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                    }
                                                                                                });
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                },
                                                                                onContentReady: function () {
                                                                                    $('.nextOfKinPhoneupt').usPhoneFormat({
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
                                                                    },
                                                                    // NO CHANGED TEL PHONE
                                                                    NO: {
                                                                        text: 'NO',
                                                                        btnClass: 'btn-red',
                                                                        keys: ['enter', 'shift'],
                                                                        action: function () {

                                                                            //UPDATE PHONE DETAILS
                                                                            $.confirm({
                                                                                title: 'UPDATE CONTACT Details!',
                                                                                content: '' +
                                                                                        '<form action="" class="formName">' +
                                                                                        '<div class="form-group">' +
                                                                                        '<label>Update Phone Contact</label>' +
                                                                                        '<input type="text" class="form-control patientContact" value="' + pContact + '" id="patientContact"/>' +
                                                                                        '</div>' +
                                                                                        '</form>',
                                                                                boxWidth: '30%',
                                                                                useBootstrap: false,
                                                                                type: 'purple',
                                                                                typeAnimated: true,
                                                                                closeIcon: true,
                                                                                buttons: {
                                                                                    Submit: {
                                                                                        text: 'Submit Contact',
                                                                                        btnClass: 'btn-purple',
                                                                                        action: function () {
                                                                                            //SAVE PHONE detalis
                                                                                            var patientContact = this.$content.find('#patientContact').val();
                                                                                            if (!patientContact) {
                                                                                                $.alert('Please provide a valid Phone Contact');
                                                                                                return false;
                                                                                            } else {
                                                                                                //...UPDATE PHONE
                                                                                                var data = {
                                                                                                    patientContact: patientContact,
                                                                                                    patientid: patientid
                                                                                                };
                                                                                                $.ajax({
                                                                                                    type: "POST",
                                                                                                    cache: false,
                                                                                                    url: "patient/updatecontact.htm",
                                                                                                    data: data,
                                                                                                    success: function (rep) {

                                                                                                    }
                                                                                                });
                                                                                                //ADD NEXT OF KIN DETAILS
                                                                                                if (pNxtfullname === null) {
                                                                                                    $.confirm({
                                                                                                        title: 'Enter Next Of Kin Details!',
                                                                                                        content: '' +
                                                                                                                '<form action="" class="formName">' +
                                                                                                                '<div class="form-group required">' +
                                                                                                                '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                                                '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                                                '</div>' +
                                                                                                                '<div class="form-group">' +
                                                                                                                '<label for="relationship">Relationship</label>' +
                                                                                                                '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                                '<option selected disabled>-- Select marital status--</option>' +
                                                                                                                '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                                '<option>Aunt</option><option>Uncle</option>' +
                                                                                                                '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' +
                                                                                                                '</select></div>' +
                                                                                                                '<div class="form-group required">' +
                                                                                                                '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                                                '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                                                '</div>' +
                                                                                                                '</form>',
                                                                                                        boxWidth: '30%',
                                                                                                        useBootstrap: false,
                                                                                                        type: 'purple',
                                                                                                        typeAnimated: true,
                                                                                                        closeIcon: true,
                                                                                                        buttons: {
                                                                                                            formSubmit: {
                                                                                                                text: 'Save & Create Visit',
                                                                                                                btnClass: 'btn-purple',
                                                                                                                action: function () {

                                                                                                                    //ADD NEXT OF KIN
                                                                                                                    var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                                    var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                                    var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                                                    if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                                                        if (!nextOfKinFullName) {
                                                                                                                            $.alert('Please Enter Next Of kin Full Name!');
                                                                                                                            return false;
                                                                                                                        }
                                                                                                                        if (!nextofkinrelationship) {
                                                                                                                            $.alert('Please select Next Of Kin Relationship');
                                                                                                                            return false;
                                                                                                                        }

                                                                                                                        if (!nextOfKinPhone) {
                                                                                                                            $.alert('Please Enter Phone No.');
                                                                                                                            return false;
                                                                                                                        }

                                                                                                                    } else {
                                                                                                                        //SUBMIT NEXT OF KIN
                                                                                                                        var data = {
                                                                                                                            nextofkinrelationship: nextofkinrelationship,
                                                                                                                            nextOfKinFullName: nextOfKinFullName,
                                                                                                                            nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                                                            patientid: patientid
                                                                                                                        };
                                                                                                                        $.ajax({
                                                                                                                            type: "POST",
                                                                                                                            cache: false,
                                                                                                                            url: "patient/updatenextofkin.htm",
                                                                                                                            data: data,
                                                                                                                            success: function (rep) {
                                                                                                                                ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                            }
                                                                                                                        });
                                                                                                                    }
                                                                                                                }
                                                                                                            },
                                                                                                            skip: {
                                                                                                                text: 'SKIP!', // With spaces and symbols
                                                                                                                action: function () {
                                                                                                                    ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                }
                                                                                                            }
                                                                                                        },
                                                                                                        onContentReady: function () {
                                                                                                            $('#nextOfKinPhone').usPhoneFormat({
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
                                                                                                } else {
                                                                                                    //UPDATE NEXT OF KIN DETAILS
                                                                                                    $.confirm({
                                                                                                        title: 'Update Next Of Kin Details!',
                                                                                                        content: '' +
                                                                                                                '<form action="" class="formName">' +
                                                                                                                '<div class="form-group">' +
                                                                                                                '<label>Update Next Of Kin: Full Name</label>' +
                                                                                                                '<input type="text" placeholder="" class="form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                                                '</div>' +
                                                                                                                '<div class="form-group">' +
                                                                                                                '<label for="relationship">Update Relationship</label>' +
                                                                                                                '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                                '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                                '<option>Aunt</option><option>Uncle</option>' +
                                                                                                                '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' +
                                                                                                                '</select></div>' +
                                                                                                                '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                                                '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                                                '</div>' +
                                                                                                                '</form>',
                                                                                                        boxWidth: '30%',
                                                                                                        useBootstrap: false,
                                                                                                        type: 'purple',
                                                                                                        typeAnimated: true,
                                                                                                        closeIcon: true,
                                                                                                        buttons: {
                                                                                                            formSubmit: {
                                                                                                                text: 'Create Visit',
                                                                                                                btnClass: 'btn-purple',
                                                                                                                action: function () {

                                                                                                                    //UPDATE NEXT OF KIN
                                                                                                                    var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                                    var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                                    var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                                                            $.alert('Please Enter Valid Next Of Kin Contact');
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
                                                                                                                                ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                            }
                                                                                                                        });
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        },
                                                                                                        onContentReady: function () {
                                                                                                            $('.nextOfKinPhoneupt').usPhoneFormat({
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
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                },
                                                                                onContentReady: function () {
                                                                                    $('.patientContact').usPhoneFormat({
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
                                                                    }
                                                                }
                                                            });
                                                        }
                                                    }
                                                }
                                            }
                                        },
                                        onContentReady: function () {
                                            $('#district2').select2();
                                            $('#village2').select2();
                                            $('.select2').css('width', '100%');
                                            $.ajax({
                                                type: 'POST',
                                                url: 'locations/fetchDistricts.htm',
                                                success: function (data) {
                                                    var res = JSON.parse(data);
                                                    if (res !== '' && res.length > 0) {
                                                        for (i in res) {
                                                            $('#district2').append('<option class="textbolder" id="dis' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                        }
                                                        var districtid = parseInt($('#district2').val());
                                                        $.ajax({
                                                            type: 'POST',
                                                            url: 'locations/fetchDistrictVillages.htm',
                                                            data: {districtid: districtid},
                                                            success: function (data) {
                                                                var res = JSON.parse(data);
                                                                if (res !== '' && res.length > 0) {
                                                                    for (i in res) {
//                                                                        $('#village2').append('<option class="classvillage" value="' + res[i].id + '" data-id="' + res[i].id + '">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
                                                                        $('#village2').append('<option class="classvillage" value="' + res[i].id + '" data-id="' + res[i].id + '">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>');  
                                                                    }
                                                                }
                                                            }
                                                        });
                                                    }
                                                }
                                            });
                                            $('#district2').change(function () {
                                                $('#village2').val(null).trigger('change');
                                                var districtid = parseInt($('#district2').val());
                                                $.ajax({
                                                    type: 'POST',
                                                    url: 'locations/fetchDistrictVillages.htm',
                                                    data: {districtid: districtid},
                                                    success: function (data) {
                                                        var res = JSON.parse(data);
                                                        if (res !== '' && res.length > 0) {
                                                            $('#village2').html('');
                                                            for (i in res) {
//                                                                $('#village2').append('<option class="classvillage" value="' + res[i].id + '" data-id="' + res[i].id + '">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>');
                                                                $('#village2').append('<option class="classvillage" value="' + res[i].id + '" data-id="' + res[i].id + '">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>');  
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
                                        }
                                    });
                                } else {
                                    //LOCATION DETAILS UPDATE
                                    $.confirm({
                                        title: 'Update Residence Details!',
                                        content: '<h5>Are you still staying in <strong style="font-size: 15px; text-transform: uppercase; color: blue; text-decoration: underline;">' + residenceVill + '</strong> village?</h5>',
                                        boxWidth: '30%',
                                        useBootstrap: false,
                                        type: 'purple',
                                        typeAnimated: true,
                                        closeIcon: true,
                                        buttons: {
                                            //YES STILL STAYING IN PREVIOUS LOCATION
                                            YES: function () {

                                                //PHONE DETAILS IF NULL
                                                if (pContact === '') {
                                                    $.confirm({
                                                        title: 'Enter Contact Details!',
                                                        content: '' +
                                                                '<form action="" class="formName">' +
                                                                '<div class="form-group required">' +
                                                                '<label>Enter Phone Contact</label>' +
                                                                '<input type="text" class="form-control patientContact" id="patientContact" placeholder=""/>' +
                                                                '</div>' +
                                                                '</form>',
                                                        boxWidth: '30%',
                                                        useBootstrap: false,
                                                        type: 'purple',
                                                        typeAnimated: true,
                                                        closeIcon: true,
                                                        buttons: {
                                                            formSubmit: {
                                                                text: 'Submit Contact',
                                                                btnClass: 'btn-purple',
                                                                action: function () {

                                                                    //SAVE PHONE detalis
                                                                    var patientContact = this.$content.find('#patientContact').val();
                                                                    if (!patientContact) {
                                                                        $.alert('Please provide a valid Phone Contact');
                                                                        return false;
                                                                    } else {
                                                                        //...SUBMIT PHONE
                                                                        var data = {
                                                                            patientContact: patientContact,
                                                                            patientid: patientid
                                                                        };
                                                                        $.ajax({
                                                                            type: "POST",
                                                                            cache: false,
                                                                            url: "patient/updatecontact.htm",
                                                                            data: data,
                                                                            success: function (rep) {

                                                                            }
                                                                        });
                                                                        //ADD NEXT OF KIN DETAILS
                                                                        if (pNxtfullname === '') {
                                                                            $.confirm({
                                                                                title: 'Enter Next Of Kin Details!',
                                                                                content: '' +
                                                                                        '<form action="" class="formName">' +
                                                                                        '<div class="form-group required">' +
                                                                                        '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                        '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                        '</div>' +
                                                                                        '<div class="form-group required">' +
                                                                                        '<label for="relationship">Relationship</label>' +
                                                                                        '<select class="form-control" id="nextofkinrelationship">' +
                                                                                        '<option selected disabled>-- Select marital status--</option>' +
                                                                                        '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                        '<option>Aunt</option><option>Uncle</option>' +
                                                                                        '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' + '</select></div>' +
                                                                                        '<div class="form-group required">' +
                                                                                        '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                        '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                        '</div>' +
                                                                                        '</form>',
                                                                                boxWidth: '30%',
                                                                                useBootstrap: false,
                                                                                type: 'purple',
                                                                                typeAnimated: true,
                                                                                closeIcon: true,
                                                                                buttons: {
                                                                                    formSubmit: {
                                                                                        text: 'Save & Create Visit',
                                                                                        btnClass: 'btn-purple',
                                                                                        action: function () {

                                                                                            //ADD NEXT OF KIN
                                                                                            var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                            var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                            var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                            if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                                if (!nextOfKinFullName) {
                                                                                                    $.alert('Please Enter Next Of kin Full Name!');
                                                                                                    return false;
                                                                                                }
                                                                                                if (!nextofkinrelationship) {
                                                                                                    $.alert('Please select Next Of Kin Relationship');
                                                                                                    return false;
                                                                                                }
                                                                                                if (!nextOfKinPhone) {
                                                                                                    $.alert('Please Enter Phone No.');
                                                                                                    return false;
                                                                                                }

                                                                                            } else {
                                                                                                //SUBMIT NEXT OF KIN
                                                                                                var data = {
                                                                                                    nextofkinrelationship: nextofkinrelationship,
                                                                                                    nextOfKinFullName: nextOfKinFullName,
                                                                                                    nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                                    patientid: patientid
                                                                                                };
                                                                                                $.ajax({
                                                                                                    type: "POST",
                                                                                                    cache: false,
                                                                                                    url: "patient/updatenextofkin.htm",
                                                                                                    data: data,
                                                                                                    success: function (rep) {
                                                                                                        ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                    }
                                                                                                });
                                                                                            }
                                                                                        }
                                                                                    }

                                                                                },
                                                                                onContentReady: function () {
                                                                                    $('.nextOfKinPhone').usPhoneFormat({
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
                                                                        } else {
                                                                            //UPDATE NEXT OF KIN DETAILS
                                                                            $.confirm({
                                                                                title: 'Update Next Of Kin Details!',
                                                                                content: '' +
                                                                                        '<form action="" class="formName">' +
                                                                                        '<div class="form-group">' +
                                                                                        '<label>Update Next Of Kin: Full Name</label>' +
                                                                                        '<input type="text" class="form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                        '</div>' +
                                                                                        '<div class="form-group">' +
                                                                                        '<label for="relationship">Update Relationship</label>' +
                                                                                        '<select class="form-control" id="nextofkinrelationship">' +
                                                                                        '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                        '<option>Aunt</option><option>Uncle</option>' +
                                                                                        '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' + '</select></div>' +
                                                                                        '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                        '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                        '</div>' +
                                                                                        '</form>',
                                                                                boxWidth: '30%',
                                                                                useBootstrap: false,
                                                                                type: 'purple',
                                                                                typeAnimated: true,
                                                                                closeIcon: true,
                                                                                buttons: {
                                                                                    formSubmit: {
                                                                                        text: 'Create Visit',
                                                                                        btnClass: 'btn-purple',
                                                                                        action: function () {

                                                                                            //UPDATE NEXT OF KIN
                                                                                            var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                            var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                            var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                                    $.alert('Please Insert Valid Next Of Kin Details');
                                                                                                    return false;
                                                                                                }

                                                                                            } else {
                                                                                                //UPDATE NEXT OF KIN
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
                                                                                                        ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                    }
                                                                                                });
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                },
                                                                                onContentReady: function () {
                                                                                    $('.nextOfKinPhoneupt').usPhoneFormat({
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
                                                                    }
                                                                }
                                                            },
                                                            Skip: function () {
                                                                //ADD NEXT OF KIN DETAILS
                                                                if (pNxtfullname === '') {
                                                                    $.confirm({
                                                                        title: 'Enter Next Of Kin Details!',
                                                                        content: '' +
                                                                                '<form action="" class="formName">' +
                                                                                '<div class="form-group required">' +
                                                                                '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                '</div>' +
                                                                                '<div class="form-group required">' +
                                                                                '<label for="relationship">Relationship</label>' +
                                                                                '<select class="form-control" id="nextofkinrelationship">' +
                                                                                '<option selected disabled>-- Select marital status--</option>' +
                                                                                '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                '<option>Aunt</option><option>Uncle</option>' +
                                                                                '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' + '</select></div>' +
                                                                                '<div class="form-group required">' +
                                                                                '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                '</div>' +
                                                                                '</form>',
                                                                        boxWidth: '30%',
                                                                        useBootstrap: false,
                                                                        type: 'purple',
                                                                        typeAnimated: true,
                                                                        closeIcon: true,
                                                                        buttons: {
                                                                            formSubmit: {
                                                                                text: 'Save & Create Visit',
                                                                                btnClass: 'btn-purple',
                                                                                action: function () {

                                                                                    //ADD NEXT OF KIN
                                                                                    var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                    var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                    var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                    if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                        if (!nextOfKinFullName) {
                                                                                            $.alert('Please Enter Next Of kin Full Name!');
                                                                                            return false;
                                                                                        }
                                                                                        if (!nextofkinrelationship) {
                                                                                            $.alert('Please select Next Of Kin Relationship');
                                                                                            return false;
                                                                                        }
                                                                                        if (!nextOfKinPhone) {
                                                                                            $.alert('Please Enter Phone No.');
                                                                                            return false;
                                                                                        }

                                                                                    } else {
                                                                                        //SUBMIT NEXT OF KIN
                                                                                        var data = {
                                                                                            nextofkinrelationship: nextofkinrelationship,
                                                                                            nextOfKinFullName: nextOfKinFullName,
                                                                                            nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                            patientid: patientid
                                                                                        };
                                                                                        $.ajax({
                                                                                            type: "POST",
                                                                                            cache: false,
                                                                                            url: "patient/updatenextofkin.htm",
                                                                                            data: data,
                                                                                            success: function (rep) {
                                                                                                ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                            }
                                                                                        });
                                                                                    }
                                                                                }
                                                                            },
                                                                            skip: {
                                                                                text: 'SKIP!', // With spaces and symbols
                                                                                action: function () {
                                                                                    ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                }
                                                                            }
                                                                        },
                                                                        onContentReady: function () {
                                                                            $('.nextOfKinPhone').usPhoneFormat({
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
                                                                } else {
                                                                    //UPDATE NEXT OF KIN DETAILS
                                                                    $.confirm({
                                                                        title: 'Update Next Of Kin Details!',
                                                                        content: '' +
                                                                                '<form action="" class="formName">' +
                                                                                '<div class="form-group">' +
                                                                                '<label>Update Next Of Kin: Full Name</label>' +
                                                                                '<input type="text" class="form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                '</div>' +
                                                                                '<div class="form-group">' +
                                                                                '<label for="relationship">Update Relationship</label>' +
                                                                                '<select class="form-control" id="nextofkinrelationship">' +
                                                                                '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                '<option>Aunt</option><option>Uncle</option>' +
                                                                                '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' + '</select></div>' +
                                                                                '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                '</div>' +
                                                                                '</form>',
                                                                        boxWidth: '30%',
                                                                        useBootstrap: false,
                                                                        type: 'purple',
                                                                        typeAnimated: true,
                                                                        closeIcon: true,
                                                                        buttons: {
                                                                            formSubmit: {
                                                                                text: 'Create Visit',
                                                                                btnClass: 'btn-purple',
                                                                                action: function () {

                                                                                    //UPDATE NEXT OF KIN
                                                                                    var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                    var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                    var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                            $.alert('Please Enter Valid Next of kin Contact');
                                                                                            return false;
                                                                                        }

                                                                                    } else {
                                                                                        //UPDATE NEXT OF KIN
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
                                                                                                ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                            }
                                                                                        });
                                                                                    }
                                                                                }
                                                                            }
                                                                        },
                                                                        onContentReady: function () {
                                                                            $('.nextOfKinPhoneupt').usPhoneFormat({
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
                                                            }
                                                        },
                                                        onContentReady: function () {
                                                            $('.patientContact').usPhoneFormat({
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
                                                } else {
                                                    //UPDATE PHONE DETAILS
                                                    $.confirm({
                                                        title: 'Update Phone Details!',
                                                        content: '<h5>Do you still use Tel: <strong style="font-size: 15px; text-transform: uppercase; color: blue; text-decoration: underline;">' + pContact + '</strong></h5>',
                                                        boxWidth: '30%',
                                                        useBootstrap: false,
                                                        type: 'purple',
                                                        typeAnimated: true,
                                                        closeIcon: true,
                                                        buttons: {
                                                            //YES NEVER CHANGED TEL PHONE
                                                            YES: function () {

                                                                //ADD NEXT OF KIN DETAILS
                                                                if (pNxtfullname === '') {
                                                                    $.confirm({
                                                                        title: 'Enter Next Of Kin Details!',
                                                                        content: '' +
                                                                                '<form action="" class="formName">' +
                                                                                '<div class="form-group required">' +
                                                                                '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                '</div>' +
                                                                                '<div class="form-group required">' +
                                                                                '<label for="relationship">Relationship</label>' +
                                                                                '<select class="form-control" id="nextofkinrelationship">' +
                                                                                '<option selected disabled>-- Select marital status--</option>' +
                                                                                '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                '<option>Aunt</option><option>Uncle</option>' +
                                                                                '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' + '</select></div>' +
                                                                                '<div class="form-group required">' +
                                                                                '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                '</div>' +
                                                                                '</form>',
                                                                        boxWidth: '30%',
                                                                        useBootstrap: false,
                                                                        type: 'purple',
                                                                        typeAnimated: true,
                                                                        closeIcon: true,
                                                                        buttons: {
                                                                            formSubmit: {
                                                                                text: 'Save & Create Visit',
                                                                                btnClass: 'btn-purple',
                                                                                action: function () {

                                                                                    //ADD NEXT OF KIN
                                                                                    var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                    var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                    var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                    if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                        if (!nextOfKinFullName) {
                                                                                            $.alert('Please Enter Next Of kin Full Name!');
                                                                                            return false;
                                                                                        }
                                                                                        if (!nextofkinrelationship) {
                                                                                            $.alert('Please select Next Of Kin Relationship');
                                                                                            return false;
                                                                                        }

                                                                                        if (!nextOfKinPhone) {
                                                                                            $.alert('Please Enter Phone No.');
                                                                                            return false;
                                                                                        }

                                                                                    } else {
                                                                                        //SUBMIT NEXT OF KIN
                                                                                        var data = {
                                                                                            nextofkinrelationship: nextofkinrelationship,
                                                                                            nextOfKinFullName: nextOfKinFullName,
                                                                                            nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                            patientid: patientid
                                                                                        };
                                                                                        $.ajax({
                                                                                            type: "POST",
                                                                                            cache: false,
                                                                                            url: "patient/updatenextofkin.htm",
                                                                                            data: data,
                                                                                            success: function (rep) {
                                                                                                ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                            }
                                                                                        });
                                                                                    }
                                                                                }
                                                                            },
                                                                            skip: {
                                                                                text: 'SKIP!', // With spaces and symbols
                                                                                action: function () {
                                                                                    ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                }
                                                                            }
                                                                        },
                                                                        onContentReady: function () {
                                                                            $('.nextOfKinPhone').usPhoneFormat({
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
                                                                } else {
                                                                    //UPDATE NEXT OF KIN DETAILS
                                                                    $.confirm({
                                                                        title: 'Update Next Of Kin Details!',
                                                                        content: '' +
                                                                                '<form action="" class="formName">' +
                                                                                '<div class="form-group">' +
                                                                                '<label>Update Next Of Kin: Full Name</label>' +
                                                                                '<input type="text" placeholder="Your name" class="name form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                '</div>' +
                                                                                '<div class="form-group">' +
                                                                                '<label for="relationship">Update Relationship</label>' +
                                                                                '<select class="form-control" id="nextofkinrelationship">' +
                                                                                '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                '<option>Aunt</option><option>Uncle</option>' +
                                                                                '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' + '</select></div>' +
                                                                                '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                '</div>' +
                                                                                '</form>',
                                                                        boxWidth: '30%',
                                                                        useBootstrap: false,
                                                                        type: 'purple',
                                                                        typeAnimated: true,
                                                                        closeIcon: true,
                                                                        buttons: {
                                                                            formSubmit: {
                                                                                text: 'Save and Create Visit',
                                                                                btnClass: 'btn-purple',
                                                                                action: function () {

                                                                                    //UPDATE NEXT OF KIN
                                                                                    var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                    var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                    var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                            $.alert('Please Enter Valid Next Of Kin Contact');
                                                                                            return false;
                                                                                        }

                                                                                    } else {
                                                                                        //UPDATE NEXT OF KIN
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
                                                                                                ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                            }
                                                                                        });
                                                                                    }
                                                                                }
                                                                            },
                                                                            skip: {
                                                                                text: 'SKIP and Create visit!', // With spaces and symbols
                                                                                action: function () {
                                                                                    ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                }
                                                                            }
                                                                        },
                                                                        onContentReady: function () {
                                                                            $('.nextOfKinPhoneupt').usPhoneFormat({
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
                                                            },
                                                            // NO CHANGED TEL PHONE
                                                            NO: {
                                                                text: 'NO',
                                                                btnClass: 'btn-red',
                                                                keys: ['enter', 'shift'],
                                                                action: function () {

                                                                    //UPDATE PHONE DETAILS
                                                                    $.confirm({
                                                                        title: 'UPDATE CONTACT Details!',
                                                                        content: '' +
                                                                                '<form action="" class="formName">' +
                                                                                '<div class="form-group">' +
                                                                                '<label>Update Phone Contact</label>' +
                                                                                '<input type="text" class="form-control patientContact" value="' + pContact + '" id="patientContact"/>' +
                                                                                '</div>' +
                                                                                '</form>',
                                                                        boxWidth: '30%',
                                                                        useBootstrap: false,
                                                                        type: 'purple',
                                                                        typeAnimated: true,
                                                                        closeIcon: true,
                                                                        buttons: {
                                                                            Submit: {
                                                                                text: 'Submit Contact',
                                                                                btnClass: 'btn-purple',
                                                                                action: function () {
                                                                                    //SAVE PHONE detalis
                                                                                    var patientContact = this.$content.find('#patientContact').val();
                                                                                    if (!patientContact) {
                                                                                        $.alert('Please provide a valid Phone Contact');
                                                                                        return false;
                                                                                    } else {

                                                                                        //...SUBMIT PHONE
                                                                                        var data = {
                                                                                            patientContact: patientContact,
                                                                                            patientid: patientid
                                                                                        };
                                                                                        $.ajax({
                                                                                            type: "POST",
                                                                                            cache: false,
                                                                                            url: "patient/updatecontact.htm",
                                                                                            data: data,
                                                                                            success: function (rep) {

                                                                                            }
                                                                                        });
                                                                                        //ADD NEXT OF KIN DETAILS
                                                                                        if (pNxtfullname === '') {
                                                                                            $.confirm({
                                                                                                title: 'Enter Next Of Kin Details!',
                                                                                                content: '' +
                                                                                                        '<form action="" class="formName">' +
                                                                                                        '<div class="form-group required">' +
                                                                                                        '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                                        '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                                        '</div>' +
                                                                                                        '<div class="form-group">' +
                                                                                                        '<label for="relationship">Relationship</label>' +
                                                                                                        '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                        '<option selected disabled>-- Select marital status--</option>' +
                                                                                                        '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                        '<option>Aunt</option><option>Uncle</option>' +
                                                                                                        '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' + '</select></div>' +
                                                                                                        '<div class="form-group required">' +
                                                                                                        '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                                        '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                                        '</div>' +
                                                                                                        '</form>',
                                                                                                boxWidth: '30%',
                                                                                                useBootstrap: false,
                                                                                                type: 'purple',
                                                                                                typeAnimated: true,
                                                                                                closeIcon: true,
                                                                                                buttons: {
                                                                                                    formSubmit: {
                                                                                                        text: 'Save & Create Visit',
                                                                                                        btnClass: 'btn-purple',
                                                                                                        action: function () {

                                                                                                            //ADD NEXT OF KIN
                                                                                                            var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                            var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                            var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                                            if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                                                if (!nextOfKinFullName) {
                                                                                                                    $.alert('Please Enter Next Of kin Full Name!');
                                                                                                                    return false;
                                                                                                                }
                                                                                                                if (!nextofkinrelationship) {
                                                                                                                    $.alert('Please select Next Of Kin Relationship');
                                                                                                                    return false;
                                                                                                                }

                                                                                                                if (!nextOfKinPhone) {
                                                                                                                    $.alert('Please Enter Phone No.');
                                                                                                                    return false;
                                                                                                                }

                                                                                                            } else {
                                                                                                                //SUBMIT NEXT OF KIN
                                                                                                                var data = {
                                                                                                                    nextofkinrelationship: nextofkinrelationship,
                                                                                                                    nextOfKinFullName: nextOfKinFullName,
                                                                                                                    nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                                                    patientid: patientid
                                                                                                                };
                                                                                                                $.ajax({
                                                                                                                    type: "POST",
                                                                                                                    cache: false,
                                                                                                                    url: "patient/updatenextofkin.htm",
                                                                                                                    data: data,
                                                                                                                    success: function (rep) {
                                                                                                                        ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                    }
                                                                                                                });
                                                                                                            }
                                                                                                        }
                                                                                                    },
                                                                                                    skip: {
                                                                                                        text: 'SKIP!', // With spaces and symbols
                                                                                                        action: function () {
                                                                                                            ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                        }
                                                                                                    }
                                                                                                },
                                                                                                onContentReady: function () {
                                                                                                    $('.nextOfKinPhone').usPhoneFormat({
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
                                                                                        } else {
                                                                                            //UPDATE NEXT OF KIN DETAILS
                                                                                            $.confirm({
                                                                                                title: 'Update Next Of Kin Details!',
                                                                                                content: '' +
                                                                                                        '<form action="" class="formName">' +
                                                                                                        '<div class="form-group">' +
                                                                                                        '<label>Update Next Of Kin: Full Name</label>' +
                                                                                                        '<input type="text" class="form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                                        '</div>' +
                                                                                                        '<div class="form-group">' +
                                                                                                        '<label for="relationship">Update Relationship</label>' +
                                                                                                        '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                        '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                        '<option>Aunt</option><option>Uncle</option>' +
                                                                                                        '<option>Friend</option><option>Son</option> <option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option>' + '</select></div>' +
                                                                                                        '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                                        '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                                        '</div>' +
                                                                                                        '</form>',
                                                                                                boxWidth: '30%',
                                                                                                useBootstrap: false,
                                                                                                type: 'purple',
                                                                                                typeAnimated: true,
                                                                                                closeIcon: true,
                                                                                                buttons: {
                                                                                                    formSubmit: {
                                                                                                        text: 'Create Visit',
                                                                                                        btnClass: 'btn-purple',
                                                                                                        action: function () {

                                                                                                            //UPDATE NEXT OF KIN
                                                                                                            var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                            var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                            var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                                                    $.alert('Please Enter Valid Next of kin Contact');
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
                                                                                                                        ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                    }
                                                                                                                });
                                                                                                            }
                                                                                                        }
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
                                                                                }
                                                                            }
                                                                        },
                                                                        onContentReady: function () {
                                                                            $('.patientContact').usPhoneFormat({
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
                                                            }
                                                        }
                                                    });
                                                }
                                            },
                                            // NO CHANGED LOCATION
                                            NO: {
                                                text: 'NO',
                                                btnClass: 'btn-red',
                                                keys: ['enter', 'shift'],
                                                action: function () {

                                                    //Residence Update
                                                    $.confirm({
                                                        title: 'Update Location Details!',
                                                        content: '' +
                                                                '<style>.select2-container{z-index: 999999999 !important;}</style>' +
                                                                '<form action="" class="formName">' +
                                                                '<div class="form-group"><label class="control-label">Select District</label>' +
                                                                '<select class="form-control select-district2" id="district2" value=""></select></div>' +
                                                                '<div class="form-group"><label class="control-label">Select Village</label>' +
                                                                '<select class="form-control select-village2" id="village2" value=""></select></div>' +
                                                                '</form>',
                                                        boxWidth: '30%',
                                                        useBootstrap: false,
                                                        type: 'purple',
                                                        typeAnimated: true,
                                                        closeIcon: true,
                                                        buttons: {
                                                            formSubmit: {
                                                                text: 'Submit Location',
                                                                btnClass: 'btn-purple',
                                                                action: function () {
                                                                    //update location detalis
                                                                    var village2 = this.$content.find('#village2').val();
                                                                    var data = {
                                                                        village: village2,
                                                                        personid: personid
                                                                    };
                                                                    $.ajax({
                                                                        type: "POST",
                                                                        cache: false,
                                                                        url: "patient/updatevillage.htm",
                                                                        data: data,
                                                                        success: function (rep) {

                                                                        }
                                                                    });
                                                                    //PHONE DETAILS IF NULL
                                                                    if (pContact === '') {
                                                                        $.confirm({
                                                                            title: 'Enter Contact Details!',
                                                                            content: '' +
                                                                                    '<form action="" class="formName">' +
                                                                                    '<div class="form-group required">' +
                                                                                    '<label>Enter Phone Contact</label>' +
                                                                                    '<input type="text" class="form-control patientContact" id="patientContact" placeholder=""/>' +
                                                                                    '</div>' +
                                                                                    '</form>',
                                                                            boxWidth: '30%',
                                                                            useBootstrap: false,
                                                                            type: 'purple',
                                                                            typeAnimated: true,
                                                                            closeIcon: true,
                                                                            buttons: {
                                                                                formSubmit: {
                                                                                    text: 'Submit Contact',
                                                                                    btnClass: 'btn-purple',
                                                                                    action: function () {
                                                                                        //SAVE PHONE detalis
                                                                                        var patientContact = this.$content.find('#patientContact').val();
                                                                                        if (!patientContact) {
                                                                                            $.alert('Please provide a valid Phone Contact');
                                                                                            return false;
                                                                                        } else {

                                                                                            //...SUBMIT PHONE
                                                                                            var data = {
                                                                                                patientContact: patientContact,
                                                                                                patientid: patientid
                                                                                            };
                                                                                            $.ajax({
                                                                                                type: "POST",
                                                                                                cache: false,
                                                                                                url: "patient/updatecontact.htm",
                                                                                                data: data,
                                                                                                success: function (rep) {

                                                                                                }
                                                                                            });
                                                                                            //ADD NEXT OF KIN DETAILS
                                                                                            if (pNxtfullname === '') {
                                                                                                $.confirm({
                                                                                                    title: 'Enter Next Of Kin Details!',
                                                                                                    content: '' +
                                                                                                            '<form action="" class="formName">' +
                                                                                                            '<div class="form-group required">' +
                                                                                                            '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                                            '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                                            '</div>' +
                                                                                                            '<div class="form-group required">' +
                                                                                                            '<label for="relationship">Relationship</label>' +
                                                                                                            '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                            '<option selected disabled>-- Select marital status--</option>' +
                                                                                                            '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                            '<option>Aunt</option><option>Uncle</option><option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Friend</option></select></div>' +
                                                                                                            '<div class="form-group required">' +
                                                                                                            '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                                            '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                                            '</div>' +
                                                                                                            '</form>',
                                                                                                    boxWidth: '30%',
                                                                                                    useBootstrap: false,
                                                                                                    type: 'purple',
                                                                                                    typeAnimated: true,
                                                                                                    closeIcon: true,
                                                                                                    buttons: {
                                                                                                        formSubmit: {
                                                                                                            text: 'Save & Create Visit',
                                                                                                            btnClass: 'btn-purple',
                                                                                                            action: function () {

                                                                                                                //ADD NEXT OF KIN
                                                                                                                var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                                var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                                var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                                                if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                                                    if (!nextOfKinFullName) {
                                                                                                                        $.alert('Please Enter Next Of kin Full Name!');
                                                                                                                        return false;
                                                                                                                    }
                                                                                                                    if (!nextofkinrelationship) {
                                                                                                                        $.alert('Please select Next Of Kin Relationship');
                                                                                                                        return false;
                                                                                                                    }
                                                                                                                    if (!nextOfKinPhone) {
                                                                                                                        $.alert('Please Enter Phone No.');
                                                                                                                        return false;
                                                                                                                    }

                                                                                                                } else {
                                                                                                                    //SUBMIT NEXT OF KIN
                                                                                                                    var data = {
                                                                                                                        nextofkinrelationship: nextofkinrelationship,
                                                                                                                        nextOfKinFullName: nextOfKinFullName,
                                                                                                                        nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                                                        patientid: patientid
                                                                                                                    };
                                                                                                                    $.ajax({
                                                                                                                        type: "POST",
                                                                                                                        cache: false,
                                                                                                                        url: "patient/updatenextofkin.htm",
                                                                                                                        data: data,
                                                                                                                        success: function (rep) {
                                                                                                                            ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                        }
                                                                                                                    });
                                                                                                                }
                                                                                                            }
                                                                                                        },
                                                                                                        skip: {
                                                                                                            text: 'SKIP!', // With spaces and symbols
                                                                                                            action: function () {
                                                                                                                ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                            }
                                                                                                        }
                                                                                                    },
                                                                                                    onContentReady: function () {
                                                                                                        $('.nextOfKinPhone').usPhoneFormat({
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
                                                                                            } else {
                                                                                                //UPDATE NEXT OF KIN DETAILS
                                                                                                $.confirm({
                                                                                                    title: 'Update Next Of Kin Details!',
                                                                                                    content: '' +
                                                                                                            '<form action="" class="formName">' +
                                                                                                            '<div class="form-group">' +
                                                                                                            '<label>Update Next Of Kin: Full Name</label>' +
                                                                                                            '<input type="text" class="form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                                            '</div>' +
                                                                                                            '<div class="form-group">' +
                                                                                                            '<label for="relationship">Update Relationship</label>' +
                                                                                                            '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                            '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                            '<option>Aunt</option><option>Uncle</option><option>Friend</option><option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option></select></div>' +
                                                                                                            '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                                            '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                                            '</div>' +
                                                                                                            '</form>',
                                                                                                    boxWidth: '30%',
                                                                                                    useBootstrap: false,
                                                                                                    type: 'purple',
                                                                                                    typeAnimated: true,
                                                                                                    closeIcon: true,
                                                                                                    buttons: {
                                                                                                        formSubmit: {
                                                                                                            text: 'Create Visit',
                                                                                                            btnClass: 'btn-purple',
                                                                                                            action: function () {
                                                                                                                //UPDATE NEXT OF KIN
                                                                                                                var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                                var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                                var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                                                        $.alert('Please Enter Valid Next Of Kin Contact');
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
                                                                                                                            ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                        }
                                                                                                                    });
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    },
                                                                                                    onContentReady: function () {
                                                                                                        $('.nextOfKinPhoneupt').usPhoneFormat({
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
                                                                                        }
                                                                                    }
                                                                                },
                                                                                Skip: function () {
                                                                                    //ADD NEXT OF KIN DETAILS
                                                                                    if (pNxtfullname === '') {
                                                                                        $.confirm({
                                                                                            title: 'Enter Next Of Kin Details!',
                                                                                            content: '' +
                                                                                                    '<form action="" class="formName">' +
                                                                                                    '<div class="form-group required">' +
                                                                                                    '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                                    '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                                    '</div>' +
                                                                                                    '<div class="form-group required">' +
                                                                                                    '<label for="relationship">Relationship</label>' +
                                                                                                    '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                    '<option selected disabled>-- Select marital status--</option>' +
                                                                                                    '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                    '<option>Aunt</option><option>Uncle</option><option>Friend</option><option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option></select></div>' +
                                                                                                    '<div class="form-group required">' +
                                                                                                    '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                                    '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                                    '</div>' +
                                                                                                    '</form>',
                                                                                            boxWidth: '30%',
                                                                                            useBootstrap: false,
                                                                                            type: 'purple',
                                                                                            typeAnimated: true,
                                                                                            closeIcon: true,
                                                                                            buttons: {
                                                                                                formSubmit: {
                                                                                                    text: 'Save & Create Visit',
                                                                                                    btnClass: 'btn-purple',
                                                                                                    action: function () {

                                                                                                        //ADD NEXT OF KIN
                                                                                                        var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                        var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                        var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                                        if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                                            if (!nextOfKinFullName) {
                                                                                                                $.alert('Please Enter Next Of kin Full Name!');
                                                                                                                return false;
                                                                                                            }
                                                                                                            if (!nextofkinrelationship) {
                                                                                                                $.alert('Please select Next Of Kin Relationship');
                                                                                                                return false;
                                                                                                            }

                                                                                                            if (!nextOfKinPhone) {
                                                                                                                $.alert('Please Enter Phone No.');
                                                                                                                return false;
                                                                                                            }

                                                                                                        } else {
                                                                                                            //SUBMIT NEXT OF KIN
                                                                                                            var data = {
                                                                                                                nextofkinrelationship: nextofkinrelationship,
                                                                                                                nextOfKinFullName: nextOfKinFullName,
                                                                                                                nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                                                patientid: patientid
                                                                                                            };
                                                                                                            $.ajax({
                                                                                                                type: "POST",
                                                                                                                cache: false,
                                                                                                                url: "patient/updatenextofkin.htm",
                                                                                                                data: data,
                                                                                                                success: function (rep) {
                                                                                                                    ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                }
                                                                                                            });
                                                                                                        }
                                                                                                    }
                                                                                                },
                                                                                                skip: {
                                                                                                    text: 'SKIP!', // With spaces and symbols
                                                                                                    action: function () {
                                                                                                        ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                    }
                                                                                                }
                                                                                            },
                                                                                            onContentReady: function () {
                                                                                                $('.nextOfKinPhone').usPhoneFormat({
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
                                                                                    } else {
                                                                                        //UPDATE NEXT OF KIN DETAILS
                                                                                        $.confirm({
                                                                                            title: 'Update Next Of Kin Details!',
                                                                                            content: '' +
                                                                                                    '<form action="" class="formName">' +
                                                                                                    '<div class="form-group">' +
                                                                                                    '<label>Update Next Of Kin: Full Name</label>' +
                                                                                                    '<input type="text" class="form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                                    '</div>' +
                                                                                                    '<div class="form-group">' +
                                                                                                    '<label for="relationship">Update Relationship</label>' +
                                                                                                    '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                    '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                    '<option>Aunt</option><option>Uncle</option><option>Friend</option><option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option></select></div>' +
                                                                                                    '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                                    '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                                    '</div>' +
                                                                                                    '</form>',
                                                                                            boxWidth: '30%',
                                                                                            useBootstrap: false,
                                                                                            type: 'purple',
                                                                                            typeAnimated: true,
                                                                                            closeIcon: true,
                                                                                            buttons: {
                                                                                                formSubmit: {
                                                                                                    text: 'Create Visit',
                                                                                                    btnClass: 'btn-purple',
                                                                                                    action: function () {

                                                                                                        //UPDATE NEXT OF KIN
                                                                                                        var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                        var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                        var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                                                $.alert('Please Enter Valid Next Of Kin Contact');
                                                                                                                return false;
                                                                                                            }

                                                                                                        } else {
                                                                                                            //UPDATE NEXT OF KIN
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
                                                                                                                    ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                }
                                                                                                            });
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            },
                                                                                            onContentReady: function () {
                                                                                                $('.nextOfKinPhoneupt').usPhoneFormat({
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
                                                                                }
                                                                            },
                                                                            onContentReady: function () {
                                                                                $('.patientContact').usPhoneFormat({
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
                                                                    } else {
                                                                        //UPDATE PHONE DETAILS
                                                                        $.confirm({
                                                                            title: 'Update Phone Details!',
                                                                            content: '<h5>Do you still use Tel: <strong style="font-size: 15px; text-transform: uppercase; color: blue; text-decoration: underline;">' + pContact + '</strong></h5>',
                                                                            boxWidth: '30%',
                                                                            useBootstrap: false,
                                                                            type: 'purple',
                                                                            typeAnimated: true,
                                                                            closeIcon: true,
                                                                            buttons: {
                                                                                //YES NEVER CHANGED TEL PHONE
                                                                                YES: function () {

                                                                                    //ADD NEXT OF KIN DETAILS
                                                                                    if (pNxtfullname === '') {
                                                                                        $.confirm({
                                                                                            title: 'Enter Next Of Kin Details!',
                                                                                            content: '' +
                                                                                                    '<form action="" class="formName">' +
                                                                                                    '<div class="form-group required">' +
                                                                                                    '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                                    '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                                    '</div>' +
                                                                                                    '<div class="form-group required">' +
                                                                                                    '<label for="relationship">Relationship</label>' +
                                                                                                    '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                    '<option selected disabled>-- Select marital status--</option>' +
                                                                                                    '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                    '<option>Aunt</option><option>Uncle</option><option>Friend</option><option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option></select></div>' +
                                                                                                    '<div class="form-group required">' +
                                                                                                    '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                                    '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                                    '</div>' +
                                                                                                    '</form>',
                                                                                            boxWidth: '30%',
                                                                                            useBootstrap: false,
                                                                                            type: 'purple',
                                                                                            typeAnimated: true,
                                                                                            closeIcon: true,
                                                                                            buttons: {
                                                                                                formSubmit: {
                                                                                                    text: 'Save & Create Visit',
                                                                                                    btnClass: 'btn-purple',
                                                                                                    action: function () {
                                                                                                        //ADD NEXT OF KIN
                                                                                                        var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                        var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                        var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                                        if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                                            if (!nextOfKinFullName) {
                                                                                                                $.alert('Please Enter Next Of kin Full Name!');
                                                                                                                return false;
                                                                                                            }
                                                                                                            if (!nextofkinrelationship) {
                                                                                                                $.alert('Please select Next Of Kin Relationship');
                                                                                                                return false;
                                                                                                            }
                                                                                                            if (!nextOfKinPhone) {
                                                                                                                $.alert('Please Enter Phone No.');
                                                                                                                return false;
                                                                                                            }

                                                                                                        } else {
                                                                                                            //SUBMIT NEXT OF KIN
                                                                                                            var data = {
                                                                                                                nextofkinrelationship: nextofkinrelationship,
                                                                                                                nextOfKinFullName: nextOfKinFullName,
                                                                                                                nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                                                patientid: patientid
                                                                                                            };
                                                                                                            $.ajax({
                                                                                                                type: "POST",
                                                                                                                cache: false,
                                                                                                                url: "patient/updatenextofkin.htm",
                                                                                                                data: data,
                                                                                                                success: function (rep) {
                                                                                                                    ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                }
                                                                                                            });
                                                                                                        }
                                                                                                    }
                                                                                                },
                                                                                                skip: {
                                                                                                    text: 'SKIP!', // With spaces and symbols
                                                                                                    action: function () {
                                                                                                        ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                    }
                                                                                                }
                                                                                            },
                                                                                            onContentReady: function () {
                                                                                                $('.nextOfKinPhone').usPhoneFormat({
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
                                                                                    } else {
                                                                                        //UPDATE NEXT OF KIN DETAILS
                                                                                        $.confirm({
                                                                                            title: 'Update Next Of Kin Details!',
                                                                                            content: '' +
                                                                                                    '<form action="" class="formName">' +
                                                                                                    '<div class="form-group">' +
                                                                                                    '<label>Update Next Of Kin: Full Name</label>' +
                                                                                                    '<input type="text" placeholder="Your name" class="name form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                                    '</div>' +
                                                                                                    '<div class="form-group">' +
                                                                                                    '<label for="relationship">Update Relationship</label>' +
                                                                                                    '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                    '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                    '<option>Aunt</option><option>Uncle</option><option>Friend</option><option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option></select></div>' +
                                                                                                    '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                                    '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                                    '</div>' +
                                                                                                    '</form>',
                                                                                            boxWidth: '30%',
                                                                                            useBootstrap: false,
                                                                                            type: 'purple',
                                                                                            typeAnimated: true,
                                                                                            closeIcon: true,
                                                                                            buttons: {
                                                                                                formSubmit: {
                                                                                                    text: 'Create Visit',
                                                                                                    btnClass: 'btn-purple',
                                                                                                    action: function () {

                                                                                                        //UPDATE NEXT OF KIN
                                                                                                        var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                        var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                        var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                                                $.alert('Please Enter Valid Next Of Kin Contact');
                                                                                                                return false;
                                                                                                            }

                                                                                                        } else {
                                                                                                            //UPDATE NEXT OF KIN
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
                                                                                                                    ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                }
                                                                                                            });
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            },
                                                                                            onContentReady: function () {
                                                                                                $('.nextOfKinPhoneupt').usPhoneFormat({
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
                                                                                },
                                                                                // NO CHANGED TEL PHONE
                                                                                NO: {
                                                                                    text: 'NO',
                                                                                    btnClass: 'btn-red',
                                                                                    keys: ['enter', 'shift'],
                                                                                    action: function () {

                                                                                        //UPDATE PHONE DETAILS
                                                                                        $.confirm({
                                                                                            title: 'UPDATE CONTACT Details!',
                                                                                            content: '' +
                                                                                                    '<form action="" class="formName">' +
                                                                                                    '<div class="form-group">' +
                                                                                                    '<label>Update Phone Contact</label>' +
                                                                                                    '<input type="text" class="form-control patientContact" value="' + pContact + '" id="patientContact"/>' +
                                                                                                    '</div>' +
                                                                                                    '</form>',
                                                                                            boxWidth: '30%',
                                                                                            useBootstrap: false,
                                                                                            type: 'purple',
                                                                                            typeAnimated: true,
                                                                                            closeIcon: true,
                                                                                            buttons: {
                                                                                                Submit: {
                                                                                                    text: 'Submit Contact',
                                                                                                    btnClass: 'btn-purple',
                                                                                                    action: function () {
                                                                                                        //SAVE PHONE detalis
                                                                                                        var patientContact = this.$content.find('#patientContact').val();
                                                                                                        if (!patientContact) {
                                                                                                            $.alert('Please provide a valid Phone Contact');
                                                                                                            return false;
                                                                                                        } else {
                                                                                                            //...SUBMIT PHONE
                                                                                                            var data = {
                                                                                                                patientContact: patientContact,
                                                                                                                patientid: patientid
                                                                                                            };
                                                                                                            $.ajax({
                                                                                                                type: "POST",
                                                                                                                cache: false,
                                                                                                                url: "patient/updatecontact.htm",
                                                                                                                data: data,
                                                                                                                success: function (rep) {

                                                                                                                }
                                                                                                            });
                                                                                                            //ADD NEXT OF KIN DETAILS
                                                                                                            if (pNxtfullname === '') {
                                                                                                                $.confirm({
                                                                                                                    title: 'Enter Next Of Kin Details!',
                                                                                                                    content: '' +
                                                                                                                            '<form action="" class="formName">' +
                                                                                                                            '<div class="form-group required">' +
                                                                                                                            '<label>Enter Next Of Kin: Full Name</label>' +
                                                                                                                            '<input type="text" class="form-control" id="nextOfKinFullName"/>' +
                                                                                                                            '</div>' +
                                                                                                                            '<div class="form-group">' +
                                                                                                                            '<label for="relationship">Relationship</label>' +
                                                                                                                            '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                                            '<option selected disabled>-- Select marital status--</option>' +
                                                                                                                            '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                                            '<option>Aunt</option><option>Uncle</option><option>Friend</option><option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option></select></div>' +
                                                                                                                            '<div class="form-group required">' +
                                                                                                                            '<label>Enter Next Of Kin: Phone No</label>' +
                                                                                                                            '<input type="text" class="form-control nextOfKinPhone" id="nextOfKinPhone"/>' +
                                                                                                                            '</div>' +
                                                                                                                            '</form>',
                                                                                                                    boxWidth: '30%',
                                                                                                                    useBootstrap: false,
                                                                                                                    type: 'purple',
                                                                                                                    typeAnimated: true,
                                                                                                                    closeIcon: true,
                                                                                                                    buttons: {
                                                                                                                        formSubmit: {
                                                                                                                            text: 'Save & Create Visit',
                                                                                                                            btnClass: 'btn-purple',
                                                                                                                            action: function () {
                                                                                                                                //ADD NEXT OF KIN
                                                                                                                                var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                                                var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                                                var nextOfKinPhone = this.$content.find('#nextOfKinPhone').val();
                                                                                                                                if (!nextofkinrelationship || !nextOfKinFullName || !nextOfKinPhone) {
                                                                                                                                    if (!nextOfKinFullName) {
                                                                                                                                        $.alert('Please Enter Next Of kin Full Name!');
                                                                                                                                        return false;
                                                                                                                                    }
                                                                                                                                    if (!nextofkinrelationship) {
                                                                                                                                        $.alert('Please select Next Of Kin Relationship');
                                                                                                                                        return false;
                                                                                                                                    }
                                                                                                                                    if (!nextOfKinPhone) {
                                                                                                                                        $.alert('Please Enter Phone No.');
                                                                                                                                        return false;
                                                                                                                                    }

                                                                                                                                } else {
                                                                                                                                    //SUBMIT NEXT OF KIN
                                                                                                                                    var data = {
                                                                                                                                        nextofkinrelationship: nextofkinrelationship,
                                                                                                                                        nextOfKinFullName: nextOfKinFullName,
                                                                                                                                        nextOfKinPhoneUpdt: nextOfKinPhone,
                                                                                                                                        patientid: patientid
                                                                                                                                    };
                                                                                                                                    $.ajax({
                                                                                                                                        type: "POST",
                                                                                                                                        cache: false,
                                                                                                                                        url: "patient/updatenextofkin.htm",
                                                                                                                                        data: data,
                                                                                                                                        success: function (rep) {
                                                                                                                                            ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                                        }
                                                                                                                                    });
                                                                                                                                }
                                                                                                                            }
                                                                                                                        },
                                                                                                                        skip: {
                                                                                                                            text: 'SKIP!', // With spaces and symbols
                                                                                                                            action: function () {
                                                                                                                                ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                            }
                                                                                                                        }
                                                                                                                    },
                                                                                                                    onContentReady: function () {
                                                                                                                        $('.nextOfKinPhone').usPhoneFormat({
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
                                                                                                            } else {
                                                                                                                //UPDATE NEXT OF KIN DETAILS
                                                                                                                $.confirm({
                                                                                                                    title: 'Update Next Of Kin Details!',
                                                                                                                    content: '' +
                                                                                                                            '<form action="" class="formName">' +
                                                                                                                            '<div class="form-group">' +
                                                                                                                            '<label>Update Next Of Kin: Full Name</label>' +
                                                                                                                            '<input type="text" placeholder="Your name" class="name form-control" value=" ' + pNxtfullname + ' " id="nextOfKinFullName">' +
                                                                                                                            '</div>' +
                                                                                                                            '<div class="form-group">' +
                                                                                                                            '<label for="relationship">Update Relationship</label>' +
                                                                                                                            '<select class="form-control" id="nextofkinrelationship">' +
                                                                                                                            '<option>' + pRelationship + '</option><option>Mother</option><option>Father</option><option>Sister</option><option>Brother</option>' +
                                                                                                                            '<option>Aunt</option><option>Uncle</option><option>Friend</option><option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option></select></div>' +
                                                                                                                            '<div class="form-group required"><label>Enter Next Of Kin: Phone No</label>' +
                                                                                                                            '<input type="text" value=" ' + pNxtofkinphonecontact + '" class="form-control nextOfKinPhoneupt" id="nextOfKinPhoneUpdt"/>' +
                                                                                                                            '</div>' +
                                                                                                                            '</form>',
                                                                                                                    boxWidth: '30%',
                                                                                                                    useBootstrap: false,
                                                                                                                    type: 'purple',
                                                                                                                    typeAnimated: true,
                                                                                                                    closeIcon: true,
                                                                                                                    buttons: {
                                                                                                                        formSubmit: {
                                                                                                                            text: 'Create Visit',
                                                                                                                            btnClass: 'btn-purple',
                                                                                                                            action: function () {

                                                                                                                                //UPDATE NEXT OF KIN
                                                                                                                                var nextOfKinFullName = this.$content.find('#nextOfKinFullName').val();
                                                                                                                                var nextofkinrelationship = this.$content.find('#nextofkinrelationship').val();
                                                                                                                                var nextOfKinPhoneUpdt = this.$content.find('#nextOfKinPhoneUpdt').val();
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
                                                                                                                                        $.alert('Please Enter Next Of Kin Contact');
                                                                                                                                        return false;
                                                                                                                                    }

                                                                                                                                } else {
                                                                                                                                    //UPDATE NEXT OF KIN
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
                                                                                                                                            ajaxSubmitDataNoLoader('patient/patientvisitation.htm', 'workpane', 'patientid=' + patientid + '&pfirstname=' + pFirstName + '&plastname=' + pLastName + '&pothername=' + pOtherName + '&pin=' + patPin + '&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                                                                                                                        }
                                                                                                                                    });
                                                                                                                                }
                                                                                                                            }
                                                                                                                        }
                                                                                                                    },
                                                                                                                    onContentReady: function () {
                                                                                                                        $('.nextOfKinPhoneupt').usPhoneFormat({
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
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            },
                                                                                            onContentReady: function () {
                                                                                                $('.patientContact').usPhoneFormat({
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
                                                                                }
                                                                            }
                                                                        });
                                                                    }
                                                                }
                                                            },
                                                        },
                                                        onContentReady: function () {                                                            
                                                            $('#district2').select2();
                                                            $('#village2').select2();
                                                            $('.select2').css('width', '100%');
                                                            $.ajax({
                                                                type: 'POST',
                                                                url: 'locations/fetchDistricts.htm',
                                                                success: function (data) {
                                                                    var res = JSON.parse(data);
                                                                    if (res !== '' && res.length > 0) {
                                                                        for (i in res) {
                                                                            $('#district2').append('<option class="textbolder" id="dis' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                                        }
                                                                        var districtid = parseInt($('#district2').val());
                                                                        $.ajax({
                                                                            type: 'POST',
                                                                            url: 'locations/fetchDistrictVillages.htm',
                                                                            data: {districtid: districtid},
                                                                            success: function (data) {
                                                                                var res = JSON.parse(data);
                                                                                if (res !== '' && res.length > 0) {
                                                                                    for (i in res) {
//                                                                                        $('#village2').append('<option class="classvillage" value="' + res[i].id + '" data-id="' + res[i].id + '">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>');
                                                                                          $('#village2').append('<option class="classvillage" value="' + res[i].id + '" data-id="' + res[i].id + '">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>');                      
                                                                                    }
                                                                                }
                                                                            }
                                                                        });
                                                                    }
                                                                }
                                                            });
                                                            $('#district2').change(function () {
                                                                $('#village2').val(null).trigger('change');
                                                                var districtid = parseInt($('#district2').val());
                                                                $.ajax({
                                                                    type: 'POST',
                                                                    url: 'locations/fetchDistrictVillages.htm',
                                                                    data: {districtid: districtid},
                                                                    success: function (data) {
                                                                        var res = JSON.parse(data);
                                                                        if (res !== '' && res.length > 0) {
                                                                            $('#village2').html('');
                                                                            for (i in res) {
//                                                                                $('#village2').append('<option class="classvillage" value="' + res[i].id + '" data-id="' + res[i].id + '">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>');
                                                                                $('#village2').append('<option class="classvillage" value="' + res[i].id + '" data-id="' + res[i].id + '">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].parish + ']</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>');  
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
                                                        }
                                                    });
                                                }
                                            }
                                        }
                                    });
                                }
                            }
                        },
                        viewdetails: {
                            text: 'View Patient Details',
                            btnClass: 'btn-blue',
                            keys: ['enter', 'shift'],
                            action: function () {                                
                                //VIEW PATIENT DETAILS
                                var data = {
                                    pNin: pNin,
                                    pNationality: pNationality,
                                    pMaritalstatus: pMaritalstatus,
                                    dob: dob,
                                    patientFullNames: patientFullNames,
                                    patPin: patPin,
                                    residenceVill: residenceVill,
                                    pContact: pContact,
                                    pDistrict: pDistrict,
                                    pRelationship: pRelationship,
                                    pNxtfullname: pNxtfullname,
                                    personid: personid,
                                    pNxtofkinphonecontact: pNxtofkinphonecontact,
                                    pFirstName: pFirstName,
                                    pLastName: pLastName,
                                    pOtherName: pOtherName,
                                    patientid: patientid,
                                    residenceparish: residenceParish
                                };
                                $.ajax({
                                    type: "GET",
                                    cache: false,
                                    url: "patient/manageregisteredpatientdetails.htm",
                                    data: data,
                                    success: function (response) {
                                        $('#workpane').html(response);
                                    }
                                });
                            }
                        }
                    }
                });
            }
        });
    }
</script>
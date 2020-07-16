<%--
    Document   : registerNewPatient
    Created on : Apr 10, 2018, 5:57:46 PM
    Author     : Grace-K
--%>
<%@include file="../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <form id="entryform">
                    <div id="horizontalwithwords"><span class="pat-form-heading">BASIC DETAILS</span></div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="pin2">Patient Number(PIN):</span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="pin2"><strong></strong></span>
                        <span><a onclick="editpin2()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>First Name:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="firstname2"><strong></strong></span>
                        <span><a onclick="editfirstname2()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="lastname2"><strong>Last Name:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="lastname2"><strong></strong></span>
                        <span><a onclick="editlastname2()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="othername2"><strong>Other Name:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="othername2"><strong></strong></span>
                        <span><a onclick="editothername2()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="phoneno2"><strong>Phone No:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="phoneno2"><strong></strong></span>
                        <span><a onclick="editphoneno2()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <input type="hidden" id="villlageidhiddn"/>
                    <input type="hidden" id="inputestimatedage"/>
                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="village3"><strong>Village:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="village3"><strong></strong></span>
                        <span><a onclick="editvillage3()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="gender2"><strong>Gender:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="gender2"><strong></strong></span>
                        <span><a onclick="editgender2()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div id="horizontalwithwords"><span class="pat-form-heading">OTHER DETAILS</span></div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for=""><strong>NIN:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="nin2"><strong></strong></span>
                        <span><a onclick="editnin2()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="dateOfBirth2"><strong>Date Of Birth:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="dateOfBirth2"><strong></strong></span>
                        <span><a onclick="editDOB()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="nationality2"><strong>Nationality:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="nationality2"><strong></strong></span>
                        <span><a onclick="editnationality2()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="nextofkinname2"><strong>Next Of Kin: Full Name:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="nextofkinname2"><strong></strong></span>
                        <span><a onclick="editnextofkinname2()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="maritalstatus2"><strong>Marital Status:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="maritalstatus2"><strong></strong></span>
                        <span><a onclick="editmaritalstatus2()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="nextofkinrelationship2"><strong>Next Of Kin: Relationship:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="nextofkinrelationship2"><strong></strong></span>
                    </div>

                    <div class="form-group bs-component col-md-12">
                        <div style="margin-left: -19px" class="col-md-9"> <span class="control-label pat-form-heading patientConfirmFont" for="nextofkinphone2"><strong>Next Of Kin: Phone No:</strong></span>&nbsp;
                            <span class="badge badge-primary patientConfirmFont" id="nextofkinphone2"><strong></strong></span>
                        </div>
                        <div class="form-group bs-component" id="appendlanguages"></div>
                        <button style="margin-top: -5% !important" class="btn btn-primary icon-btn pull-right col-md-3" id="saveNewPatientDetails">
                            <i class="fa fa-save"></i>Save Patient
                        </button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $("#patientvisitcreateresponse").hide();
    });

    $('#saveNewPatientDetails').click(function () {
        $('#saveNewPatientDetails').prop('disabled', true);
        var firstname = $('#firstname2').text();
        var lastname = $('#lastname2').text();
        var pin = $('#pin2').text();
        var dateOfBirth = $('#dateOfBirth2').text();
        var othername = $('#othername2').text();
        var nationality = $('#nationality2').text();
        var village = $('#villlageidhiddn').val();
        var nextofkinphone = $('#nextofkinphone2').text();
        var phoneno = $('#phoneno2').text();
        var patientGender = $('#gender2').text();
        var nextofkinname = $('#nextofkinname2').text();
        var nextofkinrelationship = $('#nextofkinrelationship2').text();
        var maritalstatus2 = $('#maritalstatus2').text();
        var nin2 = $('#nin2').text();
        var inputestimatedage = $('#inputestimatedage').val();
        var data = {
            firstname2: firstname,
            lastname2: lastname,
            dateOfBirth2: dateOfBirth,
            pin2: pin,
            othername2: othername,
            phoneno2: phoneno,
            nextofkinphone2: nextofkinphone,
            gender2: patientGender,
            nationality2: nationality,
            village3: village,
            nextofkinname2: nextofkinname,
            nextofkinrelationship2: nextofkinrelationship,
            maritalstatus2: maritalstatus2,
            inputestimatedage: inputestimatedage,
            nin2: nin2,
            languageIds: JSON.stringify(languageIds)
        };
        $.ajax({
            type: "POST",
            cache: false,
            url: "patient/checkpatientexists.htm",
            data: data,
            success: function(result){
                if(result.toString().toLowerCase() === "true"){
                    $.confirm({
                        title: 'Patient Details Already Exist.',
                        content: 'Do you want to register the patient again?',
                        boxWidth: '35%',
                        useBootstrap: false,
                        type: 'purple',
                        typeAnimated: true,
                        closeIcon: true,
                        theme: 'modern',
                        buttons:{
                            Yes:{
                                text: 'Yes',
                                btnClass: 'btn-red',
                                keys: ['enter', 'shift'],
                                action: function (){
                                    functionSaveNewPatient(data);
                                } 
                            },
                            No:{
                                text: 'No',
                                btnClass: 'btn-purple',
                                keys: ['enter', 'shift'],
                                action: function (){
                                    ajaxSubmitData('patient/patientvisits.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            }
                        }
                    });
                }else{
                    functionSaveNewPatient(data);
                }
            }
        });
//       
//        $.ajax({
//            type: "POST",
//            cache: false,
//            url: "patient/savenewpatient.htm",
//            data: data,
//            success: function (response) {
//                window.location = '#close2';
//                $('#workpane').html(response);
//            }
//        });
    });
    //
    var functionSaveNewPatient = function(data){
        $.ajax({
            type: "POST",
            cache: false,
            url: "patient/savenewpatient.htm",
            data: data,
            success: function (response) {
                window.location = '#close2';
                $('#workpane').html(response);
            }
        });
    }
    //

    function editpin2() {
        var pin2 = $('#pin2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Patient PIN:</label>' +
                    '<input type="text" class="form-control" value="' + pin2 + '" id="editpin2"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editpin2 = this.$content.find('#editpin2').val();
                        $("#pin2").text(editpin2);
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
    
   

    function editfirstname2() {
        var firstname2 = $('#firstname2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>First Name:</label>' +
                    '<input type="text" class="form-control" value="' + firstname2 + '" id="editfirstname2"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editfirstname2 = this.$content.find('#editfirstname2').val();
                        if (!editfirstname2) {
                            $.alert('Please provide your valid First name');
                            return false;
                        } else {
                            $("#firstname2").text(editfirstname2);
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

    function editlastname2() {
        var lastname2 = $('#lastname2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Last Name:</label>' +
                    '<input type="text" class="form-control" value="' + lastname2 + '" id="editlastname2"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editlastname2 = this.$content.find('#editlastname2').val();
                        if (!editlastname2) {
                            $.alert('Please provide your valid Last name');
                            return false;
                        } else {
                            $("#lastname2").text(editlastname2);
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

    function editothername2() {
        var othername2 = $('#othername2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Other Name:</label>' +
                    '<input type="text" class="form-control" value="' + othername2 + '" id="editothername2"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editothername2 = this.$content.find('#editothername2').val();
                        $("#othername2").text(editothername2);
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

    function editphoneno2() {
        var phoneno2 = $('#phoneno2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Phone No:</label>' +
                    '<input type="text" class="form-control" value="' + phoneno2 + '" id="editphoneno2"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editphoneno2 = this.$content.find('#editphoneno2').val();
                        $("#phoneno2").text(editphoneno2);
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#editphoneno2').usPhoneFormat({
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

    function editvillage3() {
        var village3 = $('#village3').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
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
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        //var editdistrictss = this.$content.find('#editdistrict22').val();
                        var editvillage3 = this.$content.find('#editvillage').val();
                        var villageEdited = $("#" + editvillage3).data("villagename22");
                        //   var districtEdited = $("#" + editdistrictss).data("districtname22");
                        $("#village3").text(villageEdited);
                        $("#villlageidhiddn").val(editvillage3);
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
                                            $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename22="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
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
                                    $('#editvillage').append('<option class="classvillage" id="' + res[i].id + '" value="' + res[i].id + '" data-villagename22="' + res[i].village + ' ">' + res[i].village + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:30px; font-weight:bolder>[' + res[i].subcounty + ']</span></option>').trigger("change");
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

    function editgender2() {
        var gender2 = $('#gender2').text();
        if (gender2 === 'Female') {
            $.confirm({
                title: 'Prompt!',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group required village">' +
                        ' <label class="control-label">Gender:</label>' +
                        ' <select class="form-control patientgender" id="patientgender">' +
                        '<option value="Female">Female</option>' +
                        '<option value="Male">Male</option>' +
                        ' </select>' +
                        '</div>' +
                        '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn-blue',
                        action: function () {
                            var patientgender = this.$content.find('.patientgender').val();
                            $("#gender2").text(patientgender);
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
                        ' <select class="form-control patientgender" id="patientgender">' +
                        '<option value="Male">Male</option>' +
                        '<option value="Female">Female</option>' +
                        ' </select>' +
                        '</div>' +
                        '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn-blue',
                        action: function () {
                            var patientgender = this.$content.find('.patientgender').val();
                            $("#gender2").text(patientgender);
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

    function editDOB() {
        var dateOfBirth2 = $('#dateOfBirth2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    ' <div class="form-group required">' +
                    '<label class="control-label" for="dateOfBirth">D.O.B</label>' +
                    '<input class="form-control" id="editdateOfBirth2" value="' + dateOfBirth2 + '">' +
                    ' </div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editdateOfBirth2 = this.$content.find('#editdateOfBirth2').val();

                        if (!editdateOfBirth2) {
                            $.alert('provide valid D.O.B');
                            return false;
                        } else {
                            $("#dateOfBirth2").text(editdateOfBirth2);
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {
                $('#editdateOfBirth2').datepicker({
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

    function editnationality2() {
        var nationality2 = $('#nationality2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '  <label class="control-label">Nationality:</label>' +
                    '  <div>' +
                    ' <div class="form-group">' +
                    '  <select class="form-control"  id="editnationality2" name="country" >' +
                    ' <option class="textbolder" value="' + nationality2 + '">' + nationality2 + '</option>' +
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
                    ' <option class="textbolder" value="Ugandan">Ugandan</option>' +
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
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editnationality2 = this.$content.find('#editnationality2').val();
                        $("#nationality2").text(editnationality2);
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

    function editnextofkinname2() {
        var nextofkinname2 = $('#nextofkinname2').text();
        var nextofkinphone2 = $('#nextofkinphone2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '<label>Enter Next Of Kin: Full Name</label>' +
                    '<input type="text" class="form-control" id="editnextofkinname2" value="' + nextofkinname2 + '"/>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label for="relationship">Relationship</label>' +
                    '<select class="form-control" id="editnextofkinrelationship2">' +
                    '<option selected disabled>-- Select marital status--</option>' +
                    '<option>Mother</option> <option>Father</option><option>Sister</option><option>Brother</option>' +
                    '<option>Aunt</option><option>Uncle</option><option>Friend</option>' +
                    '<option>Son</option><option>Daughter</option><option>Cousin</option><option>Grand Mother</option><option>Grand Father</option><option>Girlfriend</option><option>Boyfriend</option><option>Husband</option><option>Wife</option><option>Nephew</option><option>Niece</option><option>Twin Brother</option><option>Twin Sister</option><option>Stepbrother</option><option>Stepsister</option><option>Twin Brother</option><option>Mother-in-law</option><option>Father-in-law</option><option>Half-brother</option><option>Half-sister</option></select></div>' +
                    '<div class="form-group required">' +
                    '<label>Enter Next Of Kin: Phone No</label>' +
                    '<input type="text" class="form-control" id="editnextofkinphone2" value="' + nextofkinphone2 + '"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editnextofkinname2 = this.$content.find('#editnextofkinname2').val();
                        var editnextofkinphone2 = this.$content.find('#editnextofkinphone2').val();
                        var editnextofkinrelationship2 = this.$content.find('#editnextofkinrelationship2').val();
                        $("#nextofkinname2").text(editnextofkinname2);
                        $("#nextofkinphone2").text(editnextofkinphone2);
                        $("#nextofkinrelationship2").text(editnextofkinrelationship2);
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

    function editmaritalstatus2() {
        var maritalstatus2 = $('#maritalstatus2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label class="control-label" for="maritalstatus">Marital Status</label>' +
                    '<select class="form-control" id="editmaritalstatus2">' +
                    '<option class="textbolder">' + maritalstatus2 + '</option>' +
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
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editmaritalstatus2 = this.$content.find('#editmaritalstatus2').val();
                        $("#maritalstatus2").text(editmaritalstatus2);
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

    function editnin2() {
        var nin2 = $('#nin2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>NIN:</label>' +
                    '<input type="text" class="form-control" value="' + nin2 + '" id="editnin2"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editnin2 = this.$content.find('#editnin2').val();
                        if (!editnin2) {
                            $.alert('Please provide your valid NIN');
                            return false;
                        } else {
                            $("#nin2").text(editnin2);
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


<%-- 
    Document   : confirmDonorDetails
    Created on : Oct 4, 2018, 1:18:41 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <form id="entryform">
                    <div id="horizontalwithwords"><span class="pat-form-heading">BASIC DETAILS</span></div>
                    <div class="form-group bs-component">
                        <span type="text" id="donorid2" style="display: none"></span>
                        <span class="control-label pat-form-heading patientConfirmFont" for="pin2">Donor Name:</span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="donorname2"><strong></strong></span>
                        <span><a onclick="editdonorname()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Origin Country:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="origincountry2"><strong></strong></span>
                        <span><a onclick="editorigincountry()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="lastname2"><strong>Donor Type:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="donortype2"><strong></strong></span>
                        <span><a onclick="editdonortype()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Contact Person First Name:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="firstname2"><strong></strong></span>
                        <span><a onclick="editfirstname()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>
                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="secondname2"><strong>Contact Person Second Name:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="secondname2"><strong></strong></span>
                        <span><a onclick="editsecondname()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>
                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="othername2"><strong>Contact Person Other Name:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="othername2"><strong></strong></span>
                        <span><a onclick="editothername()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div id="horizontalwithwords"><span class="pat-form-heading">OTHER DETAILS</span></div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="telno2"><strong>Tel No.:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="telno2"><strong></strong></span>
                        <span><a onclick="edittelno()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="email2"><strong>Email:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="email2"><strong></strong></span>
                        <span><a onclick="editemail()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>

                    <div class="form-group bs-component">
                        <span class="control-label pat-form-heading patientConfirmFont" for="nationality2"><strong>Fax:</strong></span>&nbsp;
                        <span class="badge badge-primary patientConfirmFont" id="fax2"><strong></strong></span>
                        <span><a onclick="editfax()"><i style="font-weight: bolder" class="fa fa-fw fa-lg fa-edit"></i></a></span>
                    </div>
                    <div class="form-group bs-component col-md-12">
                        <button style="margin-top: -5% !important" class="btn btn-primary icon-btn pull-right col-md-3" id="saveNewDonorDetails">
                            <i class="fa fa-save"></i>Save Donor
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

    $('#saveNewDonorDetails').click(function () {
        $('#saveNewDonorDetails').prop('disabled', true);
        var donorid = $('#donorid2').text();
        var donorname = $('#donorname2').text();
        var country = $('#origincountry2').text();
        var donortype = $('#donortype2').text();
        var firstname = $('#firstname2').text();
        var secondname = $('#secondname2').text();
        var othername = $('#othername2').text();
        var telno = $('#telno2').text();
        var email = $('#email2').text();
        var fax = $('#fax2').text();

     
    });

    function editdonorname() {
        var donorname2 = $('#donorname2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Donor Name:</label>' +
                    '<input type="text" class="form-control" value="' + donorname2 + '" id="editdonorname2"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editdonorname2 = this.$content.find('#editdonorname2').val();
                        if (!editdonorname2) {
                            $.alert('Please provide your valid Donor name');
                            return false;
                        } else {
                            $("#donorname2").text(editdonorname2);
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

    function editgender2() {
        var donortype2 = $('#donortype2').text();
        if (donortype2 === 'GROUP/ORGANISATION') {
            $.confirm({
                title: 'Prompt!',
                content: '' +
                        '<form action="" class="formName">' +
                        '<div class="form-group required village">' +
                        ' <label class="control-label">Donor Type:</label>' +
                        '<input id="organisation" value="Organisation" class="form-check-input" type="radio" name="donortype"><span class="label-text">' + 'Organisation' + '</span>' +
                        '<input id="individual" value="Individual" class="form-check-input" type="radio" name="donortype"><span class="label-text">' + 'Individual' + '</span>' +
                        '</div>' +
                        '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn-blue',
                        action: function () {
                            var donorType = $("input:radio[name=donortype]:checked").val();
                            $("#donortype2").text(donorType);
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
                        ' <label class="control-label">Donor Type:</label>' +
                        '<input id="organisation" value="Organisation" class="form-check-input" type="radio" name="donortype"><span class="label-text">' + 'Organisation' + '</span>' +
                        '<input id="individual" value="Individual" class="form-check-input" type="radio" name="donortype"><span class="label-text">' + 'Individual' + '</span>' +
                        '</div>' +
                        '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn-blue',
                        action: function () {
                            var donorType = $("input:radio[name=donortype]:checked").val();
                            $("#donortype2").text(donorType);
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


    function editdonortype() {
        var donortype = $('#donortype2').text();
        if (donortype === "GROUP/ORGANISATION") {
            // Check #x
            var donortype2 = $("#organisation").prop("checked", true);


        } else {
        }
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Donor Type:</label>' +
                    '<input type="text" class="form-control" value="' + donortype2 + '" id="editdonortype2"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editdonortype2 = this.$content.find('#editdonortype2').val();
                        $("#donortype2").text(editdonortype2);
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

    function editcontactperson() {
        var contactperson2 = $('#contactperson2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Donor Contact Person:</label>' +
                    '<input type="text" class="form-control" value="' + contactperson2 + '" id="editcontactperson2"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editcontactperson2 = this.$content.find('#editcontactperson2').val();
                        if (!editcontactperson2) {
                            $.alert('Please provide your valid Contact Person');
                            return false;
                        } else {
                            $("#contactperson2").text(editcontactperson2);
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

    function edittelno() {
        var telno2 = $('#telno2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Telephone No.:</label>' +
                    '<input type="text" class="form-control" value="' + telno2 + '" id="edittelno2"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var edittelno2 = this.$content.find('#edittelno2').val();
                        if (!edittelno2) {
                            $.alert('Please provide your valid Telephone Number');
                            return false;
                        } else {
                            $("#telno2").text(edittelno2);
                        }
                    }
                },
                cancel: function () {
                    //close
                }
            },
            onContentReady: function () {

                $('#edittelno2').usPhoneFormat({
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

    function editemail() {
        var email2 = $('#email2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Donor Email:</label>' +
                    '<input type="text" class="form-control" value="' + email2 + '" id="editemail2"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Submit',
                    btnClass: 'btn-blue',
                    action: function () {
                        var editemail2 = this.$content.find('#editemail2').val();
                        $("#email2").text(editemail2);
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

    function editorigincountry() {
        var origincountry2 = $('#origincountry2').text();
        $.confirm({
            title: 'Prompt!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group required">' +
                    '  <label class="control-label">Country:</label>' +
                    '  <div>' +
                    ' <div class="form-group">' +
                    '  <select class="form-control"  id="editorigincountry2" name="country" >' +
                    ' <option class="textbolder" value="' + origincountry2 + '">' + origincountry2 + '</option>' +
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
                        var editorigincountry2 = this.$content.find('#editorigincountry2').val();
                        $("#origincountry2").text(editorigincountry2);
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

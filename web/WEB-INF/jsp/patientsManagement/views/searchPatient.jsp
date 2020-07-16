<%-- 
    Document   : searchPatient
    Created on : Apr 15, 2018, 4:44:35 PM
    Author     : Grace-K
--%>
<!--Dashboard Cards-->
<link rel="stylesheet" type="text/css" href="static/res/css/card/bootstrap-extended.css">
<link rel="stylesheet" type="text/css" href="static/res/css/card/colors.css">
<link rel="stylesheet" type="text/css" href="static/res/css/card/components.css">
<link rel="stylesheet" type="text/css" href="static/res/css/card/vendors.min.css">

<div class="app-title" >
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
                    <li class="last active"><a href="#">Patient Visit</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <div class="tile-body">
            <div id="search-form_3">
                <!--<input id="patientSearch" type="text" oninput="searchPatient()" placeholder="Search Patient" onfocus="displaySearchResults()" class="search_3 dropbtn"/>-->
                <input id="patientSearch" type="text" placeholder="Search Patient" onfocus="displaySearchResults()" class="search_3 dropbtn"/>
            </div>
            <div id="myDropdown" class="search-content">

            </div><br>
        </div>
    </div>
    <div class="col-md-2"></div>
</div></br></br>

<div class="">
    <div class="row">
        <div class="col-md-1">

        </div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-3">
                    <div class="card-counter primary">
                        <i class="fa fa-male"></i><i class="fa fa-female"></i><i class="fa fa-child"></i>
                        <span class="count-numbers">${totalpatientvisit}</span>
                        <span class="count-name">Total Patient<span style="text-transform: lowercase">(s)</span></span>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-counter primary">
                        <i class="fa fa-male"></i>
                        <span class="count-numbers">${totalpatientsMale}</span>
                        <span class="count-name">Male</span>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-counter info">
                        <i class="fa fa-female"></i>
                        <span class="count-numbers">${totalpatientsFemale}</span>
                        <span class="count-name">Female</span>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-counter info">
                        <i class="fa fa-book"></i>
                        <span class="count-numbers" style="font-size: x-large;">
                            <span id="staff-total-patients">${stafftotalpatients}</span> 
                            Of 
                            <span id="total-patients">${totalpatientvisit}</span>
                        </span>
                        <span class="count-name">My Register</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-1">

        </div>
    </div></br>

    <div class="row">
        <div class="col-md-1">

        </div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-content">
                            <div style="padding: 4px !important;  font-weight: bolder;" class="card-body">
                                <div class="row">
                                    <div class="col-md-4 border-right-blue-grey border-right-lighten-4">
                                        <div class="float-left pl-2">
                                            <span class="font-large-3 text-bold-300">${totalpatientvisitbelow5}</span>
                                        </div>
                                        <div style="font-weight: bold; font-size: 100%; padding-top: 6% !important; padding-left: 2% !important;" class="float-left mt-2 ml-1">
                                            <span class="blue-grey darken-1 block">0 - 4</span>
                                            <span class="blue-grey darken-1 block">years</span>
                                        </div>
                                    </div>
                                    <div class="col-md-4 border-right-blue-grey border-right-lighten-4">
                                        <div class="float-left pl-2">
                                            <span class="font-large-3 text-bold-300">${totalpatientvisit5to12}</span>
                                        </div>
                                        <div style="font-weight: bold; font-size: 100%; padding-top: 6% !important; padding-left: 2% !important;" class="float-left mt-2 ml-1">
                                            <span class="blue-grey darken-1 block">5 - 12</span>
                                            <span class="blue-grey darken-1 block">years</span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="float-left pl-2">
                                            <span class="font-large-3 text-bold-300">${totalpatientvisit13andabove}</span>
                                        </div>
                                        <div style="font-weight: bold; font-size: 100%; padding-top: 6% !important; padding-left: 2% !important;" class="float-left mt-2 ml-1">
                                            <span class="blue-grey darken-1 block">13 years</span>
                                            <span class="blue-grey darken-1 block"> and Above</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-1">

        </div>
    </div>
</div>

<div class="" id="patientsDetails">

</div>

<input id="patient-searched-names" value="" type="hidden"/>
<!--model Add New Insurance Company-->
<div class="modal fade" id="modelConfirmConsent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: auto"> 
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h3 class="" id="dialogs">Consent</h3>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button> 
            </div> 
            <div class="modal-body">

                <div align="center" id="activity-callBack">
                    <fieldset align="center" class="FieldsetContainer ui-corner-all" style="height: auto; padding: 0px !important">
                        <table width="100%">
                            <tbody>
                                <tr>
                                    <td align="center" bgcolor="#C93AC9">
                                        <span style="color:#FFFFFF; font-weight:bolder">
                                            <h5>Please read the Consent below to seek new patient's will to be registered.</h5>
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <table width="100%" cellspacing="5px" class="consentForm">
                            <tbody>
                                <tr>
                                    <td colspan="2"><span>Now, I am going to capture your details including your photo,</span> </td>
                                </tr>
                                <tr>
                                    <td colspan="2"><span>and fingerprint into the computer for ease of management of your records.</span></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><span>Is this ok?</span></td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp; </td>
                                </tr>
                                <tr>
                                    <td> <span> <font color="red" size="4"><i>Consent Given</i> </font></span> </td>
                                    <td width="78%" align="left">  <input id="patientConsentTrue" type="radio" name="consent" value="Yes">&nbsp;&nbsp;</td>
                                </tr>
                                <tr>
                                    <td><span> <font color="red" size="4"> <i>Consent Rejected</i> </font></span> </td>
                                    <td width="78%" align="left"><input type="radio" name="consent" value="No" onclick="$('#modelConfirmConsent').modal('hide');">&nbsp;&nbsp;</td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>
                </div>
            </div>
            <div class="modal-footer"> 
            </div>
        </div>
    </div> 
</div><!-- /.modal-content --> 

<script>
    var facilityId = ${facilityid};
    $(function(){
        connect();
    });
    breadCrumb();
    $('#patientSearch').on('input keyup', function(e){ //
        if(e.currentTarget.value.length >= 3){
            searchPatient();
        }else if(e.key === " " || e.key === "Enter"){
            searchPatient();
        }
    });
    function displaySearchResults() {
        document.getElementById("myDropdown").classList.add("showSearch");
    }
    function trim(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    function searchPatient() {
        var student = trim($('#patientSearch').val());
        var size = student.length;
        if (size > 0) {
            $.ajax({
                type: "POST",
                cache: false,
                url: "patient/searchPatient.htm",
                data: {searchValue: student},
                success: function (response) {
                    $('#myDropdown').html(response);
                }
            });
        } else {
            $('#myDropdown').html('');
        }
    }
    function clearSearchResult() {
        document.getElementById('searchResults').style.display = 'none';
    }

    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("search-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('showSearch')) {
                    openDropdown.classList.remove('showSearch');
                    var patientSearchvalue = $('#patientSearch').val();
                    patientSearchvalue = capitalizePatientSearchResults(patientSearchvalue);
                    $("#patient-searched-names").val(patientSearchvalue);
                    document.getElementById("patientSearch").value = '';
                    $('#myDropdown').html('');
                }
            }
        }
    };

    function confirmPatientConsent() {
        $('#modelConfirmConsent').modal('show');
    }

    $('#patientConsentTrue').click(function () {
        var patientSearchValue = $('#patient-searched-names').val();
        $('#modelConfirmConsent').modal('hide');
        $('body').removeClass('modal-open');
        $('.modal-backdrop').remove();
        ajaxSubmitData('patient/registernewpatient.htm', 'workpane', 'patientname=' + patientSearchValue + '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });

    function capitalizePatientSearchResults(str) {
        str = str.toLowerCase().split(' ');
        for (var i = 0; i < str.length; i++) {
            str[i] = str[i].split('');
            str[i][0] = str[i][0].toUpperCase();
            str[i] = str[i].join('');
        }
        return str.join(' ');
    }
    function connect(){
        var socket = new SockJS('iics-queue');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function(frame){
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/facilitypatientcount/' + facilityId, function(data){
                $("#total-patients").text(data.body);
            });
        });
    }
</script>
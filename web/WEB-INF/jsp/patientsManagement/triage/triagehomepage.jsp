<%-- 
    Document   : doctorConsultationsHome
    Created on : Aug 16, 2018, 8:14:38 AM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<style>
    @-webkit-keyframes blink {
        0% {
            opacity: 1;
        }
        50% {
            opacity: 0;
        }
        100% {
            opacity: 1;
        }
    }
    @-moz-keyframes blink {
        0% {
            opacity: 1;
        }
        50% {
            opacity: 0;
        }
        100% {
            opacity: 1;
        }
    }
    @-o-keyframes blink {
        0% {
            opacity: 1;
        }
        50% {
            opacity: 0;
        }
        100% {
            opacity: 1;
        }
    }
    .triagePatientsQueues {
        -webkit-animation: blink 2s;
        -webkit-animation-iteration-count: infinite;
        -moz-animation: blink 2s;
        -moz-animation-iteration-count: infinite;
        -o-animation: blink 1s;
        -o-animation-iteration-count: infinite;
    }
</style>
<div id="mmmainControlpanel">
    <div class="app-title" id="">
        <div class="col-md-5">
            <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
            <p>Together We Save Lives...!</p>
        </div>
        <div>
            <div class="mmmains">
                <div class="wrapper">
                    <ul class="breadcrumbs">
                        <li class="first"><a href="#" class="fa fa-home" onclick="clearInterval(interval);ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');cleanUp();"></a></li>
                        <li><a href="#" onclick="clearInterval(interval);ajaxSubmitData('patient/patientmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');cleanUp();">Patient Management</a></li>
                        <li class="last active"><a href="#">Patient Triage</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-title">
                        <h5>Today's Patients.</h5>  
                    </div>
                    <div class="tile-body">
                        <fieldset style="min-height:100px;">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="pull-left menu-icon htdmDiv" style="margin-left: 201px;" id="pickPatientForTriageH" data-new-click="true">
                                        <div class="card-footer text-center">
                                            <h5>HT/DM Triage</h5>
                                        </div><hr/>
                                        <div class="icon-content">
                                            <img src="static/img/queue-hover.png" class="triagePatientsQueues pull-right" border="1" width="90" height="70">
                                        </div><br>
                                        <div class="icon-content center">
                                            <h6>
                                                <span class="badge badge-patientinfo" id="queuedPatientsH"></span>
                                                <input id="nextPatientH" type="hidden" value="0"/>
                                            </h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="pull-right menu-icon" style="margin-right: 201px;" id="pickPatientForTriage" data-new-click="true">
                                        <div class="card-footer text-center">
                                            <h5>General Triage</h5>
                                        </div><hr/>
                                        <div class="icon-content">
                                            <img src="static/img/queue-hover.png" class="triagePatientsQueues pull-right" border="1" width="90" height="70">
                                        </div><br>
                                        <div class="icon-content center">
                                            <h6>
                                                <span class="badge badge-info" id="queuedPatients"></span>
                                                <input id="nextPatient" type="hidden" value="0"/>
                                            </h6>
                                        </div>
                                    </div> 
                                </div>
                            </div><br><br><br>
                            <div class="row" style="margin-top: 31px;">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-md-3" id="fetchCanceledH">
                                            <div class="card-counter info" onclick="fetchCanceledPatientsH()" title="Not In Queue">
                                                <i class="fa fa-close danger"></i>
                                                <span class="count-numbers text-danger" id="canceled-countH">-</span>
<!--                                                <span class="count-name">Canceled</span>-->
                                                <span class="count-name">NIQ</span>
                                            </div>
                                        </div>
                                        <div class="col-md-3 change">
                                            <div class="card-counter primary">
                                                <i class="fa fa-male success"></i>
                                                <i class="fa fa-female success"></i>
                                                <i class="fa fa-child success"></i>
                                                <span class="count-numbers text-success" id="serviced">-</span>
                                                <span class="count-name">Serviced Patients</span>
                                            </div>
                                        </div>
                                        <div class="col-md-3 change">
                                            <div class="card-counter info">
                                                <i class="fa fa-clock-o info"></i>
                                                <span class="count-numbers text-info" id="waiting">-</span>
                                                <span class="count-name">Average Waiting Time</span>
                                            </div>
                                        </div>
                                        <div class="col-md-3 change">
                                            <div class="card-counter info" id="fetchCanceled" onclick="fetchCanceledPatients()" title="Not In Queue">
                                                <i class="fa fa-close danger"></i>
                                                <span class="count-numbers text-danger" id="canceled-count">-</span>
                                                <!--<span class="count-name">Canceled</span>-->
                                                <span class="count-name">NIQ</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--model Patient Triage-->
<div class="">
    <div id="modalOrderitems" class="stockDetailsModal">
        <div class="">
            <div id="head">
                <h5 class="modal-title names" id="title">Patient Triage</h5>
                <a href="#close" title="Close" class="close2">X</a>
                <hr>
            </div>
            <div class="row scrollbar" id="content">
                <div class="col-md-12">
                    <%@include file="views/patientTriageForm.jsp" %>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var staff;
    var interval;
    var waitingH = 0;
    var waitingN = 0;
    var canceledN = 0;
    var canceledH = 0;
    var servicedN = 0;
    var servicedH = 0;
    var keyid = '0';
    var patientid33;
    var socketHTDMClinic;
    var queueCanceled = 0;
    var patientVisitationId;
    var socketNormalClinic;
    //
    var skipWeight = false;
    var skipHeight = false;
    var skipTemp = false;
    var skipPressure = false;
    var skipRespirationRate = false;
    var stompClient = null;
    var facilityId = ${facilityid};
    var eventSource = null;
    //
    $(document).ready(function () {
        breadCrumb();
        $('.htdmDiv').hide();
        $('#fetchCanceledH').hide();
        keyid = ${keyid};
        if (parseInt(keyid) > 0) {
            $('.htdmDiv').show();
            $('#fetchCanceledH').show();
            $.ajax({
                type: 'GET',
                data_type: 'JSON',
                url: "queuingSystem/fetchTriageStaffDetails.htm",
                success: function (data) {
                    staff = JSON.parse(data);
                    //
                    connect();
                    initNotification();
                    //
//                    var host = location.host;
//                    var url = 'ws://' + host + '/IICS/queuingServer?'
//                            + 'staffid=' + staff.staffid
//                            + '&serviceid=' + keyid
//                            + '&room=' + staff.room
//                            + '&label=' + staff.label + "&host=" + host;
//                    socketHTDMClinic = new WebSocket(url);
//                    socketHTDMClinic.onmessage = function (ev) {
//                        var response = JSON.parse(ev.data);
//                        if (response.type === 'update') {
//                            $('#queuedPatientsH').html(response.size);
//                        } else if (response.type === 'next') {
//                            $('#nextPatientH').val(response.visit);
//                        }
//                    };
                }
            });
        } else {
            $('.change').removeClass('col-md-3');
            $('.change').addClass('col-md-4');
        }

        $.ajax({
            type: 'GET',
            data_type: 'JSON',
            url: "queuingSystem/fetchTriageStaffDetails.htm",
            success: function (data) {
                staff = JSON.parse(data);
                //
                connect();
                initNotification();
                //
//                var host = location.host;
//                var url = 'ws://' + host + '/IICS/queuingServer?'
//                        + 'staffid=' + staff.staffid
//                        + '&serviceid=' + staff.serviceid
//                        + '&room=' + staff.room
//                        + '&label=' + staff.label + "&host=" + host;
//                socketNormalClinic = new WebSocket(url);
//                socketNormalClinic.onmessage = function (ev) {
//                    var response = JSON.parse(ev.data);
//                    if (response.type === 'update') {
//                        $('#queuedPatients').html(response.size);
//                    } else if (response.type === 'next') {
//                        $('#nextPatient').val(response.visit);
//                    }
//                };
            }
        });

        //Get next patient.
//        $('#pickPatientForTriage').click(function () {
//            var element = $(this);
//            var isNewClick = element.data('new-click');
//            element.find('.icon-content').css('cursor', 'not-allowed');
//            if(isNewClick === true){
//                element.data('new-click', false);
//                var visitid = parseInt($('#nextPatient').val());
//                if (visitid > 0) {
//                    $.ajax({
//                        type: 'POST',
//                        data: {visitid: visitid},
//                        url: 'patient/getPatientVisitDetails.htm',
//                        success: function (res) {
//                            element.data('new-click', true);
//                            element.find('.icon-content').css('cursor', 'default');
//                            if (res !== 'refresh' && res !== '') {
//                                var data = {
//                                    type: 'PICK',
//                                    visitid: visitid,
//                                    serviceid: staff.serviceid,
//                                    staffid: staff.staffid,
//                                    room: staff.room,
//                                    label: staff.label
//                                };
//                                socketNormalClinic.send(JSON.stringify(data));
//                                var visitDetails = JSON.parse(res);
//                                $.confirm({
//                                    title: '',
//                                    content: '<h3><strong><font color="#054afc">' + visitDetails.names + '</font></strong></h3><br/>' +
//                                            '<h4><strong><font color="#054afc">' + visitDetails.visitno + '</font></strong></h4>',
//                                    boxWidth: '40%',
//                                    useBootstrap: false,
//                                    type: 'purple',
//                                    typeAnimated: true,
//                                    theme: 'modern',
//                                    icon: 'fa fa-question-circle',
//                                    buttons: {
//                                        formSubmit: {
//                                            text: 'Receive Patient',
//                                            btnClass: 'btn-purple',
//                                            action: function () {
//                                                pickedPatientInQueue(visitDetails.patientid, visitid, visitDetails.visitno);
//                                                patientVisitationId = visitid;
//                                                patientid33 = visitDetails.patientid;
//                                            }
//                                        },
//                                        close: {
//                                            text: 'Cancel',
//                                            btnClass: 'btn-red cancel',
//                                            action: function () {
//                                                var data = {
//                                                    visitid: visitid,
//                                                    serviceid: staff.serviceid
//                                                };
//                                                $.ajax({
//                                                    type: 'POST',
//                                                    data: data,
//                                                    data_type: 'JSON',
//                                                    url: "queuingSystem/cancelPoppedPatient.htm",
//                                                    success: function (canceled) {
//                                                        if (canceled === 'refresh') {
//                                                            document.location.reload(true);
//                                                        }
//                                                        if (canceled !== 'fasle') {
//                                                            $('#canceled-count').html(canceled);
//                                                        }
//                                                    }
//                                                });
//                                            }
//                                        }
//                                    }
//                                });
//                            } else {
//                                if (res !== 'refresh') {
//                                    document.location.reload(true);
//                                }
//                            }
//                        }
//                    });
//                } else {
//                    element.data('new-click', true);
//                    element.find('.icon-content').css('cursor', 'default');
//                }
//            }
//        });

        $('#pickPatientForTriage').click(function () {
            var element = $(this);
            var isNewClick = element.data('new-click');
            element.find('.icon-content').css('cursor', 'not-allowed');
            if(isNewClick === true){
                element.data('new-click', false);
//                var visitid = parseInt($('#nextPatient').val());                
                $.ajax({
                    type: 'GET',
                    url: 'queuingSystem/popPatient',
                    data: { unitserviceid: staff.serviceid },
                    success: function (data, textStatus, jqXHR) {
                        var visitid = parseInt(data);
                        stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/'  + facilityId + '/' + staff.serviceid, {}, JSON.stringify({ unitserviceid: staff.serviceid }));
                        if (visitid > 0) {
                            $.ajax({
                                type: 'POST',
                                data: {visitid: visitid},
                                url: 'patient/getPatientVisitDetails.htm',
                                success: function (res) {
                                    element.data('new-click', true);
                                    element.find('.icon-content').css('cursor', 'pointer');
                                    if (res !== 'refresh' && res !== '') {
//                                        var data = {
//                                            type: 'PICK',
//                                            visitid: visitid,
//                                            serviceid: staff.serviceid,
//                                            staffid: staff.staffid,
//                                            room: staff.room,
//                                            label: staff.label
//                                        };
//                                        socketNormalClinic.send(JSON.stringify(data));
                                        var visitDetails = JSON.parse(res);
                                        $.confirm({
                                            title: '',
                                            content: '<h3><strong><font color="#054afc">' + visitDetails.names + '</font></strong></h3><br/>' +
                                                    '<h4><strong><font color="#054afc">' + visitDetails.visitno + '</font></strong></h4>',
                                            boxWidth: '40%',
                                            useBootstrap: false,
                                            type: 'purple',
                                            typeAnimated: true,
                                            theme: 'modern',
                                            icon: 'fa fa-question-circle',
                                            buttons: {
                                                formSubmit: {
                                                    text: 'Receive Patient',
                                                    btnClass: 'btn-purple',
                                                    action: function () {
                                                        $('#savePatientTriage').data('caller', 'triage');
                                                        pickedPatientInQueue(visitDetails.patientid, visitid, visitDetails.visitno);
                                                        patientVisitationId = visitid;
                                                        patientid33 = visitDetails.patientid;
                                                    }
                                                },
                                                close: {
                                                    text: 'Cancel',
                                                    btnClass: 'btn-red cancel',
                                                    action: function () {
                                                        var data = {
                                                            visitid: visitid,
                                                            serviceid: staff.serviceid
                                                        };
                                                        $.ajax({
                                                            type: 'POST',
                                                            data: data,
                                                            data_type: 'JSON',
                                                            url: "queuingSystem/cancelPoppedPatient.htm",
                                                            success: function (canceled) {
                                                                if (canceled === 'refresh') {
                                                                    document.location.reload(true);
                                                                }
                                                                if (canceled !== 'fasle') {
//                                                                    $('#canceled-count').html(canceled);
                                                                    fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triage', unitserviceid: staff.serviceid }, '/app/canceledpatients');
                                                                    stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/' + facilityId + '/' + staff.serviceid, {}, JSON.stringify({ unitserviceid: staff.serviceid }));
                                                                }
                                                            }
                                                        });
                                                    }
                                                }
                                            }
                                        });
                                    } else {
                                        if (res !== 'refresh') {
                                            document.location.reload(true);
                                        }
                                    }
                                }
                            });
                        } else {
                            element.data('new-click', true);
                            element.find('.icon-content').css('cursor', 'pointer');
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR);
                        console.log(textStatus);
                        console.log(errorThrown);
                    }
                });
            }
        });
        
        $('#pickPatientForTriageH').click(function () {
            var element = $(this);
            var isNewClick = element.data('new-click');
            element.find('.icon-content').css('cursor', 'not-allowed');
            if(isNewClick === true){
                element.data('new-click', false);
//                var visitid = parseInt($('#nextPatientH').val());
                 $.ajax({
                    type: 'GET',
                    url: 'queuingSystem/popPatient',
                    data: { unitserviceid: keyid },
                    success: function (data, textStatus, jqXHR) {
                        var visitid = parseInt(data);
                        stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/'  + facilityId + '/' + keyid, {}, JSON.stringify({ unitserviceid: keyid }));
                        if (visitid > 0) {
                            $.ajax({
                                type: 'POST',
                                data: {visitid: visitid},
                                url: 'patient/getPatientVisitDetails.htm',
                                success: function (res) {
                                    element.data('new-click', true);
                                    element.find('.icon-content').css('cursor', 'pointer');
                                    if (res !== 'refresh' && res !== '') {
//                                        var data = {
//                                            type: 'PICK',
//                                            visitid: visitid,
//                                            serviceid: keyid,
//                                            staffid: staff.staffid,
//                                            room: staff.room,
//                                            label: staff.label
//                                        };
//                                        socketHTDMClinic.send(JSON.stringify(data));
                                        var visitDetails = JSON.parse(res);
                                        $.confirm({
                                            title: '',
                                            content: '<h3><strong><font color="#054afc">' + visitDetails.names + '</font></strong></h3><br/>' +
                                                    '<h4><strong><font color="#054afc">' + visitDetails.visitno + '</font></strong></h4>',
                                            boxWidth: '40%',
                                            useBootstrap: false,
                                            type: 'purple',
                                            typeAnimated: true,
                                            theme: 'modern',
                                            icon: 'fa fa-question-circle',
                                            buttons: {
                                                formSubmit: {
                                                    text: 'Receive Patient',
                                                    btnClass: 'btn-purple',
                                                    action: function () {
                                                        $('#savePatientTriage').data('caller', 'triageH');
                                                        pickedPatientInQueue(visitDetails.patientid, visitid, visitDetails.visitno);
                                                        patientVisitationId = visitid;
                                                        patientid33 = visitDetails.patientid;
                                                    }
                                                },
                                                close: {
                                                    text: 'Cancel',
                                                    btnClass: 'btn-red cancel',
                                                    action: function () {
                                                        var data = {
                                                            visitid: visitid,
                                                            serviceid: keyid
                                                        };
                                                        $.ajax({
                                                            type: 'POST',
                                                            data: data,
                                                            data_type: 'JSON',
                                                            url: "queuingSystem/cancelPoppedPatient.htm",
                                                            success: function (canceled) {
                                                                if (canceled === 'refresh') {
                                                                    document.location.reload(true);
                                                                }
                                                                if (canceled !== 'fasle') {
//                                                                    $('#canceled-count').html(canceled);
                                                                    fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triageHTDM', unitserviceid: keyid }, '/app/canceledpatients');
                                                                    stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/' + facilityId + '/' + keyid, {}, JSON.stringify({ unitserviceid: keyid }));
                                                                }
                                                            }
                                                        });
                                                    }
                                                }
                                            }
                                        });
                                    } else {
                                        if (res !== 'refresh') {
                                            document.location.reload(true);
                                        }
                                    }
                                }
                            });
                        } else {
                            element.data('new-click', true);
                            element.find('.icon-content').css('cursor', 'hand');
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR);
                        console.log(textStatus);
                        console.log(errorThrown);
                    }
                });                 
            }
        });

        //Get HTDM Patients
//        $('#pickPatientForTriageH').click(function () {
//            var element = $(this);
//            var isNewClick = element.data('new-click');
//            element.find('.icon-content').css('cursor', 'not-allowed');
//            if(isNewClick === true){
//                element.data('new-click', false);
//                var visitid = parseInt($('#nextPatientH').val());
//                if (visitid > 0) {
//                    $.ajax({
//                        type: 'POST',
//                        data: {visitid: visitid},
//                        url: 'patient/getPatientVisitDetails.htm',
//                        success: function (res) {
//                            element.data('new-click', true);
//                            element.find('.icon-content').css('cursor', 'default');
//                            if (res !== 'refresh' && res !== '') {
//                                var data = {
//                                    type: 'PICK',
//                                    visitid: visitid,
//                                    serviceid: keyid,
//                                    staffid: staff.staffid,
//                                    room: staff.room,
//                                    label: staff.label
//                                };
//                                socketHTDMClinic.send(JSON.stringify(data));
//                                var visitDetails = JSON.parse(res);
//                                $.confirm({
//                                    title: '',
//                                    content: '<h3><strong><font color="#054afc">' + visitDetails.names + '</font></strong></h3><br/>' +
//                                            '<h4><strong><font color="#054afc">' + visitDetails.visitno + '</font></strong></h4>',
//                                    boxWidth: '40%',
//                                    useBootstrap: false,
//                                    type: 'purple',
//                                    typeAnimated: true,
//                                    theme: 'modern',
//                                    icon: 'fa fa-question-circle',
//                                    buttons: {
//                                        formSubmit: {
//                                            text: 'Receive Patient',
//                                            btnClass: 'btn-purple',
//                                            action: function () {
//                                                pickedPatientInQueue(visitDetails.patientid, visitid, visitDetails.visitno);
//                                                patientVisitationId = visitid;
//                                                patientid33 = visitDetails.patientid;
//                                            }
//                                        },
//                                        close: {
//                                            text: 'Cancel',
//                                            btnClass: 'btn-red cancel',
//                                            action: function () {
//                                                var data = {
//                                                    visitid: visitid,
//                                                    serviceid: keyid
//                                                };
//                                                $.ajax({
//                                                    type: 'POST',
//                                                    data: data,
//                                                    data_type: 'JSON',
//                                                    url: "queuingSystem/cancelPoppedPatient.htm",
//                                                    success: function (canceled) {
//                                                        if (canceled === 'refresh') {
//                                                            document.location.reload(true);
//                                                        }
//                                                        if (canceled !== 'fasle') {
//                                                            $('#canceled-count').html(canceled);
//                                                        }
//                                                    }
//                                                });
//                                            }
//                                        }
//                                    }
//                                });
//                            } else {
//                                if (res !== 'refresh') {
//                                    document.location.reload(true);
//                                }
//                            }
//                        }
//                    });
//                } else {
//                    element.data('new-click', true);
//                    element.find('.icon-content').css('cursor', 'default');
//                }
//            }
//        });

        $('#savePatientTriage').click(function () {
//            User must enter triage information to queue a patient.
//            
//            var patientWeight = document.getElementById('patientWeight').value;
//            var patientTemperature = document.getElementById('patientTemperature').value;
//            var patientHeight = document.getElementById('patientHeight').value;
//            var patientPressureSystolic = document.getElementById('patientPressureSystolic').value;
//            var patientPressureDiastolic = document.getElementById('patientPressureDiastolic').value;
//            var patientPulse = document.getElementById('patientPulse').value;
//            var patientHeadCircum = document.getElementById('patientHeadCircum').value;
//            var patientBodySurfaceArea = document.getElementById('patientBodySurfaceArea').value;
//            var patientRespirationRate = document.getElementById('patientRespirationRate').value;
//            var patientTriageNotes = document.getElementById('patientTriageNotes').value;

//            if (patientWeight.toString().length < 1 && patientHeight.toString().length < 1 && patientTemperature.toString().length < 1 && patientPressureSystolic.toString().length < 1 && patientPressureDiastolic.toString().length < 1 && patientPulse.toString().length < 1 && patientHeadCircum.toString().length < 1 && patientBodySurfaceArea.toString().length < 1 && patientRespirationRate.toString().length < 1 && patientTriageNotes.toString().length < 1) {
//                queuePatientToOtherService(patientVisitationId);
//            } else {
//                queuePatientToOtherService2(patientVisitationId);
//            }
            if(validateTriageInfo()){

            if (patientWeight.toString().length < 1 && patientHeight.toString().length < 1 && patientTemperature.toString().length < 1 && patientPressureSystolic.toString().length < 1 && patientPressureDiastolic.toString().length < 1 && patientPulse.toString().length < 1 && patientHeadCircum.toString().length < 1 && patientBodySurfaceArea.toString().length < 1 && patientRespirationRate.toString().length < 1 && patientTriageNotes.toString().length < 1) {
                queuePatientToOtherService(patientVisitationId);
            } else {
                queuePatientToOtherService2(patientVisitationId);
            }
            }else{
                $.toast({
                    heading: 'Error',
                    text: "Please provide all the required fields.",
                    icon: 'error',
                    hideAfter: 2000,
                    position: 'mid-center'
                });                
            }
        });

//        interval = setInterval(function () {
//            //Fetch Cancelled patients.
//            var serviceid = parseInt(staff.serviceid);
//            if (serviceid > 0) {
//                $.ajax({
//                    type: 'GET',
//                    data: {unitserviceid: staff.serviceid},
//                    data_type: 'JSON',
//                    url: "queuingSystem/countCanceledPatients.htm",
//                    success: function (canceled) {
//                        canceledN = parseInt(canceled);
//                        $('#canceled-count').html(canceled);
//                    }
//                });
//                $.ajax({
//                    type: 'GET',
//                    data: {unitserviceid: keyid},
//                    data_type: 'JSON',
//                    url: "queuingSystem/countCanceledPatients.htm",
//                    success: function (canceled) {
//                        canceledH = parseInt(canceled);
//                        $('#canceled-countH').html(canceled);
//                    }
//                });
//
//                $.ajax({
//                    type: 'GET',
//                    data: {unitserviceid: staff.serviceid},
//                    data_type: 'JSON',
//                    url: "queuingSystem/countServicedPatients.htm",
//                    success: function (serviced) {
//                        servicedN = parseInt(serviced);
//                        $('#serviced').html(parseInt(servicedN + servicedH));
//                    }
//                });
//                $.ajax({
//                    type: 'GET',
//                    data: {unitserviceid: keyid},
//                    data_type: 'JSON',
//                    url: "queuingSystem/countServicedPatients.htm",
//                    success: function (serviced) {
//                        servicedH = parseInt(serviced);
//                        $('#serviced').html(parseInt(servicedN + servicedH));
//                    }
//                });
//                $.ajax({
//                    type: 'GET',
//                    data: {unitserviceid: staff.serviceid},
//                    data_type: 'JSON',
//                    url: "queuingSystem/getWaitingTime.htm",
//                    success: function (waiting) {
//                        waitingN = parseInt(waiting);
//                        $.ajax({
//                            type: 'GET',
//                            data: {unitserviceid: keyid},
//                            data_type: 'JSON',
//                            url: "queuingSystem/getWaitingTime.htm",
//                            success: function (waiting) {
//                                waitingH = parseInt(waiting);
//                                $('#waiting').html(parseInt((waitingN + waitingH)) + ' Mins');
//                            }
//                        });
//                    }
//                });
//            }
//        }, 1000 * 30);
    });

    function functioncheckPatientweight() {        
        // 
        if($('#patientWeight').val().toString().length > 0 && $('#patientWeight').val().toString() !== ''){
            $('#patientWeight').css('border-color', '#C0C0C0');
        }else{
            $('#patientWeight').css('border-color', '#ff0000');
        }
        //
        var patientWeight = $('#patientWeight').val();
        var patientHeight2 = $('#patientHeight').val();

        if (patientHeight2 === null || typeof patientHeight2 === 'undefined' || patientHeight2 === '') {
            $('#patientBMInoHeighteerrormsg').show();
            $('#patientBMInoWeighteerrormsg').hide();
        } else {
            if (patientWeight !== null || typeof patientWeight !== 'undefined' || patientWeight !== '') {
                $('#patientBMInoHeighteerrormsg').hide();
                $('#patientBMInoWeighteerrormsg').hide();
                patientWeight = parseFloat(patientWeight);
                patientHeight2cm = parseFloat(patientHeight2);


                $('#patientBMInoHeighteerrormsg').hide();
                $('#patientBMInoWeighteerrormsg').hide();
                patientHeight2cm = parseFloat(patientHeight2cm);
                patientWeight = parseFloat(patientWeight);
                var patientHeightinMetres = patientHeight2cm / 100;
                var patientHeightinMetressquared = patientHeightinMetres * patientHeightinMetres;

                var patientBIM = patientWeight / patientHeightinMetressquared;
                $('#patientBMIReport').val(Math.round(patientBIM));
            }
        }
    }

    function functioncheckPatientTemperature() {
        // 
            if($('#patientTemperature').val().toString().length > 0 && $('#patientTemperature').val().toString() !== ""){
                $('#patientTemperature').css('border-color', '#C0C0C0');
            }else{
                $('#patientTemperature').css('border-color', '#ff0000');
            }
        //
        var patientTemperature = $('#patientTemperature').val();
        patientTemperature = parseInt(patientTemperature);
        if (patientTemperature < 30 || patientTemperature > 45) {
            $('#patientTemperatureerrormsg').show();
        } else {
            $('#patientTemperatureerrormsg').hide();
        }
    }

    function functioncheckpatientHeight() {
        // 
            if($('#patientHeight').val().toString().length > 0 && $('#patientHeight').val().toString() !== ''){
                $('#patientHeight').css('border-color', '#C0C0C0');
            }else{
                $('#patientHeight').css('border-color', '#ff0000');
            }
        //
        var patientHeightcm = $('#patientHeight').val();
        var patientWeight = $('#patientWeight').val();

        if (parseInt(patientHeightcm) < 20 || parseInt(patientHeightcm) > 300) {
            $('#patientpatientHeighterrormsg').show();
        } else {
            $('#patientpatientHeighterrormsg').hide();
        }

        if (patientWeight === null || typeof patientWeight === 'undefined' || patientWeight === '') {
            $('#patientBMInoHeighteerrormsg').hide();
            $('#patientBMInoWeighteerrormsg').show();
        } else {
            if (patientHeightcm !== null || typeof patientHeightcm !== 'undefined' || patientHeightcm !== '') {
                $('#patientBMInoHeighteerrormsg').hide();
                $('#patientBMInoWeighteerrormsg').hide();
                patientHeightcm = parseFloat(patientHeightcm);
                patientWeight = parseFloat(patientWeight);
                var patientHeightinMetres = patientHeightcm / 100;
                var patientHeightinMetressquared = patientHeightinMetres * patientHeightinMetres;

                var patientBIM2 = patientWeight / patientHeightinMetressquared;
                $('#patientBMIReport').val(Math.round(patientBIM2));
            }
        }
    }

    function functioncheckpatientPulse() {
        var patientPulse = $('#patientPulse').val();
        patientPulse = parseInt(patientPulse);

        if (patientPulse < 20 || patientPulse > 250) {
            $('#patientPulseerrormsg').show();
        } else {
            $('#patientPulseerrormsg').hide();
        }
    }

    function functioncheckpatientHeadCircum() {
        var patientHeadCircum = $('#patientHeadCircum').val();
        patientHeadCircum = parseInt(patientHeadCircum);

        if (patientHeadCircum < 30 || patientHeadCircum > 100) {
            $('#patientHeadCircumerrormsg').show();
        } else {
            $('#patientHeadCircumerrormsg').hide();
        }
    }

    function pickedPatientInQueue(patientid, patientvisitid, visitnumber) {
        $.ajax({
            type: 'GET',
            data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
            url: "triage/triagepatientinqueuedetails.htm",
            success: function (data) {
                $.ajax({
                    type: 'GET',
                    data: {patientid: patientid.toString()},
                    url: "triage/getPatientMedicalIssues.htm",
                    success: function (res) {
                        $('#issuesAndAllergies').html(res);
                    }
                });
                resetControls();
                window.location = '#modalOrderitems';
                $('#patientBasicInfoTriage').html(data);
                initDialog('stockDetailsModal');
            }
        });
    }

    function queuePatientToOtherService(patientVisitationId) {
        $.ajax({
            type: 'GET',
            data: {patientVisitationId: patientVisitationId},
            url: "doctorconsultation/queuepatienttootherservice.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'SELECT SERVICE TO QUEUE PATIENT NEXT',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '50%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Queue',
                            btnClass: 'btn-purple',
                            action: function () {
                                var queueStaffid = $('#QueuingUnitServiceStaffid').val();
                                var serviceid = $('#queuingFacilityUnitServices').val();
                                var facilityUnitId = $('#queuingFacilityUnits').val(); 
//                                var queueData = {
//                                    type: 'ADD',
//                                    visitid: parseInt(patientVisitationId),
//                                    serviceid: serviceid,
//                                    staffid: queueStaffid
//                                };
//                                var host = location.host;
//                                var url = 'ws://' + host + '/IICS/queuingServer';
//                                var ws = new WebSocket(url);
//                                //
//                                queueData.host = host;
//                                //
//                                ws.onopen = function (ev) {
//                                    ws.send(JSON.stringify(queueData));
//                                };
//                                ws.onmessage = function (ev) {
//                                    if (ev.data === 'ADDED') {
//                                        window.location = '#close';
//                                    }
//                                };
                                //
                                var triageCaller = $('#savePatientTriage').data('caller');
                                if(triageCaller.toString().toLowerCase() === 'triage'.toLowerCase()){
                                    $.ajax({
                                        type: 'GET',
                                        url: 'queuingSystem/servicePoppedPatient',
                                        data: { visitid: patientVisitationId, serviceid: staff.serviceid, staffid: staff.staffid  },
                                        success: function (data, textStatus, jqXHR) {
                                            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triage', unitserviceid: staff.serviceid, keyid:keyid }, '/app/servicedpatientscount');
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            console.log(jqXHR);
                                            console.log(textStatus);
                                            console.log(errorThrown);
                                        }
                                    });
                                } else if(triageCaller.toString().toLowerCase() === 'triageH'.toLowerCase()) {
                                    $.ajax({
                                        type: 'GET',
                                        url: 'queuingSystem/servicePoppedPatient',
                                        data: { visitid: patientVisitationId, serviceid: keyid, staffid: staff.staffid  },
                                        success: function (data, textStatus, jqXHR) {                                            
                                            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triage', unitserviceid: staff.serviceid, keyid:keyid }, '/app/servicedpatientscount');
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            console.log(jqXHR);
                                            console.log(textStatus);
                                            console.log(errorThrown);
                                        }
                                    });
                                }                                
                                //
                                $.ajax({
                                    type: 'GET',
                                    url: 'queuingSystem/pushPatient',
                                    data: { visitid: parseInt(patientVisitationId), serviceid: serviceid, staffid: queueStaffid },
                                    success: function (data, textStatus, jqXHR) {
                                        stompClient.send('/app/patientqueuesize/' + facilityUnitId + '/' + facilityId + '/' + serviceid, {}, JSON.stringify({ unitserviceid: serviceid }));
                                        window.location = '#close';
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {                                
                                        console.log(jqXHR);
                                        console.log(textStatus);
                                        console.log(errorThrown);
                                    }
                                });
                            }
                        },
                        close: {
                            text: 'Close',
                            btnClass: 'btn-red',
                            action: function () {

                            }
                        }
                    }
                });
            }
        });
    }

    function queuePatientToOtherService2(patientVisitationId) {
        $.ajax({
            type: 'GET',
            data: {patientVisitationId: patientVisitationId},
            url: "doctorconsultation/queuepatienttootherservice.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'SELECT SERVICE TO QUEUE PATIENT NEXT',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '50%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Queue',
                            btnClass: 'btn-purple',
                            action: function () {
                                var queueStaffid = $('#QueuingUnitServiceStaffid').val();
                                var serviceid = $('#queuingFacilityUnitServices').val();
                                var facilityUnitId = $('#queuingFacilityUnits').val();
//                                var queueData = {
//                                    type: 'ADD',
//                                    visitid: parseInt(patientVisitationId),
//                                    serviceid: serviceid,
//                                    staffid: queueStaffid
//                                };
//                                var host = location.host;
//                                var url = 'ws://' + host + '/IICS/queuingServer';
//                                var ws = new WebSocket(url);
//                                //
//                                queueData.host = host;
//                                //
//                                ws.onopen = function (ev) {
//                                    ws.send(JSON.stringify(queueData));
//                                };
//                                ws.onmessage = function (ev) {
//                                    if (ev.data === 'ADDED') {
//                                        window.location = '#close';
//                                    }
//                                };  
                                //
                                var triageCaller = $('#savePatientTriage').data('caller');
                                if(triageCaller.toString().toLowerCase() === 'triage'.toLowerCase()){
                                    $.ajax({
                                        type: 'GET',
                                        url: 'queuingSystem/servicePoppedPatient',
                                        data: { visitid: patientVisitationId, serviceid: staff.serviceid, staffid: staff.staffid  },
                                        success: function (data, textStatus, jqXHR) {
                                            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triage', unitserviceid: staff.serviceid, keyid:keyid }, '/app/servicedpatientscount');
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            console.log(jqXHR);
                                            console.log(textStatus);
                                            console.log(errorThrown);
                                        }
                                    });
                                } else if(triageCaller.toString().toLowerCase() === 'triageH'.toLowerCase()) {
                                    $.ajax({
                                        type: 'GET',
                                        url: 'queuingSystem/servicePoppedPatient',
                                        data: { visitid: patientVisitationId, serviceid: keyid, staffid: staff.staffid  },
                                        success: function (data, textStatus, jqXHR) {
                                            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triage', unitserviceid: staff.serviceid, keyid:keyid }, '/app/servicedpatientscount');
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            console.log(jqXHR);
                                            console.log(textStatus);
                                            console.log(errorThrown);
                                        }
                                    });
                                }
                                //
                                $.ajax({
                                    type: 'GET',
                                    url: 'queuingSystem/pushPatient',
                                    data: { visitid: parseInt(patientVisitationId), serviceid: serviceid, staffid: queueStaffid },
                                    success: function (data, textStatus, jqXHR) {
                                        stompClient.send('/app/patientqueuesize/' + facilityUnitId + '/' + facilityId + '/' + serviceid, {}, JSON.stringify({ unitserviceid: serviceid }));
                                        window.location = '#close';
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {                                
                                        console.log(jqXHR);
                                        console.log(textStatus);
                                        console.log(errorThrown);
                                    }
                                });

                                //saveTriageDetails
                                var patientWeight2 = document.getElementById('patientWeight').value;
                                var patientTemperature2 = document.getElementById('patientTemperature').value;
                                var patientHeight2 = document.getElementById('patientHeight').value;
                                var patientPressureSystolic2 = document.getElementById('patientPressureSystolic').value;
                                var patientPressureDiastolic2 = document.getElementById('patientPressureDiastolic').value;
                                var patientPulse2 = document.getElementById('patientPulse').value;
                                var patientHeadCircum2 = document.getElementById('patientHeadCircum').value;
                                var patientBodySurfaceArea2 = document.getElementById('patientBodySurfaceArea').value;
                                var patientRespirationRate2 = document.getElementById('patientRespirationRate').value;
                                var patientTriageNotes2 = document.getElementById('patientTriageNotes').value;


                                var data = {
                                    patientWeight: patientWeight2,
                                    patientTemperature: patientTemperature2,
                                    patientHeight: patientHeight2,
                                    patientPressureSystolic: patientPressureSystolic2,
                                    patientPressureDiastolic: patientPressureDiastolic2,
                                    patientPulse: patientPulse2,
                                    patientHeadCircum: patientHeadCircum2,
                                    patientBodySurfaceArea: patientBodySurfaceArea2,
                                    patientRespirationRate: patientRespirationRate2,
                                    patientTriageNotes: patientTriageNotes2,
                                    patientVisitationId: patientVisitationId
                                };
                                $.ajax({
                                    type: "POST",
                                    cache: false,
                                    url: "triage/savePatientTriage.htm",
                                    data: data,
                                    success: function (rep) {
                                        $('#patientWeight').val("");
                                        $('#patientTemperature').val("");
                                        $('#patientHeight').val("");
                                        $('#patientPressureSystolic').val("");
                                        $('#patientPressureDiastolic').val("");
                                        $('#patientPulse').val("");
                                        $('#patientHeadCircum').val("");
                                        $('#patientBodySurfaceArea').val("");
                                        $('#patientRespirationRate').val("");
                                        $('#patientTriageNotes').val("");
                                        $('#patientBMIReport').val("");
                                    }
                                });
                            }
                        },
                        close: {
                            text: 'Close',
                            btnClass: 'btn-red',
                            action: function () {

                            }
                        }
                    }
                });
            }
        });
    }

    function fetchCanceledPatients() {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Canceled Patients',
            content: '<div id="cancel-list" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
            type: 'purple',
            typeAnimated: true,
            boxWidth: '70%',
            useBootstrap: false,
            buttons: {
                close: {
                    text: 'Close',
                    action: function () {

                    }
                }
            },
            onContentReady: function () {
                var canceledList = this.$content.find('#cancel-list');
                $.ajax({
                    type: 'POST',
                    data: {serviceid: staff.serviceid},
                    url: 'queuingSystem/fetchCanceledPatients.htm',
                    success: function (res) {
                        canceledList.html(res);
                    }
                });
            }
        });
    }

    function fetchCanceledPatientsH() {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Canceled Patients',
            content: '<div id="cancel-list" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
            type: 'purple',
            typeAnimated: true,
            boxWidth: '70%',
            useBootstrap: false,
            buttons: {
                close: {
                    text: 'Close',
                    action: function () {

                    }
                }
            },
            onContentReady: function () {
                var canceledList = this.$content.find('#cancel-list');
                $.ajax({
                    type: 'POST',
                    data: {serviceid: keyid},
                    url: 'queuingSystem/fetchCanceledPatients.htm',
                    success: function (res) {
                        canceledList.html(res);
                    }
                });
            }
        });
    }

    function restoreCanceledPatient(visitid, serviceid, names, visitNo) {
        $.confirm({
            title: '',
            content: '<h3><strong><font color="#054afc">' + names + '</font></strong></h3><br/>' +
                    '<h4><strong><font color="#054afc">' + visitNo + '</font></strong></h4>',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            theme: 'modern',
            icon: 'fa fa-question-circle',
            buttons: {
                formSubmit: {
                    text: 'Restore',
                    btnClass: 'btn-purple',
                    action: function () {
//                        var data = {
//                            type: 'REVERT',
//                            visitid: visitid,
//                            serviceid: serviceid
//                        };
                        if (parseInt(keyid) === parseInt(serviceid)) {
//                            socketHTDMClinic.send(JSON.stringify(data));
                            $('#restore' + visitid).prop('disabled', true);
//                            var nextVisit = parseInt($('#nextPatientH').val());
//                            if (nextVisit < 1) {
//                                var reset = {
//                                    type: 'RESET',
//                                    serviceid: serviceid
//                                };
//                                socketHTDMClinic.send(JSON.stringify(reset));
//                            }
                            $.ajax({
                                type: 'GET',
                                url: 'queuingSystem/revertPoppedPatient.htm',
                                data: { visitid: visitid, serviceid: serviceid },
                                success: function (data, textStatus, jqXHR) {
                                    //
                                    fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triageHTDM', unitserviceid: keyid }, '/app/canceledpatients');                                    
                                    stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/' + facilityId + '/' + keyid, {}, JSON.stringify({ unitserviceid: keyid }));
                                    //
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    console.log(jqXHR);
                                    console.log(textStatus);
                                    console.log(errorThrown);
                                }
                            }); 
                        } else {
                            $('#restore' + visitid).prop('disabled', true);
                            $.ajax({
                                type: 'GET',
                                url: 'queuingSystem/revertPoppedPatient.htm',
                                data: { visitid: visitid, serviceid: serviceid },
                                success: function (data, textStatus, jqXHR) {
                                    //
                                    fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triage', unitserviceid: staff.serviceid }, '/app/canceledpatients');
                                    stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/' + facilityId + '/' + staff.serviceid, {}, JSON.stringify({ unitserviceid: staff.serviceid }));
                                    //
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    console.log(jqXHR);
                                    console.log(textStatus);
                                    console.log(errorThrown);
                                }
                            }); 
//                            socketNormalClinic.send(JSON.stringify(data));
//                            $('#restore' + visitid).prop('disabled', true);
//                            var nextVisit = parseInt($('#nextPatient').val());
//                            if (nextVisit < 1) {
//                                var reset = {
//                                    type: 'RESET',
//                                    serviceid: serviceid
//                                };
//                                socketNormalClinic.send(JSON.stringify(reset));
//                            }
                        }
                    }
                },
                close: {
                    text: 'Cancel',
                    btnClass: 'btn-red cancel',
                    action: function () {

                    }
                }
            }
        });
    }
    function validateTriageInfo(){
        var result = false;
        var estimatedAge = document.getElementById('estimated-age'); 
        var patientWeight = document.getElementById('patientWeight');
        var patientTemperature = document.getElementById('patientTemperature');
        var patientHeight = document.getElementById('patientHeight');
        var patientPressureSystolic = document.getElementById('patientPressureSystolic');
        var patientPressureDiastolic = document.getElementById('patientPressureDiastolic');
        var patientRespirationRate = document.getElementById('patientRespirationRate');
        if(skipWeight){
            result = true;
            patientWeight.style.borderColor = "#C0C0C0";
        } else {
            if(patientWeight.value.toString().length > 0 && patientWeight.value.toString() !== ''){
                result = true;
            }else{
                result = false;
                patientWeight.style.borderColor = "#ff0000";
            }
        }
        if(skipHeight){
            result = (result === true);
            patientHeight.style.borderColor = "#C0C0C0";
        } else {
            if(patientHeight.value.toString().length > 0 && patientHeight.value.toString() !== ''){
                result = (result === true);
            }else{
                result = false;
                patientHeight.style.borderColor = "#ff0000";
            }
        }
        if(skipTemp){
            result = (result === true);
            patientTemperature.style.borderColor = "#C0C0C0";
        } else {
            if(patientTemperature.value.toString().length > 0 && patientTemperature.value.toString() !== ""){
                result = (result === true);
            }else{
                result = false;
                patientTemperature.style.borderColor = "#ff0000";
            }
        }
        if(skipRespirationRate){
            result = (result === true);
            patientRespirationRate.style.borderColor = "#C0C0C0";
        } else {
            if(patientRespirationRate.value.toString().length > 0 && patientRespirationRate.value.toString() !== ""){
                result = (result === true);
            }else{
                result = false;
                patientRespirationRate.style.borderColor = "#ff0000";
            }
        }
        if(skipPressure){
            result = (result === true);
            patientPressureSystolic.style.borderColor = "#C0C0C0";
            patientPressureDiastolic.style.borderColor = "#C0C0C0";
        } else {
            if((!isNaN(estimatedAge.value.replace(/\D/g, ""))) && Number(estimatedAge.value.replace(/\D/g, '')) >= 16 && 
                    estimatedAge.value.includes("Years")){
                if(patientPressureSystolic.value.toString().length > 0 && patientPressureDiastolic.value.toString().length > 0 &&
                        patientPressureSystolic.value.toString() !== '' && patientPressureDiastolic.value.toString() !== ""){
                    result = (result === true);
                }else{
                    result = false;
                    patientPressureSystolic.style.borderColor = "#ff0000";
                    patientPressureDiastolic.style.borderColor = "#ff0000";
                }
            }
        }
        return result;
    }
    function connect(){
        var socket = new SockJS('iics-queue');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function(frame){
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/canceledpatientstriage/' +  staff.facilityunitid + '/'  + facilityId, function(data){
                handleCount(data.body, '#canceled-count');
            });
            stompClient.subscribe('/topic/canceledpatientstriageHTDM/' +  staff.facilityunitid + '/'  + facilityId, function(data){
                handleCount(data.body, '#canceled-countH');
            });
            stompClient.subscribe('/topic/servicedpatientscounttriage/' +  staff.facilityunitid + '/'  + facilityId, function(data){
                handleCount(data.body, '#serviced');
            });
            stompClient.subscribe('/topic/patientqueuesize/' + staff.facilityunitid + '/'  + facilityId + '/' + staff.serviceid, function(data){
                handleCount(data.body, '#queuedPatients');
            });
            stompClient.subscribe('/topic/patientqueuesize/' + staff.facilityunitid + '/'  + facilityId + '/' + keyid, function(data){
                handleCount(data.body, '#queuedPatientsH');
            });
            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triage', unitserviceid: staff.serviceid, keyid: keyid }, '/app/servicedpatientscount');
            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triage', unitserviceid: staff.serviceid }, '/app/canceledpatients');
            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triageHTDM', unitserviceid: keyid }, '/app/canceledpatients');
            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triage', unitserviceid: staff.serviceid, staffid: staff.staffid, type: 'requests' }, '/app/patientlabs');
            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'triage', unitserviceid: staff.serviceid, staffid: staff.staffid, type: 'results' }, '/app/patientlabs');
            stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/' + facilityId + '/' + staff.serviceid, {}, JSON.stringify({ unitserviceid: staff.serviceid }));
            stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/' + facilityId + '/' + keyid, {}, JSON.stringify({ unitserviceid: keyid }));
        });
    }
    function fetchCount(data, destination){
        stompClient.send(destination  + '/'  +  staff.facilityunitid + '/'  + facilityId, {}, JSON.stringify(data));
    }
    function handleCount(message, targetControl){
        $(targetControl).html(message).trigger('create');
    }  
    function initNotification(){
        eventSource = new EventSource('notifications/averagewaitingtime');
        eventSource.onmessage = function(event) {
            var data = JSON.parse(event.data);
            console.log(data);
        };
        eventSource.onopen = function(e) {
            console.log('open');
        };
	eventSource.onerror = function(e) {
            if (e.readyState === EventSource.CLOSED) {
                console.log('close');
            }
            else {
                console.log(e);
            }
        };
        eventSource.addEventListener("averageWaitingTime", function(e) {            
            var data = JSON.parse(e.data);
            $("#waiting").text(data.triage  + ' Mins');
            console.log(e.data);
        }, false); 
    }
    function cleanUp() {
       if(eventSource !== null){
            eventSource.close();
       }
    }
    function resetControls() {
        skipWeight = false;
        $('span#weight-skip-reason').html('');
        $('#patientWeight').attr('readonly', false);

        skipHeight = false;
        $('#heigth-skip-reason').html('');
        $('#patientHeight').attr('readonly', false);

        skipTemp = false;
        $('#temp-skip-reason').html('');
        $('#patientTemperature').attr('readonly', false);

        skipRespirationRate = false;
        $('#respiration-skip-reason').html('');
        $('#patientRespirationRate').attr('readonly', false);

        skipPressure = false;
        $('#pressure-skip-reason').html('');
        $('#patientPressureDiastolic').attr('readonly', false);
        $('#patientPressureSystolic').attr('readonly', false);
    }
</script>
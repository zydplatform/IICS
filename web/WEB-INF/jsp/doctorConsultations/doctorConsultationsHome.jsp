<%-- 
    Document   : doctorConsultationsHome
    Created on : Aug 16, 2018, 8:14:38 AM
    Author     : HP
--%>
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
    .patientsQueues {
        -webkit-animation: blink 2s;
        -webkit-animation-iteration-count: infinite;
        -moz-animation: blink 2s;
        -moz-animation-iteration-count: infinite;
        -o-animation: blink 1s;
        -o-animation-iteration-count: infinite;
    }
    .workedon-components-cards{
        width: 100%;
        border-left: 12px solid gray;
        box-shadow: 1px 1px 3px #888;
        border-left-color: #af16af;
        height: 67px;
        padding-left: 3%;
        padding-top: 6%;
        font-size: 18px;
        margin-bottom: 11px;
    }
    .prescribed-components-cards{
        width: 100%;
        border-left: 12px solid gray;
        box-shadow: 1px 1px 3px #888;
        border-left-color: #006600;
        height: 67px;
        padding-left: 3%;
        padding-top: 6%;
        font-size: 18px;
        margin-bottom: 11px;
    }
</style>
<%@include file="../include.jsp" %>
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
                        <li class="last active"><a href="#">Doctor Consultation</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div>
        <div class="row">
            <div class="col-md-12">
                <main id="main">
                    <input id="tab1" class="tabCheck todayspatients" type="radio" name="tabs" checked>
                    <label class="tabLabels" for="tab1">Patients</label>
                    <input id="tab2" class="tabCheck" type="radio" name="tabs">
                    <label class="tabLabels" for="tab2">Patient Register</label>
                    <input id="tab3" class="tabCheck" type="radio" name="tabs">
                    <label class="tabLabels" for="tab3">Performance</label>
                    <section class="tabContent" id="content1">
                        <div >
                            <div style="margin: 10px;">
                                <fieldset style="min-height:100px;">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="tile">
                                                <div class="tile-body">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div id="pausedPatientQueueQ">
                                                                <div class="pull-left menu-icon" id="pickpausedPatient" style="margin-left: 201px;">
                                                                    <div class="card-footer text-center">
                                                                        <h5>Paused Patient</h5>
                                                                    </div><hr/>
                                                                    <div class="icon-content">
                                                                        <button type="button"   onclick="pickPausedPatientQueues();" class="btn btn-danger" id="patientdetailsbtn">${patientdetails}</button>
                                                                    </div><br>
                                                                    <div class="icon-content center">
                                                                        <h6>
                                                                            <input id="hiddenpausedPatients" type="hidden" value="${patientvisitid}">
                                                                            <input id="hiddenpausedPatientpauseid" type="hidden" value="${patientpauseid}">
                                                                        </h6>
                                                                    </div>
                                                                </div>  
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div id="normapPatientQueues">
                                                                <div class="pull-right menu-icon" style="margin-right: 201px;" id="pickPatient" data-new-click="true">
                                                                    <div class="icon-content">
                                                                        <img src="static/img/queue-hover.png" class="patientsQueues pull-right" border="1" width="90" height="70">
                                                                    </div><br>
                                                                    <div class="icon-content center">
                                                                        <h6>
                                                                            <span class="badge badge-info" id="queuedPatients"></span>
                                                                            <input id="nextPatient" type="hidden" value="0"/>
                                                                        </h6>
                                                                    </div>
                                                                </div>  
                                                            </div>

                                                        </div>
                                                    </div><br>
                                                    <div class="row" id="getStatisticsofpatientsdiv">
                                                        <%@include file="views/statistics.jsp" %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </div> 
                        </div>
                    </section>
                    <section class="tabContent" id="content2">
                        <div id="todaysreceivedcliniciansdiv"></div>
                    </section>
                    <section class="tabContent" id="content3">
                        <%@include file="performance/performancePane.jsp" %>
                    </section>
                </main>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div id="prescribeunprescribedpatients" class="prescriptionDiaolog prescribeunprescribedpatient">
                        <div>
                            <div id="head">
                                <a href="#close" title="Close Patient" class="close3" id="closeOrUnPauseApatientid" style="display: block; width: 93px; margin-right: 100px;" onclick="closeactivatepatienttab2();" >Close</a>
                                <a href="#close" title="Pause Patient" class="close2" id="pauseOrUnPauseApatientid" style="display: block; width: 93px;" onclick="pausedPickedPatientsTab();">Pause</a>
                                <h2 class="modalDialog-title" id="titleoralprescribeheading">Patient Details</h2>
                                <hr>
                            </div>
                            <div class="row scrollbar" id="content">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div>
                                                <div id="addprescribediv">

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div id="patientsfromlaboratoryfortesting" class="prescriptionDiaolog Patientsfromlaboratoryfortests">
                        <div>
                            <div id="head">
                                <a href="#close" id="lab-request-btn2" title="Close" class="close2" style="display: block;" onclick="activatepatientstab();">X</a>
                                <h2 class="modalDialog-title" id="titleoralprescribeheading">LABORATORY REQUEST(S).</h2>
                                <hr>
                            </div>
                            <div class="row scrollbar" id="content">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div>
                                                <div id="laboratorylabpatientsdiv">

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div id="patientstolaboratorytesting" class="prescriptionDiaolog patientstolaboratorytests">
                        <div>
                            <div id="head">
                                <a href="#close" title="Close" id="lab-request-btn" class="close2" style="display: block;" onclick="activatepatientstab();">X</a>
                                <h2 class="modalDialog-title" id="titleoralprescribeheading">LABORATORY REQUEST(S).</h2>
                                <hr>
                            </div>
                            <div class="row scrollbar" id="content">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div>
                                                <div id="patientstolaboratorysdiv">

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var stompClient = null;
    var staff;
    var facilityId = ${facilityid};
    var eventSource = null;
    var serverDate = '${serverdate}';
    $(function(){
        toggleTabs(true);
    });
    function activatepatientstab() {  
        debugger
        fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid, staffid: staff.staffid, type: 'requests' }, '/app/patientlabs');
        fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid, staffid: staff.staffid, type: 'results' }, '/app/patientlabs');
        $('.todayspatients').prop('checked', true);
    }
    function pausedPickedPatientsTab() {
        var visitid = $('#facilityvisitPatientvisitid').val();
        var name = $('#facilityvisitedPatientname').val();
        $('.todayspatients').prop('checked', true);
        $('#hiddenpausedPatients').val(visitid);
        $('#patientdetailsbtn').html(name);

        document.getElementById('normapPatientQueues').style.display = 'none';
        document.getElementById('pausedPatientQueueQ').style.display = 'block';
    }
//    var staff;
    var socket;
    var interval;
    var queueCanceled = 0;
    $(document).ready(function () {
        if (${size} > 0) {
            document.getElementById('normapPatientQueues').style.display = 'none';
            document.getElementById('pausedPatientQueueQ').style.display = 'block';
        } else {
            document.getElementById('normapPatientQueues').style.display = 'block';
            document.getElementById('pausedPatientQueueQ').style.display = 'none';
        }

        $.ajax({
            type: 'GET',
            data_type: 'JSON',
            url: "queuingSystem/fetchStaffDetails.htm",
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
//                        + '&label=' + staff.label;
//                socket = new WebSocket(url);
//                socket.onmessage = function (ev) {
//                    var response = JSON.parse(ev.data);
//                    if (response.type === 'update') {
//                        $('#queuedPatients').html(response.size);
//                    } else if (response.type === 'next') {
//                        $('#nextPatient').val(response.visit);
//                    }
//                };
            }
        });

        //Gep next patient.
//        $('#pickPatient').click(function () {
//            var visitid = parseInt($('#nextPatient').val());
//            if (visitid > 0) {
//                toggleCloseButton(visitid);
//                $.ajax({
//                    type: 'POST',
//                    data: {visitid: visitid},
//                    url: 'patient/getPatientVisitDetails.htm',
//                    success: function (res) {
//                        if (res !== 'refresh' && res !== '') {
//                            var data = {
//                                type: 'PICK',
//                                visitid: visitid,
//                                serviceid: staff.serviceid,
//                                staffid: staff.staffid,
//                                room: staff.room,
//                                label: staff.label
//                            };
//                            socket.send(JSON.stringify(data));
//                            var visitDetails = JSON.parse(res);
//                            $.confirm({
//                                title: '',
//                                content: '<h3><strong><font color="#054afc">' + visitDetails.names + '</font></strong></h3><br/>' +
//                                        '<h4><strong><font color="#054afc">' + visitDetails.visitno + '</font></strong></h4>',
//                                boxWidth: '40%',
//                                useBootstrap: false,
//                                type: 'purple',
//                                typeAnimated: true,
//                                theme: 'modern',
//                                icon: 'fa fa-question-circle',
//                                buttons: {
//                                    formSubmit: {
//                                        text: 'Receive Patient',
//                                        btnClass: 'btn-purple',
//                                        action: function () {
//                                            pickedPatientInQueue(visitDetails.patientid, visitid, visitDetails.visitno);
//                                        }
//                                    },
//                                    close: {
//                                        text: 'Cancel',
//                                        btnClass: 'btn-red cancel',
//                                        action: function () {
//                                            var data = {
//                                                visitid: visitid,
//                                                serviceid: staff.serviceid
//                                            };
//                                            $.ajax({
//                                                type: 'POST',
//                                                data: data,
//                                                data_type: 'JSON',
//                                                url: "queuingSystem/cancelPoppedPatient.htm",
//                                                success: function (canceled) {
//                                                    if (canceled === 'refresh') {
//                                                        document.location.reload(true);
//                                                    }
//                                                    if (canceled !== 'fasle') {
//                                                        $('#canceled-count').html(canceled);
//                                                    }
//                                                }
//                                            });
//                                        }
//                                    }
//                                }
//                            });
//                        } else {
//                            if (res !== 'refresh') {
//                                document.location.reload(true);
//                            }
//                        }
//                    }
//                });
//            }
//        });
        
        $('#pickPatient').on('click', function () {
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
                    toggleCloseButton(visitid);
                    $.ajax({
                        type: 'POST',
                        url: 'doctorconsultation/pausepickedpatient.htm',
                        data: { patientvisitid: visitid },
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR);
                        }
                    });
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
//                                        socket.send(JSON.stringify(data));
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
                                                pickedPatientInQueue(visitDetails.patientid, visitid, visitDetails.visitno);
                                                        fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid }, '/app/servicedpatientscount');
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
        //                                                            $('#canceled-count').html(canceled);
                                                                    fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid }, '/app/canceledpatients');
															$.ajax({
                                                                type: 'POST',
                                                                data: {patientvisitid: visitid},
                                                                url: "doctorconsultation/closepausedpatient.htm",
                                                                success: function (data) {                                                                    
                                                                    ajaxSubmitData('doctorconsultation/doctorconsultationhome.htm', '', 'act=a&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                }
                                                            });
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
        
//        $('#pickPatient').on('click', function () {
//            var element = $(this);
//            var isNewClick = element.data('new-click');
//            element.find('.icon-content').css('cursor', 'not-allowed');
//            if(isNewClick === true){
//                element.data('new-click', false);                
//                var visitid = parseInt($('#nextPatient').val());
//                if (visitid > 0) {
//                    toggleCloseButton(visitid);
//                    $.ajax({
//                        type: 'POST',
//                        url: 'doctorconsultation/pausepickedpatient.htm',
//                        data: { patientvisitid: visitid },
//                        success: function (data, textStatus, jqXHR) {
//                            console.log(data);
//                        },
//                        error: function (jqXHR, textStatus, errorThrown) {
//                            console.log(jqXHR);
//                        }
//                    });
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
//                                socket.send(JSON.stringify(data));
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
//                                                fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid }, '/app/servicedpatientscount');
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
////                                                            $('#canceled-count').html(canceled);
//                                                            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid }, '/app/canceledpatients');
//                                                            $.ajax({
//                                                                type: 'POST',
//                                                                data: {patientvisitid: visitid},
//                                                                url: "doctorconsultation/closepausedpatient.htm",
//                                                                success: function (data) {
//                                                                    ajaxSubmitData('doctorconsultation/doctorconsultationhome.htm', '', 'act=a&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                                                                }
//                                                            });
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
//                        $('#canceled-count').html(canceled);
//                    }
//                });
//                $.ajax({
//                    type: 'GET',
//                    data: {unitserviceid: staff.serviceid},
//                    data_type: 'JSON',
//                    url: "queuingSystem/countServicedPatients.htm",
//                    success: function (canceled) {
//                        $('#serviced').html(canceled);
//                    }
//                });
//
//                $.ajax({
//                    type: 'GET',
//                    data: {unitserviceid: staff.serviceid},
//                    data_type: 'JSON',
//                    url: "queuingSystem/getWaitingTime.htm",
//                    success: function (waiting) {
//                        var waitingN = parseInt(waiting);
//                        $('#waitingTime').html(parseInt((waitingN)) + ' Mins');
//                        // $.ajax({
//                           // type: 'GET',
//                           // data: {unitserviceid: staff.serviceid},
//                           // data_type: 'JSON',
//                           // url: "queuingSystem/getWaitingTime.htm",
//                           // success: function (waiting) {
//                               // var waitingH = parseInt(waiting);
//                               // $('#waitingTime').html(parseInt((waitingN + waitingH)) + ' Mins');
//                           // }
//                        // });
//                    }
//                });
//                $.ajax({
//                    type: 'POST',
//                    data: {type: 'requests'},
//                    url: "doctorconsultation/countRequestsPatients.htm",
//                    success: function (requests) {
//                        $('#labrequests').html(requests);
//                    }
//                });
//
//                $.ajax({
//                    type: 'POST',
//                    data: {type: 'results'},
//                    url: "doctorconsultation/countRequestsPatients.htm",
//                    success: function (requests) {
//                        $('#labresults').html(requests);
//                    }
//                });
//            }
//        }, 1000 * 30);
        $('#tab3').click(function () {
            fetchDailyStaffPerformance();
        });
        $('#tab2').click(function () {
            ajaxSubmitData('doctorconsultation/gettodaysreceivedpatients.htm', 'todaysreceivedcliniciansdiv', 'act=a&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });
    });

    function pickedPatientInQueue(patientid, patientvisitid, visitnumber) {
        $.ajax({
            type: 'GET',
            data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber, act: 'a'},
            url: "doctorconsultation/patientinqueuedetails.htm",
            success: function (repos) {
                ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                window.location = "#prescribeunprescribedpatients";
                $('#addprescribediv').html(repos);
                initDialog('prescribeunprescribedpatient');
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
                        $('#restore' + visitid).prop('disabled', true);
//                        var data = {
//                            type: 'REVERT',
//                            visitid: visitid,
//                            serviceid: serviceid
//                        };
//                        socket.send(JSON.stringify(data));
//                        $('#restore' + visitid).prop('disabled', true);
//                        var nextVisit = parseInt($('#nextPatient').val());
                        $.ajax({
                            type: 'GET',
                            url: 'queuingSystem/revertPoppedPatient.htm',
                            data: { visitid: visitid, serviceid: serviceid },
                            success: function (data, textStatus, jqXHR) {                                
                                //
                                fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid }, '/app/canceledpatients');
                                stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/' + facilityId + '/' + staff.serviceid, {}, JSON.stringify({ unitserviceid: staff.serviceid }));
                                //
                            },
                            error: function (jqXHR, textStatus, errorThrown) {                                
                                console.log(jqXHR);
                                console.log(textStatus);
                                console.log(errorThrown);
                        }
                        }); 
//                        if (nextVisit < 1) {
//                            var reset = {
//                                type: 'RESET',
//                                serviceid: serviceid
//                            };
//                            socket.send(JSON.stringify(reset));
//                        }
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
    function pickPausedPatientQueues() {
        var patvisitid = $('#hiddenpausedPatients').val();
        toggleCloseButton(patvisitid);
        $.ajax({
            type: 'POST',
            data: {patvisitid: patvisitid},
            url: "doctorconsultation/pickpausedpatientqueues.htm",
            success: function (data) {
                document.getElementById('normapPatientQueues').style.display = 'block';
                document.getElementById('pausedPatientQueueQ').style.display = 'none';
                var results = JSON.parse(data);
                pickedPatientInQueue(results[0].patientid, results[0].patientvisitid, results[0].visitnumber);
            }
        });

    }
    function closeactivatepatienttab2() {
        window.location = '#close';
        $('.todayspatients').prop('checked', true);
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        $.ajax({
            type: 'POST',
            data: {patientvisitid: patientvisitid},
            url: "doctorconsultation/closepausedpatient.htm",
            success: function (data) {

            }
        });
        //
        $.ajax({
            type: 'GET',
            url: 'queuingSystem/servicePoppedPatient',
            data: { visitid: patientvisitid, serviceid: staff.serviceid, staffid: staff.staffid },
            success: function (data, textStatus, jqXHR) {
                fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid }, '/app/servicedpatientscount');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
        stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/' + facilityId + '/' + staff.serviceid, {}, JSON.stringify({ unitserviceid: staff.serviceid }));
        //
    }
    function toggleCloseButton(patientvisitid){        
        console.log('patientvisitid: ' + patientvisitid);
        $.ajax({
            type: 'GET',
            data: {patientvisitid: patientvisitid},
            url: "doctorconsultation/patientobservationcount.htm",
            success: function (data) {
                console.log('data: ' + data);
                if(parseInt(data) !== 0){
                    $('#closeOrUnPauseApatientid').show();
                    $('#closePatientBtn').show();
                    $('#pauseOrUnPauseApatientid').hide();
                }else {
                    $('#closeOrUnPauseApatientid').hide();
                    $('#closePatientBtn').hide();
                    $('#pauseOrUnPauseApatientid').show();
                }

            }
        });
    }
    function toggleTabs(value){        
        $('.labReqTab').prop('disabled', value);
        $('.refsTab').prop('disabled', value);
        $('.prespTab').prop('disabled', value);
    }
    function connect(){
        var socket = new SockJS('iics-queue');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function(frame){
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/servicedpatientscountconsultation/' + staff.facilityunitid + '/'  + facilityId, function(data){
                handleCount(data.body, '#serviced');
            });
            stompClient.subscribe('/topic/labrequestsconsultation/' + staff.facilityunitid + '/'  + facilityId, function(data){
                handleCount(data.body, '#labrequests');
            });
            stompClient.subscribe('/topic/labresultsconsultation/' + staff.facilityunitid + '/'  + facilityId, function(data){
                handleCount(data.body, '#labresults');
            });
            stompClient.subscribe('/topic/canceledpatientsconsultation/' + staff.facilityunitid + '/'  + facilityId, function(data){
                handleCount(data.body, '#canceled-count');
            });
            stompClient.subscribe('/topic/patientqueuesize/' + staff.facilityunitid + '/'  + facilityId + '/' + staff.serviceid, function(data){
                handleCount(data.body, '#queuedPatients');
            });
            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid }, '/app/servicedpatientscount');
            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid }, '/app/canceledpatients');
            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid, staffid: staff.staffid, type: 'requests' }, '/app/patientlabs');
            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'consultation', unitserviceid: staff.serviceid, staffid: staff.staffid, type: 'results' }, '/app/patientlabs');
            stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/' + facilityId + '/' + staff.serviceid, {}, JSON.stringify({ unitserviceid: staff.serviceid }));
        });
    }
    function fetchCount(data, destination){
        stompClient.send(destination + '/' + staff.facilityunitid + '/'  + facilityId, {}, JSON.stringify(data));
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
            $("#waitingTime").text(data.consultation  + ' Mins');
            console.log(e.data);
        }, false); 
    }
   function cleanUp() {
       if(eventSource !== null){
            eventSource.close();
       }
    }
</script>
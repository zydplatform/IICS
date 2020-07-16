<%--
    Document   : drugDispensingPane
    Created on : Sep 18, 2018, 7:29:45 AM
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
    .dispensingPatientsQueues {
        -webkit-animation: blink 2s;
        -webkit-animation-iteration-count: infinite;
        -moz-animation: blink 2s;
        -moz-animation-iteration-count: infinite;
        -o-animation: blink 1s;
        -o-animation-iteration-count: infinite;
    }
</style>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-title">
<!--                    <h5>Today's Patients.</h5>-->
                    <h5>Today's Prescriptions.</h5>
                </div>
                <div class="tile-body">
                    <fieldset style="min-height:100px;">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="pull-right menu-icon" style="margin-right: 201px;" id="pickPatientForDispensing" 
                                     data-new-click="true">
                                    <div class="icon-content">
                                        <img src="static/img/queue-paper.png" class="dispensingPatientsQueues pull-right" border="1" width="90" height="70" />
                                    </div><br>
                                    <div class="icon-content center">
                                        <h6>
                                            <span class="badge badge-info" id="queuedPatients"></span>
                                            <input id="nextPatient" type="hidden" value="0"/>
                                            <input id="can-review" name="can-review" type="hidden" value="${usercanreviewprescription}"/>
                                        </h6>
                                    </div>
                                </div>
                            </div>
                        </div><br><br><br>
                        <div class="row" style="margin-top: 31px;">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="card-counter primary">
                                            <i class="fa fa-male"></i>
                                            <i class="fa fa-female"></i>
                                            <i class="fa fa-child"></i>
                                            <span class="count-numbers text-success" id="serviced">-</span>
<!--                                            <span class="count-name">Total Patient Serviced</span>-->
                                            <span class="count-name">Total Prescriptions Serviced</span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card-counter info">
                                            <i class="fa fa-clock-o"></i>
                                            <span class="count-numbers text-info" id="waiting">-</span>
                                            <span class="count-name">Average Waiting Time</span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
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

<div class="">
    <div id="modalPatientDispensing" class="stockDetailsModal">
        <div class="">
            <div id="head">
                <h5 class="modal-title names" id="title">Dispensing</h5>
                <a href="#close" title="Close" class="close2">X</a>
                <hr>
            </div>
            <div class="row scrollbar" id="content">
                <div class="col-md-12">
                    <div id="patientBasicInfoDipensing">

                    </div></br>

                    <div class="tile">
                        <div class="tile-body" id="prescribedDrugsDivpane">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>    
    breadCrumb();
    var staff;
    var socket;
    var interval;
    var canceledT = 0;
    var servicedT = 0;
    //
    var stompClient = null;
    var facilityId = ${facilityid};
    var eventSource = null;
    var takenPrescriptions = [];    
    //
    var patientVisitationId;
    $(document).ready(function () {
        breadCrumb();
        //
        var canReview = $('input[name="can-review"]').val();
        if(canReview === "false"){
            $('div.icon-content').css('cursor', 'not-allowed');
        }   
        //
        $.ajax({
            type: 'GET',
            data_type: 'JSON',
            url: "queuingSystem/fetchDispensingStaffDetails.htm",
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
        $('#pickPatientForDispensing').click(function () {
            var element = $(this);
            var isNewClick = element.data('new-click');
            element.find('.icon-content').css('cursor', 'not-allowed');     
            var canReview = $('input[name="can-review"]').val();
            if(canReview === "false"){
                return false;
            }       
            if (isNewClick === true) {
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
                            element.data('new-click', true);
                            element.find('.icon-content').css('cursor', 'pointer');
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
                                                        pickedPatientInDispensingQueue(visitDetails.patientid, visitid, visitDetails.visitno);
                                                        patientVisitationId = visitid;
                                                        fetchCount({ facilityunitid: staff.facilityunitid, destination: 'pharmacy', unitserviceid: staff.serviceid }, '/app/servicedpatientscount');                                                            
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
            //                                                                   $('#canceled-count').html(canceled);                                                                    
                                                                    fetchCount({ faciltiyunitid: staff.facilityunitid, destination: 'pharmacy', unitserviceid: staff.serviceid }, '/app/canceledpatients');
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
        
//        //Gep next patient.
//        $('#pickPatientForDispensing').click(function () {
//            var element = $(this);
//            var isNewClick = element.data('new-click');
//            element.find('.icon-content').css('cursor', 'not-allowed');            
//            if (isNewClick === true) {
//                element.data('new-click', false);
//                var visitid = parseInt($('#nextPatient').val());
//                if (visitid > 0) {
//                    $.ajax({
//                        type: 'POST',
//                        url: 'dispensing/pauseprescription.htm',
//                        data: { patientvisitid: visitid, prescriptionid: '0', pausestage: 'review' },
//                        success: function (data, textStatus, jqXHR) {
//                            console.log(data);
//                            $.ajax({
//                                type: 'POST',
//                                data: {visitid: visitid},
//                                url: 'patient/getPatientVisitDetails.htm',
//                                success: function (res) {
//                                    element.data('new-click', true);
//                                    element.find('.icon-content').css('cursor', 'default');
//                                    if (res !== 'refresh' && res !== '') {
////                                        var data = {
////                                            type: 'PICK',
////                                            visitid: visitid,
////                                            serviceid: staff.serviceid,
////                                            staffid: staff.staffid,
////                                            room: staff.room,
////                                            label: staff.label
////                                        };
////                                        socket.send(JSON.stringify(data));
////                                        var visitDetails = JSON.parse(res);
//                                        $.ajax({
//                                            type: 'GET',
//                                            url: 'queuingSystem/servicePoppedPatient',
//                                            data: { visitid: visitid, serviceid: staff.serviceid, staffid: staff.staffid },
//                                            success: function (data, textStatus, jqXHR) {
//                                                fetchCount({ facilityunitid: staff.facilityunitid, destination: 'pharmacy', unitserviceid: staff.serviceid }, '/app/servicedpatientscount');
//                                            },
//                                            error: function (jqXHR, textStatus, errorThrown) {
//                                                console.log(jqXHR);
//                                                console.log(textStatus);
//                                                console.log(errorThrown);
//                                            }
//                                        });
//                                        $.confirm({
//                                            title: '',
//                                            content: '<h3><strong><font color="#054afc">' + visitDetails.names + '</font></strong></h3><br/>' +
//                                                    '<h4><strong><font color="#054afc">' + visitDetails.visitno + '</font></strong></h4>',
//                                            boxWidth: '40%',
//                                            useBootstrap: false,
//                                            type: 'purple',
//                                            typeAnimated: true,
//                                            theme: 'modern',
//                                            icon: 'fa fa-question-circle',
//                                            buttons: {
//                                                formSubmit: {
//                                                    text: 'Receive Patient',
//                                                    btnClass: 'btn-purple',
//                                                    action: function () {
//                                                        pickedPatientInDispensingQueue(visitDetails.patientid, visitid, visitDetails.visitno);
//                                                        patientVisitationId = visitid;                                                        
//                                                        fetchCount({ facilityunitid: staff.facilityunitid, destination: 'pharmacy', unitserviceid: staff.serviceid }, '/app/servicedpatientscount');
//                                                    }
//                                                },
//                                                close: {
//                                                    text: 'Cancel',
//                                                    btnClass: 'btn-red cancel',
//                                                    action: function () {
//                                                        var data = {
//                                                            visitid: visitid,
//                                                            serviceid: staff.serviceid
//                                                        };
//                                                        $.ajax({
//                                                            type: 'POST',
//                                                            data: data,
//                                                            data_type: 'JSON',
//                                                            url: "queuingSystem/cancelPoppedPatient.htm",
//                                                            success: function (canceled) {
//                                                                if (canceled === 'refresh') {
//                                                                    document.location.reload(true);
//                                                                }
//                                                                if (canceled !== 'fasle') {
////                                                                    $('#canceled-count').html(canceled);                                                                    
//                                                                    fetchCount({ faciltiyunitid: staff.facilityunitid, destination: 'pharmacy', unitserviceid: staff.serviceid }, '/app/canceledpatients');
//                                                                }
//                                                            }
//                                                        });
//                                                    }
//                                                }
//                                            }
//                                        });
//                                    } else {
//                                        if (res !== 'refresh') {
//                                            document.location.reload(true);
//                                        }
//                                    }
//                                }
//                            });
//                        }
//                    });
//                    //                $.ajax({
//                    //                    type: 'POST',
//                    //                    data: {visitid: visitid},
//                    //                    url: 'patient/getPatientVisitDetails.htm',
//                    //                    success: function (res) {
//                    //                        if (res !== 'refresh' && res !== '') {
//                    //                            var data = {
//                    //                                type: 'PICK',
//                    //                                visitid: visitid,
//                    //                                serviceid: staff.serviceid,
//                    //                                staffid: staff.staffid,
//                    //                                room: staff.room,
//                    //                                label: staff.label
//                    //                            };
//                    //                            socket.send(JSON.stringify(data));
//                    //                            var visitDetails = JSON.parse(res);
//                    //                            $.confirm({
//                    //                                title: '',
//                    //                                content: '<h3><strong><font color="#054afc">' + visitDetails.names + '</font></strong></h3><br/>' +
//                    //                                        '<h4><strong><font color="#054afc">' + visitDetails.visitno + '</font></strong></h4>',
//                    //                                boxWidth: '40%',
//                    //                                useBootstrap: false,
//                    //                                type: 'purple',
//                    //                                typeAnimated: true,
//                    //                                theme: 'modern',
//                    //                                icon: 'fa fa-question-circle',
//                    //                                buttons: {
//                    //                                    formSubmit: {
//                    //                                        text: 'Receive Patient',
//                    //                                        btnClass: 'btn-purple',
//                    //                                        action: function () {
//                    //                                            pickedPatientInDispensingQueue(visitDetails.patientid, visitid, visitDetails.visitno);
//                    //                                            patientVisitationId = visitid;
//                    //                                        }
//                    //                                    },
//                    //                                    close: {
//                    //                                        text: 'Cancel',
//                    //                                        btnClass: 'btn-red cancel',
//                    //                                        action: function () {
//                    //                                            var data = {
//                    //                                                visitid: visitid,
//                    //                                                serviceid: staff.serviceid
//                    //                                            };
//                    //                                            $.ajax({
//                    //                                                type: 'POST',
//                    //                                                data: data,
//                    //                                                data_type: 'JSON',
//                    //                                                url: "queuingSystem/cancelPoppedPatient.htm",
//                    //                                                success: function (canceled) {
//                    //                                                    if (canceled === 'refresh') {
//                    //                                                        document.location.reload(true);
//                    //                                                    }
//                    //                                                    if (canceled !== 'fasle') {
//                    //                                                        $('#canceled-count').html(canceled);
//                    //                                                    }
//                    //                                                }
//                    //                                            });
//                    //                                        }
//                    //                                    }
//                    //                                }
//                    //                            });
//                    //                        } else {
//                    //                            if (res !== 'refresh') {
//                    //                                document.location.reload(true);
//                    //                            }
//                    //                        }
//                    //                    }
//                    //                });
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
//                        canceledT = parseInt(canceled);
//                        $('#canceled-count').html(canceled);
//                    }
//                });
//                $.ajax({
//                    type: 'GET',
//                    data: {unitserviceid: staff.serviceid},
//                    data_type: 'JSON',
//                    url: "queuingSystem/countServicedPatients.htm",
//                    success: function (serviced) {
//                        servicedT = parseInt(serviced);
//                        $('#serviced').html(serviced);
//                    }
//                });
//                //
//                $.ajax({
//                    type: 'GET',
//                    data: {},
//                    data_type: 'JSON',
//                    url: "dispensing/pausedprescriptionscount.htm",
//                    success: function (data) {
//                        pausedPrescriptions = parseInt(data);
//                        $('#paused-count').html(pausedPrescriptions);
//                    }
//                });
//                //
//                $.ajax({
//                    type: 'GET',
//                    data: {unitserviceid: staff.serviceid},
//                    data_type: 'JSON',
//                    url: "queuingSystem/getWaitingTime.htm",
//                    success: function (waiting) {
//                        $('#waiting').html(parseInt(waiting) + ' Mins');
//                    }
//                });
//            }
//        }, 1000 * 30);
    });

    function pickedPatientInDispensingQueue(patientid, patientvisitid, visitnumber) {
//        $.ajax({
//            type: 'GET',
//            data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
//            url: "dispensing/dispensingpatientinqueuedetails.htm",
//            success: function (data) {
//                $.ajax({
//                    type: 'GET',
//                    data: {patientid: patientid.toString()},
//                    url: "triage/getPatientMedicalIssues.htm",
//                    success: function (res) {
//                        $('#issuesAndAllergies').html(res);
//                    }
//                });
////                window.location = '#modalPatientDispensing';
////                $('#patientBasicInfoDipensing').html(data);
////                initDialog('stockDetailsModal');
//            }
//        });

//        $.ajax({
//            type: 'GET',
//            data: {patientvisitid: patientvisitid},
//            url: "dispensing/prescribedDrugsDetails.htm",
//            success: function (data) {
//                $('#prescribedDrugsDivpane').html(data);
//            }
//        });
        $.ajax({
            type: 'GET',
            data: { patientvisitid: patientvisitid },
            url: "dispensing/getprescriptionid.htm",
            success: function (data, textStatus, jqXHR) {
                pushPrescription('dispensing/pushprescription.htm', { patientvisitid: patientvisitid, prescriptionid: data, staffid: staff.staffid, facilityunitid: staff.facilityunitid, queuestage: 'review', ispopped: true, poppedby: staff.staffid });
                navigateTo('view-prescription-items', patientvisitid);
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
//                        if (nextVisit < 1) {
//                            var reset = {
//                                type: 'RESET',
//                                serviceid: serviceid
//                            };
//                            socket.send(JSON.stringify(reset));
//                        }
                        $.ajax({
                            type: 'GET',
                            url: 'queuingSystem/revertPoppedPatient.htm',
                            data: { visitid: visitid, serviceid: serviceid },
                            success: function (data, textStatus, jqXHR) {
                                //
                                fetchCount({ facilityunitid: staff.facilityunitid, destination: 'pharmacy', unitserviceid: staff.serviceid }, '/app/canceledpatients');
                                stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/'  + facilityId + '/' + staff.serviceid, {}, JSON.stringify({ unitserviceid: staff.serviceid }));
                                //
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
                    text: 'Cancel',
                    btnClass: 'btn-red cancel',
                    action: function () {

                    }
                }
            }
        });
    }
    //
    function fetchCount(data, destination){
        stompClient.send(destination + "/" + staff.facilityunitid + '/'  + facilityId, {}, JSON.stringify(data));
    }
    function handleCount(message, targetControl){
        $(targetControl).html(message).trigger('create');
    }  
    function pushPrescription(url, data){
        $.ajax({
            type: 'POST',
            url: url,
            data: data,
            success: function (result, textStatus, jqXHR) {
                if(data.queuestage.toString().toLowerCase() !== 'review'){
                    ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
                fetchCount({ facilityunitid: data.facilityunitid, queuestage: data.queuestage }, '/app/prescriptioncount');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    }
    function popPrescription(url, data, targetUrl, targetControl){
        $.ajax({
            type: 'GET',
            url: url,
            data: data,
            success: function (result, textStatus, jqXHR) {
                ajaxSubmitData(targetUrl, targetControl, 'prescriptionid=' + result, 'GET');
                fetchCount({ facilityunitid: data.facilityunitid, queuestage: data.queuestage }, '/app/prescriptioncount');                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    }    
    function connect() {
        var socket = new SockJS('iics-queue');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function (frame) {
            console.log('Connected: ' + frame);            
            stompClient.subscribe('/topic/canceledpatientsdispensing/' + staff.facilityunitid + '/'  + facilityId, function(data){
                handleCount(data.body, '#canceled-count');
            });
            stompClient.subscribe('/topic/approvalprescriptioncount/' + staff.facilityunitid + '/'  + facilityId, function (data) {
                handleCount(data.body, '#reviewed-count');
            });
            stompClient.subscribe('/topic/pickingprescriptioncount/' + staff.facilityunitid + '/'  + facilityId, function (data) {
                handleCount(data.body, '#pick-lists-count');
            });
            stompClient.subscribe('/topic/dispensingprescriptioncount/' + staff.facilityunitid + '/'  + facilityId, function (data) {
                handleCount(data.body, '#ready-to-issue-prescription-count');
            });
            stompClient.subscribe('/topic/servicedprescriptioncount/' + staff.facilityunitid + '/'  + facilityId, function (data) {
                handleCount(data.body, '#serviced-prescription-count');
            });
            stompClient.subscribe('/topic/servicedpatientscountdispensing/' + staff.facilityunitid + '/'  + facilityId, function(data){
                handleCount(data.body, '#serviced');
            });
            stompClient.subscribe('/topic/patientqueuesize/' + staff.facilityunitid + '/'  + facilityId + '/' + staff.serviceid, function(data){
                handleCount(data.body, '#queuedPatients');
            });
            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'pharmacy', unitserviceid: staff.serviceid }, '/app/servicedpatientscount');
            fetchCount({ facilityunitid: staff.facilityunitid, destination: 'pharmacy', unitserviceid: staff.serviceid }, '/app/canceledpatients');
            stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/'  + facilityId + '/' + staff.serviceid, {}, JSON.stringify({ unitserviceid: staff.serviceid }));
        });
    }
    function initNotification(){        
        if (eventSource !== null) {
            eventSource.close();
        }
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
            $("#waiting").text(data.dispensing  + ' Mins');
            console.log(e.data);
        }, false); 
    }
    function serviceprescription(visitid){
        $.ajax({
            type: 'GET',
            url: 'queuingSystem/servicePoppedPatient',
            data: { visitid: visitid, serviceid: staff.serviceid, staffid: staff.staffid },
            success: function (data, textStatus, jqXHR) {
                ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                fetchCount({ facilityunitid: staff.facilityunitid, destination: 'pharmacy', unitserviceid: staff.serviceid }, '/app/servicedpatientscount');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    }
    function unPopPatient(patientVisitId){
        $.ajax({
            type: 'POST',
            data: { patientvisitid: patientVisitId },
            url: 'queuingSystem/unpoppatient.htm',
            success: function (data, textStatus, jqXHR) {
                ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                stompClient.send('/app/patientqueuesize/' + staff.facilityunitid + '/'  + facilityId + '/' + staff.serviceid, {}, JSON.stringify({ unitserviceid: staff.serviceid }));                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    }
    function addBackToQueue(prescriptionId, queueStage){
        $.ajax({
            type: 'POST',
            data: { prescriptionid: prescriptionId },
            url : 'dispensing/addbacktoqueue.htm',
            success: function (data, textStatus, jqXHR) {
                ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                fetchCount({ facilityunitid: staff.facilityunitid, queuestage: queueStage }, '/app/prescriptioncount');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    }
    function closePoppedPrescription(data, hasApprovables){
        $.ajax({
            type: 'POST',
            data: data,
            url: 'dispensing/closepoppedprescription.htm',
            success: function (result, textStatus, jqXHR) {
                console.log(result);    
                if(hasApprovables === false){
                    unServicePrescription({ prescriptionid: data.prescriptionid });
                }
                ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    }    
    function recordUnResolvedPrescriptions(prescriptionId, patientVisitId){
        $.ajax({
            type: 'POST',
            url: 'dispensing/recordunresolvedprescriptions.htm',
            data: { prescriptionid: prescriptionId, patientvisitid: patientVisitId },
            success: function (data, textStatus, jqXHR) {
                console.log(data);
                fetchCount({ facilityunitid: staff.facilityunitid, queuestage: 'serviced' }, '/app/prescriptioncount');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    }
    function recordUnservicedPrescription(prescriptionId){
        $.ajax({
            type: 'POST',
            url: 'dispensing/recordunservicedprescription.htm',
            data: { prescriptionid: prescriptionId },
            success: function (data, textStatus, jqXHR) {
                console.log(data);
                fetchCount({ facilityunitid: staff.facilityunitid, queuestage: 'serviced' }, '/app/prescriptioncount');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    }
    function printPrescription(printType, prescriptionid, prescriberid, patientVisitId) {
        $.confirm({
            icon: 'fa fa-print',
            title: 'PRINT PRESCRIPTION',
            content: '<div id="print-prescription-area" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
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
                var printArea = this.$content.find('#print-prescription-area');
                $.ajax({
                    type: 'GET',
                    data: {prescriptionid: prescriptionid, patientvisitid: patientVisitId, prescriberid: prescriberid, printtype: printType},
                    url: 'dispensing/printprescription.htm',
                    success: function (result) {
                        if (result !== '') {
                            var objbuilder = '';
                            objbuilder += ('<object width="100%" height="500px" data="data:application/pdf;base64,');
                            objbuilder += (result);
                            objbuilder += ('" type="application/pdf" class="internal">');
                            objbuilder += ('<embed src="data:application/pdf;base64,');
                            objbuilder += (result);
                            objbuilder += ('" type="application/pdf"/>');
                            objbuilder += ('</object>');
                            printArea.html(objbuilder);
                        } else {
                            printArea.html('<div class="bs-component">' +
                                    '<div class="alert alert-dismissible alert-warning">' +
                                    '<h4>Warning!</h4>' +
                                    '<p>Error generating PDF. Please <strong>Refresh</strong> & Try Again.</p></div></div>'
                                    );
                        }
                    }
                });
            }
        });
    }
    function unServicePrescription(data){
        $.ajax({
            type: 'POST',
            data: data,
            url: 'dispensing/unserviceprescription.htm',
            success: function (data, textStatus, jqXHR) {
                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);        
            }
        });
    }
</script>


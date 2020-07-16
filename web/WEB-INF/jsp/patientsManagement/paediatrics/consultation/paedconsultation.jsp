<%-- 
    Document   : paedconsultation
    Created on : Nov 5, 2018, 10:41:57 AM
    Author     : user
--%>

<%@include file="../../../include.jsp" %>
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
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                        <li><a href="#" onclick="ajaxSubmitData('patient/patientmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Patient Management</a></li>
                        <li class="last active"><a href="#">Doctor's Consultation</a></li>
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
                        <div>
                            <div style="margin: 10px;">
                                <fieldset style="min-height:100px;">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="tile">
                                                <div class="tile-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="pull-right menu-icon" style="margin-right: 201px;" id="pickPatient">
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
                                                    </div><br>
                                                    <div class="row" id="getStatisticsofpatientsdiv">
                                                        <%@include file="../../../../jsp/doctorConsultations/views/statistics.jsp" %>
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
                        <%@include file="../../../doctorConsultations/performance/performancePane.jsp" %>
                    </section>
                </main>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div id="prescribeunprescribedpatients" class="prescriptionDiaolog prescribeunprescribedpatient">
                        <div>
                            <div id="head">
                                <a href="#close" title="Pause Patient" class="close2" style="display: block; width: 93px;" onclick="activatepatientstab();">Pause</a>
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
                                <a href="#close" title="Close" class="close2" style="display: block;" onclick="activatepatientstab();">X</a>
                                <h2 class="modalDialog-title" id="titleoralprescribeheading">PATIENT LABORATORY REQUEST(S).</h2>
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
                                <a href="#close" title="Close" class="close2" style="display: block;" onclick="activatepatientstab();">X</a>
                                <h2 class="modalDialog-title" id="titleoralprescribeheading">PATIENT LABORATORY REQUEST(S).</h2>
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
        function activatepatientstab() {
        $('.todayspatients').prop('checked', true);
    }
    var staff;
    var socket;
    var interval;
    var queueCanceled = 0;
    $(document).ready(function () {
        $.ajax({
            type: 'GET',
            data_type: 'JSON',
            url: "queuingSystem/fetchStaffDetails.htm",
            success: function (data) {
                staff = JSON.parse(data);
                var host = location.host;
                var url = 'ws://' + host + '/IICS/queuingServer?'
                        + 'staffid=' + staff.staffid
                        + '&serviceid=' + staff.serviceid
                        + '&room=' + staff.room
                        + '&label=' + staff.label + "&host=" + host;
                socket = new WebSocket(url);
                socket.onmessage = function (ev) {
                    var response = JSON.parse(ev.data);
                    if (response.type === 'update') {
                        $('#queuedPatients').html(response.size);
                    } else if (response.type === 'next') {
                        $('#nextPatient').val(response.visit);
                    }
                };
            }
        });

        //Gep next patient.
        $('#pickPatient').click(function () {
            var visitid = parseInt($('#nextPatient').val());
            if (visitid > 0) {
                $.ajax({
                    type: 'POST',
                    data: {visitid: visitid},
                    url: 'patient/getPatientVisitDetails.htm',
                    success: function (res) {
                        if (res !== 'refresh' && res !== '') {
                            var data = {
                                type: 'PICK',
                                visitid: visitid,
                                serviceid: staff.serviceid,
                                staffid: staff.staffid,
                                room: staff.room,
                                label: staff.label
                            };
                            socket.send(JSON.stringify(data));
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
                                                        $('#canceled-count').html(canceled);
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
            }
        });

        interval = setInterval(function () {
            //Fetch Cancelled patients.
            var serviceid = parseInt(staff.serviceid);
            if (serviceid > 0) {
                $.ajax({
                    type: 'GET',
                    data: {unitserviceid: staff.serviceid},
                    data_type: 'JSON',
                    url: "queuingSystem/countCanceledPatients.htm",
                    success: function (canceled) {
                        $('#canceled-count').html(canceled);
                    }
                });
                $.ajax({
                    type: 'GET',
                    data: {unitserviceid: staff.serviceid},
                    data_type: 'JSON',
                    url: "queuingSystem/countServicedPatients.htm",
                    success: function (canceled) {
                        $('#serviced').html(canceled);
                    }
                });

                $.ajax({
                    type: 'POST',
                    data: {type: 'requests'},
                    url: "doctorconsultation/countRequestsPatients.htm",
                    success: function (requests) {
                        $('#labrequests').html(requests);
                    }
                });

                $.ajax({
                    type: 'POST',
                    data: {type: 'results'},
                    url: "doctorconsultation/countRequestsPatients.htm",
                    success: function (requests) {
                        $('#labresults').html(requests);
                    }
                });
            }
        }, 1000 * 30);
        $('#tab3').click(function () {
            fetchDailyStaffPerformance();
        });
         $('#tab2').click(function () {
           ajaxSubmitData('doctorconsultation/gettodaysreceivedpatients.htm', 'todaysreceivedcliniciansdiv', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });
    });

    function pickedPatientInQueue(patientid, patientvisitid, visitnumber) {
        $.ajax({
            type: 'GET',
            data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
            url: "paediatrics/patientinqueuedetails.htm",
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
                        var data = {
                            type: 'REVERT',
                            visitid: visitid,
                            serviceid: serviceid
                        };
                        socket.send(JSON.stringify(data));
                        $('#restore' + visitid).prop('disabled', true);
                        var nextVisit = parseInt($('#nextPatient').val());
                        if (nextVisit < 1) {
                            var reset = {
                                type: 'RESET',
                                serviceid: serviceid
                            };
                            socket.send(JSON.stringify(reset));
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
</script>
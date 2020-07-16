<%-- 
    Document   : laboratoryHome
    Created on : Sep 13, 2018, 5:43:03 AM
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
    .laboratoryPatientsQueues {
        -webkit-animation: blink 2s;
        -webkit-animation-iteration-count: infinite;
        -moz-animation: blink 2s;
        -moz-animation-iteration-count: infinite;
        -o-animation: blink 1s;
        -o-animation-iteration-count: infinite;
    }
    .card-counter{
        box-shadow: 2px 2px 10px #9f77a7;
        margin: 5px;
        padding: 20px 10px;
        background-color: #fff;
        height: 100px;
        border-radius: 5px;
        transition: .3s linear all;
    }

    .card-counter:hover{
        box-shadow: 4px 4px 20px #DADADA;
        transition: .3s linear all;
    }

    .card-counter i{
        font-size: 5em;
        opacity: 0.2;
    }

    .card-counter .count-numbers{
        position: absolute;
        right: 35px;
        top: 20px;
        font-size: 32px;
        display: block;
        font-weight: bolder;
    }

    .card-counter .count-name{
        position: absolute;
        right: 35px;
        top: 65px;
        font-style: normal;
        text-transform: capitalize;
        opacity: 0.5;
        display: block;
        font-size: 18px;
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
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                        <li class="last active"><a href="#">Laboratory</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div id="laboratorypatientsdiv">
        <%@include file="views/todayspatients.jsp" %>
    </div>
</div>
<div class="">
    <div id="patientInLaboratory" class="prescriptionDiaolog laboratoryPatient">
        <div class="">
            <div id="head">
                <h5 class="modal-title names" id="title">Patient Lab Test Request</h5>
                <a href="#close" title="Close" class="close2" onclick="activelabtabclose();">X</a>
                <hr>
            </div>
            <div class="row scrollbar" id="content">
                <div class="col-md-12">
                    <div id="addLaboratoryPatientdiv">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        ajaxSubmitData('laboratory/todayslaboratorypatientsregister.htm', 'todayslabpatientsdiv', 'b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    function activelabtabclose() {
        $('.todayslabpatients').prop('checked', true);
    }
    var currentstaff;
    var currentsocket;
    $(document).ready(function () {
        breadCrumb();
        $.ajax({
            type: 'GET',
            data_type: 'JSON',
            url: "queuingSystem/fetchLaboratoryStaffDetails.htm",
            success: function (data) {
                currentstaff = JSON.parse(data);
                var host = location.host;
                var url = 'ws://' + host + '/IICS/queuingServer?'
                        + 'staffid=' + currentstaff.staffid
                        + '&serviceid=' + currentstaff.serviceid
                        + '&room=' + currentstaff.room
                        + '&label=' + currentstaff.label + "&host=" + host;
                currentsocket = new WebSocket(url);
                currentsocket.onmessage = function (ev) {
                    var response = JSON.parse(ev.data);
                    if (response.type === 'update') {
                        $('#queuedLabPatients').html(response.size);
                    } else if (response.type === 'next') {
                        $('#nextLabPatient').val(response.visit);
                    }
                };
            }
        });
        //Gep next patient.
        $('#pickPatientForLaboratory').click(function () {
            var visitid = parseInt($('#nextLabPatient').val());
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
                                serviceid: currentstaff.serviceid,
                                staffid: currentstaff.staffid,
                                room: currentstaff.room,
                                label: currentstaff.label
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
                                            pickedPatientInLabQueue(visitDetails.patientid, visitid, visitDetails.visitno);
                                        }
                                    },
                                    close: {
                                        text: 'Cancel',
                                        btnClass: 'btn-red cancel',
                                        action: function () {
                                            var data = {
                                                type: 'REVERT',
                                                visitid: visitid,
                                                serviceid: currentstaff.serviceid
                                            };
                                            socket.send(JSON.stringify(data));
                                        }
                                    }
                                },
                                onContentReady: function () {
                                    var cancel = $('.cancel');
                                    cancel.prop('disabled', true);

                                    var countDownDate = new Date().getTime() + 5 * 60 * 1000;
                                    var x = setInterval(function () {
                                        var now = new Date().getTime();
                                        var distance = countDownDate - now;

                                        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                                        var seconds = Math.floor((distance % (1000 * 60)) / 1000);
                                        if (seconds < 10)
                                            seconds = '0' + seconds;
                                        cancel.html('0' + minutes + ":" + seconds);
                                        if (distance < 0) {
                                            clearInterval(x);
                                            cancel.prop('disabled', false);
                                            cancel.html('Cancel');
                                        }
                                    }, 1000);
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
    });
    function pickedPatientInLabQueue(patientid, visitid, visitno) {
        $.ajax({
            type: 'GET',
            data: {patientid: patientid, patientvisitid: visitid, visitnumber: visitno},
            url: "laboratory/patientinqueuedetails.htm",
            success: function (repos) {
                window.location = "#patientInLaboratory";
                $('#addLaboratoryPatientdiv').html(repos);
                initDialog('laboratoryPatient');
            }
        });
    }
</script>
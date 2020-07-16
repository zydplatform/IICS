<%-- 
    Document   : triage
    Created on : Oct 18, 2018, 9:01:29 AM
    Author     : user
--%>

<%@include file="../../../include.jsp" %>
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
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                        <li><a href="#" onclick="ajaxSubmitData('patient/patientmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Patient Management</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('paediatrics/paediaricsmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Paediatrics</a></li>
                        <li class="last active"><a href="#">Peadiatrics Triage</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-title">
                    <h5>Today's Patients.</h5>  
                </div>
                <div class="tile-body">
                    <fieldset style="min-height:100px;">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="pull-right menu-icon" style="margin-right: 201px;" id="pickPatientForTriage">
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
                                    <div class="col-md-4">
                                        <div class="card-counter primary">
                                            <i class="fa fa-child success"></i>
                                            <i class="fa fa-child success"></i>
                                            <i class="fa fa-child success"></i>
                                            <span class="count-numbers text-success" id="serviced">-</span>
                                            <span class="count-name">Serviced Patients</span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card-counter info">
                                            <i class="fa fa-clock-o info"></i>
                                            <span class="count-numbers text-info">0</span>
                                            <span class="count-name">Average Waiting Time</span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card-counter info" id="fetchCanceled" onclick="fetchCanceledPatients()">
                                            <i class="fa fa-close danger"></i>
                                            <span class="count-numbers text-danger" id="canceled-count">-</span>
                                            <span class="count-name">Canceled</span>
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
                    <%@include file="paedtriageform.jsp" %>
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
    $(document).ready(function () {
        $.ajax({
            type: 'GET',
            data_type: 'JSON',
            url: "queuingSystem/fetchTriageStaffDetails.htm",
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
        //Get next Patient
        $('#pickPatientForTriage').click(function () {
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
                                            patientVisitationId = visitid;
                                            document.getElementById('visitid').value=visitid;
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
    });
    function pickedPatientInQueue(patientid, patientvisitid, visitnumber) {
        $.ajax({
            type: 'GET',
            data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
            url: "paediatrics/triagepatientinqueuedetails.htm",
            success: function (data) {
                
                window.location = '#modalOrderitems';
                $('#patientBasicInfoTriage').html(data);
                initDialog('stockDetailsModal');
            }
        });
    }
    function functioncheckPatientweightb() {
        $('#weightageboys').html('');
        var patientWeight = $('#patientWeightb').val();
        var patientHeight2 = $('#patientHeightb').val();
         var monthsintotal =$('#monthsintotal').val();
        if (patientHeight2 === null || typeof patientHeight2 === 'undefined' || patientHeight2 === '') {
            $('#patientBMInoHeighteerrormsgb').show();
            $('#patientBMInoWeighteerrormsgb').hide();
        } else {
            if (patientWeight !== null || typeof patientWeight !== 'undefined' || patientWeight !== '') {
                $('#patientBMInoHeighteerrormsgb').hide();
                $('#patientBMInoWeighteerrormsgb').hide();
                patientWeight = parseFloat(patientWeight);
                patientHeight2cm = parseFloat(patientHeight2);


                $('#patientBMInoHeighteerrormsgb').hide();
                $('#patientBMInoWeighteerrormsgb').hide();
                patientHeight2cm = parseFloat(patientHeight2cm);
                patientWeight = parseFloat(patientWeight);
                var patientHeightinMetres = patientHeight2cm / 100;
                var patientHeightinMetressquared = patientHeightinMetres * patientHeightinMetres;

                var patientBIM = patientWeight / patientHeightinMetressquared;
                $('#patientBMIReportb').val(Math.round(patientBIM));
            }
        }
        
        $.ajax({
            type: 'POST',
            data: {patientWeight: patientWeight,monthsintotal: monthsintotal},
            url: "paediatrics/WFAobservationboys.htm",
            success: function (respose) {
                if (respose === '') {
                    document.getElementById('weightageboys').innerHTML = "Patient is above 10 years.";
                }
                if(respose==="Normal"){
                    document.getElementById('weightageboys').innerHTML="Normal";
                }
                if(respose==="Growth Problem"){
                    document.getElementById('weightageboys').innerHTML="Growth Problem";
                }
                if(respose==="Under Weight"){
                    document.getElementById('weightageboys').innerHTML="Under Weight";
                }
                if(respose==="Severely Underweight"){
                    document.getElementById('weightageboys').innerHTML="Severely Underweight";
                }
            }
        });
        
    }
    function functioncheckPatientweightbb(){
        $('#weightageboysb').html('');
        var patientWeight = $('#patientWeightbb').val();
        var patientHeight2 = $('#patientHeightbb').val();
         var monthsintotal =$('#monthsintotal').val();
        if (patientHeight2 === null || typeof patientHeight2 === 'undefined' || patientHeight2 === '') {
            $('#patientBMInoHeighteerrormsgbb').show();
            $('#patientBMInoWeighteerrormsgbb').hide();
        } else {
            if (patientWeight !== null || typeof patientWeight !== 'undefined' || patientWeight !== '') {
                $('#patientBMInoHeighteerrormsgbb').hide();
                $('#patientBMInoWeighteerrormsgbb').hide();
                patientWeight = parseFloat(patientWeight);
                patientHeight2cm = parseFloat(patientHeight2);


                $('#patientBMInoHeighteerrormsgbb').hide();
                $('#patientBMInoWeighteerrormsgbb').hide();
                patientHeight2cm = parseFloat(patientHeight2cm);
                patientWeight = parseFloat(patientWeight);
                var patientHeightinMetres = patientHeight2cm / 100;
                var patientHeightinMetressquared = patientHeightinMetres * patientHeightinMetres;

                var patientBIM = patientWeight / patientHeightinMetressquared;
                $('#patientBMIReportbb').val(Math.round(patientBIM));
            }
        }
        
        $.ajax({
            type: 'POST',
            data: {patientWeight: patientWeight,monthsintotal: monthsintotal},
            url: "paediatrics/WFAobservationboys.htm",
            success: function (respose) {
                if(respose===''){
                    document.getElementById('weightageboysb').innerHTML="Patient is above 10 years.";
                }
                if(respose==="Normal"){
                    document.getElementById('weightageboysb').innerHTML="Normal";
                }
                if(respose==="Growth Problem"){
                    document.getElementById('weightageboysb').innerHTML="Growth Problem";
                }
                if(respose==="Under Weight"){
                    document.getElementById('weightageboysb').innerHTML="Under Weight";
                }
                if(respose==="Severely Underweight"){
                    document.getElementById('weightageboysb').innerHTML="Severely Underweight";
                }
            }
        });
        
    }

    function functioncheckPatientTemperature() {
        var patientTemperature = $('#patientTemperature').val();
        patientTemperature = parseInt(patientTemperature);
        if (patientTemperature < 30 || patientTemperature > 45) {
            $('#patientTemperatureerrormsg').show();
        } else {
            $('#patientTemperatureerrormsg').hide();
        }
    }

    function functioncheckpatientHeightb() {
        $('#heightlengthboys').html('');
        $('#weightheightboys').html('');
        var patientHeightcm = $('#patientHeightb').val();
        var patientWeight = $('#patientWeightb').val();
        var monthsintotal =$('#monthsintotal').val();
        if (parseInt(patientHeightcm) < 20 || parseInt(patientHeightcm) > 300) {
            $('#patientpatientHeighterrormsgb').show();
        } else {
            $('#patientpatientHeighterrormsgb').hide();
        }

        if (patientWeight === null || typeof patientWeight === 'undefined' || patientWeight === '') {
            $('#patientBMInoHeighteerrormsgb').hide();
            $('#patientBMInoWeighteerrormsgb').show();
        } else {
            if (patientHeightcm !== null || typeof patientHeightcm !== 'undefined' || patientHeightcm !== '') {
                $('#patientBMInoHeighteerrormsgb').hide();
                $('#patientBMInoWeighteerrormsgb').hide();
                patientHeightcm = parseFloat(patientHeightcm);
                patientWeight = parseFloat(patientWeight);
                var patientHeightinMetres = patientHeightcm / 100;
                var patientHeightinMetressquared = patientHeightinMetres * patientHeightinMetres;

                var patientBIM2 = patientWeight / patientHeightinMetressquared;
                
                $('#patientBMIReportb').val(Math.round(patientBIM2));
            }
        }
        $.ajax({
            type: 'POST',
            data: {patientHeightcm: patientHeightcm,monthsintotal: monthsintotal},
            url: "paediatrics/HFAobservationboys.htm",
            success: function (respose) {
                if(respose==='Normal'){
                    document.getElementById('heightlengthboys').innerHTML="Normal";
                }
                else if(respose==='Stunted'){
                    document.getElementById('heightlengthboys').innerHTML="Stunted";
                }
                else if(respose==='Severely Stunted'){
                    document.getElementById('heightlengthboys').innerHTML="Severely Stunted";
                }
                else if(respose==='Very Tall'){
                    document.getElementById('heightlengthboys').innerHTML="Very Tall";
                }
                else if(respose==='Tall'){
                    document.getElementById('heightlengthboys').innerHTML="Tall";
                }else{
                     document.getElementById('heightlengthboys').innerHTML="Invalid";
                }
            }
        });
        $.ajax({
            type: 'POST',
            data: {patientHeightcm: patientHeightcm,patientWeight: patientWeight},
            url: "paediatrics/WFHobservationboys.htm",
            success: function (respose) {
                
                 if(respose==='Obese'){
                     document.getElementById('weightheightboys').innerHTML="Obese";
                     document.getElementById('weightheightboys').style.color='red';
                }
                else if(respose==='Over weight'){
                     document.getElementById('weightheightboys').innerHTML="Over weight";
                     document.getElementById('weightheightboys').style.color='red';
                }
                else if(respose==='Over Weight Risk'){
                     document.getElementById('weightheightboys').innerHTML="Over Weight Risk";
                     document.getElementById('weightheightboys').style.color='red';
                }
                else if(respose==='Normal'){
                     document.getElementById('weightheightboys').innerHTML="Normal";
                }
                else if(respose==='Wasted'){
                     document.getElementById('weightheightboys').innerHTML="Wasted";
                     
                }
                else if(respose==='Severely Wasted'){
                     document.getElementById('weightheightboys').innerHTML="Severely Wasted";
                     document.getElementById('weightheightboys').style.color='red';
                }else{
                    document.getElementById('weightheightboys').innerHTML="Invalid";
                }
            }
        });
    }
    function functioncheckpatientHeightbb(){
        $('#heightlengthboysb').html('');
        $('#weightheightboysb').html('');
        var patientHeightcm = $('#patientHeightbb').val();
        var patientWeight = $('#patientWeightbb').val();
        var monthsintotal =$('#monthsintotal').val();
        if (parseInt(patientHeightcm) < 20 || parseInt(patientHeightcm) > 300) {
            $('#patientpatientHeighterrormsgbb').show();
        } else {
            $('#patientpatientHeighterrormsgbb').hide();
        }

        if (patientWeight === null || typeof patientWeight === 'undefined' || patientWeight === '') {
            $('#patientBMInoHeighteerrormsgbb').hide();
            $('#patientBMInoWeighteerrormsgbb').show();
        } else {
            if (patientHeightcm !== null || typeof patientHeightcm !== 'undefined' || patientHeightcm !== '') {
                $('#patientBMInoHeighteerrormsgbb').hide();
                $('#patientBMInoWeighteerrormsgbb').hide();
                patientHeightcm = parseFloat(patientHeightcm);
                patientWeight = parseFloat(patientWeight);
                var patientHeightinMetres = patientHeightcm / 100;
                var patientHeightinMetressquared = patientHeightinMetres * patientHeightinMetres;

                var patientBIM2 = patientWeight / patientHeightinMetressquared;
                
                $('#patientBMIReportbb').val(Math.round(patientBIM2));
            }
        }
        console.log("-------patientBIM2-----"+patientBIM2);
        $.ajax({
            type: 'POST',
            data: {patientHeightcm: patientHeightcm,monthsintotal: monthsintotal},
            url: "paediatrics/HFAobservationboys.htm",
            success: function (respose) {
                if(respose==='Normal'){
                    document.getElementById('heightlengthboysb').innerHTML="Normal";
                }
                else if(respose==='Stunted'){
                    document.getElementById('heightlengthboysb').innerHTML="Stunted";
                }
                else if(respose==='Severely Stunted'){
                    document.getElementById('heightlengthboysb').innerHTML="Severely Stunted";
                }
                else if(respose==='Very Tall'){
                    document.getElementById('heightlengthboysb').innerHTML="Very Tall";
                }
                else if(respose==='Tall'){
                    document.getElementById('heightlengthboysb').innerHTML="Tall";
                }else{
                     document.getElementById('heightlengthboysb').innerHTML="Invalid";
                }
            }
        });
        $.ajax({
            type: 'POST',
            data: {patientbmi: patientBIM2, monthsintotal: monthsintotal},
            url: "paediatrics/BMIFAobservationboys.htm",
            success: function (respose) {
                if (respose === 'Obese') {
                    document.getElementById('bmiboys').innerHTML = "Obese";

                } else if (respose === 'Over weight') {
                    document.getElementById('bmiboys').innerHTML = "Over weight";

                } else if (respose === 'Over Weight Risk') {
                    document.getElementById('bmiboys').innerHTML = "Over Weight Risk";

                } else if (respose === 'Normal') {
                    document.getElementById('bmiboys').innerHTML = "Normal";
                } else if (respose === 'Wasted') {
                    document.getElementById('bmiboys').innerHTML = "Wasted";

                } else if (respose === 'Severely Wasted') {
                    document.getElementById('bmiboys').innerHTML = "Severely Wasted";

                } else {
                    document.getElementById('bmiboys').innerHTML = "Invalid";
                }
            }
        });
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
                        if (parseInt(keyid) === parseInt(serviceid)) {
                            socketHTDMClinic.send(JSON.stringify(data));
                            $('#restore' + visitid).prop('disabled', true);
                            var nextVisit = parseInt($('#nextPatientH').val());
                            if (nextVisit < 1) {
                                var reset = {
                                    type: 'RESET',
                                    serviceid: serviceid
                                };
                                socketHTDMClinic.send(JSON.stringify(reset));
                            }
                        } else {
                            socketNormalClinic.send(JSON.stringify(data));
                            $('#restore' + visitid).prop('disabled', true);
                            var nextVisit = parseInt($('#nextPatient').val());
                            if (nextVisit < 1) {
                                var reset = {
                                    type: 'RESET',
                                    serviceid: serviceid
                                };
                                socketNormalClinic.send(JSON.stringify(reset));
                            }
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


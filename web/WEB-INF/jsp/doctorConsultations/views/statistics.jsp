<%-- 
    Document   : statistics
    Created on : Sep 25, 2018, 4:10:32 PM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<div class="col-md-3">
    <div class="card-counter primary">
        <i class="fa fa-male"></i><i class="fa fa-female"></i><i class="fa fa-child"></i>
        <span class="count-numbers text-success" id="serviced">-</span>
        <span class="count-name">Total Patients</span>
    </div>
</div>
<div class="col-md-2">
    <div class="card-counter primary fetchlab" onclick="viewPatientslabrequests();">
        <i class="fa fa-male"></i><i class="fa fa-female"></i><i class="fa fa-child"></i>
        <span class="count-numbers" id="labrequests">-</span>
        <span class="count-name">Lab Requests</span>
    </div>
</div>
<div class="col-md-2">
    <div class="card-counter info fetchlab" onclick="viewPatientsabresultsback();">
        <i class="fa fa-male"></i><i class="fa fa-female"></i><i class="fa fa-child"></i>
        <span class="count-numbers" id="labresults">-</span>
        <span class="count-name">Lab Results</span>
    </div>
</div>
<div class="col-md-2">
    <div class="card-counter info" id="fetchCanceled" onclick="fetchCanceledPatients()" title="Not In Queue">
        <i class="fa fa-close danger"></i>
        <span class="count-numbers text-danger" id="canceled-count">-</span>
        <!--<span class="count-name">Canceled</span>-->
        <span class="count-name">NIQ</span>
    </div>
</div>
<div class="col-md-3">
    <div class="card-counter info">
        <i class="fa fa-clock-o info"></i>
        <span class="count-numbers text-info" id="waitingTime">-</span>
        <span class="count-name">Average Waiting Time</span>
    </div>
</div>
<script>
    function viewPatientsabresultsback() {
        $.ajax({
            type: 'GET',
            data: {},
            url: "doctorconsultation/viewPatientslaboratoryresultsback.htm",
            success: function (data) {
                window.location = '#patientsfromlaboratoryfortesting';
                $('#laboratorylabpatientsdiv').html(data);
                initDialog('Patientsfromlaboratoryfortests');
            }
        });
    }
    function viewPatientslabrequests() {
        $.ajax({
            type: 'GET',
            data: {},
            url: "doctorconsultation/viewpatientslabrequests.htm",
            success: function (data) {
                window.location = '#patientstolaboratorytesting';
                $('#patientstolaboratorysdiv').html(data);
                initDialog('patientstolaboratorytests');
            }
        });
    }
    function viewpatientprescriptions() {
        $.ajax({
            type: 'GET',
            data: {},
            url: "doctorconsultation/viewpatientmadeprescriptions.htm",
            success: function (data) {
                $.confirm({
                    title: 'PRESCRIBED PATIENTS',
                    content: '' + data,
                    closeIcon: true,
                    type: 'purple',
                    boxWidth: '80%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        close: function () {

                        }
                    }
                });
            }
        });
    }
</script>
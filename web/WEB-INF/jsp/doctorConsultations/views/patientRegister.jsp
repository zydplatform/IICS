<%-- 
    Document   : patientRegister
    Created on : Oct 7, 2018, 11:14:44 AM
    Author     : HP
--%>
<div class="row">
    <div class="form-group col-md-3">
        <label for="sDate">Select Date</label>
        <div class="input-group">
            <input style=" margin-bottom: 2%" class="form-control col-md-10" id="reportPatientDateConsultation" type="text" placeholder="DD-MM-YYYY"/>
        </div>
    </div>
    <div class="form-group col-md-3">
        <label for="">Select Type</label>
        <select class="form-control" id="filteredserviceType">
            <option value="allPatients">All</option>
            <option value="attended">Attended</option>
            <option value="unattended">Un Attended</option>
        </select>
    </div>
    <div class="col-md-3 col-sm-1" style="margin-left: 0%; margin-top: 21px;">
        <button class="btn btn-primary" onclick="ConsreportPatientDate()" type="button">
            <i class="fa fa-lg fa-fw fa-search"></i>
        </button>
    </div>

</div>
<div id="patientRegisterClinicianDiv">

</div>
<div class="row">
    <div class="col-md-12">
        <div id="servicedpatients" class="prescriptionDiaolog servicedprescribedpatient">
            <div>
                <div id="head">
                    <a href="#close" title="Close Patient" class="close2" style="display: block; width: 93px;">Close</a>
                    <h2 class="modalDialog-title" id="titleoralprescribeheading">Patient Details</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div id="servicedprescribediv">

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
    var serverDate = '${serverdate}';
    $(document).ready(function () {
        $("#reportPatientDateConsultation").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });
        var reportdate = $('#reportPatientDateConsultation').val();
        var type4 = $('#filteredserviceType').val();
        if (reportdate !== '') {
            $('#patientRegisterClinicianDiv').html('');
            $.ajax({
                type: 'GET',
                data: {date: reportdate,type:type4, act: 'b'},
                url: 'doctorconsultation/gettodaysreceivedpatients.htm',
                success: function (report) {
                    $('#patientRegisterClinicianDiv').html(report);
                }
            });
        }
    });

    function ConsreportPatientDate() {
        var reportdate = $('#reportPatientDateConsultation').val();
        var type2 = $('#filteredserviceType').val();
        if (reportdate !== '') {
            $('#patientRegisterClinicianDiv').html('');
            $.ajax({
                type: 'GET',
                data: {date: reportdate,type:type2, act: 'b'},
                url: 'doctorconsultation/gettodaysreceivedpatients.htm',
                success: function (report) {
                    $('#patientRegisterClinicianDiv').html(report);
                }
            });
        }
    }
</script>

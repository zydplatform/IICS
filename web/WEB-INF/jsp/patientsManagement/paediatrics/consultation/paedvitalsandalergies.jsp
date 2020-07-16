<%-- 
    Document   : paedvitalsandalergies
    Created on : Nov 5, 2018, 2:04:49 PM
    Author     : user
--%>
<style>
    #range{
        margin-bottom: 2em;
    }
    #rangeone{
        margin-bottom: 1em;
    }

</style>
<%@include file="../../../include.jsp" %>
<input type="hidden" id="paedgender">
<input type="hidden" id="paedconsultationtotalmonths">
<input type="hidden" id="zscoresidpaed">
<div id="consultationbelow5" style="display: none">
    <div class="row">
        <div class="col-md-6">
            <fieldset>
                <legend>Patient Vitals</legend>
                <table class="table table-hover table-bordered" id="patientvitalsstable" style="width: 100% !important;">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Vital Name</th>
                            <th>Vital Measure</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>Blood Pressure (mmHg)</td>
                            <td align="center" id="bloodpressuretd">
                                <c:choose>
                                    <c:when test="${systolic == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${systolic}/${diastolic} mmHg
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updatebloodpressurevitals(${systolic},${diastolic}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Weight (kg)</td>
                            <td align="center" id="weighttd">
                                <c:choose>
                                    <c:when test="${weight == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        <span id="wwweight">${weight}</span> kg
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updateweightvitals(${weight}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Height (cm)</td>
                            <td align="center" id="heighttd">
                                <c:choose>
                                    <c:when test="${height == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${height} cm
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updateheightvitals(${height}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>Temperature (Celc)</td>
                            <td align="center" id="temperaturetd">
                                <c:choose>
                                    <c:when test="${temperature == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${temperature} Celc
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updatetemperaturevitals(${temperature}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>Body Surface Area (cm)</td>
                            <td align="center" id="bodysurfaceareatd">
                                <c:choose>
                                    <c:when test="${bodysurfacearea == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${bodysurfacearea} cm
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updatebodysurfaceareavitals(${bodysurfacearea}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>6</td>
                            <td>Mid-Upper Arm Circumference</td>
                            <td align="center" id="headcircumtd">
                                <c:choose>
                                    <c:when test="${muac == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${muac} cm
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updatemuacvitals(${muac}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>7</td>
                            <td>Pulse (B/min)</td>
                            <td align="center" id="pulsetd">
                                <c:choose>
                                    <c:when test="${pulse == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${pulse} B/min
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updatepulsevitals(${pulse}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>8</td>
                            <td>Respiration Rate (B/min)</td>
                            <td align="center" id="respirationratetd">
                                <c:choose>
                                    <c:when test="${respirationrate == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${respirationrate} B/min
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updaterespirationratevitals(${respirationrate}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                    </tbody>
                </table>
            </fieldset> 
        </div>
        <div class="col-md-6">
            <fieldset>
                <legend>Z-score Measurements</legend>
                <div class="row">

                    <div class="col-md-6">
                        <div class="card-counter info">
                            <i class="fa fa-stumbleupon info icon-color"></i>
                            <span class="numbers text-info">${wfazscore}</span>
                            <span class="count-name" >Weight For Age</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card-counter info">
                            <i class="fa fa-stumbleupon info icon-color"></i>
                            <span class="numbers text-info">${hfazscore}</span>
                            <span class="count-name" >Height For Age</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="card-counter info">
                            <i class="fa fa-stumbleupon info icon-color"></i>
                            <span class="numbers text-info">${wfhzscore}</span>
                            <span class="count-name" >Weight For Height</span>
                        </div>

                    </div>
                    <div class="col-md-6">
                        <div class="card-counter info">
                            <i class="fa fa-stumbleupon info icon-color"></i>
                            <span class="numbers text-info">${bmi}</span>
                            <span class="count-name" >BMI</span>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-bottom: 7em">
                    <div class="col-md-8">
                        <div class="form-group row">
                            <div class="col-sm-8">
                                <textarea class="form-control exampleFormControlTextarea1 pull-left" id="savepatientstriageaddednote" placeholder="Add Notes" rows="1"></textarea>
                            </div>
                            <input for="exampleFormControlTextarea1" onclick="savepatienttriageaddednotes();" type="button" value="Add Notes" class="col-sm-4 btn btn-primary">
                        </div>
                    </div>
                </div>
                            <div class="row">
                    <div class="col-md-12">
                        <button class="btn btn-primary icon-btn pull-right" onclick="" id="nutritionbtn4">
                            <i class="fa fa-plus"></i>Enroll to Nutrition
                        </button>
                    </div>
                </div>
            </fieldset> 
        </div>
    </div>
</div>
<div id="consultationabove5" style="display: none">
    <div class="row">
        <div class="col-md-6">
            <fieldset>
                <legend>Patient Vitals</legend>
                <table class="table table-hover table-bordered" id="patientvitalsstable" style="width: 100% !important;">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Vital Name</th>
                            <th>Vital Measure</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>Blood Pressure (mmHg)</td>
                            <td align="center" id="bloodpressuretd">
                                <c:choose>
                                    <c:when test="${systolic == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${systolic}/${diastolic} mmHg
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updatebloodpressurevitals(${systolic},${diastolic}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Weight (kg)</td>
                            <td align="center" id="weighttd">
                                <c:choose>
                                    <c:when test="${weight == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        <span id="wwweight">${weight}</span> kg
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updateweightvitals5(${weight}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Height (cm)</td>
                            <td align="center" id="heighttd">
                                <c:choose>
                                    <c:when test="${height == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${height} cm
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updateheightvitals5(${height}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>Temperature (Celc)</td>
                            <td align="center" id="temperaturetd">
                                <c:choose>
                                    <c:when test="${temperature == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${temperature} Celc
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updatetemperaturevitals(${temperature}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>Body Surface Area (cm)</td>
                            <td align="center" id="bodysurfaceareatd">
                                <c:choose>
                                    <c:when test="${bodysurfacearea == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${bodysurfacearea} cm
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updatebodysurfaceareavitals(${bodysurfacearea}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>6</td>
                            <td>Mid-Upper Arm Circumference</td>
                            <td align="center" id="headcircumtd">
                                <c:choose>
                                    <c:when test="${muac == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${muac} cm
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updatemuacvitals(${muac}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>7</td>
                            <td>Pulse (B/min)</td>
                            <td align="center" id="pulsetd">
                                <c:choose>
                                    <c:when test="${pulse == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${pulse} B/min
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updatepulsevitals(${pulse}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                        <tr>
                            <td>8</td>
                            <td>Respiration Rate (B/min)</td>
                            <td align="center" id="respirationratetd">
                                <c:choose>
                                    <c:when test="${respirationrate == 0}">
                                        <strong>
                                            <a href="#"><font color="blue">Pending</font></a>
                                        </strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${respirationrate} B/min
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="center"><span  title="Update Of This Item." onclick="updaterespirationratevitals(${respirationrate}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                        </tr>
                    </tbody>
                </table>
            </fieldset> 
        </div>
        <div class="col-md-6">
            <fieldset>
                <legend>Z-score Measurements</legend>
                <div class="row">
                    <div class="col-md-6">
                        <div class="card-counter info">
                            <i class="fa fa-stumbleupon info icon-color"></i>
                            <c:choose>
                                <c:when test="${wfazscore == ''}">
                                    <span class="numbers text-info">Patient is below 10 years.</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="numbers text-info">${wfazscore}</span>
                                </c:otherwise>
                            </c:choose>
                            <span class="numbers count-name" >Weight For Age</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card-counter info">
                            <i class="fa fa-stumbleupon info icon-color"></i>
                            <span class="numbers text-info">${hfazscore}</span>
                            <span class="count-name" >Height For Age</span>
                        </div>
                    </div>
                </div>
                <div class="row" >
                    <div class="col-md-6">
                        <div class="card-counter info">
                            <i class="fa fa-stumbleupon info icon-color"></i>
                            <span class="numbers text-info">${bmiforage}</span>
                            <span class="count-name" >BMI For Age</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card-counter info">
                            <i class="fa fa-stumbleupon info icon-color"></i>
                            <span class="numbers text-info" id="bmiforage">${bmi}</span>
                            <span class="count-name" >BMI</span>
                        </div>
                    </div>
                </div>

                <div class="row" style="margin-bottom: 7em">
                    <div class="col-md-8">
                        <div class="form-group row">
                            <div class="col-sm-8">
                                <textarea class="form-control exampleFormControlTextarea1 pull-left" id="savepatientstriageaddednote" placeholder="Add Notes" rows="1"></textarea>
                            </div>
                            <input for="exampleFormControlTextarea1" onclick="savepatienttriageaddednotes();" type="button" value="Add Notes" class="col-sm-4 btn btn-primary">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <button class="btn btn-primary icon-btn pull-right" onclick="" id="nutritionbtn5">
                            <i class="fa fa-plus"></i>Enroll to Nutrition
                        </button>
                    </div>
                </div>
            </fieldset> 
        </div>
    </div>
</div>
<script>
    $(document).ready (function (){
        document.getElementById('nutritionbtn4').disabled=true;
        document.getElementById('nutritionbtn5').disabled=true;
    });
    function updatebloodpressurevitals(systolic, diastolic, visitnumber) {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();
        var currentpressure = '';
        var currentpressuredia = '';
        if (systolic === 0) {
            currentpressure = '';
            currentpressuredia = '';

        } else {
            currentpressure = systolic;
            currentpressuredia = diastolic;
        }

        $.confirm({
            title: 'Edit Blood Pressure',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Systolic(mmHg)</label>' +
                    '<input type="number" placeholder="Enter Systolic" value="' + currentpressure + '" class="systolic form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Diastolic(mmHg)</label>' +
                    '<input type="text" placeholder="Enter Diastolic" value="' + currentpressuredia + '" class="diastolic form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var systolic = this.$content.find('.systolic').val();
                        var diastolic = this.$content.find('.diastolic').val();
                        if (!systolic) {
                            $.alert('provide a valid Systolic');
                            return false;
                        }
                        if (!diastolic) {
                            $.alert('provide a valid diastolic');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'pressure', systolic: systolic, diastolic: diastolic, patientvisitid: patientvisitid},
                            url: "paediatrics/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                        url: "paediatrics/patientinqueuedetails.htm",
                                        success: function (repos) {
                                            ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            $('#addprescribediv').html(repos);
                                        }
                                    });
                                }
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function updateweightvitals(weight, visitnumber) {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var zscoresidpaed = $('#zscoresidpaed').val();
        var patientid = $('#facilityvisitedPatientid').val();
        var paedgender = $('#paedgender').val();
        var paedconsultationtotalmonths = $('#paedconsultationtotalmonths').val();
        var currentweight = '';
        if (weight === 0) {
            currentweight = '';
        } else {
            currentweight = weight;
        }
        $.confirm({
            title: 'Edit Weight',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Weight(kg)</label>' +
                    '<input type="number" placeholder="Enter Weight" value="' + currentweight + '" class="weight form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var weight = this.$content.find('.weight').val();
                        if (!weight) {
                            $.alert('provide a valid Weight');
                            return false;
                        } else {
                            $.ajax({
                                type: 'POST',
                                data: {type: 'weight', patientvisitid: patientvisitid, weight: weight},
                                url: "paediatrics/updatepatientvisitvitals.htm",
                                success: function (data) {
                                    if (data === 'success') {
                                        if (paedgender === 'Male') {
                                            $.ajax({
                                                type: 'POST',
                                                data: {patientWeight: weight, monthsintotal: paedconsultationtotalmonths},
                                                url: "paediatrics/WFAobservationboys.htm",
                                                success: function (respose) {
                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {wfazscore: respose, zscoresidpaed: zscoresidpaed},
                                                        url: "paediatrics/updatewfazscore.htm",
                                                        success: function (respose) {
                                                            $.ajax({
                                                                type: 'GET',
                                                                data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                                url: "paediatrics/patientinqueuedetails.htm",
                                                                success: function (repos) {
                                                                    ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    $('#addprescribediv').html(repos);
                                                                }
                                                            });
                                                        }
                                                    });
                                                }
                                            });
                                        } else {
                                            $.ajax({
                                                type: 'POST',
                                                data: {patientWeight: weight, monthsintotal: paedconsultationtotalmonths},
                                                url: "paediatrics/WFAobservationgirls.htm",
                                                success: function (respose) {

                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {wfazscore: respose, zscoresidpaed: zscoresidpaed},
                                                        url: "paediatrics/updatewfazscore.htm",
                                                        success: function (respose) {
                                                            $.ajax({
                                                                type: 'GET',
                                                                data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                                url: "paediatrics/patientinqueuedetails.htm",
                                                                success: function (repos) {
                                                                    ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    $('#addprescribediv').html(repos);
                                                                }
                                                            });
                                                        }
                                                    });
                                                }
                                            });
                                        }
                                    }
                                }
                            });
                        }
                    }
                },
                close: function () {
                }
            }
        });

    }

    function updateweightvitals5(weight, visitnumber) {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();
        var paedgender = $('#paedgender').val();
        var paedconsultationtotalmonths = $('#paedconsultationtotalmonths').val();
        var currentweight = '';
        var zscoresidpaed = $('#zscoresidpaed').val();
        if (weight === 0) {
            currentweight = '';
        } else {
            currentweight = weight;
        }
        $.confirm({
            title: 'Edit Weight',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Weight(kg)</label>' +
                    '<input type="number" placeholder="Enter Weight" value="' + currentweight + '" class="weight form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var weight = this.$content.find('.weight').val();
                        if (!weight) {
                            $.alert('provide a valid Weight');
                            return false;
                        } else {
                            $.ajax({
                                type: 'POST',
                                data: {type: 'weight', patientvisitid: patientvisitid, weight: weight},
                                url: "paediatrics/updatepatientvisitvitals.htm",
                                success: function (data) {
                                    if (data === 'success') {
                                        if (paedgender === 'Male') {
                                            $.ajax({
                                                type: 'POST',
                                                data: {patientWeight: weight, monthsintotal: paedconsultationtotalmonths},
                                                url: "paediatrics/WFAobservationboys.htm",
                                                success: function (respose) {

                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {wfazscore: respose, zscoresidpaed: zscoresidpaed},
                                                        url: "paediatrics/updatewfazscore.htm",
                                                        success: function (respose) {
                                                            $.ajax({
                                                                type: 'GET',
                                                                data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                                url: "paediatrics/patientinqueuedetails.htm",
                                                                success: function (repos) {
                                                                    ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    $('#addprescribediv').html(repos);
                                                                }
                                                            });
                                                        }
                                                    });
                                                }
                                            });
                                        } else {
                                            $.ajax({
                                                type: 'POST',
                                                data: {patientWeight: weight, monthsintotal: paedconsultationtotalmonths},
                                                url: "paediatrics/WFAobservationgirls.htm",
                                                success: function (respose) {

                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {wfazscore: respose, zscoresidpaed: zscoresidpaed},
                                                        url: "paediatrics/updatewfazscore.htm",
                                                        success: function (respose) {
                                                            $.ajax({
                                                                type: 'GET',
                                                                data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                                url: "paediatrics/patientinqueuedetails.htm",
                                                                success: function (repos) {
                                                                    ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    $('#addprescribediv').html(repos);
                                                                }
                                                            });
                                                        }
                                                    });
                                                }
                                            });
                                        }
                                    }
                                }
                            });
                        }
                    }
                },
                close: function () {
                }
            }
        });

    }

    function updateheightvitals(height, visitnumber) {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();
        var paedgender = $('#paedgender').val();
        var paedconsultationtotalmonths = $('#paedconsultationtotalmonths').val();
        var weight = $('#wwweight').html();
        var currentheight = '';
        var zscoresidpaed = $('#zscoresidpaed').val();
        if (height === 0) {
            currentheight = '';
        } else {
            currentheight = height;
        }
        $.confirm({
            title: 'Edit Height',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Height(cm)</label>' +
                    '<input type="number" placeholder="Enter Height" value="' + currentheight + '" class="height form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var height = this.$content.find('.height').val();
                        if (!height) {
                            $.alert('provide a valid Height');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'height', patientvisitid: patientvisitid, height: height},
                            url: "paediatrics/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    if (paedgender === 'Male') {
                                        $.ajax({
                                            type: 'POST',
                                            data: {patientHeightcm: height, monthsintotal: paedconsultationtotalmonths},
                                            url: "paediatrics/HFAobservationboys.htm",
                                            success: function (respose) {
                                                $.ajax({
                                                    type: 'POST',
                                                    data: {hfazscore: respose, zscoresidpaed: zscoresidpaed},
                                                    url: "paediatrics/updatehfazscore.htm",
                                                    success: function (respose) {
                                                        $.ajax({
                                                            type: 'GET',
                                                            data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                            url: "paediatrics/patientinqueuedetails.htm",
                                                            success: function (repos) {
                                                                ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                $('#addprescribediv').html(repos);
                                                            }
                                                        });

                                                    }
                                                });
                                            }
                                        });
                                        if (weight !== '' && weight !== 'undefined' && weight !== 'Pending') {

                                            $.ajax({
                                                type: 'POST',
                                                data: {patientHeightcm: height, patientWeight: weight},
                                                url: "paediatrics/WFHobservationboys.htm",
                                                success: function (respose) {

                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {wfhzscore: respose, zscoresidpaed: zscoresidpaed},
                                                        url: "paediatrics/updatewfhzscore.htm",
                                                        success: function (respose) {
                                                            $.ajax({
                                                                type: 'GET',
                                                                data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                                url: "paediatrics/patientinqueuedetails.htm",
                                                                success: function (repos) {
                                                                    ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    $('#addprescribediv').html(repos);
                                                                }
                                                            });

                                                        }
                                                    });
                                                }
                                            });
                                        }
                                    } else {
                                        if (weight !== '' && weight !== 'undefined' && weight !== 'Pending') {
                                            $.ajax({
                                                type: 'POST',
                                                data: {patientHeightcm: height, patientWeight: weight},
                                                url: "paediatrics/WFHobservationgirls.htm",
                                                success: function (respose) {

                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {wfhzscore: respose, zscoresidpaed: zscoresidpaed},
                                                        url: "paediatrics/updatewfhzscore.htm",
                                                        success: function (respose) {
                                                            $.ajax({
                                                                type: 'GET',
                                                                data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                                url: "paediatrics/patientinqueuedetails.htm",
                                                                success: function (repos) {
                                                                    ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    $('#addprescribediv').html(repos);
                                                                }
                                                            });
                                                        }
                                                    });
                                                }
                                            });
                                        }
                                        $.ajax({
                                            type: 'POST',
                                            data: {patientHeightcm: height, monthsintotal: paedconsultationtotalmonths},
                                            url: "paediatrics/HFAobservationgirls.htm",
                                            success: function (respose) {
                                                $.ajax({
                                                    type: 'POST',
                                                    data: {hfazscore: respose, zscoresidpaed: zscoresidpaed},
                                                    url: "paediatrics/updatehfazscore.htm",
                                                    success: function (respose) {
                                                        $.ajax({
                                                            type: 'GET',
                                                            data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                            url: "paediatrics/patientinqueuedetails.htm",
                                                            success: function (repos) {
                                                                ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                $('#addprescribediv').html(repos);
                                                            }
                                                        });
                                                    }
                                                });
                                            }
                                        });
                                    }
                                }
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }

    function updateheightvitals5(height, visitnumber) {
        var bmiforage = $('#bmiforage').html();
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();
        var paedgender = $('#paedgender').val();
        var paedconsultationtotalmonths = $('#paedconsultationtotalmonths').val();
        var weight = $('#wwweight').html();
        var currentheight = '';
        var zscoresidpaed = $('#zscoresidpaed').val();
        if (height === 0) {
            currentheight = '';
        } else {
            currentheight = height;
        }
        $.confirm({
            title: 'Edit Height',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Height(cm)</label>' +
                    '<input type="number" placeholder="Enter Height" value="' + currentheight + '" class="height form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var height = this.$content.find('.height').val();
                        if (!height) {
                            $.alert('provide a valid Height');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'height', patientvisitid: patientvisitid, height: height},
                            url: "paediatrics/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    if (paedgender === 'Male') {
                                        $.ajax({
                                            type: 'POST',
                                            data: {patientHeightcm: height, monthsintotal: paedconsultationtotalmonths},
                                            url: "paediatrics/HFAobservationboys.htm",
                                            success: function (respose) {
                                                $.ajax({
                                                    type: 'POST',
                                                    data: {hfazscore: respose, zscoresidpaed: zscoresidpaed},
                                                    url: "paediatrics/updatehfazscore.htm",
                                                    success: function (respose) {
                                                        $.ajax({
                                                            type: 'GET',
                                                            data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                            url: "paediatrics/patientinqueuedetails.htm",
                                                            success: function (repos) {
                                                                ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                $('#addprescribediv').html(repos);
                                                            }
                                                        });

                                                    }
                                                });
                                            }
                                        });
                                        if (weight !== '' && weight !== 'undefined' && weight !== 'Pending') {

                                            $.ajax({
                                                type: 'POST',
                                                data: {patientbmi: bmiforage, monthsintotal: paedconsultationtotalmonths},
                                                url: "paediatrics/BMIFAobservationboys.htm",
                                                success: function (respose) {
                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {bmi: respose, zscoresidpaed: zscoresidpaed},
                                                        url: "paediatrics/updatebmi.htm",
                                                        success: function (respose) {
                                                            $.ajax({
                                                                type: 'GET',
                                                                data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                                url: "paediatrics/patientinqueuedetails.htm",
                                                                success: function (repos) {
                                                                    ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    $('#addprescribediv').html(repos);
                                                                }
                                                            });

                                                        }
                                                    });
                                                }
                                            });
                                        }
                                    } else {
                                        if (weight !== '' && weight !== 'undefined' && weight !== 'pending') {

                                            $.ajax({
                                                type: 'POST',
                                                data: {patientbmi: bmiforage, monthsintotal: paedconsultationtotalmonths},
                                                url: "paediatrics/BMIFAobservationgirls.htm",
                                                success: function (respose) {
                                                    $.ajax({
                                                        type: 'POST',
                                                        data: {bmi: respose, zscoresidpaed: zscoresidpaed},
                                                        url: "paediatrics/updatebmi.htm",
                                                        success: function (respose) {
                                                            $.ajax({
                                                                type: 'GET',
                                                                data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                                url: "paediatrics/patientinqueuedetails.htm",
                                                                success: function (repos) {
                                                                    ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                    $('#addprescribediv').html(repos);
                                                                }
                                                            });
                                                        }
                                                    });
                                                }
                                            });
                                        }
                                        $.ajax({
                                            type: 'POST',
                                            data: {patientHeightcm: height, monthsintotal: paedconsultationtotalmonths},
                                            url: "paediatrics/HFAobservationgirls.htm",
                                            success: function (respose) {
                                                $.ajax({
                                                    type: 'POST',
                                                    data: {hfazscore: respose, zscoresidpaed: zscoresidpaed},
                                                    url: "paediatrics/updatehfazscore.htm",
                                                    success: function (respose) {
                                                        $.ajax({
                                                            type: 'GET',
                                                            data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                                            url: "paediatrics/patientinqueuedetails.htm",
                                                            success: function (repos) {
                                                                ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                $('#addprescribediv').html(repos);
                                                            }
                                                        });
                                                    }
                                                });
                                            }
                                        });
                                    }
                                }
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }

    function updatetemperaturevitals(temperature, visitnumber) {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();

        var currenttemperature = '';
        if (temperature === 0) {
            currenttemperature = '';
        } else {
            currenttemperature = temperature;
        }
        $.confirm({
            title: 'Edit Temperature',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Temperature(Celc)</label>' +
                    '<input type="number" placeholder="Enter Temperature" value="' + currenttemperature + '" class="temperature form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var temperature = this.$content.find('.temperature').val();
                        if (!temperature) {
                            $.alert('provide a valid Temperature');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'temperature', patientvisitid: patientvisitid, temperature: temperature},
                            url: "paediatrics/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                        url: "paediatrics/patientinqueuedetails.htm",
                                        success: function (repos) {
                                            ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            $('#addprescribediv').html(repos);
                                        }
                                    });
                                }
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function updatebodysurfaceareavitals(bodysurfacearea, visitnumber) {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();

        var currentbodysurfacearea = '';
        if (bodysurfacearea === 0) {
            currentbodysurfacearea = '';
        } else {
            currentbodysurfacearea = bodysurfacearea;
        }
        $.confirm({
            title: 'Edit Body Surface Area',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Body Surface Area(cm)</label>' +
                    '<input type="number" placeholder="Enter Body Surface Area" value="' + currentbodysurfacearea + '" class="bodysurfacearea form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var bodysurfacearea = this.$content.find('.bodysurfacearea').val();
                        if (!bodysurfacearea) {
                            $.alert('provide a valid body surface area');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'bodysurfacearea', patientvisitid: patientvisitid, bodysurfacearea: bodysurfacearea},
                            url: "paediatrics/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                        url: "paediatrics/patientinqueuedetails.htm",
                                        success: function (repos) {
                                            ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            $('#addprescribediv').html(repos);
                                        }
                                    });
                                }
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function updatemuacvitals(muac, visitnumber) {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();

        var currentmuac = '';
        if (muac === 0) {
            currentmuac = '';
        } else {
            currentmuac = muac;
        }
        $.confirm({
            title: 'Edit Mid-Upper Arm Circumference',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>muac(cm)</label>' +
                    '<input type="number" placeholder="Enter muac" value="' + currentmuac + '" class="muac form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var Muac = this.$content.find('.muac').val();
                        if (!Muac) {
                            $.alert('provide a valid head circum');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'muac', patientvisitid: patientvisitid, Muac: Muac},
                            url: "paediatrics/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                        url: "paediatrics/patientinqueuedetails.htm",
                                        success: function (repos) {
                                            ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            $('#addprescribediv').html(repos);
                                        }
                                    });
                                }
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function updatepulsevitals(pulse, visitnumber) {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();

        var currentpulse = '';
        if (pulse === 0) {
            currentpulse = '';
        } else {
            currentpulse = pulse;
        }
        $.confirm({
            title: 'Edit Pulse',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Pulse(B/min)</label>' +
                    '<input type="number" placeholder="Enter Pulse" value="' + currentpulse + '" class="pulse form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var pulse = this.$content.find('.pulse').val();
                        if (!pulse) {
                            $.alert('provide a valid pulse');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'pulse', patientvisitid: patientvisitid, pulse: pulse},
                            url: "paediatrics/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                        url: "paediatrics/patientinqueuedetails.htm",
                                        success: function (repos) {
                                            ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            $('#addprescribediv').html(repos);
                                        }
                                    });
                                }
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function updaterespirationratevitals(respirationrate, visitnumber) {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();

        var currentrespirationrate = '';
        if (respirationrate === 0) {
            currentrespirationrate = '';
        } else {
            currentrespirationrate = respirationrate;
        }
        $.confirm({
            title: 'Edit Respiration Rate',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Respiration Rate(B/min)</label>' +
                    '<input type="number" placeholder="Enter Respiration Rate" value="' + currentrespirationrate + '" class="respirationrate form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var respirationrate = this.$content.find('.respirationrate').val();
                        if (!respirationrate) {
                            $.alert('provide a valid respiration rate');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'respirationrate', patientvisitid: patientvisitid, respirationrate: respirationrate},
                            url: "paediatrics/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
                                        url: "paediatrics/patientinqueuedetails.htm",
                                        success: function (repos) {
                                            ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'patientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            $('#addprescribediv').html(repos);
                                        }
                                    });
                                }
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
</script>
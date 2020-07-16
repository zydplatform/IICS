<%-- 
    Document   : patientVitalsAndAllergies
    Created on : Aug 19, 2018, 10:10:12 AM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<style>
    .reasonDetails{
        color: #0000ff;
        font-weight: bold;
    }
</style>
<div class="row">
    <div class="col-md-6">
        <fieldset>
            <legend>Patient Vitals</legend>
            <table class="table table-hover table-bordered" id="patientvitalsstable" style="width: 100% !important;">
                <thead>
                    <tr>
                        <th style="width: 10%">No</th>
                        <th style="width: 40%;">Vital Name</th>
                        <th style="width: 20%;">Vital Measure</th>
                        <th style="width: 50%;">Reason</th>
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
                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${systolic}/${diastolic} mmHg
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${PressureReason != null}">
                                    <a href="#" class="reasonDetails" data-toggle="modal" data-target="#reason-modal">${PressureReason}</a>
                                </c:when>
                                <c:otherwise>
                                    N/A
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
                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${weight} kg
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${weightReason != null}">
                                    <a href="#" class="reasonDetails" data-toggle="modal" data-target="#reason-modal">${weightReason}</a>
                                </c:when>
                                <c:otherwise>
                                    N/A
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
                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${height} cm
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                            <c:when test="${HeightReason != null}">
                                <a href="#" class="reasonDetails" data-toggle="modal" data-target="#reason-modal">${HeightReason}</a>
                            </c:when>
                                <c:otherwise>
                                    N/A
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
                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${temperature} Celc
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${TempReason != null}">
                                    <a href="#" class="reasonDetails" data-toggle="modal" data-target="#reason-modal">${TempReason}</a>
                                </c:when>
                                <c:otherwise>
                                    N/A
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
                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${bodysurfacearea} cm
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>N/A</td>
                        <td align="center"><span  title="Update Of This Item." onclick="updatebodysurfaceareavitals(${bodysurfacearea}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>Head Circum (cm)</td>
                        <td align="center" id="headcircumtd">
                            <c:choose>
                                <c:when test="${headcircum == 0}">
                                    <strong>
                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${headcircum} cm
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>N/A</td>
                        <td align="center"><span  title="Update Of This Item." onclick="updateheadcircumvitals(${headcircum}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                    </tr>
                    <tr>
                        <td>7</td>
                        <td>Pulse (B/min)</td>
                        <td align="center" id="pulsetd">
                            <c:choose>
                                <c:when test="${pulse == 0}">
                                    <strong>
                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${pulse} B/min
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>N/A</td>
                        <td align="center"><span  title="Update Of This Item." onclick="updatepulsevitals(${pulse}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                    </tr>
                    <tr>
                        <td>8</td>
                        <td>Respiration Rate (B/min)</td>
                        <td align="center" id="respirationratetd">
                            <c:choose>
                                <c:when test="${respirationrate == 0}">
                                    <strong>
                                        <a href="#" class="pending-link"><font color="blue">Pending</font></a>
                                    </strong>
                                </c:when>
                                <c:otherwise>
                                    ${respirationrate} B/min
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${RespirationReason != null}">
                                    <a href="#" class="reasonDetails" data-toggle="modal" data-target="#reason-modal">${RespirationReason}</a>
                                </c:when>
                                <c:otherwise>
                                    N/A
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="center"><span  title="Update Of This Item." onclick="updaterespirationratevitals(${respirationrate}, '${visitnumber}');" class="badge badge-info icon-custom"><i class="fa fa-edit"></i></span></td>
                    </tr>
                </tbody>
            </table>
            <div class="row">
                <div class="col-md-4"> 
                    <div class="form-group bs-component pull-left" >
                        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>BMI:</strong></span>&nbsp;
                        <strong>
                            <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${bmi}</strong></span>
                        </strong>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="form-group row">
                        <div class="col-sm-8">
                            <textarea class="form-control exampleFormControlTextarea1" id="savepatientstriageaddednote" placeholder="Add Notes" rows="1"></textarea>
                        </div>
                        <input for="exampleFormControlTextarea1" onclick="savepatienttriageaddednotes();" type="button" value="Add Notes" class="col-sm-4 btn btn-primary">
                    </div>
                </div>
            </div>
        </fieldset> 
    </div>
    <div class="col-md-6">
        <fieldset>
            <legend>Patient Allergies</legend>
            <div id="patientIssuesAndAllergiesDiv">

            </div>
        </fieldset> 
    </div>
</div>
<div class="modal fade" id="reason-modal" tabindex="-1" role="dialog" aria-labelledby="reason-modal" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="container" style="width:auto; padding: 1%;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <fieldset>
                                        <div>
                                            <label class="text-muted">Reason By:</label> 
                                            <label><strong><div>${reasonBy}</div></strong></label>                                                
                                        </div>
                                        <div>
                                            <label class="text-muted">E-mail Address:</label> 
                                            <label><strong><div>${email}</div></strong></label>                                                
                                        </div>
                                        <div>
                                            <label class="text-muted">Phone Contacts:</label> 
                                            <label><strong><div>${contacts}</div></strong></label>                                                
                                        </div>
                                        <div>
                                            <label class="text-muted">Unit:</label> 
                                            <label><strong><div>${reasonUnit}</div></strong></label>                                                
                                        </div>       
<!--                                        <div>
                                            <label class="text-muted">Added:</label> 
                                            <label><strong><div>${reasonAdded}</div></strong></label>                                                
                                        </div> -->
                                    </fieldset>
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
    $('a.pending-link').on('click', function(e){
        e.preventDefault();
        e.stopPropagation();
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
                    '<input type="text" placeholder="Enter Systolic" value="' + currentpressure + '" class="systolic form-control" required />' +
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
                            url: "doctorconsultation/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber,act:'b'},
                                        url: "doctorconsultation/patientinqueuedetails.htm",
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
        var patientid = $('#facilityvisitedPatientid').val();
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
                    '<input type="text" placeholder="Enter Weight" value="' + currentweight + '" class="weight form-control" required />' +
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
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'weight', patientvisitid: patientvisitid, weight: weight},
                            url: "doctorconsultation/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber,act:'b'},
                                        url: "doctorconsultation/patientinqueuedetails.htm",
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
    function updateheightvitals(height, visitnumber) {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();

        var currentheight = '';
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
                    '<input type="text" placeholder="Enter Height" value="' + currentheight + '" class="height form-control" required />' +
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
                            url: "doctorconsultation/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber,act:'b'},
                                        url: "doctorconsultation/patientinqueuedetails.htm",
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
                    '<input type="text" placeholder="Enter Temperature" value="' + currenttemperature + '" class="temperature form-control" required />' +
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
                            url: "doctorconsultation/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber,act:'b'},
                                        url: "doctorconsultation/patientinqueuedetails.htm",
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
                    '<input type="text" placeholder="Enter Body Surface Area" value="' + currentbodysurfacearea + '" class="bodysurfacearea form-control" required />' +
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
                            url: "doctorconsultation/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber,act:'b'},
                                        url: "doctorconsultation/patientinqueuedetails.htm",
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
    function updateheadcircumvitals(headcircum, visitnumber) {
        var patientvisitid = $('#facilityvisitPatientvisitid').val();
        var patientid = $('#facilityvisitedPatientid').val();

        var currentheadcircum = '';
        if (headcircum === 0) {
            currentheadcircum = '';
        } else {
            currentheadcircum = headcircum;
        }
        $.confirm({
            title: 'Edit Head Circum',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Head Circum(cm)</label>' +
                    '<input type="text" placeholder="Enter Head Circum" value="' + currentheadcircum + '" class="headcircum form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var headcircum = this.$content.find('.headcircum').val();
                        if (!headcircum) {
                            $.alert('provide a valid head circum');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {type: 'headcircum', patientvisitid: patientvisitid, headcircum: headcircum},
                            url: "doctorconsultation/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber,act:'b'},
                                        url: "doctorconsultation/patientinqueuedetails.htm",
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
                    '<input type="text" placeholder="Enter Pulse" value="' + currentpulse + '" class="pulse form-control" required />' +
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
                            url: "doctorconsultation/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber,act:'b'},
                                        url: "doctorconsultation/patientinqueuedetails.htm",
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
                    '<input type="text" placeholder="Enter Respiration Rate" value="' + currentrespirationrate + '" class="respirationrate form-control" required />' +
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
                            url: "doctorconsultation/updatepatientvisitvitals.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber,act:'b'},
                                        url: "doctorconsultation/patientinqueuedetails.htm",
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
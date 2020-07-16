<%-- 
    Document   : patientRegister
    Created on : Sep 6, 2018, 2:54:48 PM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<div class="app-title" id="">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>
    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', '', 'GET');"></a></li>
                    <li><a href="#" onclick="ajaxSubmitData('patient/patientmenu.htm', 'workpane', '', 'GET');">Patient Management</a></li>
                    <li class="last active"><a href="#">Patient Register</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<h4 class="center">Patient List</h4></br>
<div class="row">
    <div class="col-md-12">
        <div class="row">

            <div class="form-group col-md-3">
                <label for="">Select Unit</label>
                <select class="form-control" id="filteredFacilityUnitid2">
                    <option value="currentfacility2">All</option>
                    <c:forEach items="${facilityUnitsList2}" var="unit">
                        <option value="${unit.id}">${unit.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group col-md-3">
                <label for="sDate">Select Date</label>
                <div class="input-group">
                    <input style=" margin-bottom: 2%" class="form-control col-md-10" id="reportPatientDate" type="text" placeholder="DD-MM-YYYY"/>
                </div>
            </div>

            <div class="form-group col-md-3">
                <label for="">Select Visit Type</label>
                <select class="form-control" id="filteredVisitType">
                    <option value="allPatients">All</option>
                    <option value="NEWVISIT">New Visits</option>
                    <option value="REVISIT">Re-visits</option>
                </select>
            </div>

            <div class="col-md-3 col-sm-1" style="margin-left: 0%; margin-top: 28px;">
                <button class="btn btn-primary" onclick="functionreportPatientDate()" type="button">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>
<div class="tile">
    <div class="tile-body">
        <div class="col-md-12"  id="dayPatientReport"></div>
    </div>
</div>
<script>
    breadCrumb();
    var reportDate;
    var visitTypevalue;
    var selectedFacilityUnitid;
    var serverDate = '${serverdate}';
    $(document).ready(function () {
        $("#reportPatientDate").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });
        reportDate = $('#reportPatientDate').val();
        visitTypevalue = $('#filteredVisitType').val();
        $.ajax({
            type: 'POST',
            data: {date: reportDate, visittype: visitTypevalue},
            url: 'patient/viewFacilityRegisteredPatients.htm',
            success: function (report) {
                $('#dayPatientReport').html(report);
            }
        });
    });

    function functionreportPatientDate() {
        $('#dayPatientReport').html('');
        selectedFacilityUnitid = $('#filteredFacilityUnitid2').val();
        visitTypevalue = $('#filteredVisitType').val();
        reportDate = $('#reportPatientDate').val();
        if (selectedFacilityUnitid === 'currentfacility2') {
            $.ajax({
                type: 'GET',
                data: {date: reportDate, visittype: visitTypevalue},
                url: 'patient/patientsStatisticsRegisterListByFacility.htm',
                success: function (report) {
                    $('#dayPatientReport').html(report);
                }
            });
        } else {
            $.ajax({
                type: 'GET',
                data: {date: reportDate, unitid: selectedFacilityUnitid, visittype: visitTypevalue},
                url: 'patient/patientsRegisterStatisticsListByUnit.htm',
                success: function (report) {
                    $('#dayPatientReport').html(report);
                }
            });
        }
    }
</script>
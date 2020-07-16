<%-- 
    Document   : patientStatistics
    Created on : Sep 11, 2018, 6:07:27 AM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                    <li class="last active"><a href="#">Statistics</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
        <div class="row">
            <div class="form-group col-md-3">
                <label for="relationship">Select Unit</label>
                <select class="form-control" id="filteredFacilityUnitid" disabled="disabled">
                    <!-- <option value="currentfacility">All</option> -->
                    <c:forEach items="${facilityUnitsList}" var="unit">
                        <option value="${unit.id}" <c:if test="${unit.selected == true}">selected="selected"</c:if>>${unit.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3">
                <label for="sDate">Select Date</label>
                <div class="input-group">
                    <input style=" margin-bottom: 2%" class="form-control col-md-10" id="statisticsPatientDate" type="text" placeholder="DD-MM-YYYY"/>
                </div>
            </div>
            <div class="col-md-3 col-sm-1" style="margin-left: -4%; margin-top: 29px;">
                <button class="btn btn-primary" onclick="functionViewPatientStatisticsByDate()" type="button">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
    <div class="col-md-1"></div>
</div>
<div class="row">
    <div class="col-md-12"  id="facilityPatientStatistics">

    </div>
</div>
<script>
    breadCrumb();
    var statisticsReportDate;
    var selectedFacilityUnit;
    var serverDate = '${serverdate}';
    $(document).ready(function () {
        $("#statisticsPatientDate").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });
        //
        // $.ajax({
           // type: 'GET',
           // url: 'patient/viewPatientRegisterStatistics.htm',
           // success: function (report) {
           //     $('#facilityPatientStatistics').html(report);
           //  }
        // });
        $('#facilityPatientStatistics').html('');
        statisticsReportDate = $('#statisticsPatientDate').val();
        selectedFacilityUnit = $('#filteredFacilityUnitid').val();
        
        $.ajax({
            type: 'GET',
            data: {date: statisticsReportDate, unitid: selectedFacilityUnit},
            url: 'patient/viewPatientsStatisticsByUnit.htm',
            success: function (report) {
                $('#facilityPatientStatistics').html(report);
            }
        });
    });

    function functionViewPatientStatisticsByDate() {
        $('#facilityPatientStatistics').html('');
        statisticsReportDate = $('#statisticsPatientDate').val();
        selectedFacilityUnit = $('#filteredFacilityUnitid').val();
        if (selectedFacilityUnit === 'currentfacility') {
            $.ajax({
                type: 'GET',
                data: {date: statisticsReportDate},
                url: 'patient/viewPatientsStatisticsByFacility.htm',
                success: function (report) {
                    $('#facilityPatientStatistics').html(report);
                }
            });
        } else {
            $.ajax({
                type: 'GET',
                data: {date: statisticsReportDate, unitid: selectedFacilityUnit},
                url: 'patient/viewPatientsStatisticsByUnit.htm',
                success: function (report) {
                    $('#facilityPatientStatistics').html(report);
                }
            });
        }
    }
</script>
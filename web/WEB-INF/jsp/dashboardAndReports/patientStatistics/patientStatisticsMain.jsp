<%-- 
    Document   : patientStatisticsMain
    Created on : Mar 1, 2019, 4:58:08 PM
    Author     : IICS
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
                    <li><a href="#!" onclick="ajaxSubmitData('dashboard/loadDashboardMenu.htm', 'workpane', '', 'GET');">Dashboard & Reports</a></li>
                    <li class="last active"><a href="#">Patient Statistics</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<br />
<div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
        <div class="row">
            <div class="form-group col-md-3">
                <label for="relationship">Select Unit</label>
                <select class="form-control" id="filteredFacilityUnitid">
                    <option value="currentfacility">All</option>
                    <c:forEach items="${facilityUnitsList}" var="unit">                        
                        <option value="${unit.id}">${unit.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3">
                <label for="start-date">Start Date</label>
                <div class="input-group">
                    <input style=" margin-bottom: 2%" class="form-control col-md-10" id="start-date" type="text" placeholder="DD-MM-YYYY"/>
                </div>
            </div>
            <div class="col-md-3">
                <label for="end-date">End Date</label>
                <div class="input-group">
                    <input style=" margin-bottom: 2%" class="form-control col-md-10" id="end-date" type="text" placeholder="DD-MM-YYYY"/>
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
    var serverDate = '${serverdate}';
    breadCrumb();
    var statisticsReportDate;
    var selectedFacilityUnit;
    $(document).ready(function () {
        $("#start-date").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });
        $("#end-date").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });        
        var startDate = $('#start-date').val();
        var endDate = $('#end-date').val();
        $.ajax({
            type: 'GET',
            // url: 'dashboard/viewfacilitypatientstatistics.htm',
            data: {startDate: startDate, endDate: endDate},
            url: 'dashboard/viewpatientsstatisticsrangebyfacility.htm',
            success: function (report) {
                $('#facilityPatientStatistics').html(report);
            }
        });        
    });

    function functionViewPatientStatisticsByDate() {
        $('#facilityPatientStatistics').html('');
        var startDate = $('#start-date').val();
        var endDate = $('#end-date').val();
        selectedFacilityUnit = $('#filteredFacilityUnitid').val();
        if (selectedFacilityUnit === 'currentfacility') {
            $.ajax({
                type: 'GET',
                data: {startDate: startDate, endDate: endDate},
                url: 'dashboard/viewpatientsstatisticsrangebyfacility.htm',
                success: function (report) {
                    $('#facilityPatientStatistics').html(report);
                }
            });
        } else {
            $.ajax({
                type: 'GET',
                data: {startDate: startDate, endDate: endDate, unitid: selectedFacilityUnit},
                url: 'dashboard/viewpatientsstatisticsrangebyunit.htm',
                success: function (report) {
                    $('#facilityPatientStatistics').html(report);
                }
            });
        }
    }
</script>
<%-- 
    Document   : attendanceNoRange
    Created on : Apr 9, 2019, 10:58:27 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="row">
                <div class="form-group col-md-3 col-sm-5">
                    <label for="unit-no-range">Unit</label>
                    <select class="form-control" id="unit-no-range" name="unit-no-range">
                        <c:forEach items="${units}" var="unit">
                            <option value="${unit.id}">${unit.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3 col-sm-5">
                    <form>
                        <div class="form-group">
                            <label for="date">Start Date</label>
                            <input class="form-control" id="date" type="text" placeholder="dd-mm-yyyy">
                        </div>
                    </form>
                </div>
                <div class="col-md-3 col-sm-1">
                    <button class="btn btn-primary" id="fetch-patient-attendance-no-range">
                        <i class="fa fa-lg fa-fw fa-search"></i>
                    </button>
                </div>
            </div>
            <div class="tile" id="no-range-summary"></div>
        </div>
    </div>
</div>
<script>
    var serverDate = '${serverdate}';
    $(document).ready(function () {
        $("#date").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });
        fetchPatientAttendanceNoRange();
    });
    function fetchPatientAttendanceNoRange() {
        $('#no-range-summary').html('');
        var unit = parseInt($('#unit-no-range').val());
        var start = ($('#date').val()).toString();
        var data = {
            unit:unit,
            date: start
        };
        $.ajax({
            type: 'POST',
            data: data,
            url: 'dashboard/fetchDailyStaffPerformance.htm',
            success: function (response) {
                $('#no-range-summary').html(response);
            }
        });
    }
</script>
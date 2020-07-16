<%-- 
    Document   : attendanceRange
    Created on : Apr 9, 2019, 10:52:04 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="row">
                <div class="form-group col-md-3">
                    <label for="unit">Unit</label>
                    <select class="form-control" id="unit" name="unit">
                        <c:forEach items="${units}" var="unit">
                            <option value="${unit.id}">${unit.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2 col-sm-4">
                    <form>
                        <div class="form-group">
                            <label for="sDate">Start Date</label>
                            <input class="form-control" id="sDate" type="text" placeholder="dd-mm-yyyy">
                        </div>
                    </form>
                </div>
                <div class="col-md-3 col-sm-4">
                    <form>
                        <div class="form-group">
                            <label for="eDate">End Date</label>
                            <input class="form-control" id="eDate" type="text"  placeholder="dd-mm-yyyy">
                        </div>
                    </form>
                </div>
                <div class="col-md-3 col-sm-1">
                    <button class="btn btn-primary" id="fetch-patient-attendance-range">
                        <i class="fa fa-lg fa-fw fa-search"></i>
                    </button>
                </div>
            </div>
            <div class="tile" id="range-summary"></div>
        </div>
    </div>
</div>
<script>
    var serverDate = '${serverdate}';
    $(function () {
        breadCrumb();
        $("#sDate").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: '01-' + parseInt(new Date(serverDate).getMonth() + 1) + '-' + parseInt(parseInt(new Date(serverDate).getYear()) + 1900)
        });
        $('#eDate').datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });
        fetchPatientAttendanceRange();
    });
    
    function fetchPatientAttendanceRange() {
        $('#range-summary').html('');
        var unit = parseInt($('#unit').val());
        var end = ($('#eDate').val()).toString();
        var start = ($('#sDate').val()).toString();
        var data = {
            unit:unit,
            enddate: end,
            startdate: start
        };
        $.ajax({
            type: 'POST',
            data: data,
            url: 'dashboard/patientattendancerange.htm',
            success: function (response) {
                $('#range-summary').html(response);
            },
            error: function (jqXHR, textStatus, errorThrown) {
               console.log(jqXHR);
               console.log(textStatus);
               console.log(errorThrown);
            }
        });
    }
</script>
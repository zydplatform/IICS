<%-- 

    Created on : Oct 15, 2018, 7:55:13 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-2">
                <form>
                    <div class="form-group">
                        <label for="">Select Date</label>
                        <input class="form-control" id="reportApprovedDate" type="text" placeholder="DD-MM-YYYY">
                    </div>
                </form>
            </div>
            <div class="col-md-2" style="margin-top: 21px; margin-left: -1%;">
                <button class="btn btn-primary" id="" type="button" onclick="functionreportIApprovedDrugs()">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12"  id="approvedDrugsContent"></div>
</div>

<script>
    $('#table-view-items-dispensed').DataTable();

    var reportApprovedDate;
    $(document).ready(function () {
        $("#reportApprovedDate").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(),
            defaultDate: new Date()
        });
        reportApprovedDate = $('#reportApprovedDate').val();
        $.ajax({
            type: 'GET',
            data: {date: reportApprovedDate},
            url: 'dispensing/readyDrugsToIssue.htm',
            success: function (report) {
                $('#approvedDrugsContent').html(report);
            }
        });
    });

    function functionreportIApprovedDrugs() {
        reportApprovedDate = $('#reportApprovedDate').val();
        $('#approvedDrugsContent').html('');
        $.ajax({
            type: 'GET',
            data: {date: reportApprovedDate},
            url: 'dispensing/readyDrugsToIssue.htm',
            success: function (report) {
                $('#approvedDrugsContent').html(report);
            }
        });
    }
</script>
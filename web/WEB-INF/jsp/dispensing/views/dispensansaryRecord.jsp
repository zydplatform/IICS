<%-- 
    Document   : dispensedDrugsView
    Created on : Oct 12, 2018, 10:20:31 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp"%>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-2">
                <form>
                    <div class="form-group">
                        <label for="">Select Date</label>
                        <input class="form-control" id="reportIssuedDate" type="text" placeholder="DD-MM-YYYY">
                    </div>
                </form>
            </div>
            <div class="col-md-2" style="margin-top: 21px; margin-left: -1%;">
                <button class="btn btn-primary" id="" type="button" onclick="functionreportIDispensedDrugs()">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12"  id="issuedDrugsContent"></div>
</div>


<script>
    var reportIssuedDate;
    $(document).ready(function () {
        $("#reportIssuedDate").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(),
            defaultDate: new Date()
        });
        reportIssuedDate = $('#reportIssuedDate').val();
        $.ajax({
            type: 'POST',
            data: {date: reportIssuedDate},
            url: 'dispensing/IssuedDispensedDrugs.htm',
            success: function (report) {
                $('#issuedDrugsContent').html(report);
            }
        });
    });
    
    function functionreportIDispensedDrugs() {
        reportIssuedDate = $('#reportIssuedDate').val();
        $('#issuedDrugsContent').html('');
        $.ajax({
            type: 'POST',
            data: {date: reportIssuedDate},
            url: 'dispensing/IssuedDispensedDrugs.htm',
            success: function (report) {
                $('#issuedDrugsContent').html(report);
            }
        });
    }
</script>
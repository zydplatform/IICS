<%-- 
    Document   : performancePane
    Created on : Oct 18, 2018, 9:33:39 AM
    Author     : IICS
--%>

<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="row">
                <div class="col-md-3 col-sm-5">
                    <form>
                        <div class="form-group">
                            <label for="date">Start Date</label>
                            <input class="form-control" id="date" type="text" placeholder="dd-mm-yyyy">
                        </div>
                    </form>
                </div>
                <div class="col-md-3 col-sm-1">
                    <button class="btn btn-primary" id="fetchPatientstatistics" onclick="fetchDailyStaffPerformance()">
                        <i class="fa fa-lg fa-fw fa-search"></i>
                    </button>
                </div>
            </div>
            <div class="tile" id="dailyPerformanceSummary"></div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#date").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(serverDate)
        });
    });
    
    function fetchDailyStaffPerformance() {
        $('#dailyPerformanceSummary').html('');
        var unit = parseInt(${unit});
        var start = ($('#date').val()).toString();
        var data = {
            unit: unit,
            date: start
        };
        $.ajax({
            type: 'POST',
            data: data,
            url: 'dashboard/fetchDailyStaffPerformance.htm',
            success: function (response) {
                $('#dailyPerformanceSummary').html(response);
            }
        });
    }
</script>
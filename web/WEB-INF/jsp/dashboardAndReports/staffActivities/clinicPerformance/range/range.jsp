<%-- 
    Document   : range
    Created on : Oct 18, 2018, 2:17:51 PM
    Author     : IICS
--%>

<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="row">
                <div class="form-group col-md-3">
                    <label for="relationship">Unit</label>
                    <select class="form-control" id="unit">
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
                    <button class="btn btn-primary" id="fetchPatientstatistics" onclick="fetchStaffPerformance()">
                        <i class="fa fa-lg fa-fw fa-search"></i>
                    </button>
                </div>
            </div>
            <div class="tile" id="performanceSummary"></div>
        </div>
    </div>
</div>
<script>
    var serverDate = '${serverdate}';
    $(document).ready(function () {
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
        fetchStaffPerformance();
    });
    
    function fetchStaffPerformance() {
        $('#performanceSummary').html('');
        var unit = parseInt($('#unit').val());
        var end = ($('#eDate').val()).toString();
        var start = ($('#sDate').val()).toString();
        var data = {
            unit:unit,
            end: end,
            start: start
        };
        $.ajax({
            type: 'POST',
            data: data,
            url: 'dashboard/fetchPatientStaffPerformance.htm',
            success: function (response) {
                $('#performanceSummary').html(response);
            }
        });
    }
</script>
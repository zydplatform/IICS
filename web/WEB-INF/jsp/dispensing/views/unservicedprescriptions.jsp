<%-- 
    Document   : unservicedprescriptions
    Created on : Aug 30, 2019, 9:19:53 AM
    Author     : IICS TECHS
--%>
<%@include file="../../include.jsp"%>

<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-5 col-sm-6 text-right"  style="line-height: 2.50em;">                
                <label for="selected-date">Date: </label>
            </div>
            <div class="col-md-2 col-sm-4">
                <form>
                    <div class="form-group">
                        <input class="form-control" id="selected-date" name="selected-date" type="text" placeholder="DD-MM-YYYY">
                    </div>
                </form>
            </div>
            <div class="col-md-2 col-sm-1">
                <button class="btn btn-primary" id="search-unserviced-prescriptions" type="button" style="margin-top: auto; margin-bottom: auto;">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>  

<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered" id="unserviced-prescriptions-table">
            <thead>
            <th>No.</th>
            <th>Prescription</th>
            <th>Reference</th>
            <th>Origin Unit</th>
            <th>Prescriber</th>
            <th>Time Received</th>
            <!--<th>Action</th>-->
            </thead>
            <tbody>
                <c:forEach items="${unservicedprescriptions}" var="prescription">
                    <tr>
                        <td></td>
                        <td>${prescription.patientname}</td>
                        <td>${prescription.referencenumber}</td>
                        <td>${prescription.originunit}</td>
                        <td>${prescription.prescriber}</td>
                        <td>${prescription.timein}</td>
                        <!--<td></td>-->
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot></tfoot>
        </table>
    </div>
</div>
<script>
    var serverDate = '${serverdate}';
    var selecteddate = '${selecteddate}';
    $("#selected-date").datetimepicker({
        pickTime: false,
        format: "DD-MM-YYYY",
        maxDate: new Date(serverDate),
        defaultDate: new Date(selecteddate)
    });
    if (!$.fn.DataTable.isDataTable('#unserviced-prescriptions-table')) {
        var table = $('#unserviced-prescriptions-table').DataTable();
        table.on('order.dt search.dt', function () {
            table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
    }
    $('#search-unserviced-prescriptions').on('click', function () {        
        var v = $('#selected-date').val().split('-');
        var date = v[2] + '-' + v[1] + '-' + v[0];
        navigateTo('unserviced-prescriptions', null, new Date(date));
        $('#tab9').prop('checked', true);
        $('#content9').attr('display', 'block');
    });
</script>
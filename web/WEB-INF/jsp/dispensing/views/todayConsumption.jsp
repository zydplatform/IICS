<%-- 
    Document   : todayConsumption
    Created on : Jul 3, 2019, 10:11:07 AM
    Author     : IICS TECHS
--%>
<%@include file="../../include.jsp"%>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-5 col-sm-6 text-right"  style="line-height: 2.50em;">                
                <label for="date-consumed">Date Consumed: </label>
            </div>
            <div class="col-md-2 col-sm-4">
                <form>
                    <div class="form-group">
                        <input class="form-control" id="date-consumed" name="date-consumed" type="text" placeholder="DD-MM-YYYY"/>
                    </div>
                </form>
            </div>
            <div class="col-md-2 col-sm-1">
                <button class="btn btn-primary" id="search-consumption" type="button" style="margin-top: auto; margin-bottom: auto;">
                    <i class="fa fa-lg fa-fw fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>  
<div class="row">
    <div class="col-md-8">
        <table class="table table-bordered" id="today-consumption-table">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Item Name</th>
                    <th>Quantity Dispensed</th>
                    <th>Stock Balance</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${todayconsumptions}" var="item">
                    <tr>
                        <td></td>
                        <td>${item.itemname}</td>
                        <td>${item.quantitydispensed}</td>
                        <td>${item.stockbalance}</td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot></tfoot>
        </table>
    </div>    
    <div class="col-md-4">
        <div class="tile">
            <div class="tile-body">
                <hr />
                <div><b>Serviced Prescriptions:</b> <span class="badge badge-info" style="font-size: small;">${totalissued} Of ${totalprescribed}</span></div>
                <c:forEach items="${percentages}" var="percentage">
                    <hr />
                    <div>${percentage.label} <span class="badge badge-info" style="font-size: small;">${percentage.count}</span></div>
                </c:forEach>                
<%--                <hr />
                <div><b>100% Serviced:</b> <span class="badge badge-info" style="font-size: small;">${serviced100}</span></div>
                <hr />
                <div><b>80% to 99% Serviced:</b> <span class="badge badge-info" style="font-size: small;">${serviced80to99}</span></div>
                <hr />
                <div><b>60% to 79% Serviced:</b> <span class="badge badge-info" style="font-size: small;">${serviced60to79}</span></div>
                <hr />
                <div><b>50% and below Serviced:</b> <span class="badge badge-info" style="font-size: small;">${serviced50andbelow}</span></div>--%>
            </div>
            <div class="tile-footer"></div>
        </div>        
    </div>
</div>

<script>
    var serverDate = '${serverdate}';
    $(function(){
        var dateconsumed = '${consumptiondate}';
        $("#date-consumed").datetimepicker({
            pickTime: false,
            format: "DD-MM-YYYY",
            maxDate: new Date(serverDate),
            defaultDate: new Date(dateconsumed)            
        });
        if (!$.fn.DataTable.isDataTable('#today-consumption-table')) {
            var table = $('#today-consumption-table').DataTable({
                "lengthMenu": [5,10, 25, 50, 100],
                "pageLength": 10
            });
            table.on('order.dt search.dt', function () {
                table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                    cell.innerHTML = i + 1;
                });
            }).draw();
        }
    });
    $('#search-consumption').on('click', function(){
        var v = $('#date-consumed').val().split('-');
        var date = v[2] + '-' + v[1] + '-' + v[0];
        navigateTo('today-consumption', null, new Date(date));               
        $('#tab8').prop('checked', true);
        $('#content8').attr('display', 'block');
    });
</script>    
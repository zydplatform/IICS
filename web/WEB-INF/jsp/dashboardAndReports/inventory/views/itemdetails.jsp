<%-- 
    Document   : itemdetails
    Created on : Oct 2, 2019, 11:03:12 AM
    Author     : IICS TECHS
--%>
<%@include file="../../../include.jsp"%>
<div class="row">
    <div class="col-md-12">
        <table id="item-details-table" class="table table-bordered">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Facility Unit Name</th>
                    <th>Quantity Received</th>
                    <th>Quantity Issued</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${items}" var="item">
                    <tr>
                        <td></td>
                        <td>${item.facilityunitname}</td>
                        <td>${item.quantityreceived}</td>
                        <td>${item.quantityissued}</td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot></tfoot>
        </table>
    </div>
</div>
<script>
    $(function(){
        if (!$.fn.DataTable.isDataTable('#item-details-table')) {
            var table = $('#item-details-table').DataTable({
                "lengthMenu": [5, 10, 25, 50, 100],
                "pageLength": 5
            });
            table.on('order.dt search.dt', function () {
                table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                    cell.innerHTML = i + 1;
                });
            }).draw();
        }
    });
</script>
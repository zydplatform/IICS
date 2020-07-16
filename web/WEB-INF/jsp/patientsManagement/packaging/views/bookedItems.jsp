<%-- 
    Document   : bookedItems
    Created on : Jul 1, 2019, 12:31:53 PM
    Author     : IICS TECHS
--%>
<%@include file="../../../include.jsp"%>

<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <table class="table table-bordered" id="booked-items-table">
            <thead>
                <tr>
                   <th>No.</th>
                   <th>Item Name</th>
                   <th>Quantity Booked</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${bookedItems}" var="item">
                    <tr>
                        <td></td>
                        <td>${item.itemname}</td>
                        <td>${item.qtybooked}</td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot></tfoot>
        </table>
    </div>
</div>

<script>    
    if (!$.fn.DataTable.isDataTable('#booked-items-table')) {
        var table = $('#booked-items-table').DataTable();
        table.on('order.dt search.dt', function () {
            table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
    }
</script>
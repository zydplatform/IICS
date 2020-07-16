<%-- 
    Document   : servicedItems
    Created on : Apr 12, 2019, 9:58:44 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp"%>

<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-title"></div>
            <div class="tile-body">
                <table id="service-items-table" class="table table-bordered">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Item</th>
                        <th>Status</th>
                        <th class="text-center">Quantity Dispensed</th>
                        <th>Batch Number(s)</th>
                        <th>Date Dispensed</th>                
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${serviceditems}" var="item">
                        <tr>
                            <td></td>
                            <td>${item.item}</td>
                            <td>${item.status}</td>
                            <td class="text-center">${item.quantitydispensed}</td>
                            <td>${item.batchnumbers}</td>
                            <td>${item.dateissued}</td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot></tfoot>
            </table>
            </div>
        </div>
    </div>
</div>

<script>
    $(function(){
        if (!$.fn.DataTable.isDataTable('#approvePrescriptionTable')) {
            var table = $('#service-items-table').DataTable();
            table.on( 'order.dt search.dt', function () {
                table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
                   cell.innerHTML = i+1;
               } );
            } ).draw();
        }
    });
</script>

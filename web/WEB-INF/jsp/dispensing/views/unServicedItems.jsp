<%-- 
    Document   : unServicedItems
    Created on : Apr 12, 2019, 10:01:22 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp"%>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-title">
<%--                <div style="font-size: 0.59em; display: inline-block; margin-right: 1%;"><span>Date Prescribed: </span><a href="#" style="color: #0000ff;">${unserviceditems.get(0).get("itemdateadded")}</a></div>--%>
<%--                <div style="font-size: 0.59em; display: inline-block; margin-right: 1%;"><span>Date Serviced: </span><a href="#" style="color: #0000ff;">${unserviceditems.get(0).get("reasondateadded")}</a></div>
                <div style="font-size: 0.59em; display: inline-block"><span> Serviced By: </span><a href="#" style="color: #0000ff;">${unserviceditems.get(0).get("addedby")}</a></div>--%>
            </div>
            <div class="tile-body">
                <table id="unservice-items-table" class="table table-bordered">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Item</th>
                        <th>Reason</th>               
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${unserviceditems}" var="item">
                        <tr>
                            <td></td>
                            <td>${item.item}</td>
                            <td>${item.reason}</td>
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
        if (!$.fn.DataTable.isDataTable('#unservice-items-table')) {
            var table = $('#unservice-items-table').DataTable({
                "lengthMenu": [ 5, 10, 25, 50, 100 ],
                "pageLength": 5
            });
            table.on( 'order.dt search.dt', function () {
                table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
                   cell.innerHTML = i+1;
               } );
            } ).draw();
        }
    });
</script>

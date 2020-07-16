<%--
    Document   : handOver
    Created on : Jul 4, 2018, 9:04:40 AM
    Author     : IICS-GRACE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp"%>
<div class="col-md-12">
    
        <h2 class="heading" id="colouredborders"></h2>
        <div class="itemBatches">
            <table class="table table-hover table-striped table-sm picklistheadertable" id="handover-table-data">
                <thead>
                    <tr>
                        <th class="">Item Name</th>
                        <th class="">Batch</th>
                        <th class="">Expiry Date</th>
                        <th class="left">Quantity Donated</th>
                        <th class="center">Quantity Taken</th>
                        <th class="right">Discrepancy</th>
                    </tr>
                </thead>
                <tbody id="handoverTableContent">
                    
                </tbody>
            </table>
        </div>
</div>
<div class="col-md-12 right"><hr/>
    <button id="btnhandoverdonoritems" class="btn btn-primary pull-right" type="button" disabled="false">
        <i class="fa fa-fw fa-lg fa-handshake-o"></i>Hand Over
    </button>
</div>
<script>

</script>
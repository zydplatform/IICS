<%-- 
    Document   : handOverOtherItems
    Created on : Oct 24, 2018, 9:39:44 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp"%>
<div class="col-md-12">
    <h2 class="heading" id="colouredborders"></h2>
    <div class="itemBatches">
        <table class="table table-hover table-striped table-sm picklistheadertable" id="otheritemhandover-table-data">
            <thead>
                <tr>
                    <th class="">Item Name</th>
                    <th class="">Specification</th>
                    <th class="left">Quantity Donated</th>
                    <th class="center">Quantity Taken</th>
                    <th class="right">Discrepancy</th>
                </tr>
            </thead>
            <tbody id="otheritemhandoverTableContent">

            </tbody>
        </table>
    </div>
</div>
<div class="col-md-12 right"><hr/>
    <button id="btnhandoverotherdonoritems" class="btn btn-primary pull-right" type="button" disabled="false">
        <i class="fa fa-fw fa-lg fa-handshake-o"></i>Hand Over
    </button>
</div>
<script>

</script>

<%-- 
    Document   : FacilityProcuredPlans
    Created on : May 10, 2018, 11:20:03 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered" id="tableFacilityfinancialyearsproc">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Financial Year</th>
                                    <th>Type</th>
                                    <th>Procurement Plans</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int j = 1;%>
                                <% int i = 1;%>
                                <c:forEach items="${facilityfinancialyears}" var="a">
                                    <tr>
                                        <td><%=j++%></td>
                                        <td>${a.financialyear}</td>
                                        <td>${a.orderperiodtype}</td>
                                        <td align="center">
                                            <button onclick="procuredprocurementplan(${a.facilityfinancialyearid}, '${a.orderperiodtype}');"  title=" The Procurement Plans Procured." class="btn btn-secondary btn-sm add-to-shelf">
                                                ${a.procurementscount} Procurement Plans
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="procuredprocurementplanview" class="supplierCatalogDialog">
            <div style="height: auto !important; ">
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="titlefinancialyrviewprocured">Procured Procurement Plans</h2>
                    <hr>
                </div>
                <div class="row" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <input id="procuredfacilityfinancialyearid" type="hidden">
                                    <div id="procuredprocurementplanviewdiv">

                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" align="right">
                                <button class="btn btn-primary" onclick="closedialogfunc4();">
                                    <i class="fa fa-check-circle"></i>
                                    close
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="facilityprocurementplan_itemzview" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document" >
                        <div class="modal-content" >
                            <div class="modal-header">
                                <h5 class="modal-title" id="title">Procurement Plan Items</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div id="procurementplan_itemzdiv">

                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12" align="right"   >
                                                <button class="btn btn-primary" data-dismiss="modal">
                                                    <i class="fa fa-check-circle"></i>
                                                    close
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#tableFacilityfinancialyearsproc').DataTable();
    function procuredprocurementplan(facilityfinancialyearid, orderperiodtype) {
        document.getElementById('procuredfacilityfinancialyearid').value = facilityfinancialyearid;
        ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredprocurementplansview.htm', 'procuredprocurementplanviewdiv', 'act=a&facilityfinancialyearid=' + facilityfinancialyearid + '&orderperiodtype=' + orderperiodtype + '&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        window.location = '#procuredprocurementplanview';
    }
    function closedialogfunc4() {
        window.location = '#close';
    }
</script>
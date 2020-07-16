<%-- 
    Document   : procurementPlanTable
    Created on : Apr 9, 2018, 6:48:45 PM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp" %>
<table class="table table-hover table-bordered" id="tableFacilityfinancialyears">
    <thead>
        <tr>
            <th>No</th>
            <th>Start Year</th>
            <th>End Year</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Approach</th>
            <th>Procurement Plans</th>
            <th>Set As Current FY</th>
            <th>Manage</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <% int i = 1;%>
        <c:forEach items="${financialyrs}" var="a">
            <tr  <c:if test="${a.isthecurrent==true}">style="color: red;"</c:if>>
                <td><%=j++%></td>
                <td>${a.startyear}</td>
                <td>${a.endyear}</td>
                <td>${a.financialyearstartdate}</td>
                <td>${a.financialyearenddate}</td>
                <td>${a.approach}</td>
                <td align="center">
                    <button onclick="financialyprocurementplansview(${a.facilityfinancialyearid},${a.startyear},${a.endyear});"  title=" The Procurement Plans To Be Procured." class="btn btn-secondary btn-sm add-to-shelf">
                        1 Procurement Plan
                    </button>
                </td>
                <td align="center">
                    <c:if test="${a.isthecurrent==true}">
                        <button title="The Financial Year Is Not Current." class="btn btn-secondary btn-sm add-to-shelf" style="background-color: green; important">
                            Yes
                        </button> 
                    </c:if>
                     <c:if test="${a.isthecurrent==false}">
                         <button title="The Financial Year Is Not Current" class="btn btn-secondary btn-sm add-to-shelf" style="">
                            No
                        </button>
                     </c:if>
                    </td>
                    <td align="center">
                        <div class="row">
                            <button onclick="managefacilityfinancialyear(${a.facilityfinancialyearid},${a.startyear},${a.endyear});"  title="Financial Year. ${a.startyear}-${a.endyear}" class="btn btn-primary btn-sm add-to-shelf subscribe">
                            <i class="fa fa-fw fa-lg fa-dedent"></i>
                        </button>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<div class="row">
    <div class="col-md-12">
        <div id="financialyprocurementplansview" class="supplierCatalogDialog">
            <div style="height: auto !important; ">
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: none;">X</a>
                    <h2 class="modalDialog-title" id="titlefinancialyrview">Un Procured Procurement Plans</h2>
                    <hr>
                </div>
                <div class="row" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <input id="facilityfinancialyearidplansview" type="hidden">
                                    <div id="financialyprocurementplansviewdiv">

                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" align="right">
                                <button class="btn btn-primary" onclick="closedialogfunc();">
                                    <i class="fa fa-check-circle"></i>
                                    OK
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script>
    function closedialogfunc() {
        window.location = '#close';
        ajaxSubmitData('facilityprocurementplanmanagement/facilityprocurementplanhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    $('#tableFacilityfinancialyears').DataTable();
    
 
    function financialyprocurementplansview(facilityfinancialyearid, start, endyear) {
        document.getElementById('facilityfinancialyearidplansview').value = facilityfinancialyearid;
        document.getElementById('titlefinancialyrview').innerHTML = start + '-' + endyear + ' ' + 'Procurement Plans';
        ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredorunprocuredprocurementplans.htm', 'financialyprocurementplansviewdiv', 'act=a&facilityfinancialyearid=' + facilityfinancialyearid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

        window.location = '#financialyprocurementplansview';
    }

</script>

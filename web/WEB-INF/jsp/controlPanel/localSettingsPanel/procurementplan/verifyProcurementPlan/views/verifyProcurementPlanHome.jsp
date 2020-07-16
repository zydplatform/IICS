<%-- 
    Document   : verifyProcurementPlanHome
    Created on : Jul 2, 2009, 12:51:22 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div class="form-group row">
                            <label class="control-label col-md-4">Procurement Plan For Financial Year:</label>
                            <div class="col-md-6">
                                <c:if test="${not empty financialyr}">
                                    <c:forEach items="${financialyr}" var="fyr">
                                        <h3><span class="badge badge-secondary"><strong>${fyr.procurementplan}</strong></span></h3>
                                    </c:forEach>  
                                </c:if>
                                <c:if test="${empty financialyr}">
                                    <h3><span class="badge badge-secondary"><strong>NO Financial Year</strong></span></h3>
                                </c:if>
                            </div>
                        </div>
                        <div class="form-group row" style="display: none;">
                            <label class="control-label col-md-4">Procurement Plan For Financial Year:</label>
                            <div class="col-md-6">
                                <select class="form-control" id="selectprocurementfacilityyrs" disabled="true">
                                    <c:forEach items="${financialyr}" var="fyr">
                                        <option  value="${fyr.facilityfinancialyearid}">${fyr.procurementplan}</option>
                                    </c:forEach>
                                </select>    
                            </div>
                        </div>
                        <div id="unapprovedfacilityunitprocurementplansdiv"></div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div>
<script>
    var selectprocurementfacilityyrs = $('#selectprocurementfacilityyrs').val();
    if (selectprocurementfacilityyrs !== null) {
        ajaxSubmitData('procurementplanmanagement/unapprovedfacilityunitprocurementplans.htm', 'unapprovedfacilityunitprocurementplansdiv', 'act=a&selectprocurementfacilityyr=' + selectprocurementfacilityyrs + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
    } else {
    }

    $('#selectprocurementfacilityyrs').change(function () {
        var financialyearid = $('#selectprocurementfacilityyrs').val();
        ajaxSubmitData('procurementplanmanagement/unapprovedfacilityunitprocurementplans.htm', 'unapprovedfacilityunitprocurementplansdiv', 'act=a&selectprocurementfacilityyr=' + financialyearid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
</script>

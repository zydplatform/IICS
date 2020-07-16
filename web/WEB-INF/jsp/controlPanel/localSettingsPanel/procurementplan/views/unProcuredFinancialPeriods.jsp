<%-- 
    Document   : unProcuredFinancialPeriods
    Created on : Apr 30, 2018, 10:41:11 AM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../../include.jsp" %>
<!DOCTYPE html>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <legend>Compose Procurement Plan</legend>
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
                                <select class="form-control" id="selectprocurementfacilityyr" disabled="true">
                                    <c:forEach items="${financialyr}" var="fyr">
                                        <option  value="${fyr.facilityfinancialyearid}">${fyr.procurementplan}</option>
                                    </c:forEach>
                                </select>    
                            </div>
                        </div>
                        <div id="unprocuredfinancialyearperiodstable"></div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
</div> 
<script>
    var selectprocurementfacilityyr = $('#selectprocurementfacilityyr').val();
    if (selectprocurementfacilityyr !== null) {
        ajaxSubmitData('procurementplanmanagement/unprocuredfinancialyearperiodstable.htm', 'unprocuredfinancialyearperiodstable', 'act=a&selectprocurementfacilityyr=' + selectprocurementfacilityyr + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    
</script>
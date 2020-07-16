<%-- 
    Document   : service
    Created on : Jul 18, 2018, 10:14:46 AM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="modal fade col-md-12" id="updateFacilityServ" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Service Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'service-content', 'act=a2&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="ResponsePaneService">
                <form id="updateService" name="updateService">
                <div class="container">
                    <div class="row">
                        
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <div class="form-group">
                                            <label class="control-label">Service Name</label>
                                            <input type="hidden" name="serviceId" value="${model.serviceObj[0]}"/>
                                            <input class="form-control col-md-10" id="servicename2" name="servicename" type="text" readonly="readonly" value="${model.serviceObj[1]}" placeholder="Service Name">
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Description</label>
                                            <textarea class="form-control col-md-10" rows="2" id="serviceDesc2" name="description" placeholder="About Service">${model.serviceObj[2]}</textarea>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Service Key</label>
                                            <input class="form-control col-md-10" id="servicekey2" name="servicekey" type="text" readonly="readonly" value="${model.serviceObj[3]}" placeholder="Service Key">
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Service Status: </label>
                                            Active: <input type="radio" name="status" id="tstatus" value="true" <c:if test="${model.serviceObj[4]==true}">checked="checked"</c:if>/>
                                                &nbsp;&nbsp;
                                                Inactive: <input type="radio" name="status" id="fstatus" value="false" <c:if test="${model.serviceObj[4]==false}">checked="checked"</c:if>/>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">Release Service: </label>
                                                Yes: <input type="radio" name="release" id="trelease" value="true" <c:if test="${model.serviceObj[5]==true}">checked="checked"</c:if>/>
                                                &nbsp;&nbsp;
                                                No: <input type="radio" name="release" id="frelease" value="false" <c:if test="${model.serviceObj[5]==false}">checked="checked"</c:if>/>
                                            </div>
                                        </div>
                                        <div class="tile-footer">
                                            <div class="row">
                                                <div class="col-md-8 col-md-offset-3">
                                                    <button type="button" class="btn btn-primary" id="btnUpdate" onClick="ajaxSubmitForm('facilityServicesManagement/updateFacilityService.htm', 'ResponsePaneService', 'updateService');">Update Service</button>
                                                    &nbsp;&nbsp;
                                                    <button type="button" class="btn btn-primary" id="btnDelete" onClick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'ResponsePaneService', 'act=c&i=${model.serviceObj[0]}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Delete Service</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                </div>
                                             </form>
                                            </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#updateFacilityServ').modal('show');
</script>
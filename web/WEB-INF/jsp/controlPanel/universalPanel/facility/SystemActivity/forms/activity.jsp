<%-- 
    Document   : activity
    Created on : Aug 24, 2018, 10:21:01 AM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="modal fade col-md-12" id="updateSystemActivity" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Activity Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('systemActivity/activityManagement.htm', 'activityPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
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
                                            <label class="control-label">Activity Name</label>
                                            <input type="hidden" name="serviceId" value="${model.activityObj[0]}"/>
                                            <input class="form-control col-md-10" id="activityname2" name="activityname" type="text" readonly="readonly" value="${model.activityObj[1]}" placeholder="Activity Name">
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Description</label>
                                            <textarea class="form-control col-md-10" rows="2" id="activityDesc2" name="description" placeholder="About Activity">${model.activityObj[2]}</textarea>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Activity Key</label>
                                            <input class="form-control col-md-10" id="activitykey2" name="activitykey" type="text" readonly="readonly" value="${model.activityObj[3]}" placeholder="Service Key">
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Activity Status: </label>
                                            Active: <input type="radio" name="status" id="tstatus" value="true" <c:if test="${model.activityObj[4]==true}">checked="checked"</c:if>/>
                                                &nbsp;&nbsp;
                                                Inactive: <input type="radio" name="status" id="fstatus" value="false" <c:if test="${model.activityObj[4]==false}">checked="checked"</c:if>/>
                                            </div>
                                        </div>
                                        <div class="tile-footer">
                                            <div class="row">
                                                <div class="col-md-8 col-md-offset-3">
                                                    <button type="button" class="btn btn-primary" id="btnUpdate" onClick="ajaxSubmitForm('systemActivity/updateSystemActivity.htm', 'ResponsePaneService', 'updateService');">Update Service</button>
                                                    &nbsp;&nbsp;
                                                    <button type="button" class="btn btn-primary" id="btnDelete" onClick="ajaxSubmitData('systemActivity/activityManagement.htm', 'ResponsePaneService', 'act=c&i=${model.activityObj[0]}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Delete Activity</button>
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
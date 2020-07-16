<%-- 
    Document   : manageVillage
    Created on : Jul 5, 2018, 4:14:54 PM
    Author     : user
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${model.scope=='a'}">
    <div class="modal fade col-md-12" id="manageVillagePane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 100%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Manage Village: ${model.villageObjc[1]}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('locations/manageVillage.htm', 'regionContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container" id="Response-pane">

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Facility:</label>
                                    <a href="#" onClick="if (${model.facility==0}) {
                                                return false;
                                            }
                                            ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'facility', v1: '${model.village[0]}', v2: '0'}, 'GET');"><b>${model.facility}</b></a>
                                </div>
                            </div>
                        </div>
                        <%--<c:if test="${model.facility>0}"> </c:if>
                        <%--<c:if test="${model.facility==0}">
                            <h1>No Attachments found</h1>
                        </c:if>
                            <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Users/Clients:</label>
                                    <a href="#" onClick="if(${model.pCurVil==0}){return false;} ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'curVillage', v1: '${model.village[0]}', v2: '0'}, 'GET');"><b>${model.pCurVil}</b></a>
                                </div>
                            </div>--%>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <button data-toggle="modal" data-target="#deleteVillage" <c:if test="${model.attachments=='true'}">disabled="disabled"</c:if> class="btn btn-primary pull-right" type="button" onClick="var resp = confirm('Are you sure you want to delete Village::${model.villageObjc[1]}');
                                        if (resp === false) {
                                            return false;
                                        }
                                        ajaxSubmitData('locations/deleteVillage.htm', 'response-pane', 'act=a&vID=${model.villageObjc[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-cut"></i>Delete Village</button>
                            </div>
                        </div>
                    </div>        
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#manageVillagePane').modal('show');
    });
</script>
</c:if>
<c:if test="${model.scope=='b'}">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Facility:</label>
                <a href="#" onClick="ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'facility', v1: '${model.village[0]}', v2: '0'}, 'GET');"><b>${model.facility}</b></a>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <button data-toggle="modal" data-target="#deleteVillage" <c:if test="${model.attachments=='true'}">disabled="disabled"</c:if> class="btn btn-primary pull-right" type="button" onClick="var resp = confirm('Are you sure you want to delete Village:: ${model.villageObjc[1]}!');
                        if (resp === false) {
                            return false;
                        }
                        ajaxSubmitData('locations/deleteVillage.htm', 'response-pane', 'act=a&id=${model.villageObjc[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-cut"></i>Delete Village</button>
            </div>
        </div>
    </div>
</c:if>
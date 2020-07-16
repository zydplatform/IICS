<%-- 
    Document   : manageParish
    Created on : Jul 2, 2018, 6:32:30 PM
    Author     : Uwera
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${model.scope=='a'}">
    <div class="modal fade col-md-12" id="manageParishPane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 150%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Manage Parish: ${model.parishObj[1]}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('locations/manageParish.htm','regionContent','act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container" id="Response-pane">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Facility:</label>
                                    <a href="#" onClick="if(${model.facility==0}){return false;} ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'facility', v1: '${model.parish[0]}', v2: '0'}, 'GET');"><b>${model.facility}</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Villages:</label>
                                    <a href="#" onClick="if(${model.village==0}){return false;} ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'village', v1: '${model.parish[0]}', v2: '0'}, 'GET');"><b>${model.village}</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Users/Clients:</label>
                                    <a href="#" onClick="if(${model.pCurVil==0}){return false;} ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'curVillage', v1: '${model.parish[0]}', v2: '0'}, 'GET');"><b>${model.pCurVil}</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <button data-toggle="modal" data-target="#deleteParish" <c:if test="${model.attachments=='true'}">disabled="disabled"</c:if> class="btn btn-primary pull-right" type="button" onClick="var resp = confirm('Are you sure you want to delete Parish:: ${model.parishObj[1]}!');
                                            if (resp === false) {
                                                return false;
                                            }
                                            ajaxSubmitData('locations/deleteParish.htm', 'response-pane', 'act=a&pID=${model.parishObj[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-cut"></i>Delete Parish</button>
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
            $('#manageParishPane').modal('show');
        });
    </script>
</c:if>
<c:if test="${model.scope=='b'}">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Facility:</label>
                <a href="#" onClick="ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'facility', v1: '${model.parish[0]}', v2: '0'}, 'GET');"><b>${model.facility}</b></a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Villages:</label>
                <a href="#" onClick="ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'village', v1: '${model.parish[0]}', v2: '0'}, 'GET');"><b>${model.village}</b></a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Users/Clients:</label>
                <a href="#" onClick="ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'curVillage', v1: '${model.parish[0]}', v2: '0'}, 'GET');"><b>${model.pCurVil}</b></a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <button data-toggle="modal" data-target="#deleteParish" <c:if test="${model.attachments=='true'}">disabled="disabled"</c:if> class="btn btn-primary pull-right" type="button" onClick="var resp = confirm('Are you sure you want to delete Parish:: ${model.parishObj[1]}!');
                        if (resp === false) {
                            return false;
                        }
                        ajaxSubmitData('locations/deleteParish.htm', 'response-pane', 'act=a&id=${model.parishObj[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-cut"></i>Delete Parish</button>
            </div>
        </div>
    </div>
</c:if>    
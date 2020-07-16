<%-- 
    Document   : manageCounty
    Created on : Jul 5, 2018, 5:00:20 PM
    Author     : user
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${model.scope=='a'}">
    <div class="modal fade col-md-12" id="manageCountyPane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 150%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Manage County:: ${model.countyObj[1]}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('locations/manageCounty.htm', 'regionContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container" id="Response-pane">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Sub Counties:</label>
                                    <a href="#" onClick="if (${model.subcounty==0}) {
                                                return false;
                                            }
                                            ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'subcounty', v1: '${model.county[0]}', v2: '0'}, 'GET');"><b>${model.subcounty}</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Parishes:</label>
                                    <a href="#" onClick="if (${model.parish==0}) {
                                                return false;} ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'parish', v1: '${model.county[0]}', v2: '0'}, 'GET');"><b>${model.parish}</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Villages:</label>
                                    <a href="#" onClick="if (${model.village==0}) {
                                                return false;} ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'village', v1: '${model.county[0]}', v2: '0'}, 'GET');"><b>${model.village}</b></a>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <button data-toggle="modal" data-target="#deleteCounty" <c:if test="${model.attachments=='true'}">disabled="disabled"</c:if> class="btn btn-primary pull-right" type="button" onClick="var resp = confirm('Delete County:: ${model.countyObj[1]}!');
                                            if (resp === false) {
                                                return false;
                                            }
                                            ajaxSubmitData('locations/deleteCounty.htm', 'response-pane', 'act=a&cID=${model.countyObj[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-cut"></i>Delete County</button>
                                      <!--  <a href="#" title="Discard County" onclick="var resp = confirm('Are you sure you want to delete County:: ${list[1]}!');
                                                    if (resp === false) {
                                                        return false;
                                                    }                                                          
                                                    ajaxSubmitData('locations/deleteCounty.htm', 'response-pane', 'act=a&id=${list[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-times"></i></a>-->
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
            $('#manageCountyPane').modal('show');
        });
    </script>
</c:if>
<c:if test="${model.scope=='b'}">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Sub Counties:</label>
                <a href="#" onClick="if (${model.subcounty==0}) {
                            return false;
                        }
                        ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'subcounty', v1: '${model.county[0]}', v2: '0'}, 'GET');"><b>${model.subcounty}</b></a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Parishes:</label>
                <a href="#" onClick="if (${model.parish==0}) {
                            return false;} ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'parish', v1: '${model.county[0]}', v2: '0'}, 'GET');"><b>${model.parish}</b></a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Villages:</label>
                <a href="#" onClick="ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'village', v1: '${model.county[0]}', v2: '0'}, 'GET');"><b>${model.village}</b></a>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Parishes:</label>
                <a href="#" onClick="if (${model.parish==0}) {
                            return false;} ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'parish', v1: '${model.county[0]}', v2: '0'}, 'GET');"><b>${model.parish}</b></a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <button data-toggle="modal" data-target="#deleteCounty" <c:if test="${model.attachments=='true'}">disabled="disabled"</c:if> class="btn btn-primary pull-right" type="button" onClick="var resp = confirm('Are you sure you want to delete Parish:: ${model.countyObj[1]}!');
                        if (resp === false) {
                            return false;
                        }
                        ajaxSubmitData('locations/deleteCounty.htm', 'response-pane', 'act=a&cID=${model.countyObj[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-cut"></i>Delete County</button>
            </div>
        </div>
    </div>
</c:if>  
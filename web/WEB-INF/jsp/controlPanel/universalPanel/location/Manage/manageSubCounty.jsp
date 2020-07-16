<%-- 
    Document   : manageSubCounty
    Created on : Jun 22, 2018, 4:18:19 PM
    Author     : Uwera
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${model.scope=='a'}">
    <div class="modal fade col-md-12" id="manageSubcountyPane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 130%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Manage Sub County: ${model.subcountyObj[1]}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('locations/manageSubCounty.htm','regionContent','act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container" id="Response-pane">
                                 <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Parishes:</label>
                                    <a href="#" onClick="if(${model.parish==0}){return false;} ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'parish', v1: '${model.subcounty[0]}', v2: '0'}, 'GET');"><b>${model.parish}</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Villages:</label>
                                    <a href="#" onClick="if(${model.village==0}){return false;} ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'village', v1: '${model.subcounty[0]}', v2: '0'}, 'GET');"><b>${model.village}</b></a>
                                </div>
                            </div>
                        </div>
                      
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                   
                                    <button data-toggle="modal" data-target="#deleteSubCounty" <c:if test="${model.attachments=='true'}">disabled="disabled"</c:if> class="btn btn-primary pull-right" type="button" onClick="var resp = confirm('Delete Sub County:: ${model.subcountyObj[1]}!?');
                                            if (resp === false) {
                                                return false;
                                            }
                                            ajaxSubmitData('locations/deleteSubCounty.htm', 'response-pane', 'act=a&scID=${model.subcountyObj[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-cut"></i>Delete Sub County</button>
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
            $('#manageSubcountyPane').modal('show');
        });
    </script>
</c:if>
<c:if test="${model.scope=='b'}">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Facility:</label>
                <a href="#" onClick="ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'facility', v1: '${model.subcounty[0]}', v2: '0'}, 'GET');"><b>${model.facility}</b></a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Villages:</label>
                <a href="#" onClick="ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'village', v1: '${model.subcounty[0]}', v2: '0'}, 'GET');"><b>${model.village}</b></a>
            </div>
        </div>
    </div>
            <!--
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Users/Clients:</label>
                <a href="#" onClick="ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'curVillage', v1: '${model.parish[0]}', v2: '0'}, 'GET');"><b>${model.pCurVil}</b></a>
            </div>
        </div>
    </div>-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <button data-toggle="modal" data-target="#deleteSubCounty" <c:if test="${model.attachments=='true'}">disabled="disabled"</c:if> class="btn btn-primary pull-right" type="button" onClick="var resp = confirm('Delete Sub County:: ${model.subcountyObj[1]}!?');
                        if (resp === false) {
                            return false;
                        }
                        ajaxSubmitData('locations/deleteSubCounty.htm', 'response-pane', 'act=a&scID=${model.subcountyObj[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-cut"></i>Delete Sub County</button>
            </div>
        </div>
    </div>
</c:if>    



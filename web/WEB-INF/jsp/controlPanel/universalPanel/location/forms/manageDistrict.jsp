<%-- 
    Document   : manageDistrict
    Created on : Jul 13, 2018, 10:13:14 AM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${model.scope=='a'}">
    <div class="modal fade col-md-12" id="manageDistrictPane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 150%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Manage District: ${model.districtObj[1]}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('locations/manageDistrict.htm', 'regionContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');clearDiv('response-pane');">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container" id="Response-pane">

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Counties:</label>
                                    <a href="#" onClick="if (${model.county==0}) {
                                                return false;
                                            }
                                            ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'county', v1: '${model.district[0]}', v2: '0'}, 'GET');"><b>${model.county}</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Sub-Counties:</label>
                                    <a href="#" onClick="if (${model.subcounty==0}) {
                                                return false;
                                            }
                                            ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'subcounty', v1: '${model.district[0]}', v2: '0'}, 'GET');"><b>${model.subcounty}</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Parishes:</label>
                                    <a href="#" onClick="if (${model.parish==0}) {
                                                return false;
                                            }
                                            ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'parish', v1: '${model.district[0]}', v2: '0'}, 'GET');"><b>${model.parish}</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Attached Villages:</label>
                                    <a href="#" onClick="if (${model.village==0}) {
                                                return false;
                                            }
                                            ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'village', v1: '${model.district[0]}', v2: '0'}, 'GET');"><b>${model.village}</b></a>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <button data-toggle="modal" data-target="#deleteDistrict" <c:if test="${model.attachments=='true'}">disabled="disabled"</c:if> class="btn btn-primary pull-right" type="button" onClick="var resp = confirm('Are you sure you want to delete District:: ${model.districtObj[1]}!');
                                            if (resp === false) {
                                                return false;
                                            }
                                            ajaxSubmitData('locations/deleteDistrictx.htm', 'response-pane', 'act=a&dID=${model.districtObj[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-cut"></i>Delete District</button>
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
            $('#manageDistrictPane').modal('show');
        });
    </script>
</c:if>
<c:if test="${model.scope=='b'}">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Counties:</label>
                <a href="#" onClick="if (${model.county==0}) {
                            return false;
                        }
                        ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'county', v1: '${model.district[0]}', v2: '0'}, 'GET');"><b>${model.county}</b>
                        </a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Sub-Counties:</label>
                <a href="#" onClick="if (${model.subcounty==0}) {
                            return false;
                        }
                        ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'subcounty', v1: '${model.district[0]}', v2: '0'}, 'GET');"><b>${model.subcounty}</b></a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label">Attached Parishes:</label>
                <a href="#" onClick="if (${model.parish==0}) {
                            return false;
                        }
                        ajaxSubmitData('locations/loadLocationAttachment.htm', 'Response-pane', {act: '${model.activity}', st: 'parish', v1: '${model.district[0]}', v2: '0'}, 'GET');"><b>${model.parish}</b></a>
            </div>
        </div
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="form-group">
            <button data-toggle="modal" data-target="#deleteDistrict" <c:if test="${model.attachments=='true'}">disabled="disabled"</c:if> class="btn btn-primary pull-right" type="button" onClick="var resp = confirm('Are you sure you want to delete District:: ${model.districtObj[1]}!');
                    if (resp === false) {
                        return false;
                    }
                    ajaxSubmitData('locations/deleteDistrictx.htm', 'response-pane', 'act=a&dID=${model.districtObj[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-cut"></i>Delete District</button>
        </div>
    </div>
</div>   

</c:if>    
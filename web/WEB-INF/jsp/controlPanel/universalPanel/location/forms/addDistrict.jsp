<%-- 
    Document   : addDistrict
    Created on : Jun 4, 2018, 12:37:43 PM
    Author     : Uwera
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<div class="modal fade col-md-12" id="districtpane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Add/Upddate District</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="clearDiv('regionContent'); ajaxSubmitData('locations/manageDistrict.htm', 'regionContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container" id="Response-pane">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <form name="submitData" id="submitData" class="form-horizontal">
                                    <div class="tile-body">
                                        <div class="form-group">
                                        <label class="control-label">Select Region:</label>
                                        <select class="form-control" name="regionid" id="regionidlist">                                                        
                                            <option value="0">--Select Region--</option>
                                            <c:forEach items="${model.regionsList}" var="list" varStatus="status">
                                                <option <c:if test="${model.district.regionid.regionid==list.regionid}">selected</c:if> value="${list.regionid}">${list.regionname}</option>
                                            </c:forEach>
                                        </select>
                                    </div>                                                
                                     <div class="form-group">
                                        <label class="control-label">District Name</label>
                                        <input name="districtid" value="${model.district.districtid}" type="hidden"/>
                                        <input class="form-control" id="districtname" type="text" name="districtname" value="${model.district.districtname}" type="text"  placeholder="District Name" validate ="not_empty" msg="Please enter a district name"/>
                                    </div>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <input type="hidden" name="cref" id="cref" value="${model.checkObj[0]}"/>
                                                <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                                <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                                <div align="left" style="alignment-adjust: central;">
                                                    <div id="btnSaveHide">
                                                        <input type="button" id="saveButton" name="button" class="btn btn-primary" value='<c:if test="${empty model.checkObj}">Save</c:if><c:if test="${not empty model.checkObj}">Update</c:if> District' onClick="var resp=validateB4Submit(); if(resp===false){return false;} ajaxSubmitForm('locations/saveOrUpdateDistrict.htm', 'Response-pane', 'submitData');"/> 
                                                        &nbsp;&nbsp;
                                                        <input name="" type="reset" value="Reset" class="btn btn-primary" >
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
        </div>
    </div>
</div>
                                



<script>
$(document).ready(function () {
        $('#districtpane').modal('show');
    });
     function validateB4Submit() {
     var districtname = document.getElementById('districtname').value;
        var regionidlist = document.getElementById('regionidlist').value;

        if (districtname === null || districtname === '0' || regionidlist === null || regionidlist === '0') {
            if (districtname === null || districtname === '0') {
                alert('Region Not Selected!');
            }
            if (regionidlist === null || regionidlist === '0') {
                alert('Region Not Selected!');
            }
            return false;
        }
        return true;
    }
</script>
  









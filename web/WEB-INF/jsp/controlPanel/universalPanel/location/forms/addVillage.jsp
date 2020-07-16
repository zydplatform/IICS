<%-- 
    Document   : addVillage
    Created on : Jun 27, 2018, 2:36:36 PM
    Author     : Uwera
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade col-md-12" id="districtpane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Add/Update Village</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="">
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
                                            <select class="form-control" name="regionid" id="regionidlist" onChange="ajaxSubmitData('locations/loadDistricts.htm', 'districtDivx', {rID: $(this).val(), loc: 55}, 'GET');">                                                         
                                                <option value="0">--Select Region--</option>
                                                <c:forEach items="${model.regionsList}" var="regions">
                                                    <option <c:if test="${model.village.parishid.subcountyid.countyid.districtid.regionid.regionid==regions.regionid}">selected</c:if> value="${regions.regionid}">${regions.regionname}</option>
                                                </c:forEach>
                                            </select>
                                        </div>  
                                        <div class="form-group">
                                            <div id="districtDivx">
                                                <label class="control-label">Select a District:</label>
                                                <div id="districtPane">
                                                    <select class="form-control" id="districtlist" name="districtlist"  onClick="ajaxSubmitData('locations/loadDistricts.htm', 'districtDivx', {rID: $('#regionidlist').val(), loc: 55}, 'GET');">
                                                        <option value="${model.village.parishid.subcountyid.countyid.districtid.districtid}" selected="selected">${model.village.parishid.subcountyid.countyid.districtid.districtname}</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div></div>
                                        </div>
                                        <div class="form-group">
                                            <div id="countyDivx">
                                                <label class="control-label">Select a County:</label>
                                                <div id="districtPane">
                                                    <select class="form-control" id="countylist" name="countyid"  onClick=" ajaxSubmitData('locations/loadCounties.htm', 'countyDivx', {dID: $('#districtlist').val(), loc:55}, 'GET');">
                                                        <option value="${model.village.parishid.subcountyid.countyid.countyid}" selected="selected">${model.village.parishid.subcountyid.countyid.countyname}</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div></div>
                                        </div>
                                        <div class="form-group">
                                            <div id="subcountyDivx">
                                                <label class="control-label">Select Sub County:</label>
                                                <div id="districtPane">
                                                    <select class="form-control" id="subCountyList" name="subcountyid"  onClick="ajaxSubmitData('locations/loadSubCounties.htm', 'subcountyDivx', {cID: $('#countylist').val(), loc:55}, 'GET');">
                                                        <option value="${model.village.parishid.subcountyid.subcountyid}" selected="selected">${model.village.parishid.subcountyid.subcountyname}</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div></div>
                                        </div>
                                          <div class="form-group">
                                            <div id="parishDivx">
                                                <label class="control-label">Select Parish:</label>
                                                <div id="districtPane">
                                                    <select class="form-control" id="parishlist" name="parishid"  onClick="ajaxSubmitData('locations/loadParishes.htm', 'parishDivx', {scID: $('#subcountylist').val(), loc:55}, 'GET');">
                                                        <option value="${model.village.parishid.parishid}" selected="selected">${model.village.parishid.subcountyid.subcountyname}</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div></div>
                                        </div>
                                       <div class="form-group">
                                            <label class="control-label"> Village Name</label>
                                            <input name="villageid" value="${model.village.villageid}" type="hidden"/>
                                            <input class="form-control"  type="text"  name="villagename" value="${model.village.villagename}"   placeholder="Village Name" validate ="not_empty" msg="Please enter village name"/>
                                        </div>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <div align="left" style="alignment-adjust: central;">
                                                    <div id="btnSaveHide">
                                                        <input type="button" id="saveButton" name="button" class="btn btn-primary" value='<c:if test="${model.activity=='update'}">Update</c:if><c:if test="${model.activity=='add'}">Add</c:if> Village' 
                                                               onClick="ajaxSubmitForm('locations/saveOrUpdateVillage.htm', 'Response-pane', 'submitData');"/> 
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
</div>
</div>
</div>
</div>

<script>
    $(document).ready(function () {
        $('#districtpane').modal('show');
    });
    function validateB4Submit() {
        var districtlist = document.getElementById('districtlist').value;
        var villagename = document.getElementById('villagename').value;
        var regionidlist = document.getElementById('regionidlist').value;
        var parishlist = document.getElementById('parishlist').value;

        if (villagename === null || villagename === '0' || districtlist === null || districtlist === '0' || parishlist === null || parishlist === '0'|| regionidlist === null || regionidlist === '0') {
            if (villagename === null || villagename === '0') {
                alert('villagename Not entered!');
            }
            if (districtlist === null || districtlist === '0') {
                alert('District Not Selected!');
            }
            if (regionidlist === null || regionidlist === '0') {
                alert('Region Not Selected!');
            }
            if (parishlist === null || parishlist === '0') {
                alert('Region Not Selected!');
            }
            return false;
        }
        return true;
    }
</script>

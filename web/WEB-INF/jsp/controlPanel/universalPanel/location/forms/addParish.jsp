<%-- 
    Document   : addParish
    Created on : Jun 26, 2018, 11:36:09 AM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade col-md-12" id="districtpane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Add/Update Parish</h5>
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
                                            <select class="form-control" name="regionid" id="regionidlist" onChange="ajaxSubmitData('locations/loadDistricts.htm', 'districtDivx', {rID: $(this).val(), loc: 44}, 'GET');">                                                         
                                                <option value="0">--Select Region--</option>
                                                <c:forEach items="${model.regionsList}" var="regions">
                                                    <option <c:if test="${model.parish.subcountyid.countyid.districtid.regionid.regionid==regions.regionid}">selected</c:if> value="${regions.regionid}">${regions.regionname}</option>
                                                </c:forEach>
                                            </select>
                                        </div>  
                                        <div class="form-group">
                                            <div id="districtDivx">
                                                <label class="control-label">Select a District:</label>
                                                <div id="districtPane">
                                                    <select class="form-control" id="districtlist" name="districtlist"  onClick="ajaxSubmitData('locations/loadDistricts.htm', 'districtDivx', {rID: $('#regionidlist').val(), loc: 44}, 'GET');">
                                                        <option value="${model.parish.subcountyid.countyid.districtid.districtid}" selected="selected">${model.parish.subcountyid.countyid.districtid.districtname}</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div></div>
                                        </div>
                                        <div class="form-group">
                                            <div id="countyDivx">
                                                <label class="control-label">Select a County:</label>
                                                <div id="districtPane">
                                                    <select class="form-control" id="countylist" name="countyid"  onClick=" ajaxSubmitData('locations/loadCounties.htm', 'countyDivx', {dID: $('#districtlist').val(), loc: 44}, 'GET');">
                                                        <option value="${model.parish.subcountyid.countyid.countyid}" selected="selected">${model.parish.subcountyid.countyid.countyname}</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div></div>
                                        </div>
                                        <div class="form-group">
                                            <div id="subcountyDivx">
                                                <label class="control-label">Select Sub County:</label>
                                                <div id="districtPane">
                                                    <select class="form-control" id="subCountyList" name="subcountyid"  onClick="ajaxSubmitData('locations/loadSubCounties.htm', 'subcountyDivx', {cID: $('#countylist').val(), loc: 44}, 'GET');">
                                                        <option value="${model.parish.subcountyid.subcountyid}" selected="selected">${model.parish.subcountyid.subcountyname}</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div></div>
                                        </div>

                                        <div class="form-group">
                                            <label class="control-label"> Parish Name</label>
                                            <input name="parishid" value="${model.parish.parishid}" type="hidden"/>
                                            <input class="form-control"  type="text" name="parishname" value="${model.parish.parishname}" type="text"  placeholder="Parish Name" validate ="not_empty" msg="Please enter parish name"/>
                                        </div>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <div align="left" style="alignment-adjust: central;">
                                                    <div id="btnSaveHide">
                                                        <input type="button" id="saveButton" name="button" class="btn btn-primary" value='<c:if test="${model.activity=='update'}">Update</c:if><c:if test="${model.activity=='add'}">Add</c:if> Parish' 
                                                               onClick="ajaxSubmitForm('locations/saveOrUpdateParish.htm', 'Response-pane', 'submitData');"/> 
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
        var parishname = document.getElementById('parishname').value;
        var regionidlist = document.getElementById('regionidlist').value;

        if (parishname === null || parishname === '0' || districtlist === null || districtlist === '0' || regionidlist === null || regionidlist === '0') {
            if (parishname === null || parishname === '0') {
                alert('parishname Not entered!');
            }
            if (districtlist === null || districtlist === '0') {
                alert('District Not Selected!');
            }
            if (regionidlist === null || regionidlist === '0') {
                alert('Region Not Selected!');
            }
            return false;
        }
        return true;
    }
</script>

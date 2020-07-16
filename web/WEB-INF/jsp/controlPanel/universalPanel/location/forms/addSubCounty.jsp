<%-- 
    Document   : addSubCounty
    Created on : Jun 20, 2018, 1:44:52 PM
    Author     : user
--%>

<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade col-md-12" id="districtpane" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Add/Update Sub County</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
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
                                            <select class="form-control" name="regionid" id="regionidlist" onChange="ajaxSubmitData('locations/loadDistricts.htm', 'districtDivx', {rID: $(this).val(), loc: 33}, 'GET');">                                                         
                                                <option value="0">--Select Region--</option>
                                                <c:forEach items="${model.regionsList}" var="regions">
                                                    <option <c:if test="${model.subcounty.countyid.districtid.regionid.regionid==regions.regionid}">selected</c:if> value="${regions.regionid}">${regions.regionname} </option>
                                                </c:forEach>
                                            </select>
                                        </div>  
                                        <div class="form-group">
                                            <div id="districtDivx">
                                                <label class="control-label">Select a District:</label>
                                                <div id="districtPane">
                                                    <select class="form-control" id="districtlist" name="districtlist"  onClick="ajaxSubmitData('locations/loadDistricts.htm', 'districtDivx', {rID: $('#regionidlist').val(), loc: 33}, 'GET');">
                                                        <option value="${model.subcounty.countyid.districtid.districtid}" selected="selected">${model.subcounty.countyid.districtid.districtname}</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div></div>
                                        </div>
                                        <div class="form-group">
                                            <div id="countyDivx">
                                                <label class="control-label">Select a County:</label>
                                                <div id="districtPane">
                                                    <select class="form-control" id="countylist" name="countyid"  onClick="ajaxSubmitData('locations/loadCounties.htm', 'countyDivx', {dID: $('#districtlist').val(), loc:33}, 'GET');">
                                                        <option value="${model.subcounty.countyid.countyid}" selected="selected">${model.subcounty.countyid.countyname}</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div></div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label"> Sub County Name</label>
                                            <input name="subcountyid" value="${model.subcounty.subcountyid}" type="hidden"/>
                                            <input class="form-control" id="subcountyname" type="text" name="subcountyname" value="${model.subcounty.subcountyname}" type="text"  placeholder="Sub County Name" validate ="not_empty" msg="Please enter a sub county name"/>
                                        </div>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <div align="left" style="alignment-adjust: central;">
                                                    <div id="btnSaveHide">
                                                        <input type="button" id="saveButton" name="button" class="btn btn-primary" value='<c:if test="${model.activity=='update'}">Update</c:if><c:if test="${model.activity=='add'}">Add</c:if> Sub County' 
                                                               onClick="ajaxSubmitForm('locations/saveOrUpdateSubCounty.htm', 'Response-pane', 'submitData');"/> 
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
        var countname = document.getElementById('countname').value;
        var regionidlist = document.getElementById('regionidlist').value;

        if (districtname === null || districtname === '0' || countname === null || countname === '0' || regionidlist === null || regionidlist === '0') {
            if (districtname === null || districtname === '0') {
                alert('District Not Selected!');
            }
            if (countname === null || countname === '0') {
                alert('Count Not Selected!');
            }
            if (regionidlist === null || regionidlist === '0') {
                alert('Region Not Selected!');
            }
            return false;
        }
        return true;
    }
</script>

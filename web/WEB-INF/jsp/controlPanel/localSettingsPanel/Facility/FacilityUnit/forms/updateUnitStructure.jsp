<%-- 
    Document   : updateUnitStructure
    Created on : Sep 12, 2018, 4:57:41 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="row">
    <div class="col-md-12">
        <form name="submitData" id="submitData">
            <div class="tile">
                <div class="tile-body">
                    <div class="row">
                        <div class="col-md-4">
                            <c:if test="${not empty model.structureListArr}">
                                <div class="form-group">
                                    <label class="control-label">Set Object:${model.unitObj.facilityunitname} Level Name</label>
                                    <select class="form-control" id="hyrchId" name="hyrchId" onChange="if (this.value === 0) {return false;}">
                                        <c:forEach items="${model.structureListArr}" var="list" varStatus="status">
                                            <option value="${list[0]}" selected="selected">${list[1]}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </c:if> 
                            <div class="form-group">
                                <c:if test="${model.serviceLevelObj==false}">
                                    <label class="control-label">
                                        Select ${model.levelHyrchObj.hierachylabel}
                                    </label>
                                    <div id="structureSelect${i}">
                                        <select class="form-control" id="sselect" name="sselect" onChange="if (this.value === '0') {
                                                $('#parentId').val(0);
                                                return false;
                                            }
                                            $('#parentId').val(this.value);">
                                            <option value="0">-Select Level-</option>
                                            <c:forEach items="${model.hyrchList}" var="list" varStatus="status">
                                                <option value="${list.facilityunitid}">${list.facilityunitname}</option>
                                            </c:forEach>
                                        </select>
                                    </div>    
                                    <c:set var="i" value="${i+1}"></c:set>
                                </c:if>
                                <c:if test="${model.serviceLevelObj==true}">
                                    <div id="selectHrchyYes">
                                        <label class="control-label">
                                            Set Structure
                                        </label>

                                        <select class="form-control" id="sselect" name="sselect" onChange="if (this.value === '0') {
                                                $('#parentId').val(0);
                                                return false;
                                            }
                                                <c:if test="${model.serviceLevelObj==true}">
                                            ajaxSubmitData('facStructureLoader.htm', 'structureSelect1', 'act=c&i=' + this.value + '&b=${model.b}&c=a&d=1&e=<c:if test="${not empty model.hyrchObj.structureid}">${model.hyrchObj.structureid}</c:if><c:if test="${empty model.hyrchObj.structureid}">0</c:if>', 'GET');
                                                </c:if>">
                                            <option value="0">-Select ${model.levelHyrchObj.hierachylabel}-</option>
                                            <c:forEach items="${model.hyrchList}" var="list" varStatus="status">
                                                <option value="${list.facilityunitid}">${list.facilityunitname}</option>
                                            </c:forEach>
                                        </select>
                                        <div id="structureSelect1"></div> 
                                    </div>
                                    <div id="selectHrchyNo"></div>
                                </c:if>
                            </div>
                            <div class="form-group">
                                <label class="control-label">
                                    <c:if test="${not empty model.unitObj.facilitystructure}">${model.unitObj.facilitystructure.hierachylabel} Name </c:if>
                                    <c:if test="${empty model.unitObj.facilitystructure}">Unit Name </c:if>
                                    </label>
                                ${model.unitObj.facilityunitname}
                                <input type="hidden" id="parentId" name="parentId" value="0"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tile-footer">
                <div class="row" id="submitBtns" >
                    <div class="col-sm-12">
                        <div class="form-actions" >
                            <input type="hidden" name="serviceState" id="serviceState" value="${model.hyrchObj.service}"/>
                            <input type="hidden" name="cref" id="cref" value="${model.unitObj.facilityunitid}"/>
                            <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                            <input type="hidden" name="formActivity" id="formActivity" value="update"/>
                            <div align="left" style="alignment-adjust: central;">
                                <div id="btnSaveHide">
                                    <c:if test="${model.hyrchObj.service==true || model.unstructuredUnits==true}">
                                        <input type="button" name="button" class='btn btn-primary' value="<c:if test="${empty model.unitObj}">Save</c:if><c:if test="${not empty model.unitObj}">Update</c:if> ${model.hyrchObj.hierachylabel}" onClick="var resp = validateB4SubmitUnit();
                                            if (resp === false) {
                                                return false;
                                            }
                                            ajaxSubmitForm('structureFacilityUnit.htm', 'addUnitResponse-pane', 'submitData');"/>
                                    </c:if>
                                    <c:if test="${model.hyrchObj.service==false}">
                                        <input type="button" name="button" class='btn btn-primary' value="<c:if test="${empty model.unitObj}">Save</c:if><c:if test="${not empty model.unitObj}">Update</c:if> Hierarchy" onClick="var resp = validateB4SubmitUnit();
                                            if (resp === false) {
                                                return false;
                                            }
                                            ajaxSubmitForm('structureFacilityUnit.htm', 'addUnitResponse-pane', 'submitData');"/>
                                    </c:if>    
                                    &nbsp;&nbsp;
                                    <input name="" type="reset" value="Reset" class="btn" onClick="$(this.form)[0].reset()">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </form>
    </div>
</div>
<script>
    $(document).ready(function () {
        breadCrumb();
        $('[data-toggle="popover"]').popover();
        $('#panel-addUnit').modal('show');
    });

    function validateB4SubmitUnit() {
        var parentId = document.getElementById('parentId').value;
        if (parentId === '0') {
            showWarningSuccess('${model.levelHyrchObj.hierachylabel} Field', 'Facility Level Structure Not Selected!', 'warning', 'errorCheck1');
            return false;
        }
        return true;
    }

    function showWarningSuccess(title, message, type, div) {
        $.toast({
            heading: title,
            text: message,
            icon: type,
            hideAfter: 3000,
            //position: 'mid-center'
            element: '#' + div,
            position: 'mid-center',
        });

    }
</script>                        
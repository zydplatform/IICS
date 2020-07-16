<%-- 
    Document   : formTransferUnit
    Created on : Jun 13, 2018, 10:42:47 AM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<legend>
    <div style="float:left" align="left">
        <c:if test="${empty model.viewForm}">
            <a id="back" href="#"  onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${model.d}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a>
            </c:if>
            <c:if test="${not empty model.viewForm}">
            <a id="back" href="#"  onClick="${model.returnURL}"> <i class="fa fa-backward"></i></a>
            </c:if>
    </div>
</legend>
<div class="row">
    <div class="col-md-12">
        <div id="addUnitResponse-pane">
            <form name="submitData" id="submitData">
                <div class="row" id="addUpdate">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="row" id="facUnitInfoDiv">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="control-label">
                                                Transfer Attachments Under ${model.unitObj.facilitystructure.hierachylabel}:
                                            </label>
                                            ${model.unitObj.facilityunitname}
                                        </div>
                                        <c:if test="${not empty model.transferArrList}">
                                            <div class="form-group">
                                                <label class="control-label">
                                                    Destination Level:
                                                </label>
                                                <select class="form-control" id="selectLevel" name="selectLevel" <c:if test="${empty model.transferArrList}">disabled="disabled"</c:if> onChange="clearDiv('structureSelect1');
                                                    if (this.value == 0) {
                                                        $('#parentId').val(0);
                                                        return false;
                                                    }
                                                    $('#parentId').val(this.value);
                                                    ajaxSubmitData('facStructureLoader.htm', 'structureSelect1', 'act=b&i=' + this.value + '&b=${model.b}&c=${model.isAttachedUnit}&d=1&e=${model.unitObj.facilitystructure.structureid}', 'GET');">
                                                    <c:if test="${empty model.transferArrList}">
                                                        <option value="0">No Registered Optional ${model.unitObj.facilitystructure.hierachylabel} For Transfer</option>
                                                    </c:if>
                                                    <c:if test="${not empty model.transferArrList}">
                                                        <option value="0">--Select Transfer Destination--</option>
                                                    </c:if>        
                                                    <c:forEach items="${model.transferArrList}" var="unit">                                
                                                        <option value="${unit[0]}">${unit[3]}: ${unit[1]}</option>
                                                    </c:forEach>
                                                </select>
                                                <div id="structureSelect1"></div>    
                                            </div>
                                        </c:if>    
                                    </div>
                                </div>
                                <div class="row">
                                    <fieldset style="width:70%">
                                        <legend>Transfer List</legend>
                                        <table class="table table-hover table-bordered" id="transferTable">
                                            <thead>
                                                <tr>
                                                    <th>No</th>
                                                    <th>Facility Structure</th>
                                                    <th>Name</th>
                                                    <th class="center">Transfer</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tableUnits">
                                                <c:set var="n" value="0"></c:set>
                                                <c:forEach items="${model.unitHychArrList}" var="list">
                                                    <c:set var="n" value="${n+1}"></c:set>
                                                    <tr id="${list[0]}">
                                                        <td>${n}</td>
                                                        <td>${list[3]}</td>
                                                        <td>${list[1]}</td>
                                                        <td class="center">
                                                            <input type="checkbox" name="selectObj${n}" id="selectObj${n}" value="${list[0]}" onChange="if (this.checked) {
                                                                        document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) + 1
                                                                    } else {
                                                                        document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) - 1
                                                                    }
                                                                    var ticks = document.getElementById('selectedObjs').value;
                                                                    if (ticks > 0) {
                                                                        $('#btnTransfer').attr('disabled', false);
                                                                    }
                                                                    if (ticks == 0) {
                                                                        $('#btnTransfer').attr('disabled', true);
                                                                    }"/>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </fieldset>
                                </div>
                            </div>
                            <div class="tile-footer">
                                <div class="row" id="submitBtns" >
                                    <div class="col-sm-12">
                                        <div class="form-actions">
                                            <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                                            <input type="hidden" name="destRef" id="parentId" value="0"/>
                                            <input type="hidden" name="cref" id="cref" value="${model.unitObj.facilityunitid}"/>
                                            <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                            <input type="hidden" name="formActivity" id="formActivity" value="update"/>
                                            <input type="hidden" name="isAttachedUnit" id="isAttachedUnit" value="${model.isAttachedUnit}"/>
                                            <div align="left" style="alignment-adjust: central;">
                                                <div id="btnSaveHide">
                                                    <input type="button" name="button" disabled="disabled" id="btnTransfer" class='btn btn-primary' value="Transfer Units Under ${model.unitObj.facilitystructure.hierachylabel}" onClick="var resp = validateB4SubmitUnit();
                                                            if (resp === false) {
                                                                return false;
                                                            }
                                                            var parent = $('#parentId').val();
                                                            ajaxSubmitData('facilityUnitSetting.htm', 'addUpdate', 'act=i&i=' + parent + '&b=${model.b}&c=${model.a}&d=${model.unitObj.facilityunitid}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"/>
                                                    &nbsp;&nbsp;
                                                    <input name="" type="reset" value="Reset" class="btn" onClick="$(this.form)[0].reset()">
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
    function validateB4SubmitUnit() {
        var parentId = document.getElementById('parentId').value;
        if (parentId === null || parentId === '') {
            alert('Destination Unit Missing/Not Set!');
            return false;
        }
        return true;
    }
</script>
<script>
    $('#transferTable').DataTable();
</script>
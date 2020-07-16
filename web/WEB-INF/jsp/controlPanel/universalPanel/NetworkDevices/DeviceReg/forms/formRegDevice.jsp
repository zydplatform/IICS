<%-- 
    Document   : formRegDevice
    Created on : Mar 12, 2018, 1:21:50 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="titleAct" value="APPROVE DEVICE ACCESS"></c:set>    
<c:if test="${not empty model.devObjArr}"><c:set var="titleAct" value="PERMIT DEVICE ACCESS"></c:set></c:if>

        <div class="modal fade col-md-12" id="panel-grantAccess" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width: 153%;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">${titleAct}</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=a4&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');  clearDiv('addnew-pane');">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container">
                            <div class="row" id="response-pane">
                                <div class="col-md-12">
                                    <div class="tile">
                                        <form class="form-horizontal" name="submitData" id="submitData" >

                                            <div class="tile-body">

                                                <div class="form-group row">
                                                    <label class="col-sm-5 control-label" for="manufacturer">Device Manufacturer:<span class="symbol required"></label>
                                                    <div class="col-sm-5">
                                                    ${model.devObj.devicemanufacturer.manufacturer}    
                                                    <input type="hidden" name="manufacturer" id="manufacturer" value="${model.devObj.devicemanufacturer.devicemanufacturerid}"/>
                                                <input type="hidden" id='logId' name='logId' value='${model.devObj.computerloghistory.computerloghistoryid}'/>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="condition">Device Condition:<span class="symbol required"></label>
                                            <div class="col-sm-5">
                                                ${model.devObj.physicalcondition}
                                                <input type="hidden" name="cond" id="cond" value="${model.devObj.physicalcondition}"/>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="condition">Operating System:<span class="symbol required"></label>
                                            <div class="col-sm-5">
                                                ${model.devObj.operatingsystem}
                                                <input type="hidden" name="osName" id="osName" value="${model.devObj.operatingsystem}"/>
                                            </div>
                                        </div>    
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="person">Request Sent By:</label>
                                            <div class="col-sm-5">
                                                ${model.devObj.person.firstname} ${model.devObj.person.lastname}
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="date">Date Requested:</label>
                                            <div class="col-sm-5"><fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${model.devObj.daterequested}"/></div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="serial">Serial Number:</label>
                                            <div class="col-sm-5">${model.devObj.serialnumber}</div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="person">OS Type:</label>
                                            <div class="col-sm-5">${model.devObj.computerloghistory.operatingsystem}</div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="mac">Physical/Mac Address:</label>
                                            <div class="col-sm-5">${model.devObj.computerloghistory.macaddress}</div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="note">Request Note:</label>
                                            <div class="col-sm-5">${model.devObj.requestnote}</div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="status">Approve Request:</label>
                                            <div class="col-sm-5">
                                                Grant: <input type="radio" name="status" id="fstatus" value="true"/>
                                                &nbsp;&nbsp;
                                                Deny: <input type="radio" name="status" id="tstatus" value="false" checked="checked"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <div class="form-actions" align="center">
                                                    <input type="hidden" name="cref" id="cref" value="${model.devObj.requestid}"/>
                                                    <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                                    <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                                    <div align="left" style="alignment-adjust: central;">
                                                        <div id="btnSaveHide">
                                                            <input type="button" id="saveButton" name="button" class="btn btn-primary" value='Register Device' onClick="var resp = validateB4Submit();
                                                                    if (resp === false) {
                                                                        return false;
                                                                    }
                                                                    ajaxSubmitForm('regPendingNetDevice.htm', 'response-pane', 'submitData');"/> 
                                                            &nbsp;&nbsp;
                                                            <input name="" type="reset" value="Reset" class="btn">
                                                        </div>
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
    function validateB4Submit() {
        var manufacturer = document.getElementById('manufacturer').value;
        var cond = document.getElementById('cond').value;

        if (manufacturer === null || manufacturer === '0' || cond === null || cond === '0') {
            if (manufacturer === null || manufacturer === '0') {
                alert('Device Manufacturer Not Selected!');
            }
            if (cond === null || cond === '0') {
                alert('Device Condition Not Selected!');
            }
            return false;
        }
        return true;
    }

    //function closeDialog(){$('#panel-grantAccess').modal('hide'); }
    $('#panel-grantAccess').modal('show');
</script>



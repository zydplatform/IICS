<%-- 
    Document   : formRegdDevice
    Created on : Mar 19, 2018, 09:29:00 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="titleAct" value="DENY DEVICE ACCESS"></c:set>    
<c:if test="${model.devObj.active==false}"><c:set var="titleAct" value="PERMIT DEVICE ACCESS"></c:set></c:if>

        <div class="modal fade" id="panel-grantAccess" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 150%;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">${titleAct}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=a2&i=0&b=${model.b}&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET'); clearDiv('addnew-pane');">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                        <!-- start: FORM VALIDATION 1 PANEL -->
                        <div class="panel panel-default">
                            <div class="panel-body" id="response-pane">
                                <form name="submitData" id="submitData" class="form-horizontal">
                                        <div class="panel-body">
                                            <div class="form-group row">
                                                <label class="col-sm-5 control-label" for="manufacturer">Device Manufacturer:<span class="symbol required"></label>
                                                <div class="col-sm-5">${model.devObj.devicemanufacturer.manufacturer}</div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-5 control-label" for="condition">Device Condition:<span class="symbol required"></label>
                                                <div class="col-sm-5">${model.devObj.physicalcondition}</div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-5 control-label" for="person">Device Owner:</label>
                                                <div class="col-sm-5">${model.devObj.person.firstname} ${model.devObj.person.lastname}</div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-5 control-label" for="serial">Serial Number:</label>
                                                <div class="col-sm-5">${model.devObj.serialnumber}</div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-5 control-label" for="person">OS Type:</label>
                                                <div class="col-sm-5">${model.devObj.operatingsystem}</div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-5 control-label" for="mac">Physical/Mac Address:</label>
                                                <div class="col-sm-5">${model.devObj.macaddress}</div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-sm-5 control-label" for="status">Manage Access:</label>
                                                <div class="col-sm-5">
                                                    Grant: <input type="radio" name="status" id="fstatus" value="true" <c:if test="${model.devObj.active==true}">checked="checked"</c:if>/>
                                                        &nbsp;&nbsp;
                                                        Deny: <input type="radio" name="status" id="tstatus" value="false" <c:if test="${model.devObj.active==false}">checked="checked"</c:if>/>
                                                    </div>
                                                </div>
                                            </div>
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-actions" align="center">
                                                    <input type="hidden" name="cref" id="cref" value="${model.devObj.registereddeviceid}"/>
                                                <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                                <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                                <div align="left" style="alignment-adjust: central;">
                                                    <div id="btnSaveHide">
                                                        <input type="button" id="saveButton" name="button" class="btn btn-primary" value='Save Change' onClick="ajaxSubmitForm('manageRegdNetDevice.htm', 'response-pane', 'submitData');"/> 
                                                        &nbsp;&nbsp;
                                                        <input name="" type="reset" value="Reset" class="btn">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                <div class="modal-footer">

                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
</div>


<script>
    //function closeDialog(){$('#panel-grantAccess').modal('hide'); }

    $('#panel-grantAccess').modal('show');


</script>
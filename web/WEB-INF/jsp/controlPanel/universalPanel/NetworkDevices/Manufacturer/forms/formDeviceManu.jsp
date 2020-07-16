<%-- 
    Document   : formDeviceManu
    Created on : Mar 6, 2018, 3:39:53 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="titleAct" value="ADD NEW"></c:set>    
<c:if test="${not empty model.manuObjArr}"><c:set var="titleAct" value="UPDATE"></c:set></c:if>

<div class="modal fade col-md-12" id="addDeviceMan" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">${titleAct} ${model.facilityType}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="clearDiv('panel_overview'); ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container" id="response-pane">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <form name="submitData" id="submitData" class="form-horizontal">
                                    <div class="tile-body">
                                        <div class="form-group row">
                                                <label class="col-sm-5 control-label" for="mname" >Manufacturer:</label>
                                                <div class="col-sm-8">
                                                    <input type="text" name="mname" id="mname" class='form-control' value="${model.manuObjArr[1]}">
                                                </div>
                                            </div>                                                
                                            <div class="form-group row">
                                                <label class="col-sm-5 control-label" for="status">Status:</label>
                                                <div class="col-sm-8">
                                                    Activated: <input type="radio" name="status" id="fstatus" value="true" <c:if test="${model.manuObjArr[2]==true || empty model.manuObjArr}">checked="checked"</c:if>/>
                                                    &nbsp;&nbsp;
                                                    Blocked: <input type="radio" name="status" id="tstatus" value="false" <c:if test="${model.manuObjArr[2]==false}">checked="checked"</c:if>/>
                                                </div>
                                            </div>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <input type="hidden" name="cref" id="cref" value="${model.manuObjArr[0]}"/>
                                                <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                                <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                                <div align="left" style="alignment-adjust: central;">
                                                    <div id="btnSaveHide">
                                                        <input type="button" id="saveButton" name="button" class="btn btn-primary" value='<c:if test="${empty model.manuObjArr}">Save</c:if><c:if test="${not empty model.manuObjArr}">Update</c:if> Manufacturer' onClick="var resp=validateB4Submit(); if(resp===false){return false;} ajaxSubmitForm('regDeviceManufacturer.htm', 'response-pane', 'submitData');"/> 
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
    function validateB4Submit(){
        var mname=document.getElementById('mname').value;
        
        if(mname===null || mname===''){
            alert('Manufacturer Name Missing!');
            return false;
        }
        return true;
    } 

     $('#addDeviceMan').modal('show'); 
</script>

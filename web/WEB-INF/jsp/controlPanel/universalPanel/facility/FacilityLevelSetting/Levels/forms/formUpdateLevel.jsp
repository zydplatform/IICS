<%-- 
    Document   : formUpdateLevel
    Created on : Dec 8, 2017, 6:49:50 AM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="titleAct" value="ADD NEW"></c:set>    
<c:if test="${not empty model.levelObjArr}"><c:set var="titleAct" value="UPDATE"></c:set></c:if>


<div class="modal fade" id="panel-addlevel4" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" style="width:60%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onClick="ajaxSubmitData('categoryLevelSetting.htm', 'workPane', 'act=a&i=0&b=${model.b}&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
                    &times;
                </button>
                <h4><i class="fa fa-pencil-square teal"></i> ${titleAct} ${model.facilityType}</h4>
            </div>
            <div class="modal-body" id="levelResponsePane">
                <div class="row">
                    <div class="col-md-12">
                        <!-- start: FORM VALIDATION 1 PANEL -->
                        <div class="panel panel-default">
                            <div class="panel-heading"></div>
                            <div class="panel-body" id="levelResponse-pane">
                                <form name="submitData" id="submitData" class="form-horizontal">
                                    <div class="row">
                                        <div class="panel-body">

                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="orgname">Level/Type:<span class="symbol required"></label>
                                                <div class="col-sm-5">
                                                    <input type="text" placeholder="Text Field" value="${model.levelObjArr[1]}" placeholder="${model.facilityType}" class="form-control" id="levelname" name="levelname">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="orgname">Short Name:<span class="symbol required"></label>
                                                <div class="col-sm-5">
                                                    <input type="text" placeholder="Text Field" value="${model.levelObjArr[2]}" placeholder="Short Name" class="form-control" id="shortname" name="shortname">
                                                </div>
                                            </div>    
                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="description" >Description:<span class="symbol required"></label>
                                                <div class="col-sm-5">
                                                    <textarea name="description" id="description" class='form-control'>${model.levelObjArr[3]}</textarea>
                                                </div>
                                            </div>                                                
                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="status">Released:</label>
                                                <div class="col-sm-5">
                                                    Yes: <input type="radio" name="status" id="fstatus" value="true" <c:if test="${model.levelObjArr[4]==true || empty model.levelObjArr}">checked="checked"</c:if>/>
                                                    &nbsp;&nbsp;
                                                    No: <input type="radio" name="status" id="tstatus" value="false" <c:if test="${model.levelObjArr[4]==false}">checked="checked"</c:if>/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-actions" align="center">
                                                <input type="hidden" name="cref" id="cref" value="${model.levelObjArr[0]}"/>
                                                <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                                <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                                <div align="left" style="alignment-adjust: central;">
                                                    <div id="btnSaveHide">
                                                        <input type="button" id="saveButton" name="button" class="btn btn-purple" value='<c:if test="${empty model.levelObjArr}">Save</c:if><c:if test="${not empty model.levelObjArr}">Update</c:if> Level' onClick="var resp=validateB4Submit(); if(resp===false){return false;} ajaxSubmitForm('regCategoryLevel.htm', 'levelResponsePane', 'submitData');"/> 
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
    function validateB4Submit(){
        var levelname=document.getElementById('levelname').value;
        var shortname=document.getElementById('shortname').value;
        var description=document.getElementById('description').value;
        
        if(levelname===null || levelname==='' || shortname===null || shortname==='' || description==='' || description===null){
            if(levelname===null || levelname===''){alert('Level Name Missing!');}
            if(shortname===null || shortname===''){alert('Short Name Missing!');}
            if(description===null || description===''){alert('Description Missing!');}  
            return false;
        }
        return true;
    } 

     $('#panel-addlevel4').modal('show'); 
</script>
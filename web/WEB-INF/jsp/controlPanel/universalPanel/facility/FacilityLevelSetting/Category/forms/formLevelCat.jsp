<%-- 
    Document   : formLevelCat
    Created on : Dec 5, 2017, 9:57:00 AM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="titleAct" value="ADD NEW"></c:set>    
<c:if test="${not empty model.catObjArr}"><c:set var="titleAct" value="UPDATE"></c:set></c:if>


<div class="modal fade" id="panel-addlevel2" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onClick="clearDiv('workPane'); ajaxSubmitData('orgLevelSetting.htm', 'workPane', 'act=b&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    &times;
                </button>
                <h4><i class="fa fa-pencil-square teal"></i> ${titleAct} ${model.facilityType}</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <!-- start: FORM VALIDATION 1 PANEL -->
                        <div class="panel panel-default">
                            <div class="panel-heading"></div>
                            <div class="panel-body" id="orgResponse-pane">
                                <form name="submitData" id="submitData" class="form-horizontal">
                                    <div class="row">
                                        <div class="panel-body">

                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="orgname">Domain Name:<span class="symbol required"></label>
                                                <div class="col-sm-5">
                                                    <input type="text" placeholder="Text Field" value="${model.catObjArr[1]}" placeholder="${model.facilityType}" class="form-control" id="catname" name="catname">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="description" >Description:<span class="symbol required"></label>
                                                <div class="col-sm-5">
                                                    <textarea name="description" id="description" class='form-control'>${model.catObjArr[2]}</textarea>
                                                </div>
                                            </div>                                                
                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="status">Status:</label>
                                                <div class="col-sm-5">
                                                    Active: <input type="radio" name="status" id="fstatus" value="true" <c:if test="${model.catObjArr[3]==true || empty model.catObjArr}">checked="checked"</c:if>/>
                                                    &nbsp;&nbsp;
                                                    Inactive: <input type="radio" name="status" id="tstatus" value="false" <c:if test="${model.catObjArr[3]==false}">checked="checked"</c:if>/>
                                                </div>
                                            </div>
                                                    <c:if test="${empty model.catObjArr}">
                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="status">Enter No. Of Levels:</label>
                                                <div class="col-sm-2">
                                                    <input type="text" value="0" maxlength="1" placeholder="Assign" onKeyPress="return isNumberKey(event)" class="form-control" id="levels" name="levels">
                                                </div>
                                            </div>    
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-actions" align="center">
                                                <input type="hidden" name="cref" id="cref" value="${model.catObjArr[0]}"/>
                                                <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                                <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                                <div align="left" style="alignment-adjust: central;">
                                                    <div id="btnSaveHide">
                                                        <input type="button" id="saveButton" name="button" class="btn btn-purple" value='<c:if test="${empty model.catObjArr}">Save</c:if><c:if test="${not empty model.catObjArr}">Update</c:if> Domain' onClick="var resp=validateB4Submit(); if(resp===false){return false;} ajaxSubmitForm('regLevelCategory.htm', 'orgResponse-pane', 'submitData');"/> 
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
        var catname=document.getElementById('catname').value;
        var description=document.getElementById('description').value;
        
        if(catname===null || catname==='' || description==='' || description===null){
            if(catname===null || catname===''){alert('Category Name Missing!');}
            if(description===null || description===''){alert('Category Description Missing!');}  
            return false;
        }
        return true;
    } 

     $('#panel-addlevel2').modal('show'); 
</script>
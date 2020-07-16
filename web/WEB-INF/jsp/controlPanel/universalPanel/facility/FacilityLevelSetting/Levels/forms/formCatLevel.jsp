<%-- 
    Document   : formCatLevel
    Created on : Dec 6, 2017, 8:41:57 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="titleAct" value="ADD NEW"></c:set>    
<c:if test="${not empty model.levelObjArr}"><c:set var="titleAct" value="UPDATE"></c:set></c:if>


<div class="modal fade" id="panel-addOrg" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" style="width:60%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onClick="ajaxSubmitData('categoryLevelSetting.htm', 'workPane', 'act=a&i=${model.i}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
                    &times;
                </button>
                <h4><i class="fa fa-pencil-square teal"></i> Add New School Types</h4>
            </div>
            <div class="modal-body" id="levelResponsePane">
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
                                                <label class="col-sm-5 control-label" for="status">Enter No. Of Levels:</label>
                                                <div class="col-sm-2">
                                                    <input type="text" value="0" maxlength="1" placeholder="Assign" onKeyPress="return isNumberKey(event)" class="form-control" id="levels" name="levels">
                                                </div>
                                            </div>    
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-actions" align="center">
                                                <div align="left" style="alignment-adjust: central;">
                                                    <div id="btnSaveHide">
                                                        <input type="button" id="saveButton" name="button" class="btn btn-purple" value='Next' onClick="var levels =$('#levels').val(); ajaxSubmitData('categoryLevelSetting.htm', 'levelResponsePane', 'act=g&i=${model.d}&b=${model.b}&c=${model.c}&d='+levels+'&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"/> 
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

     $('#panel-addOrg').modal('show'); 
</script>

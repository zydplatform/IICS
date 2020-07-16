<%-- 
    Document   : addChildNode
    Created on : May 17, 2018, 11:45:13 PM
    Author     : samuelwam
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="titleAct" value="ADD NEW NODE"></c:set>    
<c:if test="${not empty model.hyrchObjArr}"><c:set var="titleAct" value="UPDATE"></c:set></c:if>


        <fieldset style="width:95%; margin: 0 auto;" >
            <legend> 
                <div style="float:left" align="left"><a id="back" href="#"  onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=d&i=${model.i}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a></div>
                &nbsp;&nbsp;&nbsp;
        Add New Node Under ${model.hyrchObjArr[1]}
    </legend>
        <div class="row">
            <div class="col-md-12">
                    <div class="tile" id="hyrchResponse-pane">
                        <form name="submitData" id="submitData" class="form-horizontal">
                            <div class="tile-body">
                                <div class="row">
                                    <div class="panel-body">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="lvlname">Child Node Name:<span class="symbol required"></label>
                                            <div class="col-sm-7">
                                                <input type="text" value="" placeholder="Node Name/Label" class="form-control" id="lvlname" name="lvlname">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="description" >Description:<span class="symbol required"></label>
                                            <div class="col-sm-7">
                                                <textarea name="description" id="description" class='form-control' placeholder="Descibe Node Here!" ></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="status">Status:</label>
                                            <div class="col-sm-7">
                                                Active: <input type="radio" name="status" id="fstatus" checked="checked" value="true"/>
                                                &nbsp;&nbsp;
                                                Inactive: <input type="radio" name="status" id="tstatus" value="false"/>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="status">Is Service Level:</label>
                                            <div class="col-sm-7">
                                                Yes: <input type="radio" name="services" id="fservices" value="true"/>
                                                &nbsp;&nbsp;
                                                No: <input type="radio" name="services" id="tservices" checked="checked" value="false"/>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <input type="hidden" name="pos" id="pos" value="0"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tile-footer">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-actions" align="center">
                                            <input type="hidden" name="cref" id="cref" value="${model.hyrchObjArr[0]}"/>
                                            <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                            <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                            <div align="left" style="alignment-adjust: central;">
                                                <div id="btnSaveHide">
                                                    <input type="button" id="saveButton" name="button" class='btn btn-primary'  aria-hidden="true" value="<c:if test="${empty model.hyrchObjArr}">Save</c:if><c:if test="${not empty model.hyrchObjArr}">Update</c:if> Node" onClick="var resp = validateB4Submit(); if (resp == false) {
                                                            return false;
                                                        }
                                                        ajaxSubmitForm('registerOrgLevelNode.htm', 'hyrchResponse-pane', 'submitData');"/> 
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
</fieldset>


<script>
    function validateB4Submit() {
        var lvlname = document.getElementById('lvlname').value;
        var description = document.getElementById('description').value;

        if (lvlname === null || lvlname === '' || description === '' || description === null) {
            if (lvlname === null || lvlname === '') {
                //alert('Level Name Missing!');
                showWarningSuccess('Level Name Missing!', 'Enter Missing Level Name!', 'warning', 'errorCheck1');
                $('#lvlname').focus();
                $('#lvlname').css('border', '2px solid #f50808c4');
            }
            if (description === null || description === '') {
                //alert('Level Description Missing!');
                showWarningSuccess('Level Description Missing!!', 'Enter Missing Level Description!', 'warning', 'errorCheck1');
                $('#description').css('border', '2px solid #f50808c4');
            }
            if (lvlname !== '') {
                $('#lvlname').css('border', '2px solid #ced4da');
            }
            if (description !== '') {
                $('#description').css('border', '2px solid #ced4da');
            }
            return false;
        }else{
            if (lvlname !== '' && description !== '') {
                //alert("No Zibs!!!!");
                $('#lvlname').css('border', '2px solid #ced4da');
                $('#description').css('border', '2px solid #ced4da');
            }
        }
        return true;
    }

</script>

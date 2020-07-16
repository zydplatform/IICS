<%-- 
    Document   : formFacLevel
    Created on : May 17, 2018, 12:55:25 AM
    Author     : samuelwam
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../../../../../include.jsp"%>

<!--<div class="modal fade col-md-12" id="panel-addHyrch" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">-->
        <div class="modal-content" style="width:80%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Add New Structure Node</h5>
                <!--<button type="button" class="close" data-dismiss="modal" aria-label="Close"  onClick="clearDiv('workPane'); ajaxSubmitData('facilityUnitSetUp.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    <span aria-hidden="true">&times;</span>
                </button>-->
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile" id="hyrchResponse-pane">
                                <form class="form-horizontal" name="submitData" id="submitData">
                                    <div class="tile-body">
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="lvlname">Level Name:<span class="symbol required"></label>
                                            <div class="col-sm-5">
                                                <input type="text" value="${model.hyrchObjArr[1]}" placeholder="${model.facilityType}" class="form-control" id="lvlname" name="lvlname">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="description" >Description:<span class="symbol required"></label>
                                            <div class="col-sm-5">
                                                <textarea name="description" id="description" class='form-control'>${model.hyrchObjArr[2]}</textarea>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-5 control-label" for="status">Status:</label>
                                            <div class="col-sm-5">
                                                Active: <input type="radio" name="status" id="fstatus" <c:if test="${model.hyrchObjArr[3]==true || empty model.hyrchObjArr}">checked="checked"</c:if> value="true"/>
                                                    &nbsp;&nbsp;
                                                    Inactive: <input type="radio" name="status" id="tstatus" <c:if test="${model.hyrchObjArr[3]==false}">checked="checked"</c:if> value="false"/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-5 control-label" for="status">Is Service Level:</label>
                                                <div class="col-sm-7">
                                                    Yes: <input type="radio" name="services" id="fservices" value="true" <c:if test="${model.hyrchObjArr[10]==true}">checked="checked"</c:if>/>
                                                    &nbsp;&nbsp;
                                                    No: <input type="radio" name="services" id="tservices" value="false" <c:if test="${model.hyrchObjArr[10]==false || empty model.hyrchObjArr}">checked="checked"</c:if>/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <input type="hidden" name="pos" id="pos" value="0"/>
                                            </div>
                                        </div>
                                        <div class="tile-footer">
                                            <div class="row">
                                                <div class="col-md-8 col-md-offset-3">
                                                    <div class="form-actions" align="center">
                                                        <input type="hidden" name="cref" id="cref" value="${model.hyrchObjArr[0]}"/>
                                                    <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                                    <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                                    <div align="left" style="alignment-adjust: central;">
                                                        <div id="btnSaveHide">
                                                            <input type="button" id="saveButton" name="button" class='btn btn-primary' aria-hidden="true" value="<c:if test="${empty model.hyrchObjArr}">Save</c:if><c:if test="${not empty model.hyrchObjArr}">Update</c:if> Structure Level" onClick="var resp = validateB4Submit(); if (resp == false) {
                                                                        return false;
                                                                    }
                                                                    ajaxSubmitForm('registerFacLevel.htm', 'hyrchResponse-pane', 'submitData');"/> 
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
        <div id="errorCheck1"></div>
    <!--</div>
</div>-->
<script>
    $(document).ready(function () {
        breadCrumb();
        $('[data-toggle="popover"]').popover();
        //$('#panel-addHyrch').modal('show');
    });

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


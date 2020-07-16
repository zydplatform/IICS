<%-- 
    Document   : viewHyrchDetails
    Created on : May 15, 2018, 1:25:28 PM
    Author     : samuelwam
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset style="width:95%; margin: 0 auto;" >
    <legend> 
        <div style="float:left" align="left"><a id="back" href="#"  onClick="ajaxSubmitData('facilityUnitSetUp.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a></div>
        &nbsp;&nbsp;&nbsp;
        Details For Hierarchy Node Under: ${model.facObj.facilityname}
    </legend>
    <div  id="hyrchResponse-pane">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <form name="submitData" id="submitData" class="form-horizontal">
                            <div class="row">
                                <div class="panel-body">
                                    <div class="form-group row">
                                        <label class="control-label" for="orgcode">Node Label:</label>
                                        <div >
                                            <c:if test="${not empty model.hyrchObj.hierachylabel}">${model.hyrchObj.hierachylabel}</c:if>
                                            <c:if test="${empty model.hyrchObj.hierachylabel}"><span class="text2">Pending</span></c:if>
                                        </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label" for="description" >Description:</label>
                                            <div>
                                            <c:if test="${not empty model.hyrchObj.description}">${model.hyrchObj.description}</c:if>
                                            <c:if test="${empty model.hyrchObj.description}"><span class="text2">Pending</span></c:if>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label" for="status">Status:</label>
                                            <div>
                                            <c:if test="${model.hyrchObj.active==true}">Active</c:if>
                                            <c:if test="${model.hyrchObj.active==false}">Inactive</c:if>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label" for="status">Is Service Level:</label>
                                            <div>
                                            <c:if test="${model.hyrchObj.service==true}">Yes</c:if>
                                            <c:if test="${model.hyrchObj.service==false}">No</c:if>
                                            </div>
                                        </div>    
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="panel-body">
                                        <div class="form-group row">
                                            <input type="button" id="updateButton" name="button" class='btn btn-primary' aria-hidden="true" value="Update Node" onClick="ajaxSubmitData('facHierarchySetting.htm', 'hyrchResponse-pane', 'act=c&i=${model.hyrchObj.structureid}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"/> 
                                        &nbsp;&nbsp;
                                        <input type="button" id="delButton" name="button" class='btn btn-primary' value="Discard Node" data-dismiss="modal" aria-hidden="true" onClick="var resp = confirm('Discard Node: ${model.hyrchObj.hierachylabel}?');
                                                if (resp == false) {
                                                    return false;
                                                }
                                                ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=f&i=${model.hyrchObj.structureid}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"/> 
                                        <c:if test="${model.hyrchObj.isparent==true}">
                                            &nbsp;&nbsp;
                                            <input type="button" id="childButton" name="button" class='btn btn-primary' value="Add Main Node" onClick="
                                                    ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=b&i=${model.hyrchObj.structureid}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"/> 
                                        </c:if> 
                                        &nbsp;&nbsp;
                                        <input type="button" id="parentButton" name="button" class='btn btn-primary' data-dismiss="modal" <c:if test="${model.hyrchObj.service==true}">disabled="disabled"</c:if> aria-hidden="true" value="Add Child Node" onClick="
                                                ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=g&i=${model.hyrchObj.structureid}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"/> 
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="tile-footer">

                </div>
            </div>
        </div>
    </div>
                                    </div>
</fieldset>


    <script>
        $(document).ready(function () {
            breadCrumb();
            $('[data-toggle="popover"]').popover();
            //$('#panel-addHyrch2').modal('show');
        });

    </script>
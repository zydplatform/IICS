<%-- 
    Document   : viewEntityDesc
    Created on : Jan 22, 2018, 3:29:31 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>

<%@include file="../../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="modal fade" id="panel-addCat" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onClick="clearDiv('workPane'); ajaxSubmitData('entityDescSetting.htm', 'workPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    &times;
                </button>
                <h4><i class="fa fa-pencil-square teal"></i>Entity Description</h4>
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
                                                <label class="col-sm-5 control-label" for="description" >Description:</label>
                                                <div class="col-sm-5">
                                                    <c:if test="${not empty model.descObj.description}">${model.descObj.description}</c:if>
                                                    <c:if test="${empty model.descObj.description}"><span class="text2">Pending</span></c:if>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="status">Status:</label>
                                                <div class="col-sm-5">
                                                    <c:if test="${model.descObj.active==true}">Active</c:if>
                                                    <c:if test="${model.descObj.active==false}">Inactive</c:if>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="addedBy">Added By:</label>
                                                <div class="col-sm-5">
                                                    <c:if test="${not empty model.descObj.person.personname}">${model.descObj.person.personname}</c:if>
                                                    <c:if test="${empty model.descObj.person.personname}"><span class="text2">Pending</span></c:if> <br>
                                                    <fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${model.descObj.dateadded}"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="updatedBy">Updated By:</label>
                                                <div class="col-sm-5">
                                                    <c:if test="${not empty model.descObj.person1.personname}">${model.descObj.person1.personname}</c:if>
                                                    <c:if test="${empty model.descObj.person1.personname}"><span class="text2">Pending</span></c:if> <br>
                                                    <fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${model.descObj.dateupdated}"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-5 control-label" for="orgStructure">Attached Levels:</label>
                                                <div class="col-sm-5">
                                                    ${model.descObj.levels}
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
    $('#panel-addCat').modal('show'); 
</script>
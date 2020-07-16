<%-- 
    Document   : categoryLevelHome
    Created on : Dec 6, 2017, 8:40:34 PM
    Author     : samuelwam
--%>

<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<div class="col-sm-12">
    <div class="box box-color box-bordered">    
        <div class="box-title">
            <h3>
                <i class="fa fa-home"></i>
                Organisation Settings - Manage/Register School Types
            </h3>
        </div>

        <div style="float:left" align="left"><a id="back" href="#"  onClick="clearDiv('workPane'); ajaxSubmitData('organisationSetting.htm', 'workPane', 'act=g&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a></div>
        <div style="float:right">   
            <span class="text4" class="ui-state-highlight">${model.message}</span>
            <div id="AddNewRg" class="form-actions text5">
                <button class='btn btn-purple' id="popUpForm" name="popUpForm" 
                        onClick="ajaxSubmitData('categoryLevelSetting.htm', 'addnew-pane', 'act=d&i=0&b=${model.b}&c=${model.a}&d=0&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Add New Type <i class="fa fa-arrow-circle-down"></i></button>
                        &nbsp;
                <button class='btn btn-purple' id="popUpForm" name="popUpForm" 
                        onClick="ajaxSubmitData('entityDescSetting.htm', 'workPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Manage/Register Descriptions <i class="fa fa-arrow-circle-right"></i></button>
            </div>
        </div>
        
        <div id="response" class="box-content nopadding">
            <div id="addnew-pane"></div>
            <!--    
    <div class="modal fade" id="panel-addLevel" tabindex="-1" role="dialog" aria-hidden="true">
    
        <div class="modal-dialog" style="width:80%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onClick="clearDiv('workPane'); ajaxSubmitData('orgLevelSetting.htm', 'workPane', 'act=b&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                        &times;
                    </button>
                    <h4><i class="fa fa-pencil-square teal"></i>Manage ${model.facilityType}</h4>
                </div>
    
                <div class="modal-body">
                    <div style="float:left">   
                        <span class="text4" class="ui-state-highlight">${model.message}</span>
                        <div id="AddNewRg" class="form-actions text5">
                            <button class='btn btn-purple' data-dismiss="modal" aria-hidden="true" id="popUpForm" name="popUpForm" 
                                    onClick="ajaxSubmitData('categoryLevelSetting.htm', 'TempDialogDiv', 'act=d&i=0&b=${model.b}&c=${model.a}&d=${model.catObj.categoryid}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Add New Level <i class="fa fa-arrow-circle-down"></i></button>
                        </div>
                    </div>
            -->
            <c:if test="${not empty  model.levelList}">
                <form id="manageFormField2" name="manageFormField2">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- start: DYNAMIC TABLE PANEL -->

                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <i class="fa fa-external-link-square"></i>
                                    Manage School Types
                                    <div class="panel-tools">
                                        <a class="btn btn-xs btn-link panel-collapse collapses" href="#">
                                        </a>
                                        <a class="btn btn-xs btn-link panel-refresh" href="#">
                                            <i class="fa fa-refresh"></i>
                                        </a>
                                        <a class="btn btn-xs btn-link panel-expand" href="#">
                                            <i class="fa fa-resize-full"></i>
                                        </a>
                                        <a class="btn btn-xs btn-link panel-close" href="#">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <table class="table table-striped table-bordered table-hover table-full-width" id="sample_1">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th class="hidden-xs">School Type</th>
                                                <th class="hidden-xs">Short Name</th>
                                                <th>Description</th> 
                                                <th>Facilities</th> 
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEFACILITYLEVEL')">
                                                    <th>Manage</th> 
                                                    </security:authorize>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITYLEVEL')">
                                                    <th>Discard</th>
                                                    </security:authorize>

                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:set var="quantity" value="quantity"/>
                                            <c:set var="qtyServiced" value="0" />
                                            <c:forEach items="${model.levelList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                                <c:choose>
                                                    <c:when test="${status.count % 2 != 0}">
                                                        <tr>
                                                        </c:when>
                                                        <c:otherwise>
                                                        <tr bgcolor="white">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td>${status.count}</td>
                                                    <td class="hidden-xs">${list.facilitylevelname}</td> 
                                                    <td class="hidden-xs">${list.shortname}</td> 
                                                    <td>${list.description}</td>
                                                    <td>${list.units}</td>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEFACILITYLEVEL')">
                                                        <td align="center">
                                                            <a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" class="close" data-dismiss="modal" aria-hidden="true" data-original-title="Edit/Update" onClick="ajaxSubmitData('categoryLevelSetting.htm', 'TempDialogDiv', 'act=c&i=${list.facilitylevelid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-edit"></i></a>
                                                        </td>
                                                    </security:authorize>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITYLEVEL')">
                                                        <td align="center">
                                                            <a href="#" data-dismiss="modal" aria-hidden="true" class="btn btn-xs btn-bricky tooltips" data-dismiss="modal" aria-hidden="true" data-placement="top" data-original-title="Remove" onClick="var resp = confirm('Delete Level?');
                                                                        if (resp === true) {
                                                                            ajaxSubmitData('categoryLevelSetting.htm', 'TempDialogDiv', 'act=h&i=${list.facilitylevelid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');
                                                                        }"><i class="fa fa-times fa fa-white"></i></a>
                                                            <input type="checkbox" name="selectObj2${status.count}" id="selectObj2${status.count}" value="${list.facilitylevelid}" onChange="if (this.checked) {
                                                                            document.getElementById('selectedObjs2').value = parseInt(document.getElementById('selectedObjs2').value) + 1
                                                                        } else {
                                                                            document.getElementById('selectedObjs2').value = parseInt(document.getElementById('selectedObjs2').value) - 1
                                                                        }
                                                                        var ticks = document.getElementById('selectedObjs2').value;
                                                                        if (ticks > 0) {
                                                                            showDiv('selectObjBtn2');
                                                                        }
                                                                        if (ticks == 0) {
                                                                            hideDiv('selectObjBtn2');
                                                                        }"/>
                                                        </td>   
                                                    </security:authorize>
                                                </tr>
                                            </c:forEach>

                                        </tbody>
                                    </table>
                                    <c:if test="${model.size>0}">
                                        <table align="right">
                                            <tr>
                                                <td>
                                                    <input type="hidden" id="selectedObjs2" name="selectedObjs2" value="0"/>
                                                    <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                                                    <input type="hidden" name="act" value="${model.act}"/>
                                                    <input type="hidden" name="b" value="${model.b}"/>
                                                    <input type="hidden" name="c" value="${model.c}"/>
                                                    <input type="hidden" name="d" value="${model.d}"/>
                                                    <input type="hidden" name="i" value="${model.catObj.categoryid}"/>
                                                    <input type="hidden" name="a" value="${model.a}"/>
                                                </td>
                                                <td align="right">
                                                    Select <a href="javascript:selectToggleCheckBox(true, 'selectObj2', ${model.size});" onClick="document.getElementById('selectedObjs2').value =${model.size}; showDiv('selectObjBtn2');"><font color="blue"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj2', ${model.size});" onClick="document.getElementById('selectedObjs2').value = 0;
                                                                hideDiv('selectObjBtn2');"><font color="blue">None</font></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="right">
                                                    <div id="selectObjBtn2" style="display:none">
                                                        <input type="button" id="saveButton" name="button" data-dismiss="modal" aria-hidden="true" class='btn btn-purple' value="Delete Level(s)" onClick="var resp = confirm('Delete Level(s)?');
                                                                    if (resp == false) {
                                                                        return false;
                                                                    }
                                                                    ajaxSubmitData('deleteCatLevel.htm', 'TempDialogDiv', $('#manageFormField2').serialize(), 'POST');"/> 
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        </br>
                                    </c:if>
                                </div>
                            </div>
                            <!-- end: DYNAMIC TABLE PANEL -->
                        </div>
                    </div>
                </form>
            </c:if>
            <c:if test="${empty model.levelList}">
                <div align="center"><h3>No Registered ${model.facilityType}</h3></div>
            </c:if>

        </div>
    </div>
</div>
<div id="TempDialogDiv"></div>
<script type="text/javascript" src="static/mainpane/plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="static/mainpane/plugins/DataTables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="static/mainpane/plugins/DataTables/media/js/DT_bootstrap.js"></script>
<script src="static/mainpane/js/table-data.js"></script>
<script>
                                                                jQuery(document).ready(function () {
                                                                    //Main.init();
                                                                    TableData.init();
                                                                });
</script>
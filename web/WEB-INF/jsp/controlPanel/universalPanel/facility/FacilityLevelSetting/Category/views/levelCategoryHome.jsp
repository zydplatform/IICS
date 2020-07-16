<%--
    Document   : levelCategoryHome
    Created on : Dec 5, 2017, 9:37:19 AM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="col-sm-12">
    <div class="box box-color box-bordered">    
        <div class="box-title">
            <h3>
                <i class="fa fa-home"></i>
                Organisation Settings - Manage/Register Domain Categories
            </h3>
        </div>
        
        <div style="float:left" align="left"><a id="back" href="#"  onClick="clearDiv('workPane'); ajaxSubmitData('orgLevelSetting.htm', 'workPane', 'act=b&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a></div>
        <div style="float:right">   
            <span class="text4" class="ui-state-highlight">${model.message}</span>
            <div id="AddNewRg" class="form-actions text5">
                <button class='btn btn-purple' id="popUpForm" name="popUpForm" 
                        onClick="ajaxSubmitData('orgLevelSetting.htm', 'addnew-pane', 'act=c&i=${model.i}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Add New Domain <i class="fa fa-arrow-circle-down"></i></button>
            </div>
        </div>

        <div id="response" class="box-content nopadding">

            <div id="addnew-pane"></div>
            <c:if test="${not empty  model.catList}">
                <form id="manageFormField" name="manageFormField">

                    <c:if test="${model.paginate==true}">
                        <script>showDiv('pagenateSearch2');</script>
                        <script>showDiv('pagenateSearch3');</script>
                        <div id="searchHeading1">
                            <c:if test="${model.count<=(model.maxResults*model.offset)}"><font color="blue"><font color="blue">${model.offset2}-${model.count}</font> of ${model.count}</font></c:if>
                            <c:if test="${model.count>(model.maxResults*model.offset)}"><font color="blue">${model.offset2}-${model.maxResults*model.offset}</font> of <font color="blue">${model.count}</font></c:if>
                            ${model.facilityType}
                            <input type="hidden" size="5" name="act" id="act" value="${model.act}"/>
                            <input type="hidden" size="5" name="b" id="b" value="${model.b}"/>
                            <input type="hidden" size="5" name="i" id="i" value="${model.i}"/>
                            <input type="hidden" size="5" name="c" id="c" value="${model.c}"/>
                            <input type="hidden" size="5" name="d" id="d" value="${model.d}"/>
                            <input type="hidden" size="5" name="sStr" id="sStr" value="${model.sStr}"/>


                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-md-12">
                            <!-- start: DYNAMIC TABLE PANEL -->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <i class="fa fa-external-link-square"></i>
                                    Manage Facility Level Category
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
                                                <th class="hidden-xs">Domain Name</th>
                                                <th>Description</th> 
                                                <th>Levels</th> 
                                                <th>Status</th>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEFACILITYLEVELCATEGORY')">
                                                    <th>Manage</th> 
                                                    </security:authorize>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITYLEVELCATEGORY')">
                                                    <th>Discard</th>
                                                    </security:authorize>

                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:set var="quantity" value="quantity"/>
                                            <c:set var="qtyServiced" value="0" />
                                            <c:forEach items="${model.catList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                                <c:choose>
                                                    <c:when test="${status.count % 2 != 0}">
                                                        <tr>
                                                        </c:when>
                                                        <c:otherwise>
                                                        <tr bgcolor="white">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td>${status.count}</td>
                                                    <td class="hidden-xs">${list.categoryname}</td> 
                                                    <td>${list.description}</td>
                                                    <td>
                                                        <div style="float:left">
                                                            <c:if test="${list.levels==0}">${list.levels}</c:if>
                                                            <c:if test="${list.levels!=0}">
                                                                <a href="#" onClick="ajaxSubmitData('categoryLevelSetting.htm', 'TempDialogDiv', 'act=a&i=${list.categoryid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">${list.levels}</a>
                                                            </c:if>
                                                        </div>
                                                        <div style="float:right"><a href="#" onClick="ajaxSubmitData('orgLevelSetting.htm', 'addnew-pane', 'act=f&i=${list.categoryid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Add</a></div>
                                                    </td>
                                                    <td></td>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEFACILITYLEVELCATEGORY')">
                                                        <td align="center">
                                                            <div style="float:left"><a href="#" data-dismiss="modal" aria-hidden="true" onClick="ajaxSubmitData('orgLevelSetting.htm', 'addnew-pane', 'act=e&i=${list.categoryid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-file-text"></i></a></div>
                                                            <div style="float:right">
                                                                <a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" data-dismiss="modal" aria-hidden="true" data-original-title="Edit/Update" onClick="ajaxSubmitData('orgLevelSetting.htm', 'addnew-pane', 'act=d&i=${list.categoryid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-edit"></i></a>
                                                            </div>
                                                        </td>
                                                    </security:authorize>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITYLEVELCATEGORY')">
                                                        <td align="center">
                                                            <a href="#" class="btn btn-xs btn-bricky tooltips" data-placement="top" data-original-title="Remove" onClick="var resp = confirm('Delete Category?');
                                                            if (resp === true) {
                                                                ajaxSubmitData('orgLevelSetting.htm', 'TempDialogDiv', 'act=g&i=${list.categoryid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');
                                                            }"><i class="fa fa-times fa fa-white"></i></a>
                                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="${list.categoryid}" onChange="if (this.checked) {
                                                                document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) + 1
                                                            } else {
                                                                document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) - 1
                                                            }
                                                            var ticks = document.getElementById('selectedObjs').value;
                                                            if (ticks > 0) {
                                                                showDiv('selectObjBtn');
                                                            }
                                                            if (ticks == 0) {
                                                                hideDiv('selectObjBtn');
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
                                                    <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                                                    <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                                                    <input type="hidden" name="act" value="${model.act}"/>
                                                    <input type="hidden" name="b" value="${model.b}"/>
                                                    <input type="hidden" name="i" value="${model.i}"/>
                                                    <input type="hidden" name="a" value="${model.a}"/>
                                                </td>
                                                <td align="right">
                                                    Select <a href="javascript:selectToggleCheckBox(true, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value =${model.size}; showDiv('selectObjBtn');"><font color="blue"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value = 0;
                                                            hideDiv('selectObjBtn');"><font color="blue">None</font></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="right">
                                                    <div id="selectObjBtn" style="display:none">
                                                        <input type="button" id="saveButton" name="button"class='btn btn-purple' value="Delete Category" onClick="var resp = confirm('Delete Category?');
                                                                if (resp == false) {
                                                                    return false;
                                                                }
                                                                ajaxSubmitData('deleteOrgLevelCat.htm', 'TempDialogDiv', $('#manageFormField').serialize(), 'POST');"/> 
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
            <c:if test="${empty model.catList}">
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
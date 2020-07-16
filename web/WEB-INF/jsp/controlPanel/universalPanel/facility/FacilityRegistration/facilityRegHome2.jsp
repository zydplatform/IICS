<%-- 
    Document   : facilityRegHome2
    Created on : Nov 29, 2017, 8:42:10 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<div class="col-sm-12">
    <div class="box box-color box-bordered">    
        <div class="box-title">
            <h3>
                <i class="fa fa-home"></i>
                Org. Settings - Manage/Register ${model.orgObj.organisationname} Facility/Org Branch
            </h3>
        </div>
        <div style="float:right">   
            <span class="text4" class="ui-state-highlight">${model.message}</span>
            <div id="AddNewRg" class="form-actions text5">
                <button class='btn btn-purple' id="popUpForm" name="popUpForm" 
                        onClick="ajaxSubmitData('organisationSetting.htm', 'addnew-pane', 'act=e&i=${model.orgObj.organisationid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Add School <i class="fa fa-arrow-circle-down"></i></button>
            </div>
        </div>

        <div id="response" class="box-content nopadding">

            <div id="addnew-pane"></div>
            <c:if test="${not empty  model.facilityList}">
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
                                    Manage Facility/Organisation Branch
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
                                            <th>Facility Name</th>
                                            <th>Code</th>   
                                            <th>Operational Units</th> 
                                            <th>Status</th>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGE')">
                                                <th>Manage</th> 
                                            </security:authorize>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITY')">
                                                <th>Discard</th>
                                            </security:authorize>

                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:set var="quantity" value="quantity"/>
                                            <c:set var="qtyServiced" value="0" />
                                            <c:forEach items="${model.facilityList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                                <c:choose>
                                                    <c:when test="${status.count % 2 != 0}">
                                                        <tr>
                                                        </c:when>
                                                        <c:otherwise>
                                                        <tr bgcolor="white">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td>${status.count}</td>
                                                    <td class="hidden-xs">${list.facilityname}</td> 
                                                    <td class="hidden-xs">${list.facilitycode}</td>
                                                    <td>
                                                        <div style="float:left">
                                                            <c:if test="${list.totalunits==0}">${list.totalunits}</c:if>
                                                            <c:if test="${list.totalunits!=0}">
                                                                ${list.totalunits}
                                                                <c:if test="${list.totalunits>0}">[<a href="#" title="View ${list.totalunits} Facility Unit" onClick="if(${list.active==false}){alert('Activate/Approve Facility!'); return false;} ajaxSubmitData('facilityUnitSetting.htm', 'workPane', 'act=a&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.orgObj.organisationid}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">view</a>]</c:if>
                                                            </c:if>
                                                        </div>
                                                        <div style="float:right">
                                                        <a href="#" onClick="if(${list.active==false}){alert('Activate/Approve Facility!'); return false;} ajaxSubmitData('deptSetting.htm', 'workPane', 'act=a&i=0&b=${model.b}&c=${model.a}&d=${list.facilityid}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Dept</a>
                                                        | 
                                                        <a href="#" onClick="if(${list.active==false}){alert('Activate/Approve Facility!'); return false;} ajaxSubmitData('orgFacilitySettings.htm', 'addnew-pane', 'act=e&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.orgObj.organisationid}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Add Unit</a>
                                                        </div>
                                                    </td>
                                                    <td><c:if test="${list.active==true}">Approved</c:if><c:if test="${list.active==false}"><span class="text4">Pending Approval</span></c:if></td>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGE')">
                                                        <td align="center">
                                                            <div style="float:left"><a href="#" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'addnew-pane', 'act=c1&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.orgObj.organisationid}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"  data-placement="top" data-original-title="View Details For ${list.facilityname}"><i class="fa fa-file-text"></i></a></div>
                                                            <div style="float:right">
                                                                <a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit/Update" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'addnew-pane', 'act=c&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.orgObj.organisationid}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-edit"></i></a>
                                                            </div>
                                                        </td>
                                                    </security:authorize>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITY')">
                                                        <td align="center">
                                                            <a href="#" class="btn btn-xs btn-bricky tooltips" data-placement="top" data-original-title="Remove" onClick="var resp=confirm('Delete Facility?'); if(resp===true){ajaxSubmitData('orgFacilitySettings.htm', 'TempDialogDiv', 'act=f&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');}"><i class="fa fa-times fa fa-white"></i></a>
                                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="${list.facilityid}" onChange="if (this.checked) {
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
                                                        <input type="button" id="saveButton" name="button"class='btn btn-purple' value="Delete Facility" onClick="var resp = confirm('Delete Facility?'); if (resp == false) {
                                                                        return false;} ajaxSubmitData('deleteFacility.htm', 'TempDialogDiv', $('#manageFormField').serialize(), 'POST');"/> 
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
            <c:if test="${empty model.facilityList}">
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
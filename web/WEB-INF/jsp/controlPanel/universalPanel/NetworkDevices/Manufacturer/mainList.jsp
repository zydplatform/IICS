<%-- 
    Document   : mainList
    Created on : Mar 6, 2018, 3:39:53 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="row">
    <div class="col-md-12">
        <p class="pull-right">
            <a class="btn btn-primary icon-btn" href="#" onClick="ajaxSubmitData('deviceManuSetting.htm', 'addnew-pane', 'act=b&i=${model.i}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
                <i class="fa fa-plus"></i>
                Add New Manufacturer
            </a>
        </p>
    </div>
                
</div>
<fieldset>
    <div id="addnew-pane"></div>
    <c:if test="${not empty  model.deviceList}">
        <form id="manageFormField" name="manageFormField">
            <table class="table table-hover table-bordered" id="dataGrid">
                <thead>
                    <tr>
                        <th>No</th>
                        <th class="hidden-xs">Manufacturer</th> 
                        <th class="hidden-xs">Status</th> 
                        <th>Added By</th>
                        <th>Date Added</th>
                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEDEVICEMANUFACTURER') or hasRole('PRIVILEGE_DELETEDEVICEMANUFACTURER')">
                            <th>Manage</th> 
                            </security:authorize>
                    </tr>
                </thead>
                <tbody id="tableFacilities">
                    <% int n = 1;%>
                    <% int w = 1;%>
                    <c:set var="count" value="1"/>
                    <c:set var="No" value="0" />
                    <c:forEach items="${model.deviceList}" var="list" varStatus="status" begin="0" end="${model.size}">
                        <c:choose>
                            <c:when test="${status.count % 2 != 0}">
                                <tr>
                                </c:when>
                                <c:otherwise>
                                <tr bgcolor="white">
                                </c:otherwise>
                            </c:choose>
                            <td>${status.count}</td>
                            <td>${list.manufacturer}</td>
                            <td><c:if test="${list.active==true}">Activated</c:if><c:if test="${list.active==false}">Blocked</c:if></td>
                            <td>${list.person.firstname} ${list.person.lastname}</td>
                            <td><fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${list.dateadded}"/></td>
                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEDEVICEMANUFACTURER') or hasRole('PRIVILEGE_DELETEDEVICEMANUFACTURER')">
                                <td align="center">
                                    <div style="float:left">
                                        <a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" class="close" data-dismiss="modal" aria-hidden="true" data-original-title="Edit/Update" onClick="ajaxSubmitData('deviceManuSetting.htm', 'addnew-pane', 'act=c&i=${list.devicemanufacturerid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                    </div>
                                    <div style="float:right">
                                        <a href="#" data-dismiss="modal" aria-hidden="true" class="btn btn-xs btn-bricky tooltips" data-dismiss="modal" aria-hidden="true" data-placement="top" data-original-title="Remove" onClick="var resp = confirm('Delete Manufacturer?');
                                            if (resp === true) {
                                                ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=e&i=${list.devicemanufacturerid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');
                                            }"><i class="fa fa-times fa fa-white"></i></a>
                                    <!--<input type="checkbox" name="selectObj2${status.count}" id="selectObj2${status.count}" value="${list.devicemanufacturerid}" onChange="if (this.checked) {
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
                                    -->
                                    </div>
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
                            <!--
                            Select <a href="javascript:selectToggleCheckBox(true, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value =${model.size};
                                    showDiv('selectObjBtn');"><font color="blue"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value = 0;
                                            hideDiv('selectObjBtn');"><font color="blue">None</font></a>
                            -->
                        </td>
                    </tr>
                    <!--<tr>
                        <td colspan="2" align="right">
                            <div id="selectObjBtn" style="display:none">
                                <input type="button" id="saveButton" name="button"class='btn btn-purple' value="Delete Manufacturer" onClick="var resp = confirm('Delete Manufacturer?');
                                        if (resp == false) {
                                            return false;
                                        }
                                        ajaxSubmitData('deleteDeviceManufac.htm', 'panel_overview', $('#manageFormField').serialize(), 'POST');"/> 
                            </div>
                        </td>
                    </tr>
                    -->
                </table>
                </br>
            </c:if>
        </form>
    </c:if>
    <c:if test="${empty model.deviceList}">
        <div align="center"><h3>No Registered ${model.facilityType}</h3></div>
    </c:if>
</fieldset>
<script>
    $(document).ready(function () {
        $('#dataGrid').DataTable();
    })
</script>
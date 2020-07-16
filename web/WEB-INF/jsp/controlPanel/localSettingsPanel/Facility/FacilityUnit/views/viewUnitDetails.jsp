<%-- 
    Document   : viewUnitDetails
    Created on : May 18, 2018, 4:24:23 PM
    Author     : samuelwam
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<legend> 
    <div style="float:left" align="left"><a id="back" href="#"  onClick="ajaxSubmitData('facilityUnitSetUp.htm', 'tabContent', 'act=b&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a></div>
    &nbsp;&nbsp;&nbsp;
    Un Structured Facility Units
</legend>

<c:if test="${not empty model.facilityUnitList}">
    <div id="unit-response">
    <table class="table table-hover table-bordered" id="searchedFacilityUnit">
        <thead>
            <tr>
                <th>No</th>
                <th>Unit Name</th>
                <th>Short Name</th>
                <th>Description</th>
                <th>Sub Units</th>
                <th class="center">Status</th>
                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEFACILITYUNITS')">
                    <th>Manage</th> 
                    </security:authorize>
                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITYUNIT')">
                    <th>Discard</th>
                    </security:authorize>
                </tr>
            </thead>
            <tbody id="tableFacilities">
            <c:set var="quantity" value="quantity"/>
            <c:set var="size" value="0" />
            <c:forEach items="${model.facilityUnitList}" var="list" varStatus="status">
                <c:choose>
                    <c:when test="${status.count % 2 != 0}">
                        <tr>
                        </c:when>
                        <c:otherwise>
                        <tr bgcolor="white">
                        </c:otherwise>
                    </c:choose>
                    <td align="left">
                        ${status.count}
                        <c:set var="size" value="${size+1}" />
                    </td>
                    <td align="left">${list.facilityunitname}</td> 
                    <td align="left">${list.shortname}</td> 
                    <td align="left">${list.description}</td>
                    <td align="center">${list.subunits}</td>
                    <td align="right">
                        <c:if test="${list.active==false}"><img src="static/images/disabledsmall.png" width="20px" height="20px" title="Pending Approval" alt="Pending Approval"></c:if>
                        <c:if test="${list.active==true}"><img src="static/images/authorised.png" width="20px" height="20px" title="Active" alt="Active"></c:if>
                        </td>
                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEFACILITYUNITS')">
                        <td align="center">
                            <a href="#" onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=b&i=${list.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');" data-placement="top" data-original-title="View Details For ${list.facilityunitname}"><i class="fa fa-fw fa-lg fa-dedent"></i></a>
                    </td>
                    </security:authorize>
                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITYUNIT')">
                    <td align="center">
                        <a href="#" class="btn btn-xs btn-bricky tooltips" data-placement="top" data-original-title="Remove" onClick="var resp = confirm('Discard ${model.hyrchObj.hierachylabel}!');
                                if (resp == false) {
                                    return false;
                                }
                                ajaxSubmitData('facilityUnitSetting.htm', 'unit-response', 'act=f&i=${list.facilityunitid}&b=${model.b}&c=false&d=0&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-times fa fa-white"></i></a>
                    </td>
                    </security:authorize>
                </tr>
            </c:forEach>
        </tbody>
        <c:if test="${size>0}">
            <table align="right">
                <tr>
                    <td>
                        <input type="hidden" id="forg" name="forg" value="0"/>
                        <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                        <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                        <input type="hidden" name="act" value="${model.act}"/>
                        <input type="hidden" name="b" value="${model.b}"/>
                        <input type="hidden" name="i" value="${model.i}"/>
                        <input type="hidden" name="a" value="${model.a}"/>
                    </td>
                    <td align="right">
                        Select <a href="javascript:selectToggleCheckBox(true, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value =${model.size};
                                showDiv('selectObjBtn');"><font color="blue"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value = 0;
                                        hideDiv('selectObjBtn');"><font color="blue">None</font></a>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <div id="selectObjBtn" style="display:none">
                            <input type="button" value="Discard ${model.hyrchObj.hierachylabel}" class='btn btn-primary' onClick="var resp = confirm('Delete Facility(s)?');
                                    if (resp == false) {
                                        return false;
                                    }
                                    ajaxSubmitData('deleteFacilityUnit.htm', 'TempDialogDiv', $('#manageFormField').serialize(), 'POST');"/>
                        </div>
                    </td>
                </tr>
            </table>
            </br>
        </c:if>
    </table>
            </div>
</c:if>
<c:if test="${empty model.facilityUnitList}">
    <div align="center"><h3>No Registered Un Structured Facility Units</h3></div>
</c:if>

<script>
    $('#searchedFacilityUnit').DataTable();
</script>

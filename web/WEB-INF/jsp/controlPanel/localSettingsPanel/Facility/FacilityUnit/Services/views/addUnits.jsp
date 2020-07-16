<%-- 
    Document   : addUnits
    Created on : Jul 17, 2018, 7:48:23 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<legend> 
    <div style="float:left" align="left"><a id="back" href="#"  onClick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'tabContent', 'act=d&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a></div>
    &nbsp;&nbsp; Assign Facility Service: ${model.serviceObj[1]}
</legend>

<c:if test="${not empty model.facilityUnitList}">
    <div id="unit-response" style="width:100%">
        <form name="manageFormField" id="manageFormField">
            <table class="table table-hover table-bordered" id="searchedFacilityUnit">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Unit Name</th>
                        <th>Short Name</th>
                        <th>Add</th> 
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
                            <td align="center">
                                <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="${list.facilityunitid}" onChange="if (this.checked) {
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
                        </tr>
                    </c:forEach>
                </tbody>
                <c:if test="${size>0}">
                    <table align="right">
                        <tr>
                            <td>
                                <input type="hidden" id="service" name="service" value="${model.serviceObj[0]}"/>
                                <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                                <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                                <input type="hidden" name="act" value="a"/>
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
                                    <input type="button" value="Assign Units" class='btn btn-primary' onClick="
                                            ajaxSubmitData('facilityServicesManagement/assignFacilityUnitService.htm', 'unit-response', $('#manageFormField').serialize(), 'POST');"/>
                                </div>
                            </td>
                        </tr>
                    </table>
                    </br>
                </c:if>
            </table>
        </form>
    </div>
</c:if>
<c:if test="${empty model.facilityUnitList}">
    <div align="center"><h3>No Registered Un Structured Facility Units</h3></div>
</c:if>

<script>
    $('#searchedFacilityUnit').DataTable();
</script>


<%-- 
    Document   : assignedServices
    Created on : Aug 24, 2018, 5:54:56 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset>
    <legend> 
    &nbsp;&nbsp; Assigned Services Under Activity: ${model.activityObj[1]}
</legend>
    <c:if test="${not empty model.unitServiceList}">
        <div id="deAssignService-response" style="width:100%">
            <form name="manageFormField" id="manageFormField">
                <table class="table table-hover table-bordered" id="searchedAssignedService">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Service Name</th>
                            <th>Remove Service</th> 
                        </tr>
                    </thead>
                    <tbody id="tableFacilities">
                        <c:set var="quantity" value="quantity"/>
                        <c:set var="size" value="0" />
                        <c:forEach items="${model.unitServiceList}" var="list" varStatus="status">
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
                                <td align="left">${list.facilityservices.servicename}</td> 
                                <td align="center">
                                    De-Assign <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="${list.activityserviceid}" onChange="if (this.checked) {
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
                                    <input type="hidden" id="activityId" name="activityId" value="${model.activityObj[0]}"/>
                                    <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                                    <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                                    <input type="hidden" name="act" value="b"/>
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
                                        <input type="button" value="Discard Services" class='btn btn-primary' onClick="
                                                ajaxSubmitData('systemActivity/assignFacilityService.htm', 'deAssignService-response', $('#manageFormField').serialize(), 'POST');"/>
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
    <c:if test="${empty model.unitServiceList}">
        <div align="center"><h3>No Assigned Facility Services</h3></div>
    </c:if>
</fieldset>

<script>
    $('#searchedAssignedService').DataTable();
</script>
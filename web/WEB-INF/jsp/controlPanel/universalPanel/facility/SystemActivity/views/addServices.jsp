<%-- 
    Document   : addServices
    Created on : Aug 24, 2018, 4:48:09 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset>
<legend> 
    <div style="float:left" align="left"><a id="back" href="#"  onClick="ajaxSubmitData('systemActivity/activityManagement.htm', 'servicePane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a></div>
    &nbsp;&nbsp; Assign System Activity: ${model.activityObj[1]}
</legend>

<c:if test="${not empty model.servListArr}">
    <div id="service-response" style="width:100%">
        <form name="manageFormField" id="manageFormField">
            <table class="table table-hover table-bordered" id="searchedFacilityService">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Service Name</th>
                        <th>Description</th>
                        <th>Add</th> 
                    </tr>
                </thead>
                <tbody id="tableFacilities">
                    <c:set var="quantity" value="quantity"/>
                    <c:set var="size" value="0" />
                    <c:forEach items="${model.servListArr}" var="list" varStatus="status">
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
                            <td align="left">${list[1]}</td> 
                            <td align="left">${list[2]}</td> 
                            <td align="center">
                                <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="${list[0]}" onChange="if (this.checked) {
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
                                    <input type="button" value="Assign Services" class='btn btn-primary' onClick="
                                            ajaxSubmitData('systemActivity/assignFacilityService.htm', 'service-response', $('#manageFormField').serialize(), 'POST');"/>
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
<c:if test="${empty model.servListArr}">
    <div align="center"><h3>No Un Assigned Facility Services</h3></div>
</c:if>
</fieldset>

<script>
    $('#searchedFacilityService').DataTable();
</script>
<%-- 
    Document   : loadDistricts
    Created on : Jun 8, 2018, 12:49:56 PM
    Author     : Uwera
--%>

<%@include file="../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:choose>
    <c:when test="${empty model.link}">
        <fieldset style="width: 99%"><legend>Manage ${model.size} Districts</legend>
            <c:if test="${not empty model.districtList}">
                <div id="response-pane"></div>
                <div class="row" id="countyPane">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                                    <thead>
                                        <tr>
                                            <th class="center">No</th>
                                            <th>District Name </th>
                                            <th>Region Name </th>
                                                <security:authorize access="hasRole('PRIVILEGE_UPDATEDISTRICTS') or hasRole('PRIVILEGE_DELETEDISTRICTS')"> </security:authorize>
                                                <th class="center">Manage</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableDesc">
                                        <c:set var="count" value="1"/>
                                        <c:set var="No" value="0" />
                                        <c:forEach items="${model.districtList}" var="list" varStatus="status"  begin="0" end="${model.size}">
                                            <c:choose>
                                                <c:when test="${status.count % 2 != 0}">
                                                    <tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <tr bgcolor="white">
                                                    </c:otherwise>
                                                </c:choose>
                                                <td>${status.count}</td>
                                                <td align="left">${list[1]}</td> 
                                                <td align="left">${list[2]}</td>
                                                <td class="center">
                                                    <a href="#" title="Update " onclick="ajaxSubmitData('addOrUpdateDistrict.htm', 'deletionDiv', {dID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                                    &nbsp;
                                                    <a href="#" title="Discard " onclick="var resp = confirm('Delete County ${list[1]}!');
                                                            if (resp === false) {
                                                                return false;
                                                            }
                                                            ajaxSubmitData('manageSelectedLocation.htm', 'deletionDiv', {id: '${list[0]}', act: 'd', st: 'a', v2: '0'}, 'GET');" ><i class="fa fa-fw fa-lg fa-times"></i></a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                            <c:if test="${empty model.districtList}">
                                <span class="text4">No Registered Districts</span> 
                            </c:if>
                            <div class="row" id="addNew"></div>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
    </c:when>
    <c:otherwise>
        <select onchange="clearFormSelect('district');
                if (this.value == 0) {
                    return false;
                }
                ${model.link}" class="form-control" id="districtlist" name="districtid">
            <option value="0">--Select District--</option>
            <c:forEach items="${model.districtList}" var="par">
                <option value="${par[0]}">${par[1]}</option>
            </c:forEach>
        </select>
    </c:otherwise>
</c:choose>



<script>
            $(document).ready(function () {
                $('#sampleTable').DataTable();
            });
</script>
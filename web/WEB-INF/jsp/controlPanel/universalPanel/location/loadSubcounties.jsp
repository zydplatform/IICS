<%-- 
    Document   : loadSubcounties
    Created on : Jun 21, 2018, 8:19:36 AM
    Author     : user
--%>
<%@include file="../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:choose>
    <c:when test="${empty model.link}">
        <fieldset style="width: 99%"><legend>Manage ${model.size}Sub Counties</legend>
            <c:if test="${not empty model.subCountyList}">
                <div id="response-pane"></div>
                <div class="row" id="countyPane">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                                    <thead>
                                        <tr>
                                            <th class="center">No</th>
                                            <th>Sub County Name </th>
                                                <security:authorize access="hasRole('PRIVILEGE_UPDATESUBCOUNTY') or hasRole('PRIVILEGE_DELETESUBCOUNTY')"> </security:authorize>
                                                <th class="center">Manage</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableDesc">
                                        <c:set var="count" value="1"/>
                                        <c:set var="No" value="0" />
                                        <c:forEach items="${model.subCountyList}" var="list" varStatus="status"  begin="0" end="${model.size}">
                                            <c:choose>
                                                <c:when test="${status.count % 2 != 0}">
                                                    <tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <tr bgcolor="white">
                                                    </c:otherwise>
                                                </c:choose>
                                                <td>${status.count}</td>
                                                <td align="left">{list[1]}</td> 
                                                <td class="center">
                                                    <a href="#" title="Update " onclick="ajaxSubmitData('addOrUpdateSubCounty.htm', 'deletionDiv', {scID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                                    &nbsp;
                                                    <a href="#" title="Discard " onclick="var resp = confirm('Are you sure you want to delete sub County ${list[1]}!');
                                                            if (resp === false) {
                                                                return false;
                                                            }
                                                            ajaxSubmitData('locations/manageSelectedLocation.htm', 'addnew-pane', {id: '${list[0]}', act: 'c', st: 'a', v2: '0'}, 'GET');" ><i class="fa fa-fw fa-lg fa-times"></i></a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                            <c:if test="${empty model.subCountyList}">
                                <span class="text4">No Registered Sub County</span> 
                            </c:if>
                            <div class="row" id="addNew"></div>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
    </c:when>
    <c:otherwise>
        <select  class="form-control"  onchange="clearFormSelect('subcounty'); if(this.value==0){return false;} ${model.link}"  id="subcountylist" name="subcountyid">
            <option value="0">--Select Sub-County--</option>
            <c:forEach items="${model.subCountyList}" var="par">
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
<%-- 
    Document   : loadParishes
    Created on : Jun 26, 2018, 2:33:42 PM
    Author     : Uwera
--%>
<%@include file="../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:choose>
    <c:when test="${empty model.link}">
        <fieldset style="width: 99%"><legend>Manage <font color="blue">${model.size}Parishes</font></legend>
            <c:if test="${not empty model.parishList}">
                <div id="response-pane"></div>
                <div class="row" id="countyPane">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                                    <thead>
                                        <tr>
                                            <th class="center">No</th>
                                            <th>Parish Name </th>
                                                <security:authorize access="hasRole('PRIVILEGE_UPDATEPARISH') or hasRole('PRIVILEGE_DELETEPARISH')"> </security:authorize>
                                                <th class="center">Manage</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableDesc">
                                        <c:set var="count" value="1"/>
                                        <c:set var="No" value="0" />
                                        <c:forEach items="${model.parishList}" var="list" varStatus="status"  begin="0" end="${model.size}">
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
                                                    <a href="#" title="Update " onclick="ajaxSubmitData('addOrUpdateParish.htm', 'deletionDiv', {pID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                                    &nbsp;
                                                    <a href="#" title="Discard " onclick="var resp = confirm('Are you sure you want to delete Parish ${list[1]}!');
                                                            if (resp === false) {
                                                                return false;
                                                            }
                                                            ajaxSubmitData('deleteParish.htm', 'deletionDiv', {pID:'${list[0]}', name: '${list[1]}'}, 'GET');" ><i class="fa fa-fw fa-lg fa-times"></i></a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                                <c:if test="${empty model.parishList}">
                <span class="text4">No Registered Parishes</span> 
            </c:if>
                            <div class="row" id="addNew"></div>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
    </c:when>
    <c:otherwise>
       <select class="form-control" onchange="clearFormSelect('villageDivx'); if(this.value==0){return false;} ${model.link}"  id="parishlist" name="parishid">
            <option value="0">--Select Parish--</option>
            <c:forEach items="${model.parishList}" var="par">
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
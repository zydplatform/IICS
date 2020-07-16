<%-- 
    Document   : selectsView
    Created on : Jun 24, 2018, 10:45:35 AM
    Author     : uwera
--%>
<%@include file="../../../../include.jsp" %>

<c:if test="${model.act=='b' && model.mainActivity=='Parish'}">
    <c:if test="${model.b=='a'}">
        <select class="form-control" name="district" id="districtlist" onChange="clearDiv('parishPane'); ajaxSubmitData('locations/manageParish.htm', 'countyPane', 'act=b&i=' + this.value + '&b=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
            <option value="0">--Select District--</option>
            <c:forEach items="${model.districtList}" var="distr">
                <option value="${distr[0]}">${distr[1]}</option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.b=='b'}">
        <select class="form-control" name="county" id="countylist" onChange="clearDiv('parishPane'); ajaxSubmitData('locations/manageParish.htm', 'subcountyPane', 'act=b&i=' + this.value + '&b=c&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
            <option value="0">--Select County--</option>
            <c:forEach items="${model.countyList}" var="count">
                <option value="${count[0]}">${count[1]}</option>
            </c:forEach>
        </select>
    </c:if>    
    <c:if test="${model.b=='c'}">
        <select class="form-control" name="subcounty" id="subcountylist" onChange="clearDiv('parishPane'); ajaxSubmitData('locations/manageParish.htm', 'parishPane', 'act=b&i=' + this.value + '&b=d&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
            <option value="0">--Select Sub-County--</option>
            <c:forEach items="${model.subCountyList}" var="count">
                <option value="${count[0]}">${count[1]} </option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.b=='d'}">
        <fieldset style="width: 100%"><legend>Parishes Under Sub-County: ${model.subCountyObj.subcountyname} [Parishes: ${model.size}]</legend>
            <div id="response-pane"></div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th class="center">No</th>
                                        <th>Parish Name</th>
                                        <th>Sub County Name</th>
                                        <th>County Name</th>
                                        <th>District Name </th>
                                        <th>Region Name </th>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEPARISH') or hasRole('PRIVILEGE_DELETEPARISH')">
                                            <th class="center">Manage</th>
                                            </security:authorize>
                                    </tr>
                                </thead>
                                <tbody id="tableDesc">
                                    <c:set var="count" value="1"/>
                                    <c:set var="No" value="0" />
                                    <c:forEach items="${model.parishList}" var="list" varStatus="status">
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
                                            <td align="left">${list[3]}</td>
                                            <td align="left">${list[4]}</td>
                                            <td align="left">${list[5]}</td>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEPARISH') or hasRole('PRIVILEGE_DELETEPARISH')">
                                                <td class="center">
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEPARISH')">
                                                        <a href="#" title="Update Parish" onclick="ajaxSubmitData('locations/addOrUpdateParish.htm', 'response-pane', {pID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                                        &nbsp;
                                                    </security:authorize>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEPARISH')">
                                                        <a href="#" title="View Attachments/Discard Parish" onclick="
                                                                ajaxSubmitData('locations/manageSelectedLoc.htm', 'response-pane', {id: '${list[0]}', act: 'p', st: 'a', v2: '0'}, 'GET');"><i class="fa fa-fw fa-lg fa-book"></i></a>
                                                        </security:authorize>
                                                </td>
                                            </security:authorize>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="row" id="addNew"></div>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset> 
    </c:if>
</c:if>
<c:if test="${model.act=='b' && model.mainActivity=='Village'}">
    <c:if test="${model.b=='a'}">
        <select class="form-control" name="district" id="districtlist" onChange="clearDiv('villagePane'); ajaxSubmitData('locations/manageVillage.htm', 'countyPane', 'act=b&i=' + this.value + '&b=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
            <option value="0">--Select District--</option>
            <c:forEach items="${model.districtList}" var="distr">
                <option value="${distr[0]}">${distr[1]}</option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.b=='b'}">
        <select class="form-control" name="county" id="countylist" onChange="clearDiv('villagePane'); ajaxSubmitData('locations/manageVillage.htm', 'subcountyPane', 'act=b&i=' + this.value + '&b=c&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
            <option value="0">--Select County--</option>
            <c:forEach items="${model.countyList}" var="count">
                <option value="${count[0]}">${count[1]}</option>
            </c:forEach>
        </select>
    </c:if>    
    <c:if test="${model.b=='c'}">
        <select class="form-control" name="subcounty" id="subcountylist" onChange="clearDiv('villagePane'); ajaxSubmitData('locations/manageVillage.htm', 'parishPane', 'act=b&i=' + this.value + '&b=d&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
            <option value="0">--Select Sub-County--</option>
            <c:forEach items="${model.subCountyList}" var="count">
                <option value="${count[0]}">${count[1]} </option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.b=='d'}">
        <select class="form-control" name="parish" id="parishlist" onChange=" ajaxSubmitData('locations/manageVillage.htm', 'villagePane', 'act=b&i=' + this.value + '&b=e&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
            <option value="0">--Select Parish--</option>
            <c:forEach items="${model.parishList}" var="count">
                <option value="${count[0]}">${count[1]} </option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.b=='e'}">
        <fieldset style="width: 100%"><legend>Villages Under Parish: ${model.parishObj.parishname} [Villages: ${model.size}]</legend>
            <div id="response-pane"></div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th class="center">No</th>
                                        <th>Village Name</th>
                                        <th>Parish Name</th>
                                        <th>Sub County Name</th>
                                        <th>County Name</th>
                                        <th>District Name </th>
                                        <th>Region Name </th>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEVILLAGE') or hasRole('PRIVILEGE_DELETEVILLAGE')">
                                            <th class="center">Manage</th>
                                            </security:authorize>
                                    </tr>
                                </thead>
                                <tbody id="tableDesc">
                                    <c:set var="count" value="1"/>
                                    <c:set var="No" value="0" />
                                    <c:forEach items="${model.villageList}" var="list" varStatus="status">
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
                                            <td align="left">${list[3]}</td>
                                            <td align="left">${list[4]}</td>
                                            <td align="left">${list[5]}</td>
                                            <td align="left">${list[6]}</td>
                                            <td align="left">${list[7]}</td>
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEVILLAGE') or hasRole('PRIVILEGE_DELETEVILLAGE')"></security:authorize>
                                            <td class="center">
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEVILLAGE')"></security:authorize>
                                            <a href="#" title="Update Parish" onclick="ajaxSubmitData('locations/addOrUpdateVillage.htm', 'response-pane', {vID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                            &nbsp;

                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEVILLAGE')"> </security:authorize>
                                                <a href="#" title="View Attachments/Discard Village" onclick="
                                                        ajaxSubmitData('locations/manageSelectedLoc.htm', 'response-pane', {id: '${list[0]}', act: 'v', st: 'a', v2: '0'}, 'GET');"><i class="fa fa-fw fa-lg fa-book"></i></a>
                                             <!--   <a href="#" title="Discard Village" onclick="var resp = confirm('Are you sure you want to delete village:: ${list[1]}!');
                                                   if (resp === false) {
                                                       return false;
                                                   }
                                                   ajaxSubmitData('locations/deleteVillage.htm', 'response-pane', 'act=a&vID=${list[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-times"></i></a>-->

                                        </td>
                                                
                                                <%-- <td class="center">
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEVILLAGE')">
                                                        <a href="#" title="Update Parish" onclick="ajaxSubmitData('locations/addOrUpdateParish.htm', 'response-pane', {vID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                                        &nbsp;
                                                    </security:authorize>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEVILLAGE')">
                                                        <a href="#" title="Discard Village" onclick="var resp = confirm('Are you sure you want to delete village:: ${model.villageObjc[1]}!');
                                                            if (resp === false) {
                                                                return false;
                                                            }
                                                            ajaxSubmitData('locations/deleteVillage.htm', 'response-pane', 'act=a&id=${list[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-times"></i></a>
                                                        </security:authorize>
                                                </td>--%>
                                         
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="row" id="addNew"></div>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>  
    </c:if>
</c:if>
<c:if test="${model.act=='b' && model.mainActivity=='Subcounty'}">
    <c:if test="${model.b=='a'}">
        <select class="form-control" name="district" id="districtlist" onChange="clearDiv('subcountyPane'); ajaxSubmitData('locations/managesubCounty.htm', 'countyPane', 'act=b&i=' + this.value + '&b=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
            <option value="0">--Select District--</option>
            <c:forEach items="${model.districtList}" var="distr">
                <option value="${distr[0]}">${distr[1]}</option>
            </c:forEach>
        </select>
    </c:if>
    <c:if test="${model.b=='b'}">
        <select class="form-control" name="county" id="countylist" onChange="clearDiv('subcountyPane'); ajaxSubmitData('locations/managesubCounty.htm', 'subcountyPane', 'act=b&i=' + this.value + '&b=c&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
            <option value="0">--Select County--</option>
            <c:forEach items="${model.countyList}" var="count">
                <option value="${count[0]}">${count[1]}</option>
            </c:forEach>
        </select>
    </c:if>    

    <c:if test="${model.b=='c'}">
        <fieldset style="width: 100%"><legend>Sub-County Under County: ${model.countyObj.countyname} [Sub counties: ${model.size}]</legend>
            <div id="response-pane"></div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th class="center">No</th>
                                        <th>Sub County Name</th>
                                        <th>County Name</th>
                                        <th>District Name </th>
                                        <th>Region Name </th>
                                            <security:authorize access="hasRole('PRIVILEGE_UPDATESUBCOUNTY') or hasRole('PRIVILEGE_DELETESUBCOUNTY')">  </security:authorize>
                                            <th class="center">Manage</th>

                                        </tr>
                                    </thead>
                                    <tbody id="tableDesc">
                                    <c:set var="count" value="1"/>
                                    <c:set var="No" value="0" />
                                    <c:forEach items="${model.subCountyList}" var="list" varStatus="status">
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
                                            <td align="left">${list[3]}</td>
                                            <td align="left">${list[4]}</td>
                                            <security:authorize access="hasRole('PRIVILEGE_UPDATESUBCOUNTY') or hasRole('PRIVILEGE_DELETESUBCOUNTY')">    </security:authorize>
                                                <td class="center">
                                                    <a href="#" title="Update Sub County" onclick="ajaxSubmitData('locations/addOrUpdateSubCounty.htm', 'response-pane', {scID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                                    &nbsp;
                                                    <a href="#" title="View Attachments/Discard Sub County" onclick="
                                                             ajaxSubmitData('locations/manageSelectedLoc.htm', 'response-pane', {id: '${list[0]}', act: 'sc', st: 'a', v2: '0'}, 'GET');"><i class="fa fa-fw fa-lg fa-book"></i>
                                                    </a>
                                                       <!-- <a href="#" title="Discard Sub County" onclick="var resp = confirm('Are you sure you want to delete Sub County:: ${list[1]}!');
                                                                if (resp === false) {
                                                                    return false;
                                                                }
                                                                ajaxSubmitData('locations/deleteSubCounty.htm', 'response-pane', 'act=a&scID=${list[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-times"></i>
                                                        </a>-->
                                                </td>
                                         </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="row" id="addNew"></div>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset> 
    </c:if>
</c:if>
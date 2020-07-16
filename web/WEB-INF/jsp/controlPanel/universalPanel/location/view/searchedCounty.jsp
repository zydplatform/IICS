<%-- 
    Document   : searchedCounty
    Created on : Jun 11, 2018, 6:40:47 PM
    Author     : user
--%>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset style="width: 99%"><legend></legend> <%--${model.title}--%>
    <div id="response-pane"></div>
    <div class="row" id="countyPane">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                        <thead>
                            <tr>
                                <th class="center">No</th>
                                <th>County Name</th>
                                <th>District Name </th>
                                <th>Region Name </th>
                        <security:authorize access="hasRole('PRIVILEGE_UPDATECOUNTY') or hasRole('PRIVILEGE_DELETECOUNTY')"> </security:authorize>
                                    <th class="center">Manage</th>
                                </tr>
                            </thead>
                            <tbody id="tableDesc">
                            <c:set var="count" value="1"/>
                            <c:set var="No" value="0" />
                            <c:forEach items="${model.countyList}" var="list" varStatus="status">
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

                                    <td class="center">
                                        <a href="#" title="Update County" onclick="ajaxSubmitData('locations/addOrUpdateCounty.htm', 'response-pane', {cID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                        &nbsp;
                                        <a href="#" title="View Attachments/Discard County" onclick="
                                                    ajaxSubmitData('locations/manageSelectedLoc.htm', 'countyPane', {id:'${list[0]}',act:'c',st:'a',v2:'0'}, 'GET');"><i class="fa fa-fw fa-lg fa-book"></i></a>
                                       <!-- <a href="#" title="Discard County" onclick="var resp = confirm('Are you sure you want to delete County ${list[1]}!');
                                                if (resp === false) {
                                                    return false;
                                                }
                                               ajaxSubmitData('locations/deleteCounty.htm', 'response-pane', 'act=a&id=${list[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-times"></i></a>-->
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
<script>
    $(document).ready(function () {
        $('#sampleTable').DataTable();
    });
</script>
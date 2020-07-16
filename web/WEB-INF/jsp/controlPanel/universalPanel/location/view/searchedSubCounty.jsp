<%-- 
    Document   : searchedSubCounty
    Created on : Jun 20, 2018, 1:20:02 PM
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
                                <th>Sub County Name</th>
                                <th>County Name</th>
                                <th>District Name </th>
                                <th>Region Name </th>
                        <security:authorize access="hasRole('PRIVILEGE_UPDATESUBCOUNTY') or hasRole('PRIVILEGE_DELETESUBCOUNTY')"> </security:authorize>
                                    <th class="center">Manage</th>
                                </tr>
                            </thead>
                            <tbody id="tableDesc">
                            <c:set var="count" value="1"/>
                            <c:set var="No" value="0" />
                            <c:forEach items="${model.subcountyList}" var="list" varStatus="status">
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

                                    <td class="center">
                                        <a href="#" title="Update Sub County" onclick="ajaxSubmitData('locations/addOrUpdateSubCounty.htm', 'response-pane', {scID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                        &nbsp;
                                        <a href="#" title="Discard Sub County" onclick="var resp = confirm('You want to delete Sub County:: ${list[1]}!');
                                                if (resp === false) {
                                                    return false;
                                                }
                                               ajaxSubmitData('locations/deleteSubCounty.htm', 'response-pane', 'act=a&scID=${list[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-times"></i></a>
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
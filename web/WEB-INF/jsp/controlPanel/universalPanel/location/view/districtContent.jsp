<%--
    Document   : districtContent
    Created on : Jun 1, 2018, 4:10:49 PM
    Author     : Uwera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="col-md-12">
    <p class="pull-right">
        <a class="btn btn-primary icon-btn" href="#" onClick="ajaxSubmitData('locations/addOrUpdateDistrict.htm', 'response-pane', {dID: '0', act: 'add'}, 'GET');">
            <i class="fa fa-plus"></i>
            Add New District
        </a>
    </p>
</div>

<div class="box-title" align="center">
    <h3>
        <i class="fa fa-home"></i>
        Manage Districts [${model.totalDistricts}]
    </h3>
</div>

<fieldset style="width: 99%"><legend></legend>  
    <div id="response-pane"></div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                        <thead>
                            <tr>
                                <th class="center">No</th>
                                <th>District Name</th>
                                <th>Region Name </th>
                                    <security:authorize access="hasRole('PRIVILEGE_UPDATEDISTRICTS') or hasRole('PRIVILEGE_DELETEDISTRICT')"> </security:authorize>

                                    <th class="center">Manage</th>
                                </tr>
                            </thead>
                            <tbody id="tableDesc">
                            <c:set var="count" value="1"/>
                            <c:set var="No" value="0" />
                            <c:forEach items="${model.districts}" var="list" varStatus="status" begin="0" end="${model.size}">
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
                                        <a href="#" title="Update District" onclick="ajaxSubmitData('locations/addOrUpdateDistrict.htm', 'response-pane', {dID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                        &nbsp;
                                         <a href="#" title="View Attachments/Discard Parish" onclick="
                                                    ajaxSubmitData('locations/manageSelectedLoc.htm', 'response-pane', {id:'${list[0]}',act:'d',st:'a',v2:'0'}, 'GET');"><i class="fa fa-fw fa-lg fa-book"></i></a>
                                       <!-- <a href="#" title="Discard District" onclick="var resp = confirm('Are you sure you want to delete District: ${list[1]}!');
                                                if (resp === false) {
                                                    return false;
                                                }
                                                ajaxSubmitData('locations/deleteDistrictx', 'response-pane', 'act=a&id=${list[0]}', 'GET');" ><i class="fa fa-fw fa-lg fa-times"></i>
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
</div>
<script>
    $(document).ready(function () {
        $('#discardPane').modal('show');
        $('#sampleTable').DataTable();
    });
</script>






















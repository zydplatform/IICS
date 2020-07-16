<%-- 
    Document   : staffAddComponents
    Created on : Aug 2, 2018, 6:31:11 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<hr>
<div class="row">
    <div class="col-md-4">
        <strong>Select Facility Units:</strong>
    </div>
    <div class="col-md-6">
        <select class="form-control" id="stafffacilityUnassignedunitsComponenents">
            <c:forEach items="${stafffacilityunitslist}" var="units">
                <option  value="${units.stafffacilityunitid}">${units.facilityunitname}</option>
            </c:forEach>
        </select>
    </div>
    <div class="col-md-2">

    </div>
</div><br>
<hr>
<form id="stafffacilityunitCompid_forms">
    <div class="row">
        <div class="col-md-4">
            <strong>Select Component</strong>
        </div>
        <div class="col-md-6">
            <select class="form-control" id="StaffgroupreleasedcomponentsId">
                <option value="select" id="defaultreleasedfagroupCompntsselectid">-----------Select------------</option>

            </select>  
        </div>
        <div class="col-md-2">

        </div>
    </div>   
</form>
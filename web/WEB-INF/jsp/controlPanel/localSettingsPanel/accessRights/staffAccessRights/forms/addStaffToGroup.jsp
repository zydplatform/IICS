<%-- 
    Document   : addStaffToGroup
    Created on : Jul 22, 2018, 6:11:16 PM
    Author     : Grace-K
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<hr>
<c:if test="${not empty facilitygroupslist}">
   
        <div class="row">
            <div class="col-md-4">
                <strong>Select Group:</strong>
            </div>
            <div class="col-md-6">
                <select class="form-control" id="groupreleasecomponentgroupid">
                    <option value="select" id="defaultgroupstaffsselectid">-----------Select------------</option>
                    <c:forEach items="${facilitygroupslist}" var="group">
                        <option id="SelectgroupstfOption${group.accessrightsgroupid}" value="${group.accessrightsgroupid}">${group.accessrightgroupname}</option>
                    </c:forEach>
                </select>  
            </div>
            <div class="col-md-2">

            </div>
        </div><br>
        <hr>
        <div class="row">
            <div class="col-md-4">
                <strong>Select Facility Units:</strong>
            </div>
            <div class="col-md-6">
                <select class="form-control" id="stafffacilityassignedunits" multiple="">
                    <c:forEach items="${stafffacilityunitslist}" var="units">
                        <option  value="${units.stafffacilityunitid}">${units.facilityunitname}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">

            </div>
        </div><br>
        <hr>
    <form id="stafffacilityunitid_forms">
        <div class="row">
            <div class="col-md-4">
                <strong>Select Component</strong>
            </div>
            <div class="col-md-6">
                <select class="form-control" id="groupreleasecomponentId">
                    <option value="select" id="defaultgroupCompntsselectid">-----------Select------------</option>

                </select>  
            </div>
            <div class="col-md-2">

            </div>
        </div>   
    </form>
    <hr>
    <div class="row">
        <div class="col-md-2">
            <div class="overlay" id="gettinggroupscomponentstructurediv" style="display: none;">
                <div class="m-loader mr-4">
                    <svg class="m-circular" viewBox="25 25 50 50">
                    <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                    </svg>
                </div>
                <h5 class="l-text">Please Wait...........</h5>
            </div>
        </div>
        <div class="col-md-10">
            <div id="releasedgroupscomponentsforgrouptree">

            </div>
        </div>
    </div>

</c:if>
<c:if test="${empty facilitygroupslist}">
    <h1 style="margin-top: 15%; margin-left: 10%;"><span class="badge badge-secondary"><strong>No Groups UN ASSIGNED TO THIS STAFF</strong></span></h1>
    <h5 style="margin-left: 20%;"><span class="badge badge-danger"><strong>First Create Access Rights Group</strong></span></h5> 
</c:if>
<script>
    $('#stafffacilityassignedunits').select2();
    $('#groupreleasecomponentgroupid').change(function () {
        var groupid = $('#groupreleasecomponentgroupid').val();
        $.ajax({
            type: 'POST',
            data: {groupid: groupid,act:'a'},
            url: "localaccessrightsmanagement/getgroupcomponents.htm",
            success: function (data, textStatus, jqXHR) {
                var response = JSON.parse(data);
                $('#groupreleasecomponentId').html('');
                $('#groupreleasecomponentId').append('<option value="select" id="defaultgroupCompntsselectid">-----------Select------------</option>');
                if (response.length > 0) {
                    for (index in response) {
                        var results = response[index];
                        $('#groupreleasecomponentId').append('<option value="' + results["systemmoduleid"] + '" id="groupCompntsselectid' + results["systemmoduleid"] + '">' + results["componentname"] + '</option>');
                    }
                }
            }
        });
    });
    $('#groupreleasecomponentId').change(function () {
        var componentid = $('#groupreleasecomponentId').val();
        var groupid = $('#groupreleasecomponentgroupid').val();
        if (componentid !== 'select') {
            document.getElementById('gettinggroupscomponentstructurediv').style.display = 'block';
            ajaxSubmitData('localaccessrightsmanagement/groupasssignedcomponentsubcomponents.htm', 'releasedgroupscomponentsforgrouptree', 'act=a&componentid=' + componentid + '&groupid=' + groupid + '&ofst=1&maxR=100&sStr=', 'GET');
        }
    });
</script>
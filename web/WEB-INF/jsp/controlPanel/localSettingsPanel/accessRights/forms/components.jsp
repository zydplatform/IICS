<%-- 
    Document   : components
    Created on : Jul 20, 2018, 4:54:29 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<hr>
<div class="row">
    <div class="col-md-4">
        <strong>Select Component:</strong>
    </div>
    <div class="col-md-6">
        <select class="form-control" id="groupreleasecomponentid">
            <option value="select" id="defaultComponentsselectid">-----------Select------------</option>
            <c:forEach items="${componentsList}" var="systemcomponent">
                <option id="SelectOption${systemcomponent.systemmoduleid}" value="${systemcomponent.systemmoduleid}">${systemcomponent.componentname}</option>
            </c:forEach>
        </select>  
    </div>
    <div class="col-md-2">
        <input type="hidden" id="createdgroupid" value="${groupid}">
    </div>
</div><br>
<hr>
<div class="row">
    <div class="col-md-2">
        <div class="overlay" id="gettingcomponentstructurediv" style="display: none;">
            <div class="m-loader mr-4">
                <svg class="m-circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                </svg>
            </div>
            <h5 class="l-text">Please Wait...........</h5>
        </div>
    </div>
    <div class="col-md-10">
        <div id="releasecomponentsforgrouptree">

        </div>
    </div>
</div>
<hr>
<div class="row">
    <div class="col-md-12">
        <button class="btn btn-primary" id="savegroupaccessrightsassignmentbtns" onclick="savegroupaccessrightsassignment();">Save</button>
    </div>
</div>
<script>
    $('#groupreleasecomponentid').change(function () {
        var systemmoduleid = $('#groupreleasecomponentid').val();
        var createdgroupid = $('#createdgroupid').val();
        if (systemmoduleid !== 'select') {
            document.getElementById('gettingcomponentstructurediv').style.display = 'block';
            //ajaxSubmitData('localaccessrightsmanagement/componentsubcomponents.htm', 'releasecomponentsforgrouptree', 'act=a&systemmoduleid=' + systemmoduleid + '&allaccesspriv=' + '${allaccesspriv}' + '&createdgroupid=' + createdgroupid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
            ajaxSubmitData('localaccessrightsmanagement/componentsubcomponentstest.htm', 'releasecomponentsforgrouptree', 'act=a&systemmoduleid=' + systemmoduleid + '&allaccesspriv=' + '${allaccesspriv}' + '&createdgroupid=' + createdgroupid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    });
</script>
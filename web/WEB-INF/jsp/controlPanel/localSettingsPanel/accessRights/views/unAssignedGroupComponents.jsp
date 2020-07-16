<%-- 
    Document   : unAssignedGroupComponents
    Created on : Aug 2, 2018, 11:18:53 AM
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
        <select class="form-control" id="ReleaseUnreleasedFacilitycomponentid">
            <option value="select" id="ReleaseUnReleasedFacilityComponentsselectid">-----------Select------------</option>
            <c:forEach items="${groupcomponentsList}" var="systemcomponent">
                <option id="ReleaseUnReleasedGroupUndefault${systemcomponent.systemmoduleid}" value="${systemcomponent.systemmoduleid}">${systemcomponent.componentname}</option>
            </c:forEach>
        </select>  
    </div>
    <div class="col-md-2">

    </div>
</div><br>
<hr>
<div class="row">
    <div class="col-md-2">
        <div class="overlay" id="gettUnreleasecomponentstructurediv" style="display: none;">
            <div class="m-loader mr-4">
                <svg class="m-circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                </svg>
            </div>
            <h5 class="l-text">Please Wait...........</h5>
        </div>
    </div>
    <input id="facilityaccessrightsgroupidComp" type="hidden" value="${accessrightsgroupid}">
    <div class="col-md-10">
        <div id="releaseUnReleasedGroupscomponentsinfacility">

        </div>
    </div>
</div>
<hr>
<script>
    $('#ReleaseUnreleasedFacilitycomponentid').change(function(){
        var componentid=$('#ReleaseUnreleasedFacilitycomponentid').val();
        ajaxSubmitDataNoLoader('localaccessrightsmanagement/componentstreeview.htm', 'releaseUnReleasedGroupscomponentsinfacility', 'systemmoduleid=' + componentid + '&act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
</script>
<%-- 
    Document   : addMoreComponents
    Created on : Jul 31, 2018, 11:47:54 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<hr>
<div class="row">
    <div class="col-md-4">
        <strong>Select Component:</strong>
    </div>
    <div class="col-md-6">
        <select class="form-control" id="ReleaseUngroupreleasecomponentid">
            <option value="select" id="ReleasedUndefaultComponentsselectid">-----------Select------------</option>
            <c:forEach items="${customChildList}" var="systemcomponent">
                <option id="ReleasedUndefault${systemcomponent.systemmoduleid}" value="${systemcomponent.systemmoduleid}">${systemcomponent.componentname}</option>
            </c:forEach>
        </select>  
    </div>
    <div class="col-md-2">

    </div>
</div><br>
<hr>
<div class="row">
    <div class="col-md-2">
        <div class="overlay" id="gettingUnreleasecomponentstructurediv" style="display: none;">
            <div class="m-loader mr-4">
                <svg class="m-circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                </svg>
            </div>
            <h5 class="l-text">Please Wait...........</h5>
        </div>
    </div>
    <input id="facilityidofunreleasedComp" type="hidden" value="${facilityid}">
    <div class="col-md-10">
        <div id="releaseUnReleasedcomponentsforfacility">

        </div>
    </div>
</div>

<hr>
<script>
    $('#ReleaseUngroupreleasecomponentid').change(function () {
        var systemmodule = $('#ReleaseUngroupreleasecomponentid').val();
        var facilityid = $('#facilityidofunreleasedComp').val();
        if (systemmodule !== 'select') {
            ajaxSubmitData('activitiesandaccessrights/componentsubcomponents.htm', 'releaseUnReleasedcomponentsforfacility', 'act=a&systemmoduleid=' + systemmodule + '&facilityid='+facilityid+'&ofst=1&maxR=100&sStr=', 'GET');
        }
    });
</script>
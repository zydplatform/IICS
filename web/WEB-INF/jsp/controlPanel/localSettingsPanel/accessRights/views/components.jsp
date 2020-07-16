<%-- 
    Document   : components
    Created on : Jul 23, 2018, 4:27:21 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-4">
        <strong>Select Component</strong>
    </div>
    <div class="col-md-4">
        <select class="form-control" id="groupaccessRightcomponentId">
            <c:forEach items="${groupcomponentsList}" var="components">
                <option  value="${components.systemmoduleid}">${components.componentname}</option>
            </c:forEach>
        </select>  
    </div>
    <div class="col-md-4 right">
        <p style="font-weight: bold;">Select Type</p>
        <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
            <div class="btn-group" role="group">
                <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-sliders" aria-hidden="true"></i>
                </button>
                <div class="dropdown-menu dropdown-menu-left">
                    <span class="dropdown-item icon-custom" onclick="viewGroupAssignedorUnComponents('granted');">Assigned</span><hr>
                    <span class="dropdown-item icon-custom" onclick="viewGroupAssignedorUnComponents('ungranted');">Un Assigned</span>
                </div>
            </div>
        </div>
    </div>
</div> <br>
<hr>
<div class="row">
    <div class="col-md-2">
        <div class="overlay" id="groupgrantedscomponentsLoader" style="display: none;">
            <div class="m-loader mr-4">
                <svg class="m-circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                </svg>
            </div>
            <h5 class="l-text">Please Wait...........</h5>
        </div> 
    </div>
    <div class="col-md-10">
        <div id="Accessgroupscomponentsforgrouptree">

        </div>
    </div>
</div>
<script>
    var selectedcomponent = $('#groupaccessRightcomponentId').val();
    if (selectedcomponent !== '' || selectedcomponent !== null) {
        document.getElementById('groupgrantedscomponentsLoader').style.display = 'block';
        ajaxSubmitData('localaccessrightsmanagement/viewgroupscomponents.htm', 'Accessgroupscomponentsforgrouptree', 'componentid=' + selectedcomponent + '&groupid=' +${groupid} + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    $('#groupaccessRightcomponentId').change(function () {
        var componentselect = $('#groupaccessRightcomponentId').val();
        document.getElementById('groupgrantedscomponentsLoader').style.display = 'block';
        ajaxSubmitData('localaccessrightsmanagement/viewgroupscomponents.htm', 'Accessgroupscomponentsforgrouptree', 'componentid=' + componentselect + '&groupid=' +${groupid} + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    function viewGroupAssignedorUnComponents(type) {
        if (type === 'ungranted') {
            var componentselect2 = $('#groupaccessRightcomponentId').val();
            document.getElementById('groupgrantedscomponentsLoader').style.display = 'block';
            ajaxSubmitData('localaccessrightsmanagement/viewUngrantedgroupscomponents.htm', 'Accessgroupscomponentsforgrouptree', 'componentid=' + componentselect2 + '&groupid=' +${groupid} + '&b=ungranted&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        } else {
            var componentselect3 = $('#groupaccessRightcomponentId').val();
            document.getElementById('groupgrantedscomponentsLoader').style.display = 'block';
            ajaxSubmitData('localaccessrightsmanagement/viewgroupscomponents.htm', 'Accessgroupscomponentsforgrouptree', 'componentid=' + componentselect3 + '&groupid=' +${groupid} + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    }
</script>
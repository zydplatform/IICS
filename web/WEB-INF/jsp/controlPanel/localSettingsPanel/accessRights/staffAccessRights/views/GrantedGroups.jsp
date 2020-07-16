<%-- 
    Document   : GrantedGroups
    Created on : Jul 23, 2018, 10:22:49 AM
    Author     : Grace-K
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<input id="staffidXXXX" value="${staffid}" type="hidden">
<div class="row">
    <div class="col-md-11 col-sm-11 right">

    </div>
</div>
<div class="row">
    <div class="col-md-4">
        <strong>Select Group:</strong>
    </div>
    <div class="col-md-4">
        <select class="form-control" id="staffGratedGroupsSlectId">
            <c:forEach items="${staffgroupslist}" var="group">
                <option value="${group.accessrightsgroupid}">${group.accessrightgroupname}</option>
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
                    <span class="dropdown-item icon-custom" onclick="viewStaffAssignedorUnComponents('granted');">Assigned</span><hr>
                    <span class="dropdown-item icon-custom" onclick="viewStaffAssignedorUnComponents('ungranted');">Un Assigned</span>
                </div>
            </div>
        </div>
    </div>
</div><br>
<hr>
<form id="StaffGrantedAccessRightsForms">
    <div class="row">
        <div class="col-md-4">
            <strong>Select Units:</strong>
        </div>
        <div class="col-md-4">
            <select class="form-control" id="GratedUnitsGroupsComponentsSlectId">
                <option value="select">-----------Select------------</option>

            </select>  
        </div>
        <div class="col-md-4">

        </div>
    </div><br>
    <hr>
    <div class="row">
        <div class="col-md-4">
            <strong>Select Components:</strong>
        </div>
        <div class="col-md-4">
            <select class="form-control" id="staffGratedGroupsComponentsSlectId">
                <option value="select" id="defgroupCompstaffsselectid">-----------Select------------</option>

            </select>  
        </div>
        <div class="col-md-4">

        </div>
    </div>  
</form><br>
<hr>
<div class="row">
    <div class="col-md-2">
        <div class="overlay" style="display: none" id="staffgrantedscomponentsLoader">
            <div class="m-loader mr-4">
                <svg class="m-circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                </svg>
            </div>
            <h5 class="l-text">Please Wait...........</h5>
        </div>
    </div>
    <div class="col-md-10">
        <div id="staffgrantedscomponentsforgrouptree" >

        </div>
    </div>
</div>
<script>
    var assaccessrightsgroupid = $('#staffGratedGroupsSlectId').val();
    var staffidXXXX = $('#staffidXXXX').val();
    if (!assaccessrightsgroupid) {
    } else {
        $.ajax({
            type: 'POST',
            data: {groupid: assaccessrightsgroupid, staffid: staffidXXXX},
            url: "localaccessrightsmanagement/getgroupstaffcomponents.htm",
            success: function (data, textStatus, jqXHR) {
                var response = JSON.parse(data);
                $('#GratedUnitsGroupsComponentsSlectId').html('');
                $('#GratedUnitsGroupsComponentsSlectId').append('<option value="select">-----------Select------------</option>');
                if (response.length > 0) {
                    for (index in response) {
                        var results = response[index];
                        $('#GratedUnitsGroupsComponentsSlectId').append('<option value="' + results["stafffacilityunitid"] + '" id="DefaulStaffGroupCompntsselectid' + results["stafffacilityunitid"] + '">' + results["facilityunitname"] + '</option>');
                    }
                }
            }
        });
    }
    $('#GratedUnitsGroupsComponentsSlectId').change(function () {
        var stafffacilityunit = $('#GratedUnitsGroupsComponentsSlectId').val();
        var assaccessrightsgroupid2 = $('#staffGratedGroupsSlectId').val();
        if (stafffacilityunit !== 'select') {
            $.ajax({
                type: 'POST',
                data: {groupid: assaccessrightsgroupid2, stafffacilityunitid: stafffacilityunit, act: 'b'},
                url: "localaccessrightsmanagement/getgroupcomponents.htm",
                success: function (data, textStatus, jqXHR) {
                    var response = JSON.parse(data);
                    $('#staffGratedGroupsComponentsSlectId').html('');
                    $('#staffGratedGroupsComponentsSlectId').append('<option value="select" id="defgroupCompstaffsselectid">-----------Select------------</option>');
                    if (response.length > 0) {
                        for (index in response) {
                            var results = response[index];
                            $('#staffGratedGroupsComponentsSlectId').append('<option value="' + results["systemmoduleid"] + '" id="DefaulgroupCompntsselectid' + results["systemmoduleid"] + '">' + results["componentname"] + '</option>');
                        }
                    }
                }
            });
        } else {

        }

    });
    $('#staffGratedGroupsComponentsSlectId').change(function () {
        if (selectedvalue === 0) {
            var staffidXX = $('#staffidXXXX').val();
            var stafffacilityunit = $('#GratedUnitsGroupsComponentsSlectId').val();
            var systemmoduleid = $('#staffGratedGroupsComponentsSlectId').val();
            var staffGratedGroupsSlectId = $('#staffGratedGroupsSlectId').val();
            if (systemmoduleid !== 'select' && stafffacilityunit !== 'select') {
                document.getElementById('staffgrantedscomponentsLoader').style.display = 'block';
                ajaxSubmitDataNoLoader('localaccessrightsmanagement/staffgrantedscomponentsgrouptree.htm', 'staffgrantedscomponentsforgrouptree', 'accessrightsgroupid=' + staffGratedGroupsSlectId + '&staffidXXXX=' + staffidXX + '&systemmoduleid=' + systemmoduleid + '&stafffacilityunit=' + stafffacilityunit + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
            }
        } else {
            viewStaffAssignedorUnComponents('ungranted');
        }
    });
    var selectedvalue = 0;
    function viewStaffAssignedorUnComponents(type) {
        if (type === 'ungranted') {
            var staffidXX = $('#staffidXXXX').val();
            var stafffacilityunit3 = $('#GratedUnitsGroupsComponentsSlectId').val();
            var systemmoduleid = $('#staffGratedGroupsComponentsSlectId').val();
            var staffGratedGroupsSlectId = $('#staffGratedGroupsSlectId').val();
            if (systemmoduleid !== 'select' && stafffacilityunit3 !== 'select') {
                selectedvalue = 1;
                document.getElementById('staffgrantedscomponentsLoader').style.display = 'block';
                ajaxSubmitDataNoLoader('localaccessrightsmanagement/staffungrantedscomponentsgrouptree.htm', 'staffgrantedscomponentsforgrouptree', 'accessrightsgroupid=' + staffGratedGroupsSlectId + '&staffidXXXX=' + staffidXX + '&systemmoduleid=' + systemmoduleid + '&stafffacilityunit=' + stafffacilityunit3 + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
            } else {
                $.confirm({
                    title: 'Components!',
                    icon: 'fa fa-warning',
                    content: 'No Component Selected Select Component First!!',
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                        }
                    }
                });
            }
        } else {
            var staffidXX2 = $('#staffidXXXX').val();
            var stafffacilityunit2 = $('#GratedUnitsGroupsComponentsSlectId').val();
            var systemmoduleid2 = $('#staffGratedGroupsComponentsSlectId').val();
            var staffGratedGroupsSlectId2 = $('#staffGratedGroupsSlectId').val();
            if (systemmoduleid2 !== 'select' && stafffacilityunit2 !== 'select') {
                selectedvalue = 0;

                document.getElementById('staffgrantedscomponentsLoader').style.display = 'block';
                ajaxSubmitDataNoLoader('localaccessrightsmanagement/staffgrantedscomponentsgrouptree.htm', 'staffgrantedscomponentsforgrouptree', 'accessrightsgroupid=' + staffGratedGroupsSlectId2 + '&staffidXXXX=' + staffidXX2 + '&systemmoduleid=' + systemmoduleid2 + '&stafffacilityunit=' + stafffacilityunit2 + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
            } else {
                $.confirm({
                    title: 'Components!',
                    icon: 'fa fa-warning',
                    content: 'No Component Selected Select Component First!!',
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                        }
                    }
                });
            }
        }
    }
    $('#staffGratedGroupsSlectId').change(function () {
        document.getElementById('StaffGrantedAccessRightsForms').reset();
        $('#staffgrantedscomponentsforgrouptree').html('');
    });
</script>
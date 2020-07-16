<%-- 
    Document   : assignedservices
    Created on : Jul 26, 2018, 9:23:47 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-12">
        <fieldset style="">
            <table class="table table-hover table-bordered" id="assignedservicetable">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Service</th>
                        <th class="center">Room(s) Taken</th>
                        <th class="center">Manage</th>
                    </tr>
                </thead>
                <tbody>
                    <% int x = 1;%>
                    <c:forEach items="${servicelist}" var="details">
                        <tr>
                            <td><%=x++%></td>
                            <td>${details.servicename}</td>
                            <td class="center">
                                <c:if test="${details.rooms !=0}">
                                    <a><button id="viewrmz" class="btn btn-warning btn-small center" style="border-radius: 50%;" onclick="viewroompath(${details.serviceid}, '${details.servicename}')"><span id="blocksz">${details.rooms}</span></button></a>
                                        </c:if>
                                        <c:if test="${details.rooms ==0}">
                                    <a><button id="viewrmz" class="btn btn-secondary btn-small center" style="border-radius: 50%;" onclick="error('${details.servicename}')"><span id="blocksz">${details.rooms}</span></button></a>   
                                        </c:if>
                            </td>
                            <td class="center">
                                <button onclick="manageservicerooms(${details.serviceid}, '${details.servicename}',${details.facilityunitserviceid})" class="btn btn-primary btn-sm">
                                    <i class="fa fa-dedent"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </fieldset>
    </div>
</div>
<!--<div class="row">
    <div class="col-md-12">
        <div id="assignRoomFacilityDialog" class="modalDialog assignCellStaffDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <font color="blue"><h2 style="font-style: oblique;margin-left: 2em" id="servicename"></h2></font>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <font color="blue"><h2 id="servicename"></h2></font>
                        
                        
                        <div class="row">
                            <div class="col-md-12 col-sm-12 right" id="assignBtnDiv">
                                <button class="btn btn-sm btn-primary icon-btn" onclick="assignservice()">
                                    <i class="fa fa-save"></i>
                                    Save service(s)
                                </button>
                            </div>
                        </div>
                        <fieldset>
                            <div class="row" id="buidingdetails" style="margin-top: 2em">

                            </div>
                        </fieldset>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>-->

<script>
    $(document).ready(function () {
        $('#assignedservicetable').DataTable();
        $('.building').select2();
        $('.select2').css('width', '100%');
        $('#assignBtnDiv').hide();

        $('#activity-select').change(function () {
            var buildingid = $(this).val();
            var serviceid = $('#serviceid').val();
            if (buildingid === null) {
                $.confirm({
                    title: 'Encountered an error!',
                    content: 'Please add locations to units before assigning them services',
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        Ok: {
                            text: 'Try again',
                            btnClass: 'btn-red',
                            action: function () {
                            }
                        },
                        close: function () {
                        }
                    }
                });
            } else {
                ajaxSubmitData('serviceallocation/unassignedservices.htm', 'buidingdetails', '&buildingid=' + buildingid + '&serviceid=' + serviceid + '', 'GET');
            }
        });
    });
    function error(servicename) {
        $.confirm({
            title: 'Warning!',
            content: 'There is no Location(s) attatched to:' + '<font color="green">' + servicename + '</font>',
            type: 'red',
            typeAnimated: true,
        });
    }
    function viewroompath(serviceid, servicename) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "serviceallocation/viewroomswithservices.htm",
            data: {serviceid: serviceid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">Room(s) assigned to:' + '<font color="green">' + servicename + '</font>' + '</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '50%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,

                });
            }
        });
    }
    var selectedRooms = new Set();
    var selectedroomid = [];
    function assignroom(roomId, facilityunitroomid) {
        if (!selectedRooms.has(roomId)) {
            selectedRooms.add(roomId);
            selectedroomid.push({
                facilityunitroomid: facilityunitroomid
            });
            $('#assignBtnDiv').show();
        } else {
            selectedRooms.delete(roomId);
            selectedRooms.delete(facilityunitroomid);
            if (selectedRooms.size < 1) {
                $('#assignBtnDiv').hide();
            }
        }
    }

    function manageservicerooms(serviceid, servicename, facilityunitserviceid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "serviceallocation/unassignedservices.htm",
            data: {serviceid: serviceid,facilityunitserviceid: facilityunitserviceid},
            success: function (jsonorderitemslist) {
                $.dialog({
                    title: '<strong class="center">Room(s) assigned to:' + '<font color="green">' + servicename + '</font>' + '</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '80%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,

                });
            }
        });
//        document.getElementById('serviceid').value = serviceid;
//        document.getElementById('facilityunitserviceid').value = facilityunitserviceid;
//        $("#servicename").html(servicename);
//        var buildingid = $('#activity-select').val();
//        window.location = '#assignRoomFacilityDialog';
//        initDialog('modalDialog assignCellStaffDialog');
//        ajaxSubmitData('serviceallocation/unassignedservices.htm', 'buidingdetails', '&buildingid=' + buildingid + '&serviceid=' + serviceid + '', 'GET');
    }
    function assignservice() {
        var serviceid = $('#serviceid').val();
        var servicename = $('#servicename').val();
        $.ajax({
            type: 'POST',
            data: {serviceid: serviceid, selectedroomid: JSON.stringify(Array.from(selectedroomid))},
            url: 'serviceallocation/savefavilityunitroom.htm',
            success: function (res) {
                ajaxSubmitData('serviceallocation/servicelocationmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                $('#assignRoomFacilityDialog').modal('hide');
                window.location = '#close';
                $.notify({
                    title: "Assignment complete : ",
                    message: "This service has been assigned to the listed room(s)",
                    icon: 'fa fa-check'
                }, {
                    type: "info"
                });
            }
        });

    }
</script>
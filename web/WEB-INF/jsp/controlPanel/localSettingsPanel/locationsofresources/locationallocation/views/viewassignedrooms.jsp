<%-- 
    Document   : viewassignedrooms
    Created on : Jul 24, 2018, 10:27:05 AM
    Author     : RESEARCH
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <div class="row">
                    <div class="col-md-7 col-sm-7">
                        <h3 class="tile-title">Assigned Locations</h3>
                    </div>
                </div>
                <table class="table table-hover table-striped" id="assignedRoomTable">
                    <thead>
                        <tr>
                            <th class="center">#</th>
                            <th class="center">Facility Unit</th>
                            <th class="center">Building</th>
                            <th class="center">Taken Rooms</th>
                            <th class="center">Manage</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int u = 1;%>
                        <% int j = 1;%>
                        <c:forEach items="${assignedUnitsList}" var="aR">
                            <tr id="${aR.facilityunitid}">
                                <td class="center"><%=u++%></td>
                                <td>${aR.facilityunitname}</td>
                                <td class="center">                                    
                                    <c:if test="${aR.buildingname != null}">
                                        <div class="animated-checkbox">
                                            <label>
                                                <input type="checkbox"><strong><span class="label-text">${aR.buildingname}</span></strong>
                                            </label>
                                        </div>
                                        
                                        </c:if>
                                        <c:if test="${aR.buildingname == null}">
                                        <strong><span style="color: red" id="blocksz">NONE</span></strong>
                                    </c:if>

                                </td>
                                <td class="center">
                                    <c:if test="${aR.facilityunitroomcount != null}">
                                        <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" class="btn btn-secondary btn-sm center"  onclick="viewAssignedRooms(${aR.facilityunitid}, '${aR.facilityunitname}', '${aR.buildingname}', '${aR.buildingid}');" style="background-color: green; color: white">
                                            <span id="blocksz">${aR.facilityunitroomcount}</span>
                                        </a>
                                    </c:if>
                                    <c:if test="${aR.facilityunitroomcount == null}">
                                        <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" href="#!" class="btn btn-secondary btn-sm center" style="background-color: green; color: white">
                                            <span id="blocksz">${aR.facilityunitroomcount}</span>
                                        </a>
                                    </c:if>
                                </td>
                                <td class="center">
                                    <button class="btn btn-sm btn-primary" onclick="deassignFacUnit(${aR.facilityunitid}, '${aR.facilityunitname}', '${aR.buildingname}', '${aR.buildingid}');" id="up<%=j++%>">
                                        <i class="fa fa-fw fa-sm fa-dedent"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="unAssignRoomFacilityDialog" class="modalDialog assignCellStaffDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="assignRoomsTitle">De-Assign Facility Unit</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="tile-body">
                                    <form action="" class="formName">
                                        <div class="form-group">
                                            <select class="form-control" id="building-selects" onchange="fetchUnitLocations();">

                                            </select>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <input id="facilityunitname" type="hidden"/>
                        <input id="facilityunitid" type="hidden"/>
                        <div class="col-md-12" id="cellsPreviewed">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="AssignRoomDialog" class="modalDialog patientConfirmFont">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="assignRoomsTitle"> Rooms Assigned To <span id="facilityunitname"></span></h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-4">
                                <h3 class="modalDialog-title" id="assignRoomsTitle">Current Building: <span id="buildingnames"></span></h3>
                            </div>
                        </div>
                        <div class="col-md-12" id="roomsPreview">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var selectedRoom = new Set();
    var selectedDeassignRooms = [];
    $(document).ready(function () {
        $('#assignedRoomTable').DataTable();
    });

    function deassignRoom(roomId, facRoomId) {
        console.log("roomId" + roomId);
        console.log("facRoomId" + facRoomId);
        if (!selectedRoom.has(roomId)) {
            selectedRoom.add(roomId);
            selectedDeassignRooms.push({
                facRoomId: facRoomId,
                roomId: roomId
            });
            $('#deassignBtnDiv').show();
        } else {
            selectedRoom.delete(roomId);
            if (selectedRoom.size < 1) {
                $('#deassignBtnDiv').hide();
            }
        }
    }

    function viewAssignedRooms(facUnitId, facUnitName, buildingname, buildingid) {
        window.location = '#AssignRoomDialog';
        initDialog('assignCellStaffDialog');
        document.getElementById('buildingnames').innerHTML = buildingname;
        document.getElementById('facilityunitname').innerHTML = facUnitName;
//        document.getElementById('buildingnames').value = buildingname;
//        document.getElementById('facilityunitname').value = facUnitName;


        ajaxSubmitData('allocationoffacilityunits/fetchrooms.htm', 'roomsPreview', '&buildingid=' + buildingid + '&facilityunitid=' + facUnitId, 'GET');

    }

    function deassignFacUnit(facUnitId, facUnitName, buildingname, buildingid) {
        window.location = '#unAssignRoomFacilityDialog';
        initDialog('assignCellStaffDialog');
        var i = 1;
        $('#cellsPreview').html('');
        document.getElementById('facilityunitid').value = facUnitId;
        document.getElementById('facilityunitname').value = facUnitName;

        $('#building-selects').html('<option value="' + buildingid + '">' + buildingname + '</option>');
        ajaxSubmitData('allocationoffacilityunits/fetchlocations.htm', 'cellsPreviewed', '&buildingid=' + buildingid + '&facilityunitid=' + facUnitId, 'GET');

        $('#building-selects').change(function () {
            ajaxSubmitData('allocationoffacilityunits/fetchlocations.htm', 'cellsPreviewed', '&buildingid=' + buildingid + '&facilityunitid=' + facUnitId, 'GET');
        });


    }

    function deassignSelectedRooms() {
        console.log(selectedDeassignRooms);
        console.log(JSON.stringify(selectedDeassignRooms));
        var facilityunitid = $('#facilityunitid').val();
        var facilityunitname = $('#facilityunitname').val();

        $.confirm({
            title: '<h3>' + +'</h3>',
            content: '<h4 class="itemTitle">De-Assign ' + selectedDeassignRooms.size + ' room(s) from <strong>' + facilityunitname + '</strong></h4>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Save De-Assign',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityunitid: facilityunitid, rooms: JSON.stringify(Array.from(selectedDeassignRooms))},
                            url: 'allocationoffacilityunits/deAssignLocation.htm',
                            success: function (res) {
                                console.log("my res" + res);
                                if (res === 'success') {
                                    ajaxSubmitData('allocationoffacilityunits/fetchAssignedRooms.htm', 'roomPaneContent', '&a', 'POST');
                                } else if (res === 'refresh') {
                                    document.location.reload(true);
                                }
                            }
                        });
                    }
                },
                close: {
                    text: 'Cancel',
                    btnClass: 'btn-red',
                    action: function () {

                    }
                }
            }
        });

    }
</script>
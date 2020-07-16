<%-- 
    Document   : unassigned
    Created on : Jul 26, 2018, 9:31:43 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-7 col-sm-7">
                <c:forEach items="${unassignedroomlist}" var="buildings">
                    <h4 style="background-color: lightcyan;font-style: italic"><font color="blue">${buildings.buildingname}</font></h4>
                </c:forEach>
            </div>
            <div class="col-md-4 col-sm-4 right" id="assignBtnDiv">
                <button class="btn btn-sm btn-primary icon-btn" onclick="assignservice()">
                    <i class="fa fa-server"></i>
                    Assign Service(s)
                </button>
            </div>
        </div>
        <fieldset>
            <table class="table table-hover table-bordered" id="unassignedservicetable">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Block</th>
                        <th>Floor</th>
                        <th>Room</th>
                        <th>Check</th>
                    </tr>
                </thead>
                <tbody>
                    <% int j = 1;%>
                    <% int x = 1;%>
                    <c:forEach items="${unassignedroomlist}" var="details">
                        <tr>
                            <td><%=x++%></td>
                            <td>${details.blockname}</td>
                            <td>${details.floorname}</td>
                            <td>${details.roomname}</td>
                            <td class="center">
                                <input class="form-check-input" type="checkbox" onclick="assignRoom(${details.blockroomid})">
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </fieldset>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="assignRoomFacilityDialog" class="modalDialog assignCellStaffDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title" id="assignRoomsTitle"></h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-4">
                        <div class="tile" id="searchTile">
                            <div class="tile-body">
                                <div id="search-form_3" class="search-form_3">
                                    <input id="facilityunitSearch" type="text" oninput="searchFacilityUnit()" placeholder="Search service" class="search_3 dropbtn"/>
                                </div><br>
                                <div id="searchResults2" class="scrollbar">

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <h4 class="tile-title">Selected Rooms.</h4>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Building</th>
                                                <th>Block</th>
                                                <th>Floor</th>
                                                <th>Room</th>
                                                <th class="center">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody id="cellPreview">

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#unassignedservicetable').DataTable();
    $(document).ready(function () {
        $('#assignBtnDiv').hide();
    });
    var selectedRooms = new Set();
    function assignRoom(roomId) {
        if (!selectedRooms.has(roomId)) {
            selectedRooms.add(roomId);
            $('#assignBtnDiv').show();
        } else {
            selectedRooms.delete(roomId);
            if (selectedRooms.size < 1) {
                $('#assignBtnDiv').hide();
            }
        }
    }
    function assignservice() {
        window.location = '#assignRoomFacilityDialog';
        initDialog('modalDialog assignCellStaffDialog');
    }
</script>
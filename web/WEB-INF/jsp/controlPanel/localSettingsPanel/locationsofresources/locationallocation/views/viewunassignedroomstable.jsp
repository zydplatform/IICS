<%-- 
    Document   : viewunassignedroomstable
    Created on : Jul 26, 2018, 12:34:29 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<div class="tile">
    <div class="row">
        <div class="col-md-7 col-sm-7">
            <h3 class="tile-title">Unassigned Locations</h3>
        </div>
        <div class="col-md-4 col-sm-4 right" id="assignBtnDiv">
            <button class="btn btn-sm btn-primary icon-btn" onclick="assignSelectedRooms()">
                <i class="fa fa-user-circle"></i>
                Assign To Facility Unit
            </button>
        </div>
    </div>
    <table class="table table-hover table-striped" id="unAssignedRoomTable">
        <thead>
            <tr>
                <th>#</th>
                <th>Block</th>
                <th>Floor</th>
                <th>Room</th>
                <th class="center">Assign</th>
            </tr>
        </thead>
        <tbody>
            <% int m = 1;%>
            <c:forEach items="${locationsList}" var="room">
                <tr>
                    <td><%=m++%></td>
                    <td>${room.blockname}</td>
                    <td>${room.floorname}</td>
                    <td>${room.roomname}</td>
                    <td class="center">
                        <input class="form-check-input" type="checkbox" onclick="assignRoom(${room.blockroomid})">
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
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
                                    <input id="facilityunitSearch" type="text" oninput="searchFacilityUnit()" placeholder="Search Facility Unit" class="search_3 dropbtn"/>
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
<script type="text/javascript">
    $(document).ready(function () {
        allRooms = ${unassignedRoomsJSON};
        $('#assignBtnDiv').hide();
        $('#unAssignedRoomTable').DataTable();
    });

   function remove(rowId) {
            $('#pre' + rowId).remove();
            selectedRooms.delete(rowId);
        }

    function searchFacilityUnit() {
        var input, filter, ul, li, a, i, p;
        input = document.getElementById('facilityunitSearch');
        filter = input.value.toUpperCase();
        ul = document.getElementById("foundItems");
        li = ul.getElementsByTagName('li');

        for (i = 0; i < li.length; i++) {
            a = li[i].getElementsByTagName("h5")[0];
            p = li[i].getElementsByTagName("p")[0];
            if (a.innerHTML.toUpperCase().indexOf(filter) > -1 || p.innerHTML.toUpperCase().indexOf(filter) > -1) {
                li[i].style.display = "";
            } else {
                li[i].style.display = "none";
            }
        }
    }
</script>
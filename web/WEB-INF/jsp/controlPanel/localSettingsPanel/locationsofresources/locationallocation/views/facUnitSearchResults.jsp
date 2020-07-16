<%-- 
    Document   : facUnitSearchResults
    Created on : Jul 26, 2018, 2:33:27 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<ul class="items" id="foundItems">
    <c:forEach items="${unitsList}" var="unit">
        <li id="li${room.blockroomid}" class="classItem border-groove" onclick="selectUnit(${unit.facilityunitid}, '${unit.facilityunitname}')">
            <h5 class="itemTitle">
                ${unit.facilityunitname}
            </h5>
            <p class="itemContent">
                <c:if test="${unit.roomCount == 1}">
                    ${unit.roomCount} Room.
                </c:if>
                <c:if test="${unit.roomCount != 1}">
                    ${unit.roomCount} Rooms.
                </c:if>
            </p>
        </li>
    </c:forEach>
</ul>
<script>
    function selectUnit(facilityunitid, facilityunitname) {
        $.confirm({
            title: '<h3>' + facilityunitname + '</h3>',
            content: '<h4 class="itemTitle">Assign ' + selectedRooms.size + ' room(s) to <strong>' + facilityunitname + '</strong></h4>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Save Allocation',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityunitid: facilityunitid, rooms: JSON.stringify(Array.from(selectedRooms))},
                            url: 'allocationoffacilityunits/saveFacilityUnitAllocations.htm',
                            success: function (res) {
                                console.log("my res"+res);
                                if (res === 'updated') {
                                    ajaxSubmitData('allocationoffacilityunits/fetchUnassignedRooms.htm', 'roomPaneContent', '&a', 'GET');
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

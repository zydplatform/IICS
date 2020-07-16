<%-- 
    Document   : searchUnits
    Created on : Jul 24, 2018, 5:35:35 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<div class="tile">
    <div class="row">
        <div class="col-md-7 col-sm-7">
            <h3 class="tile-title">Facility Unit Location.</h3>
        </div>
        <div class="col-md-4 col-sm-4 right" id="deassignBtnDiv">
            <button class="btn btn-sm btn-primary icon-btn" onclick="deassignSelectedRooms()">
                <i class="fa fa-user-circle"></i>
                De-Assign Facility Unit
            </button>
        </div>
    </div>
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th class="center">#</th>
                <th class="center">Block</th>
                <th class="center">Floor</th>
                <th class="center">Room</th>
                <th class="center">De-Assign</th>
            </tr>
        </thead>
        <tbody id="cellsPreview">
            <% int m = 1;%>
            <c:forEach items="${locationLists}" var="rm">
                <tr id="${rm.facilityunitroomid}">
                    <td><%=m++%></td>
                    <td>${rm.blockname}</td>
                    <td>${rm.floorname}</td>
                    <td>${rm.roomname}</td>
                    <td class="center">
                        <input class="form-check-input" type="checkbox" onclick="deassignRoom(${rm.blockroomid}, ${rm.facilityunitroomid})">
                    </td>
                </tr>
            </c:forEach>

        </tbody>
    </table>
</div>
<script>
    $(document).ready(function () {
        $('#deassignBtnDiv').hide();
    });

</script>


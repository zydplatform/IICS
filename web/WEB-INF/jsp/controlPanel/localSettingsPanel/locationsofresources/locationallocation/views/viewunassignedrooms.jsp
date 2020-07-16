<%-- 
    Document   : viewunassignedrooms
    Created on : Jul 24, 2018, 10:27:20 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<div class="row">
    <div class="col-md-4 col-sm-4">
        <form action="" class="formName">
            <div class="form-group">
                <select class="form-control" id="building-select">
                    <c:forEach items="${BuildingsLists}" var="building">
                        <option value="${building.buildingid}-${building.buildingname}">${building.buildingname}</option>
                    </c:forEach>
                </select>
            </div>
        </form>
    </div>
    <div class="col-md-7 col-sm-7 right">

    </div>
</div>
<div id="unassignedRoomTableData">

</div>
<script type="text/javascript">
    var selectedRooms = new Set();
    var allRooms = [];
    $(document).ready(function () {
        $('#assignBtnDiv').hide();
        $('#unAssignedRoomTable').DataTable();
        $('#building-select').select2();
        $('.select2').css('width', '100%');
        var buildingid_buildingname = document.getElementById('building-select').value;
        var fields = buildingid_buildingname.split('-');
        var buildingid = fields[0];
        var buildingname = fields[1];
        console.log("buildingid" + buildingid);

        ajaxSubmitData('allocationoffacilityunits/fetchUnassigned.htm', 'unassignedRoomTableData', '&buildingid=' + buildingid, 'GET');

        $('#building-select').change(function () {
            $('#unassignedRoomTableData').html('');
            var buildingid_buildingname = document.getElementById('building-select').value;
            var fields = buildingid_buildingname.split('-');
            var buildingid = fields[0];
            var buildingname = fields[1];
            ajaxSubmitData('allocationoffacilityunits/fetchUnassigned.htm', 'unassignedRoomTableData', '&buildingid=' + buildingid, 'GET');
        });
    });

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

    function assignSelectedRooms() {
        var buildingid_buildingname = document.getElementById('building-select').value;
        var fields = buildingid_buildingname.split('-');
        var buildingid = fields[0];
        var buildingname = fields[1];
        if (selectedRooms.size === 1) {
            $('#assignRoomsTitle').html(selectedRooms.size + ' Room Selected.');
        } else {
            $('#assignRoomsTitle').html(selectedRooms.size + ' Rooms Selected.');
        }
        ajaxSubmitData('allocationoffacilityunits/fetchFacilityUnit.htm', 'searchResults2', 'buildingid=' + buildingid, 'GET');
        window.location = '#assignRoomFacilityDialog';
        initDialog('assignCellStaffDialog');
        var div = $('.assignCellStaffDialog > div').height();
        var divHead = $('.assignCellStaffDialog > div > #head').height();
        var searchForm = $('.search-form_3').height();
        $('#searchResults2').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.16) - parseInt(searchForm));
        $(window).resize(function () {
            div = $('.assignCellStaffDialog > div').height();
            divHead = $('.assignCellStaffDialog > div > #head').height();
            searchForm = $('.search-form_3').height();
            $('#searchResults2').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.16) - parseInt(searchForm));
        });
        $('#cellPreview').html('');
        var rooms = Array.from(selectedRooms);
        var buildingid_buildingname = document.getElementById('building-select').value;
        var fields = buildingid_buildingname.split('-');
        var buildingid = fields[0];
        var buildingname = fields[1];
        for (i in rooms) {
            for (j in allRooms) {
                if (allRooms[j].blockroomid === rooms[i]) {
                    $('#cellPreview').append(
                            '<tr id="pre' + allRooms[j].blockroomid + '">' +
                            '<td>' + buildingname + '</td>' +
                            '<td>' + allRooms[j].blockname + '</td>' +
                            '<td>' + allRooms[j].floorname + '</td>' +
                            '<td>' + allRooms[j].roomname + '</td>' +
                            '<td class="center">' +
                            '<span class="badge badge-danger icon-custom" onclick="remove(' + allRooms[j].blockroomid + ')">' +
                            '<i class="fa fa-close"></i></span></td>' +
                            '</tr>'
                            );
                }
            }
        }
    }

</script>

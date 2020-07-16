<%-- 
    Document   : viewallocations
    Created on : Jul 23, 2018, 4:12:24 PM
    Author     : RESEARCH
--%>

<div class="row">
    <div class="col-md-4 col-sm-4">
        
    </div>
    <div class="col-md-7 col-sm-7 right">
        <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
            <div class="btn-group" role="group">
                <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-sliders" aria-hidden="true"></i>
                </button>
                <div class="dropdown-menu dropdown-menu-left">
                    <a class="dropdown-item" href="#!" id="load-assigned-rooms">Assigned</a><hr>
                    <a class="dropdown-item" href="#!" id="load-unassigned-rooms">Unassigned</a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12" id="roomPaneContent">

    </div>
</div>
<script>
    $(document).ready(function () {
        ajaxSubmitData('allocationoffacilityunits/fetchAssignedRooms.htm', 'roomPaneContent', '&a', 'POST');

        $('#load-unassigned-rooms').click(function () {
            $('#roomPaneContent').html('');
            ajaxSubmitData('allocationoffacilityunits/fetchUnassignedRooms.htm', 'roomPaneContent', '&a', 'GET');
        });
        $('#load-assigned-rooms').click(function () {
            $('#roomPaneContent').html('');
            ajaxSubmitData('allocationoffacilityunits/fetchAssignedRooms.htm', 'roomPaneContent', '&a', 'POST');

        });
    });
</script>
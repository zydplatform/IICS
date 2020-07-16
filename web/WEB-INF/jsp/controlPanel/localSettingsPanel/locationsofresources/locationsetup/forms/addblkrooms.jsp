<%-- 
    Document   : addblkrooms
    Created on : May 17, 2018, 10:58:22 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<style>
    .error
    {
        border:2px solid red;
    }
     .myform{
        width: 100% !important;
    }

</style>
<div class="col-md-4">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Enter Building Details</h4>
                <div class="tile-body">
                    <form id="buildingentryform">
                        <div class="form-group">
                            <label class="control-label">Select Building:</label>
                            <select class="form-control myform" id="selectedbuildings">
                                <c:forEach items="${BuildingsListsed}" var="u">
                                    <option value="${u.buildingid}-${u.buildingname}">${u.buildingname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Number Of Rooms</label>
                            <input class="form-control myform" autofocus="autofocus" id="roomnumber" type="number" placeholder="Enter Number Of Blocks">
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureRoom" type="button">
                        <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                        Add Rooms
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="col-md-8">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Entered Room(s).</h4>
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Building</th>
                            <th>Room Name</th>
                            <th>Edit</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody id="enteredRoomsBody">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="saverooms">
                        Finish
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var roomList = new Set();
    var roomObjectList = [];
    document.getElementById('saverooms').disabled = true;

    $('#captureRoom').click(function () {

        var buildingid_buildingname = document.getElementById('selectedbuildings').value;
        var fields = buildingid_buildingname.split('-');
        var buildingname = fields[1];
        var numberofrooms = $('#roomnumber').val();
        var i;
        for (i = 1; i <= numberofrooms; i++) {
            document.getElementById('saverooms').disabled = false;

            $('#enteredRoomsBody').append(
                    '<tr id="rowg' + i + '">' +
                    '<td class="center">' + buildingname + '</td>' +
                    '<td class="center" >Room' + ' ' + i + '</td>' +
                    '<td class="center"><span class="badge id="rmname" oninput="checkroomname()" badge-info icon-custom" onclick="editroomname(\'rowg' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                    '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                    );
            document.getElementById('roomnumber').value = "";
        }

        $('#' + i).parent().remove();
    });

    function remove(i) {
        $('#rowg' + i).remove();
        roomList.delete(i);
    }

    function checkroomname() {
        var roomname = $('#rmname').val();
        var buildingid_buildingname = document.getElementById('selectedbuildings').value;
        var fields = buildingid_buildingname.split('-');
        var buildingid = fields[0];

        if (roomname.length > 0) {
            $.ajax({
                type: 'POST',
                data: {buildingid: buildingid, roomname: roomname},
                url: "locationofresources/checkbuildingroomname.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'existing') {
                        $('#roomname').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: roomname + ' Already Exists',
                        });
                        document.getElementById('captureRoom').disabled = true;
                    } else {
                        $('#roomname').removeClass('error');
                        document.getElementById('captureRoom').disabled = false;
                    }
                }
            });
        }
    }

    function editroomname(id) {
        $.confirm({
            title: 'Change Room Name!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Room Name</label>' +
                    '<input  id="editedRoomname" oninput="checkeditedroomname()" type="text" placeholder="Please Enter Room Name Here" class="myform form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                        var name = this.$content.find('#editedRoomname').val();
                        if (!name) {
                            $('#editedRoomname').addClass('error');
                            $.alert('Please Enter Room Name');
                            return false;
                        }
                        $.alert('New Room Name Is ' + name);

                        var x = document.getElementById('enteredRoomsBody').rows;
                        var y = x[id].cells;
                        y[1].innerHTML = name;
                    }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
    
    function checkroomname() {
        var roomname = $('#rmname').val();
        var buildingid_buildingname = document.getElementById('selectedbuildings').value;
        var fields = buildingid_buildingname.split('-');
        var buildingid = fields[0];

        if (roomname.length > 0) {
            $.ajax({
                type: 'POST',
                data: {buildingid: buildingid, roomname: roomname},
                url: "locationofresources/checkbuildingroomname.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'existing') {
                        $('#roomname').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: roomname + ' Already Exists',
                        });
                        document.getElementById('captureRoom').disabled = true;
                    } else {
                        $('#roomname').removeClass('error');
                        document.getElementById('captureRoom').disabled = false;
                    }
                }
            });
        }
    }
    
    function checkeditedroomname() {
        var roomname = $('#editedRoomname').val();
        var buildingid_buildingname = document.getElementById('selectedbuildings').value;
        var fields = buildingid_buildingname.split('-');
        var buildingid = fields[0];

        if (roomname.length > 0) {
            $.ajax({
                type: 'POST',
                data: {buildingid: buildingid, roomname: roomname},
                url: "locationofresources/checkbuildingroomname.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'existing') {
                        $('#roomname').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: roomname + ' Already Exists',
                        });
                        document.getElementById('captureRoom').disabled = true;
                    } else {
                        $('#roomname').removeClass('error');
                        document.getElementById('captureRoom').disabled = false;
                    }
                }
            });
        }
    }

    //SAVING ROOMS TO A BUILDING
    $('#saverooms').click(function () {

        var tablebody = document.getElementById("enteredRoomsBody");
        var x = document.getElementById("enteredRoomsBody").rows.length;
        for (var i = 0; i < x; i++) {
            var row = tablebody.rows[i];
            var ids = row.id;
            var tableData = $('#' + ids).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();
            roomObjectList.push({
                rowid: i,
                roomnames: tableData[1],
            });
            
        }
        if (roomObjectList.length > 0) {
            var buildingid_buildingname = document.getElementById('selectedbuildings').value;
            var fields = buildingid_buildingname.split('-');
            var buildingid = fields[0];
            var data = {
                rooms: JSON.stringify(roomObjectList),
                buildingid: buildingid,
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'locationofresources/savenewroom.htm',
                success: function (res) {
                    if (res === 'Saved') {
                        $('#enteredRoomsBody').html('');
                        document.getElementById('roomnumber').value = "";
                        roomObjectList = [];

                    }
                }
            });
        }

    });
</script>
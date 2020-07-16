<%-- 
    Document   : roomtofloor
    Created on : Jun 22, 2018, 11:39:12 AM
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
                <h4 class="tile-title">Enter Room Details</h4>
                <div class="tile-body">
                    <form id="buildingentryform">
                        <input class="form-control myform" id="blockname" type="hidden" value="${blockname}" readonly="true">
                        <input class="form-control myform" id="blockid" type="hidden" value="${facilityblockid}">
                        <div class="form-group">
                            <label class="control-label">Select Floor:</label>
                            <select class="form-control myform" id="selectedfloors">
                                <c:forEach items="${BlockFloorList}" var="r">
                                    <option value="${r.blockfloorid}-${r.floorname}">${r.floorname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Number Of Rooms</label>
                            <input class="form-control myform" id="roomnumbers" type="number" placeholder="Enter Number Of Rooms">
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureRoomz" type="button">
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
                            <th>Floor</th>
                            <th>Room Name</th>
                            <th>Edit</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody id="enteredRoomsBodyed">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="saveroomz">
                        Finish & Save Room(s)
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var roomList = new Set();
    var roomList = [];
    var roomObjectLists = [];
    var roomSet = new Set();
    document.getElementById('saveroomz').disabled = true;
    $(document).ready(function () {
        var floorid_floorname = document.getElementById('selectedfloors').value;
        var fields = floorid_floorname.split('-');
        var floorid = fields[0];
        var floorname = fields[1];
        var facilityblockid = $('#blockid').val();
        var blockname = $('#blockname').val();

        console.log("facilityblockid" + facilityblockid);
        console.log("blockname" + blockname);

        $.ajax({
            type: 'GET',
            data: {blockfloorid: floorid, floorname: floorname, facilityblockid: facilityblockid, blockname: blockname},
            url: "locationofresources/checkfloorroomname.htm",
            success: function (results) {
                roomsLists = JSON.parse(results);
                console.log(roomsLists);
                for (var index in roomsLists) {
                    var data = roomsLists[index].toString().toUpperCase();
                    console.log(data);
                    if (!roomSet.has(data)) {
                        roomSet.add(data);
                    }
                }
            }

        });

        $('#captureRoomz').click(function () {

            var floorid_floorname = document.getElementById('selectedfloors').value;
            var fields = floorid_floorname.split('-');
            var floorid = fields[0];
            var floorname = fields[1];
            var numberofrooms = $('#roomnumbers').val();
            var i;
            $.ajax({
                type: 'GET',
                data: {blockfloorid: floorid, floorname: floorname, facilityblockid: facilityblockid, blockname: blockname},
                url: "locationofresources/checkfloorroomname.htm",
                success: function (results) {
                    console.log(results);
                    roomList = JSON.parse(results);
                    var set = new Set(roomList);
                    var j = 1;
                    $('#enteredRoomsBodyed').html('');
                    for (i = 1; i <= numberofrooms; i++) {
                        var roomNameUpper = ('ROOM' + ' ' + i);
                        if (set.has(roomNameUpper)) {
                            for (i = Number(numberofrooms) + Number(j); i <= Number(numberofrooms) + Number(numberofrooms); i++) {
                                document.getElementById('saveroomz').disabled = false;

                                $('#enteredRoomsBodyed').append(
                                        '<tr id="rowrm' + i + '">' +
                                        '<td class="center">' + floorname + '</td>' +
                                        '<td class="center" >ROOM' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editroomname(\'rowrm' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('roomnumbers').value = "";
                            }
                        } else {
                            $('#enteredRoomsBodyed').html('');
                            for (i = 1; i <= numberofrooms; i++) {
                                document.getElementById('saveroomz').disabled = false;

                                $('#enteredRoomsBodyed').append(
                                        '<tr id="rowggg' + i + '">' +
                                        '<td class="center">' + floorname + '</td>' +
                                        '<td class="center" >ROOM' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom" onclick="editroomname(\'rowggg' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('roomnumbers').value = "";
                            }

                        }
                    }

                }

            });

            $('#' + i).parent().remove();
        });
    });
    function remove(i) {
        $('#rowggg' + i).remove();
        roomList.delete(i);
    }

    function editroomname(id) {
        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        $.confirm({
            title: 'Change Room Name!',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            theme: 'modern',
            icon: 'fa fa-question-circle',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Room Name</label><br>' +
                    '<span id="errormessage" style="color: red"><strong><strong></span>' +
                    '<input  id="editedRoomname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Room Name Here" class="name form-control myform" oninput="checkroomname();" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                        var name = this.$content.find('.name').val().toUpperCase();
                        ;
                        if (!name) {
                            $('#editedRoomname').addClass('error');
                            $.alert('Please Enter Room Name');
                            return false;
                        }
                        $.alert('New Room Name Is ' + name);

                        var x = document.getElementById('enteredRoomsBodyed').rows;
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
        var roomname = $('#editedRoomname').val().toUpperCase();

        if (roomSet.has(roomname)) {
            $('#editedRoomname').addClass('error');
            $.alert('Room Name' + ' ' + '<strong>' + roomname + '</strong>' + ' ' + 'Already Exists');
        } else {
            $('#editedRoomname').removeClass('error');
        }

    }

    //SAVING ROOMS TO A BUILDING
    $('#saveroomz').click(function () {

        var tablebodys = document.getElementById("enteredRoomsBodyed");
        var t = document.getElementById("enteredRoomsBodyed").rows.length;
        for (var i = 0; i < t; i++) {
            var rowed = tablebodys.rows[i];
            var ided = rowed.id;
            var tableData = $('#' + ided).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();
            console.log("naaaaaaammmmmeeeeeeeee" + tableData[1]);
            roomObjectLists.push({
                rowid: i,
                roomnamed: tableData[1],
            });
        }
        if (roomObjectLists.length > 0) {
            var floorid_floorname = document.getElementById('selectedfloors').value;
            var fields = floorid_floorname.split('-');
            var blockfloorid = fields[0];
            var data = {
                roomz: JSON.stringify(roomObjectLists),
                blockfloorid: blockfloorid
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'locationofresources/saveroomTofloor.htm',
                success: function (res) {
                    $('#enteredRoomsBodyed').html('');
                    document.getElementById('roomnumbers').value = "";
                    roomObjectLists = [];

                    if (res === 'Saved') {
                        document.getElementById('roomnumbers').value = "";
                        $.toast({
                            heading: 'Success',
                            text: 'Building Added Successfully.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('locationofresources/managebuilding.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        window.location = '#close';
                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'An unexpected error occured.',
                            icon: 'error'
                        });
                        ajaxSubmitData('locationofresources/managebuilding.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        window.location = '#close';
                    }

                }

            });
        }

    });
</script>


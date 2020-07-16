<%-- 
    Document   : addnewroom
    Created on : Jul 19, 2018, 3:56:51 PM
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
                        <div class="form-group">
                            <label class="control-label">Select Floor:</label>
                            <select class="form-control myform" id="selectedfloor">
                                <c:forEach items="${BlockFloorLists}" var="r">
                                    <option value="${r.blockfloorid}-${r.floorname}">${r.floorname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Number Of Rooms</label>
                            <input class="form-control myform" id="otherroomnumber" type="number" placeholder="Enter Number Of Rooms">
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureOtherRoom" type="button">
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
                            <th>Room Name</th>
                            <th>Edit</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody id="enteredOtherRoomsBody">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="saveotherrooms">
                        Finish & Save Room
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var roomList = new Set();
    var roomsLists = [];
    var roomObjectList = [];
    var roomSet = new Set();
    document.getElementById('saveotherrooms').disabled = true;
    $(document).ready(function () {
        var floorid_floorname = document.getElementById('selectedfloor').value;
        var fields = floorid_floorname.split('-');
        var floorid = fields[0];
        var floorname = fields[1];

//        $.ajax({
//            type: 'GET',
//            data: {blockfloorid: floorid, floorname: floorname},
//            url: "locationofresources/checkfloorroomname.htm",
//            success: function (results) {
//                roomsLists = JSON.parse(results);
//                console.log(roomsLists);
//                for (var index in roomsLists) {
//                    var data = roomsLists[index].toString().toUpperCase();
//                    console.log(data);
//                    if (!roomSet.has(data)) {
//                        roomSet.add(data);
//                    }
//                }
//            }
//
//        });
        $('#captureOtherRoom').click(function () {
            var numberofotherrooms = $('#otherroomnumber').val();
            var floorid_floorname = document.getElementById('selectedfloor').value;
            var fields = floorid_floorname.split('-');
            var floorid = fields[0];
            var floorname = fields[1];
            var i;

            $('#enteredOtherRoomsBody').html('');
            for (i = 1; i <= numberofotherrooms; i++) {
                document.getElementById('saveotherrooms').disabled = false;
                $('#enteredOtherRoomsBody').append(
                        '<tr id="rowrm' + i + '">' +
                        '<td class="center" >ROOM' + ' ' + i + '</td>' +
                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editthermname(\'rowrm' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                        );
                document.getElementById('otherroomnumber').value = "";
            }
//            $.ajax({
//                type: 'GET',
//                data: {blockfloorid: floorid, floorname: floorname, facilityblockid: facilityblockid, blockname: blockname},
//                url: "locationofresources/checkfloorroomname.htm",
//                success: function (results) {
//                    console.log(results);
//                    roomsLists = JSON.parse(results);
//                    var set = new Set(roomsLists);
//                    var j = 1;
//                    $('#enteredOtherRoomsBody').html('');
//                    for (i = 1; i <= numberofotherrooms; i++) {
//                        var roomNameUpper = ('ROOM' + ' ' + i);
//                        if (set.has(roomNameUpper)) {
//                            for (i = Number(numberofotherrooms) + Number(j); i <= Number(numberofotherrooms) + Number(numberofotherrooms); i++) {
//                                document.getElementById('saveotherrooms').disabled = false;
//                                $('#enteredOtherRoomsBody').append(
//                                        '<tr id="rowrm' + i + '">' +
//                                        '<td class="center">' + floorname + '</td>' +
//                                        '<td class="center" >ROOM' + ' ' + i + '</td>' +
//                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editthermname(\'rowrm' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
//                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
//                                        );
//                                document.getElementById('otherroomnumber').value = "";
//                            }
//                        } else {
//                            $('#enteredOtherRoomsBody').html('');
//                            for (i = 1; i <= numberofotherrooms; i++) {
//                                document.getElementById('saveotherrooms').disabled = false;
//                                $('#enteredOtherRoomsBody').append(
//                                        '<tr id="rowrm' + i + '">' +
//                                        '<td class="center">' + floorname + '</td>' +
//                                        '<td class="center" >ROOM' + ' ' + i + '</td>' +
//                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editthermname(\'rowrm' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
//                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
//                                        );
//                                document.getElementById('otherroomnumber').value = "";
//                            }
//                        }
//                    }
//
//                }
//
//            });
        });
    });

    function remove(i) {
        $('#row' + i).remove();
        otherroomList.delete(i);
    }

    function editthermname(id) {
        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        $.confirm({
            title: 'Change Room Name!',
            boxWidth: '40%',
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
                    '<input  id="editedotherrmname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Room Name Here" class="myform form-control" oninput="checkroomname(this.id);" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                        var name = this.$content.find('#editedotherrmname').val().toUpperCase();
                        ;
                        if (!name) {
                            $('#editedotherrmname').addClass('error');
                            $.alert('Please Enter Room Name');
                            return false;
                        }

                        var x = document.getElementById('enteredOtherRoomsBody').rows;
                        var y = x[id].cells;
                        y[1].innerHTML = name;

                        $.alert('New Room Name Is ' + name);

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


    function checkroomname(id) {
        var roomname = $('#editedotherrmname').val().toUpperCase();

        if (roomSet.has(roomname)) {
            $('#editedotherrmname').addClass('error');
            $.alert('Room Name' + ' ' + '<strong>' + roomname + '</strong>' + ' ' + 'Already Exists');
        } else {
            $('#editedotherrmname').removeClass('error');
        }
    }

    //SAVING ROOMS TO A BLOCK
    $('#saveotherrooms').click(function () {
        var tablebody = document.getElementById("enteredOtherRoomsBody");
        var y = document.getElementById("enteredOtherRoomsBody").rows.length;
        for (var i = 0; i < y; i++) {
            var row = tablebody.rows[i];
            var ids = row.id;
            var tableData = $('#' + ids).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();
            roomObjectList.push({
                rowid: i,
                roomnamed: tableData[1],
            });
        }

        if (roomObjectList.length > 0) {
            var floorid_floorname = document.getElementById('selectedfloor').value;
            var fields = floorid_floorname.split('-');
            var floorid = fields[0];
            var floorname = fields[1];
            var data = {
                rooms: JSON.stringify(roomObjectList),
                floorid: floorid
            };
            $.ajax({
                type: 'POST',
                data: data,
                url: 'locationofresources/addroom.htm',
                success: function (res) {
                    console.log("results is stunta" + res);
                    if (res === 'Saved') {
                        document.getElementById('otherroomnumber').value = "";
                        $('#enteredOtherRoomsBody').html('');
                        roomObjectList = [];
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


        } else {

        }

    });
</script>

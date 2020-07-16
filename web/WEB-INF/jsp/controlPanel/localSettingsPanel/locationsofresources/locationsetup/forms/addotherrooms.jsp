<%-- 
    Document   : addblkrooms
    Created on : May 17, 2018, 10:58:22 AM
    Author     : RESEARCH
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                            <label class="control-label">Building</label>
                            <input class="form-control myform" id="buildingname" type="text" value="${buildingname}" readonly="true">
                            <input class="form-control myform" id="buildingid" type="hidden" value="${buildingid}">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Select Block</label>
                            <select class="form-control floor_search myform" id="selectBlockx" onchange="floorsInBlock()">
                                <c:forEach items="${BlockList}" var="blocks">
                                    <option class="textbolder" value="${blocks.facilityblockid}-${blocks.blockname}">${blocks.blockname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Select Floor</label>
                            <select class="form-control floor_search myform" id="selectFloorx">

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
                            <th>Floor</th>
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
    var roomSet = new Set();
    var roomsLists = [];
    var roomObjectList = [];
    document.getElementById('saveotherrooms').disabled = true;
    function floorsInBlock() {
        var facilityblockid_blockname = document.getElementById('selectBlockx').value;
        var fields = facilityblockid_blockname.split('-');
        var facilityblockid = fields[0];
        var blockname = fields[1];
        var buildingid = $('#buildingid').val();
        var buildingname = $('#buildingname').val();
        console.log("--------------facilityblockid1111" + facilityblockid);

        $.ajax({
            type: 'GET',
            data: {facilityblockid: facilityblockid},
            url: "locationofresources/floorsInBlock.htm",
            success: function (results) {
                var res = JSON.parse(results);
                console.log("-----------------response----------------------" + results);
                if (res !== '' && res.length > 0) {
                    for (i in res) {
                        $('#selectFloorx').html('');
                        $('#selectFloorx').append('<option class="classpost" id="' + res[i].blockfloorid + '" value="' + res[i].blockfloorid + '" data-floorname="' + res[i].floorname + ' ">' + res[i].floorname + '</option>');
                    }
                } else {
                }

            }

        });
    }
    $(document).ready(function () {
        var floorid = $('#floorid').val();
        var floorname = $('#floorname').val();
        var facilityblockid = $('#blockid').val();
        var blockname = $('#blockname').val();

//        $.ajax({
//            type: 'GET',
//            data: {blockfloorid: floorid, floorname: floorname, facilityblockid: facilityblockid, blockname: blockname},
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
//
//            }
//
//        });

        $('#captureOtherRoom').click(function () {
            var numberofotherrooms = $('#otherroomnumber').val();
            var blockfloor = document.getElementById('selectFloorx').value;
            var floorid = parseInt($('#selectFloorx').val());
            var floorname = $("#" + blockfloor).data("floorname");

            var facilityblockid_blockname = document.getElementById('selectBlockx').value;
            var fields = facilityblockid_blockname.split('-');
            var facilityblockid = fields[0];
            var blockname = fields[1];
            var i;
            $.ajax({
                type: 'GET',
                data: {blockfloorid: floorid, floorname: floorname, facilityblockid: facilityblockid, blockname: blockname},
                url: "locationofresources/checkfloorroomname.htm",
                success: function (results) {
                    console.log(results);
                    roomsLists = JSON.parse(results);
                    var set = new Set(roomsLists);
                    var j = 1;
                    $('#enteredOtherRoomsBody').html('');
                    for (i = 1; i <= numberofotherrooms; i++) {
                        var roomNameUpper = ('ROOM' + ' ' + i);
                        if (set.has(roomNameUpper)) {
                            for (i = Number(numberofotherrooms) + Number(j); i <= Number(numberofotherrooms) + Number(numberofotherrooms); i++) {
                                document.getElementById('saveotherrooms').disabled = false;
                                $('#enteredOtherRoomsBody').append(
                                        '<tr id="rowrm' + i + '">' +
                                        '<td class="center">' + floorname + '</td>' +
                                        '<td class="center" >ROOM' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editthermname(\'rowrm' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('otherroomnumber').value = "";
                            }
                        } else {
                            $('#enteredOtherRoomsBody').html('');
                            for (i = 1; i <= numberofotherrooms; i++) {
                                document.getElementById('saveotherrooms').disabled = false;
                                $('#enteredOtherRoomsBody').append(
                                        '<tr id="rowrm' + i + '">' +
                                        '<td class="center">' + floorname + '</td>' +
                                        '<td class="center" >ROOM' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editthermname(\'rowrm' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('otherroomnumber').value = "";
                            }
                        }
                    }

                }

            });
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
                    '<label>Enter Room Name</label>' +
                    '<span id="errormessage" style="color: red"><strong><strong></span>' +
                    '<input  id="editedotherrmname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Room Name Here" class="myform form-control" oninput="checkroomname();" required />' +
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


    function checkroomname() {
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
        var blockfloor = document.getElementById('selectFloorx').value;
        var blockfloorid = parseInt($('#selectFloorx').val());
        var floorname = $("#" + blockfloor).data("floorname");

        var facilityblockid_blockname = document.getElementById('selectBlockx').value;
        var fields = facilityblockid_blockname.split('-');
        var facilityblockid = fields[0];
        var blockname = fields[1];

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

            $.ajax({
                type: 'POST',
                data: {blockfloorid: blockfloorid, roomname: JSON.stringify(roomObjectList)},
                url: "locationofresources/checkroomname.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'existing') {
                        $.alert({
                            title: 'Alert!',
                            content: tablebody + ' Already Exists Please Edit Room Name',
                        });
                        document.getElementById('saveotherrooms').disabled = true;
                    } else {
                        var blockfloor = document.getElementById('selectFloorx').value;
                        var floorid = parseInt($('#selectFloorx').val());
                        var floorname = $("#" + blockfloor).data("floorname");
                        var data = {
                            rooms: JSON.stringify(roomObjectList),
                            floorid: floorid
                        };
                        $.ajax({
                            type: 'POST',
                            data: data,
                            url: 'locationofresources/addroom.htm',
                            success: function (res) {
                                if (res !== '') {
                                    document.getElementById('otherroomnumber').value = "";
                                    $('#enteredOtherRoomsBody').html('');
                                    roomObjectList = [];
                                    $.toast({
                                        heading: 'Success',
                                        text: 'Floor Successfully Added.',
                                        icon: 'success',
                                        hideAfter: 2000,
                                        position: 'bottom-center'
                                    });
                                    ajaxSubmitData('locationofresources/managebuilding.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    window.location = '#close';
                                } else {
                                    $.toast({
                                        heading: 'Error',
                                        text: 'An unexpected error occured while trying to add Floors.',
                                        icon: 'error'
                                    });
                                    window.location = '#close';
                                }
                            }
                        });
                        document.getElementById('saveotherrooms').disabled = false;
                    }
                }
            });

        } else {

        }

    });
</script>
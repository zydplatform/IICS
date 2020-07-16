<%-- 
    Document   : manageroominfloor
    Created on : Aug 27, 2019, 12:13:16 PM
    Author     : USER 1
--%>

<%@include file= "../../../../include.jsp" %>

<style>
    .error
    {
        border:2px solid red;
    }
    .myform{
        width: 100% !important;
    }

</style>
<div class="col-md-6">

    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <form id="buildingentryform">
                        <input class="form-control myform" id="floorid" type="hidden" value="${BuildingList.buildingname}" readonly="true">
                        <input class="form-control myform" id="floorname" type="hidden" value="${BuildingList.buildingid}">
                        <div class="form-group">
                            <label class="control-label">Select Floor:</label>

                            <select class="form-control myform" id="selectedfloors">
                                <c:forEach items="${floorlists}" var="r">               
                                    <option value="${r.floorid}">${r.floorname}</option>         
                                </c:forEach>            
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Number Of Rooms</label>
                            <input class="form-control myform" id="roomnumbers" type="number" placeholder="Enter Number Of Rooms" oninput="showroomlabelz();">
                        </div>
                    </form>
                    <div class="tile">
                        <p class="tile-title">Room labels for <span id = "roomlabelz"></span>  </p>
                        <div id ="roomformz" style="overflow: auto; max-height: 100px">


                        </div>
                    </div>
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
<div class="col-md-6">
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
         document.getElementById('captureRoomz').disabled = true;
        $('#roomlabelz').html($('#selectedfloors option:selected').html());
        var floorid_floorname = document.getElementById('selectedfloors').value;
        var fields = floorid_floorname.split('-');
        var floorname = fields[1];
        var floorid = $('#floorid').val();
        var floorname = $('#floorname').val();

        console.log("floorid" + floorid);
        console.log("floorname" + floorname);

        $.ajax({
            type: 'GET',
            data: {floorid: floorid, floorname: floorname},
            url: "facilityinfrastructure/checkfloorroomname.htm",
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

            var floorid = fields[0];
            var floorname = $('#selectedfloors option:selected').html();
            ;
            var numberofrooms = $('#roomnumbers').val();
            var i;
            $.ajax({
                type: 'GET',
                data: {floorid: floorid, floorname: floorname},
                url: "facilityinfrastructure/checkfloorroomname.htm",
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
                            $.alert('<b>You can save default room names eg(room 1, room 2 etc) or edit default names before saving.</b>');
                        } else {
                            $('#enteredRoomsBodyed').html('');
                            for (i = 1; i <= numberofrooms; i++) {
                                var roomformlabelz = $('#roomformlabelz' + i).val();
                                var roomsentensecase = roomformlabelz.charAt(0).toUpperCase() + roomformlabelz.substr(1).toLowerCase();
                                document.getElementById('saveroomz').disabled = false;

                                $('#enteredRoomsBodyed').append(
                                        '<tr id="rowggg' + i + '">' +
                                        '<td class="center">' + floorname + '</td>' +
                                        '<td class="center" >' + roomsentensecase + '</td>' +
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
                    '<span id= "errorxx">' +
                    '</span>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {

                        var name = this.$content.find('.name').val();
                        var namecase = name.charAt(0).toUpperCase() + name.substr(1).toLowerCase();
                        if (namecase.trim().length === 0 || namecase === undefined) {
                            $('#errorxx').html('<span style="color:red">*Field Required.*</span>');
                            $('#editedRoomname').focus();
                            return false;
                        } else {
                            if (!namecase) {
                                $('#editedRoomname').addClass('error');
                                $.alert('Please Enter Room Name');
                                return false;
                            }
                        }
                        $.alert('New Room Name Is ' + namecase);

                        var x = document.getElementById('enteredRoomsBodyed').rows;
                        var y = x[id].cells;
                        y[1].innerHTML = namecase;
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
    function checkregex(obj) {
        var roomlabel = $(obj).val();
        var regex = /^[a-zA-Z0-9_-\s]*$/;
        var testname = regex.test(roomlabel);
        if (testname !== true) {
            $.confirm({
                title: 'Info',
                content: 'Room name format not allowed',
                boxWidth: '35%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                closeIcon: true,
                theme: 'modern',
                buttons: {
                    OK: {
                        text: 'Ok',
                        btnClass: 'btn-purple',
                        keys: ['enter', 'shift'],e
                        action: function () {
                            $(obj).val('');
                        }
                    }
                }
            });
            $(obj).addClass('error');
            document.getElementById('captureRoomz').disabled = true;
        } else if (roomlabel.trim().length === 0 || roomlabel === undefined) {
            $('#errors').html('<span style="color:red">*Field Required.*</span>');
            $(obj).focus();
            return false;
        } else {
             document.getElementById('captureRoomz').disabled = false;
            $(obj).removeClass('error');
            return true;
        }
    }

    function checkroomname() {
        var roomname = $('#editedRoomname').val();
        var roomchangecase = roomname.charAt(0).toUpperCase() + roomname.substr(1).toLowerCase();
        var regexx = /^[a-zA-Z0-9_-\s]*$/;
        var testname = regexx.test(roomchangecase);
        if (testname !== true) {
            $.confirm({
                title: 'Info',
                content: 'room name format not allowed',
                boxWidth: '35%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                closeIcon: true,
                theme: 'modern',
                buttons: {
                    OK: {
                        text: 'Ok',
                        btnClass: 'btn-purple',
                        keys: ['enter', 'shift'],
                        action: function () {
                            $('#editedRoomname').val('');
                        }
                    }
                }
            });
            $('#editedRoomname').addClass('error');
        } else {
            if (roomSet.has(roomchangecase)) {
                $('#editedRoomname').addClass('error');
                $.alert('Room Name' + ' ' + '<strong>' + roomchangecase + '</strong>' + ' ' + 'Already Exists');
            } else {
                $('#editedRoomname').removeClass('error');
            }

        }
    }
    function showroomlabelz() {
        alert("what is failing ?");
        debugger
        var floorname = $('#selectedfloors option:selected').html();
        var i;
        var numberofrooms = $('#roomnumbers').val();
        $('#roomformz').html('');
        if (numberofrooms > 20) {
            $.confirm({
                title: 'Info',
                content: 'Maximum room number is 20',
                boxWidth: '35%',
                useBootstrap: false,
                type: 'purple',
                typeAnimated: true,
                closeIcon: true,
                theme: 'modern',
                buttons: {
                    OK: {
                        text: 'Ok',
                        btnClass: 'btn-purple',
                        keys: ['enter', 'shift'],
                        action: function () {

                        }
                    }
                }
            });
        } else {
            for (i = 1; i <= numberofrooms; i++) {
                $('#roomformz').append(
                        '<form action="" class="formName" "frm' + i + '">' +
                        '<div class="form-group">' +
                        '<label>Room label ' + i + ' for ' + floorname + '</label><br>' +
                        '<span id="errormessage" style="color: red"><strong><strong></span>' +
                        '<input  id="roomformlabelz' + i + '" type="text" placeholder="Please Enter Room Name Here" class="name form-control myform" oninput="checkregex(this);" required />' +
                        '</div>' +
                        '</form>'
                      );

            }
            
        }

    }
    //SAVING ROOMS 
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
                roomnamed: tableData[1]
            });
        }
        console.log(JSON.stringify(roomObjectLists));
        if (roomObjectLists.length > 0) {

            var floorid = document.getElementById('selectedfloors').value;
            var data = {
                roomz: JSON.stringify(roomObjectLists),
                floorid: floorid
            };
            $.ajax({
                type: 'POST',
                data: data,
                cache: false,
                url: 'facilityinfrastructure/saveroomTofloor.htm',
                success: function (res) {
                    console.log(res);
                    var messages = JSON.parse(res);
                    if (messages.length !== 0) {
                        var display = '';
                        for (var message in messages) {
                            display += messages[message] + '<br/>';
                        }

                        $.confirm({
                            title: 'Info',
                            content: display,
                            boxWidth: '35%',
                            useBootstrap: false,
                            type: 'purple',
                            typeAnimated: true,
                            closeIcon: true,
                            theme: 'modern',
                            buttons: {
                                OK: {
                                    text: 'Ok',
                                    btnClass: 'btn-purple',
                                    keys: ['enter', 'shift'],
                                    action: function () {
                                        ajaxSubmitData('facilityinfrastructure/manageinfrastructure.htm', 'workpane', '', 'GET');
                                    }
                                }
                            }
                        });//                                        
                    } else {
                        document.getElementById('roomnumbers').value = "";
                        $.toast({
                            heading: 'Success',
                            text: 'Rooms Added Successfully.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'top-center'
                        });
                        ajaxSubmitData('facilityinfrastructure/manageinfrastructure.htm', 'workpane', '', 'GET');
                        window.location = '#close';
                    }
                }



            });
        }

    });
    $('#selectedfloors').change(function () {
        $('#roomlabelz').html($('#selectedfloors option:selected').html());
    });
</script>
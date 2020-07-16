<%-- 
    Document   : roomtoblock
    Created on : May 22, 2018, 10:28:27 AM
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
                <h4 class="tile-title"></h4>
                <div class="tile-body">
                    <form id="buildingentryform">
                        <div class="form-group">
                            <label class="control-label">Building</label>
                            <input class="form-control myform" id="buildingid" type="hidden" value="${buildingid}" readonly="true">
                            <input class="form-control myform" id="buildingname" type="text" value="${buildingname}" readonly="true">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Select Block</label>
                            <select class="form-control floor_search myform" id="selectBlocked">
                                <c:forEach items="${BlockLists}" var="blocks">
                                    <option class="textbolder" value="${blocks.facilityblockid}-${blocks.blockname}">${blocks.blockname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Number Of Floors</label>
                            <input class="form-control myform" id="floornumber" type="number" placeholder="Enter Number Of Floors">
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="capturetheFloor" type="button">
                        <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                        Add Floors
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
                <h4 class="tile-title">Entered Floor(s).</h4>
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Block</th>
                            <th>Floor Name</th>
                            <th>Edit</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody id="enteredTheFloorsBody">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="savethefloors">
                        Finish
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var floorList = new Set();
    var floorSet = new Set();
    var floorLists = [];
    var floorObjectLists = [];
    document.getElementById('savethefloors').disabled = true;
    $(document).ready(function () {
        var buildingid = $('#buildingid').val();
        var buildingname = $('#buildingname').val();
//
//        $.ajax({
//            type: 'GET',
//            data: {tablerowid: facilityblockid, tableData: blockname, a: buildingid, b: buildingname},
//            url: "locationofresources/checkblockfloorname.htm",
//            success: function (results) {
//                floorList = JSON.parse(results);
//                console.log(floorList);
//                for (var index in floorList) {
//                    var data = floorList[index].toString().toUpperCase();
//                    console.log(data);
//                    if (!floorSet.has(data)) {
//                        floorSet.add(data);
//                    }
//                }
//
//            }
//
//        });

        $('#capturetheFloor').click(function () {
            var numberoffloors = $('#floornumber').val();
            var facilityblockid_blockname = document.getElementById('selectBlocked').value;
            var fields = facilityblockid_blockname.split('-');
            var facilityblockid = fields[0];
            var blockname = fields[1];
            var i;
            $.ajax({
                type: 'GET',
                data: {tablerowid: facilityblockid, tableData: blockname, a: buildingid, b: buildingname},
                url: "locationofresources/checkblockfloorname.htm",
                success: function (results) {
                    console.log(results);
                    floorLists = JSON.parse(results);
                    var set = new Set(floorLists);
                    var j = 1;
                    $('#enteredTheFloorsBody').html('');
                    for (i = 1; i <= numberoffloors; i++) {
                        var floorNameUpper = ('FLOOR' + ' ' + i);
                        if (set.has(floorNameUpper)) {
                            for (i = Number(numberoffloors) + Number(j); i <= Number(numberoffloors) + Number(numberoffloors); i++) {
                                document.getElementById('savethefloors').disabled = false;
                                $('#enteredTheFloorsBody').append(
                                        '<tr id="rowrm' + i + '">' +
                                        '<td class="center">' + blockname + '</td>' +
                                        '<td class="center" >Floor' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editthermname(\'rowrm' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('floornumber').value = "";
                            }
                        } else {
                            $('#enteredTheFloorsBody').html('');
                            for (i = 1; i <= numberoffloors; i++) {
                                document.getElementById('savethefloors').disabled = false;

                                $('#enteredTheFloorsBody').append(
                                        '<tr id="rowf' + i + '">' +
                                        '<td class="center">' + blockname + '</td>' +
                                        '<td class="center" >FLOOR' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editthermname(\'rowf' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('floornumber').value = "";
                            }
                        }
                    }

                }

            });

            $('#' + i).parent().remove();

        });

    });

    function remove(i) {
        $('#rowf' + i).remove();
        floorList.delete(i);
    }

    function editthermname(id) {

        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');

        $.confirm({
            title: 'Change Floor Name!',
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
                    '<label>Enter Floor Name</label><br>' +
                    '<span id="errormessage" style="color: red"><strong><strong></span>' +
                    '<input  id="editedthefloorname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Floor Name Here" class="name form-control myform" oninput="checkfloorname();" required />' +
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
                            $('#editedthefloorname').addClass('error');
                            $.alert('Please Enter Floor Name');
                            return false;
                        }

                        var x = document.getElementById('enteredTheFloorsBody').rows;
                        var y = x[id].cells;
                        y[1].innerHTML = name;

                        $.alert('New Floor Name Is ' + name);
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

    function checkfloorname() {
        var floorname = $('#editedthefloorname').val().toUpperCase();

        if (floorSet.has(floorname)) {
            $('#editedthefloorname').addClass('error');
            $.alert('Floor Name' + ' ' + '<strong>' + floorname + '</strong>' + ' ' + 'Already Exists');
        } else {
            $('#editedthefloorname').removeClass('error');
        }
    }

    //SAVING FLOORS TO A BLOCK
    $('#savethefloors').click(function () {
        var facilityblockid_blockname = document.getElementById('selectBlocked').value;
        var fields = facilityblockid_blockname.split('-');
        var facilityblockid = fields[0];
        var blockname = fields[1];

        $.confirm({
            title: 'Message!',
            content: 'Would You Like To Add Room(s) To A Floor?',
            type: 'blue',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                       
                        var tablebody = document.getElementById("enteredTheFloorsBody");
                        var f = document.getElementById("enteredTheFloorsBody").rows.length;
                        for (var i = 0; i < f; i++) {
                            var rowed = tablebody.rows[i];
                            var ided = rowed.id;
                            var tableData = $('#' + ided).closest('tr')
                                    .find('td')
                                    .map(function () {
                                        return $(this).text();
                                    }).get();
                            floorObjectLists.push({
                                rowid: i,
                                floornamed: tableData[1]
                            });
                        }
                        if (floorObjectLists.length > 0) {
                            $.ajax({
                                type: 'POST',
                                data: {floorz: JSON.stringify(floorObjectLists), facilityblockid: facilityblockid},
                                url: 'locationofresources/savefloorToblock.htm',
                                success: function (res) {
                                    $('#divSection89').hide();
                                    $('#divSection90').show();
                                    console.log(res);
                                    if (JSON.parse(res).length !== 0) {
                                        console.log("res2" + res);
                                        $('#enteredFloorsBodyed').html('');
                                        document.getElementById('floornumber').value = "";
                                        floorObjectLists = [];
                                        ajaxSubmitData('locationofresources/addroomtofloor.htm', 'roomcontent', 'res=' + res + '&facilityblockid=' + facilityblockid + '&blockname=' + blockname + '&d=0&ofst=1&maxR=100&sStr=', 'POST');
                                    }


                                }
                            });
                        }
                    }
                },
                NO: function () {
                    //CODE FOR FLOOR-FLOOR
                    var tablebody = document.getElementById("enteredTheFloorsBody");
                    var f = document.getElementById("enteredTheFloorsBody").rows.length;
                    for (var i = 0; i < f; i++) {
                        var rowed = tablebody.rows[i];
                        var ided = rowed.id;
                        var tableData = $('#' + ided).closest('tr')
                                .find('td')
                                .map(function () {
                                    return $(this).text();
                                }).get();
                        floorObjectLists.push({
                            rowid: i,
                            floornamed: tableData[1],
                            floorxid: i
                        });
                    }
                    for (var x in floorObjectLists) {
                        OneNameArray.push({
                            roomname: 'ROOM 1',
                            floorxid: floorObjectLists[x].floorxid,
                            roomid: x
                        });
                    }
                    $.ajax({
                        type: 'POST',
                        cache: false,
                        dataType: 'text',
                        data: {floorObjectLists: JSON.stringify(floorObjectLists), rooms: JSON.stringify(OneNameArray), facilityblockid: facilityblockid},
                        url: "locationofresources/savefloors.htm",
                        success: function (results) {
                            console.log(results);
                            if (results !== '') {
                                document.getElementById('floornumber').value = "";
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
                }
            }

        });

    });
</script>


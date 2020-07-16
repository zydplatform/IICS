<%-- 
    Document   : newroom
    Created on : May 29, 2018, 5:04:52 PM
    Author     : RESEARCH
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../../../../../include.jsp" %>
<style>
    .error
    {
        border:2px solid red;
    }

</style>
<div class="col-md-4">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Enter Floor Details</h4>
                <div class="tile-body">
                    <form id="buildingentryform">
                        <div class="form-group"> 
                            <div class="form-group">
                                <label class="control-label">Select Block:</label>
                                <select class="form-control myform" id="selectblocks">
                                    <c:forEach items="${BldBlocks}" var="t">
                                        <option value="${t.facilityblockid}-${t.blockname}">${t.blockname}</option>
                                    </c:forEach>
                                </select>
                            </div>
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
                        Add Floor
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
    var roomList = new Set();
    var floorSet = new Set();
    var floorList = [];
    var floorObjectLists = [];
    document.getElementById('savethefloors').disabled = true;
    $(document).ready(function () {
        $('#capturetheFloor').click(function () {
            var numberofthefloors = $('#floornumber').val();
            var blockid_blockname = document.getElementById('selectblocks').value;
            var fields = blockid_blockname.split('-');
            var blockname = fields[1];
            var facilityblockid = fields[0];
            var i;

            $.ajax({
                type: 'GET',
                data: {tablerowid: facilityblockid, tableData: blockname},
                url: "locationofresources/checkfloornames.htm",
                success: function (results) {
                    console.log(results);
                    floorList = JSON.parse(results);
                    var set = new Set(floorList);
                    var j = 1;
                    $('#enteredTheFloorsBody').html('');
                    for (i = 1; i <= numberofthefloors; i++) {
                        var floorNameUpper = ('FLOOR' + ' ' + i);
                        if (set.has(floorNameUpper)) {
                            for (i = Number(numberofthefloors) + Number(j); i <= Number(numberofthefloors) + Number(numberofthefloors); i++) {
                                document.getElementById('savethefloors').disabled = false;

                                $('#enteredTheFloorsBody').append(
                                        '<tr id="rowrm' + i + '">' +
                                        '<td class="center">' + blockname + '</td>' +
                                        '<td class="center" >FLOOR' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editthermname(\'rowrm' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('floornumber').value = "";
                            }
                        } else {
                            $('#enteredTheFloorsBody').html('');
                            for (i = 1; i <= numberofthefloors; i++) {
                                document.getElementById('savethefloors').disabled = false;
                                $('#enteredTheFloorsBody').append(
                                        '<tr id="rowrm' + i + '">' +
                                        '<td class="center">' + blockname + '</td>' +
                                        '<td class="center" >FLOOR' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editthermname(\'rowrm' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
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
        $('#rowrm' + i).remove();
        roomList.delete(i);
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
                    '<input  id="editedFloorname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Floor Name Here" class="name form-control myform" oninput="checkfloornames();" required />' +
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
                            $('#editedFloorname').addClass('error');
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

    function checkfloornames() {
        var floorname = $('#editedFloorname').val().toUpperCase();

        if (floorSet.has(floorname)) {
            $('#editedFloorname').addClass('error');
            $.alert('Floor Name' + ' ' + '<strong>' + floorname + '</strong>' + ' ' + 'Already Exists');
        } else {
            $('#editedFloorname').removeClass('error');
        }

    }

    //SAVING ROOMS TO A BLOCK
    $('#savethefloors').click(function () {
        var blockid_blockname = document.getElementById('selectblocks').value;
        var fields = blockid_blockname.split('-');
        var blockname = fields[1];
        var facilityblockid = fields[0];
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
                        var id = $('#theblockid').val();
                        var name = $('#theblockname').val();
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
                            var blockid_blockname = document.getElementById('selectblocks').value;
                            var fields = blockid_blockname.split('-');
                            var blockname = fields[1];
                            var blockid = fields[0];
                            var data = {
                                floorz: JSON.stringify(floorObjectLists),
                                facilityblockid: blockid
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'locationofresources/savefloorToblock.htm',
                                success: function (res) {
                                    $('#divSection5').hide();
                                    $('#divSection4').show();
                                    console.log("res1" + res);
                                    if (JSON.parse(res).length !== 0) {
                                        console.log("res2" + res);
                                        $('#enteredTheFloorsBody').html('');
                                        document.getElementById('floornumber').value = "";
                                        floorObjectLists = [];
                                        ajaxSubmitData('locationofresources/addroomtofloor.htm', 'roomfloorcontents', 'res=' + res + '&facilityblockid=' + facilityblockid + '&blockname=' + blockname + '&d=0&ofst=1&maxR=100&sStr=', 'POST');
                                    }


                                }
                            });
                        }
                    }
                },
                NO: function () {
                    //CODE FOR FLOOR-FLOOR
                    var blockid_blockname = document.getElementById('selectblocks').value;
                    var fields = blockid_blockname.split('-');
                    var blockid = fields[0];
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
                    console.log(JSON.stringify(OneNameArray));
                    $.ajax({
                        type: 'POST',
                        cache: false,
                        dataType: 'text',
                        data: {floorObjectLists: JSON.stringify(floorObjectLists), rooms: JSON.stringify(OneNameArray), facilityblockid: blockid},
                        url: "locationofresources/savefloors.htm",
                        success: function (results) {
                            console.log(results);
                            if (results === 'Saved') {
                                document.getElementById('floornumber').value = "";
                                floorObjectLists = [];
                                $('#enteredTheFloorsBody').html('');
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
                                    text: 'An unexpected error occured while trying to add Floors.',
                                    icon: 'error'
                                });
                                ajaxSubmitData('locationofresources/managebuilding.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                window.location = '#close';
                            }
                        }
                    });
                }
            }

        });
    });
</script>
<%-- 
    Document   : floortoblock
    Created on : Jul 2, 2009, 2:43:22 AM
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
                            <input class="form-control" id="buildingid" type="hidden" value="${buildingid}" readonly="true">
                            <input class="form-control" id="buildingname" type="hidden" value="${buildingname}">
                            <label class="control-label">Select Block:</label>
                            <select class="form-control myform" id="selectedblocks">
                                <c:forEach items="${NewBlockList}" var="n">
                                    <option value="${n.facilityblockid}-${n.blockname}">${n.blockname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Number Of Floors</label>
                            <input class="form-control myform" id="floornumbers" type="number" placeholder="Enter Number Of Floors">
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureFloor" type="button">
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
                    <tbody id="enteredFloorsBodyed">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="savefloorz">
                        Finish
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var floornames = [];
    var floornamestestSet = new Set();
    var floorSet = new Set();
    var floorObjectLists = [];
    $(document).ready(function () {
        var blockid_blockname = document.getElementById('selectedblocks').value;
        var fields = blockid_blockname.split('-');
        var blockname = fields[1];
        var facilityblockid = fields[0];
        var buildingid = $('#buildingid').val();
        var buildingname = $('#buildingname').val();

        $.ajax({
            type: 'GET',
            data: {tablerowid: facilityblockid, tableData: blockname, a: buildingid, b: buildingname},
            url: "locationofresources/checkblockfloorname.htm",
            success: function (results) {
                floorList = JSON.parse(results);
                console.log(floorList);
                for (var index in floorList) {
                    var data = floorList[index].toString().toUpperCase();
                    console.log(data);
                    if (!floorSet.has(data)) {
                        floorSet.add(data);
                    }
                }

            }

        });

        $('#captureFloor').click(function () {
            var blockid_blockname = document.getElementById('selectedblocks').value;
            var fields = blockid_blockname.split('-');
            var blockname = fields[1];
            var facilityblockid = fields[0];
            var numberoffloors = $('#floornumbers').val();
            var i;
            $.ajax({
                type: 'GET',
                data: {tablerowid: facilityblockid, tableData: blockname, a: buildingid, b: buildingname},
                url: "locationofresources/checkblockfloorname.htm",
                success: function (results) {
                    console.log(results);
                    floornames = JSON.parse(results);
                    var set = new Set(floornames);
                    var j = 1;
                    $('#enteredTheFloorsBody').html('');
                    for (i = 1; i <= numberoffloors; i++) {
                        var floorNameUpper = ('FLOOR' + ' ' + i);
                        if (set.has(floorNameUpper)) {
                            for (i = Number(numberoffloors) + Number(j); i <= Number(numberoffloors) + Number(numberoffloors); i++) {
                                document.getElementById('savefloorz').disabled = false;
                                $('#enteredTheFloorsBody').append(
                                        '<tr id="floorggg' + i + '">' +
                                        '<td class="center">' + blockname + '</td>' +
                                        '<td class="center" >FLOOR' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editfloorname(\'floorggg' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('floornumbers').value = "";
                            }
                        } else {
                            for (i = 1; i <= numberoffloors; i++) {
                                document.getElementById('savefloorz').disabled = false;
                                $('#enteredTheFloorsBody').html('');
                                $('#enteredFloorsBodyed').append(
                                        '<tr id="floorggg' + i + '">' +
                                        '<td class="center">' + blockname + '</td>' +
                                        '<td class="center" >FLOOR' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom" onclick="editfloorname(\'floorggg' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('floornumbers').value = "";
                            }
                        }
                    }

                }

            });
            $('#' + i).parent().remove();
        });
    });
    function remove(i) {
        $('#floorggg' + i).remove();
        floornamestestSet.delete(i);
    }

    function editfloorname(id) {
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
                    '<input  id="editedthefloorname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Floor Name Here" class="name form-control myform" oninput="checkfloornames();" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                        var name = this.$content.find('.name').val().toUpperCase();
                        if (!name) {
                            $('#editedthefloorname').addClass('error');
                            $.alert('Please Enter Floor Name');
                            return false;
                        }
                        $.alert('New Floor Name Is ' + name);

                        var x = document.getElementById('enteredFloorsBodyed').rows;
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

    function checkfloornames() {
        var floorname = $('#editedthefloorname').val().toUpperCase();
        ;
        if (floorSet.has(floorname)) {
            $('#editedthefloorname').addClass('error');
            $.alert('Floor Name' + ' ' + '<strong>' + floorname + '</strong>' + ' ' + 'Already Exists');
        } else {
            $('#editedthefloorname').removeClass('error');
        }
    }
    //SAVING FLOORS TO A BLOCK
    $('#savefloorz').click(function () {
        var blockid_blockname = document.getElementById('selectedblocks').value;
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
                        var tablebodys = document.getElementById("enteredFloorsBodyed");
                        var t = document.getElementById("enteredFloorsBodyed").rows.length;
                        for (var i = 0; i < t; i++) {
                            var rowed = tablebodys.rows[i];
                            var ided = rowed.id;
                            var tableData = $('#' + ided).closest('tr')
                                    .find('td')
                                    .map(function () {
                                        return $(this).text();
                                    }).get();
                            console.log("naaaaaaammmmmeeeeeeeee" + tableData[1]);
                            floorObjectLists.push({
                                rowid: i,
                                floornamed: tableData[1],
                            });
                        }
                        if (floorObjectLists.length > 0) {
                            var blockid_blockname = document.getElementById('selectedblocks').value;
                            var fields = blockid_blockname.split('-');
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
                                    $('#divSection22').hide();
                                    $('#divSection7').hide();
                                    $('#divSection8').show();
                                    console.log("res1" + res);
                                    if (JSON.parse(res).length !== 0) {
                                        console.log("res2" + res);
                                        $('#enteredFloorsBodyed').html('');
                                        document.getElementById('floornumbers').value = "";
                                        floorObjectLists = [];
                                        ajaxSubmitData('locationofresources/addroomtofloor.htm', 'roomfloorcontent', 'res=' + res + '&facilityblockid=' + facilityblockid + '&blockname=' + blockname + '&d=0&ofst=1&maxR=100&sStr=', 'POST');
                                    }


                                }
                            });
                        }
                    }
                },
                NO: function () {
                    //CODE FOR FLOOR-FLOOR
                    var blockid_blockname = document.getElementById('selectedblocks').value;
                    var fields = blockid_blockname.split('-');
                    var blockname = fields[1];
                    var facilityid = $('#facilityidz').val();
                    for (var x in floorObjectLists) {
                        OneNameArray.push({
                            roomname: 'ROOM 1',
                            floorxid: floorObjectLists[x].floorxid,
                            roomid: x
                        });
                    }
                    $.ajax({
                        type: 'GET',
                        cache: false,
                        dataType: 'text',
                        data: {floorObjectLists: JSON.stringify(floorObjectLists), rooms: JSON.stringify(OneNameArray)},
                        url: "locationofresources/savefloors.htm",
                        success: function () {
                            $('#enteredFloorsBodyed').html('');
                            document.getElementById('floornumbers').value = "";
                            floorObjectLists = [];
                            ajaxSubmitData('locationofresources/addblock.htm', 'blockcontent', 'res=' + blockname + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'POST');

                        }
                    });
                }
            }

        });

    });
</script>
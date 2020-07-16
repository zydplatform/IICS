<%-- 
    Document   : addlocationofresources
    Created on : May 15, 2018, 12:15:49 PM
    Author     : RESEARCH
--%>

<%@include file="../../../../../include.jsp" %>
<!DOCTYPE html>
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
                <h4 class="tile-title">Enter Block Details</h4>
                <div class="tile-body">
                    <form id="buildingentryform">
                        <div class="form-group">
                            <label class="control-label">Select Building:</label>
                            <select class="form-control myform" id="selectbuilding">
                                <c:forEach items="${BuildingsListsz}" var="g">
                                    <option value="${g.buildingid}-${g.buildingname}">${g.buildingname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Number Of Blocks</label>
                            <input class="form-control myform" id="blocknumber" type="number" placeholder="Enter Number Of Blocks">
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureBlock" type="button">
                        <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                        Add Blocks
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
                <h4 class="tile-title">Entered Blocks(s).</h4>
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Building</th>
                            <th>Block Name</th>
                            <th>Edit Block Name</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody id="enteredBlocksBody">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="saveblocks">
                        Finish
                    </button>
                </div>
            </div>
            <span id="incrementx" class="">0</span>
        </div>
    </div>
</div>

<script>
    var blockList = new Set();
    var blockSet = new Set();
    var blockLists = [];
    var blocksList = [];
    var blockObjectList = [];
    document.getElementById('saveblocks').disabled = true;

    $(document).ready(function () {
        var buildingid_buildingname = document.getElementById('selectbuilding').value;
        var fields = buildingid_buildingname.split('-');
        var buildingid = fields[0];
        var buildingname = fields[1];
        $.ajax({
            type: 'GET',
            data: {a: buildingid, b: buildingname},
            url: "locationofresources/checkbuildingblockname.htm",
            success: function (results) {
                blocksList = JSON.parse(results);
                for (var index in blocksList) {
                    var data = blocksList[index].toString().toUpperCase();
                    console.log(data);
                    if (!blockSet.has(data)) {
                        blockSet.add(data);
                    }
                }

            }

        });

        $('#captureBlock').click(function () {

            var buildingid_buildingname = document.getElementById('selectbuilding').value;
            var fields = buildingid_buildingname.split('-');
            var buildingid = fields[0];
            var buildingname = fields[1];
            var numberofblock = $('#blocknumber').val();
            var i;
            $.ajax({
                type: 'GET',
                data: {a: buildingid, b: buildingname},
                url: "locationofresources/checkbuildingblockname.htm",
                success: function (results) {
                    console.log(results);
                    blockLists = JSON.parse(results);
                    var set = new Set(blockLists);
                    var j = 1;
                    $('#enteredBlocksBody').html('');
                    for (i = 1; i <= numberofblock; i++) {
                        var blockNameUpper = ('BLOCK' + ' ' + i);
                        if (set.has(blockNameUpper)) {
                            for (i = Number(numberofblock) + Number(j); i <= Number(numberofblock) + Number(numberofblock); i++) {
                                document.getElementById('saveblocks').disabled = false;
                                $('#enteredBlocksBody').append(
                                        '<tr id="rowgh' + i + '">' +
                                        '<td class="center">' + buildingname + '</td>' +
                                        '<td class="center" >BLOCK' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editotherblkname(\'rowgh' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('blocknumber').value = "";
                            }
                        } else {
                            $('#enteredBlocksBody').html('');
                            for (i = 1; i <= numberofblock; i++) {
                                document.getElementById('saveblocks').disabled = false;
                                $('#enteredBlocksBody').append(
                                        '<tr id="rowgh' + i + '">' +
                                        '<td class="center">' + buildingname + '</td>' +
                                        '<td class="center" >BLOCK' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom" id="blkname" onclick="editblkname(\'rowgh' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('blocknumber').value = "";
                            }

                        }
                    }

                }

            });

            $('#' + i).parent().remove();
        });
    });
    function remove(i) {
        $('#rowgh' + i).remove();
        blockList.delete(i);
    }

    function editblkname(id) {
        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        $.confirm({
            title: 'Change Block Name!',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            theme: 'modern',
            icon: 'fa fa-question-circle',
            content: '' +
                    '<form action="" class="formName myform">' +
                    '<div class="form-group">' +
                    '<label>Enter Block Name</label><br>' +
                    '<span id="errormessage" style="color: red"><strong><strong></span>' +
                    '<input  id="editedblkname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Block Name Here" class="name form-control myform" oninput="checkblockname();" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                        var name = this.$content.find('.name').val().toUpperCase();
                        if (!name) {
                            $('#editedblkname').addClass('error');
                            $.alert('Please Enter Block Name');
                            return false;
                        }

                        var x = document.getElementById('enteredBlocksBody').rows;
                        var y = x[id].cells;
                        y[1].innerHTML = name;

                        $.alert('New Block Name Is ' + name);
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

    function checkblockname() {
        var blockname = $('#editedblkname').val().toUpperCase();

        if (blockSet.has(blockname)) {
            $('#editedblkname').addClass('error');
            $.alert('Block Name' + ' ' + '<strong>' + blockname + '</strong>' + ' ' + 'Already Exists');
        } else {
            $('#editedblkname').removeClass('error');
        }

    }

    $('#saveblocks').click(function () {
        var numberofblock = $('#blocknumber').val();
        $.confirm({
            title: 'Message!',
            content: 'Would You Like To Add Floor(s) To A Block?',
            type: 'blue',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                        $('#divSection1').hide();
                        $('#divSection2').hide();
                        $('#divSection5').show();

                        var tablebody = document.getElementById("enteredBlocksBody");
                        var x = document.getElementById("enteredBlocksBody").rows.length;
                        for (var i = 0; i < x; i++) {
                            var row = tablebody.rows[i];
                            var ids = row.id;
                            var tableData = $('#' + ids).closest('tr')
                                    .find('td')
                                    .map(function () {
                                        return $(this).text();
                                    }).get();
                            blockObjectList.push({
                                rowid: i,
                                blocknames: tableData[1],
                                blockxid: numberofblock
                            });
                        }
                        if (blockObjectList.length > 0) {
                            var buildingid_buildingname = document.getElementById('selectbuilding').value;
                            var fields = buildingid_buildingname.split('-');
                            var buildingid = fields[0];
                            var buildingname = fields[1];
                            var data = {
                                blocks: JSON.stringify(blockObjectList),
                                buildingid: buildingid
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'locationofresources/savenewblocks.htm',
                                success: function (resed) {
                                    if (JSON.parse(resed).length !== 0) {
                                        $('#enteredBuildingsBody').html('');
                                        document.getElementById('blocknumber').value = "";
                                        buildingObjectList = [];
                                        ajaxSubmitData('locationofresources/addfloortoblock.htm', 'floorblkcontents', 'res=' + resed + '&a=' + buildingid + '&b=' + buildingname + '&d=0&ofst=1&maxR=100&sStr=', 'POST');

                                    }
                                }
                            });
                        }
                        //alert("very it popo");
                    }
                },
                NO: function () {
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
                                    $('#divSection1').hide();
                                    $('#divSection2').hide();
                                    $('#divSection5').hide();
                                    $('#divSection4').show();
                                    var buildingid_buildingname = document.getElementById('selectbuilding').value;
                                    var fields = buildingid_buildingname.split('-');
                                    var buildingid = fields[0];
                                    var buildingname = fields[1];
                                    var tablebody = document.getElementById("enteredBlocksBody");
                                    var x = document.getElementById("enteredBlocksBody").rows.length;
                                    for (var i = 0; i < x; i++) {
                                        var row = tablebody.rows[i];
                                        var ids = row.id;
                                        var tableData = $('#' + ids).closest('tr')
                                                .find('td')
                                                .map(function () {
                                                    return $(this).text();
                                                }).get();
                                        blockObjectList.push({
                                            rowid: i,
                                            blocknames: tableData[1],
                                            blockxid: numberofblock
                                        });
                                    }
                                    for (var p in OneNameArray) {
                                        OneNameArrays.push({
                                            floorname: 'FLOOR 1',
                                            blockid: OneNameArray[p].blockid,
                                            floorid: p
                                        });
                                    }
                                    $.ajax({
                                        type: 'GET',
                                        cache: false,
                                        dataType: 'text',
                                        data: {blockObjectList: JSON.stringify(blockObjectList), floors: JSON.stringify(OneNameArrays), buildingid: buildingid, buildingname: buildingname},
                                        url: "locationofresources/addNewblock.htm",
                                        success: function (res) {
                                            if (JSON.parse(res).length !== 0) {
                                                $('#enteredBuildingsBody').html('');
                                                ajaxSubmitData('locationofresources/addnewrooms.htm', 'roomfloorcontents', 'res=' + res + '&d=0&ofst=1&maxR=100&sStr=', 'POST');

                                            }
                                        }
                                    });
                                }

                            },
                            NO: function () {
                                var buildingid_buildingname = document.getElementById('selectbuilding').value;
                                var fields = buildingid_buildingname.split('-');
                                var buildingid = fields[0];
                                var buildingName = fields[1];
                                var count = $('#incrementx').html();

                                var tablebody = document.getElementById("enteredBlocksBody");
                                var x = document.getElementById("enteredBlocksBody").rows.length;
                                for (var i = 0; i < x; i++) {
                                    var row = tablebody.rows[i];
                                    var ids = row.id;
                                    var tableData = $('#' + ids).closest('tr')
                                            .find('td')
                                            .map(function () {
                                                return $(this).text();
                                            }).get();
                                    blockObjectList.push({
                                        rowid: i,
                                        blocknames: tableData[1],
                                        blockxid: numberofblock
                                    });
                                }
                                for (var p in blockObjectList) {
                                    OneNameArrays.push({
                                        floorname: 'FLOOR 1',
                                        blockid: blockObjectList[p].blockid,
                                        floorid: p
                                    });
                                }
                                console.log(OneNameArrays);
                                for (var t in OneNameArray) {
                                    OneNameArrayroom.push({
                                        roomname: 'ROOM 1',
                                        floorid: OneNameArrays[t].blockid,
                                        roomid: t
                                    });
                                }
                                console.log(OneNameArrayroom);
                                $.ajax({
                                    type: 'GET',
                                    cache: false,
                                    dataType: 'text',
                                    data: {blockObjectList: JSON.stringify(blockObjectList), floors: JSON.stringify(OneNameArrays), buildingid: buildingid, buildingname: buildingName, rooms: JSON.stringify(OneNameArrayroom)},
                                    url: "locationofresources/addNewblockz.htm",
                                    success: function (data) {
                                        $('#enteredBuildingsBody').html('');
                                        buildingObjectList = [];
                                        if (data === 'success') {
                                            document.getElementById('buildingname').value = "";
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
                                                text: 'An unexpected error occured while trying to add Buildings.',
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
                }
            }
        });
    });

</script>

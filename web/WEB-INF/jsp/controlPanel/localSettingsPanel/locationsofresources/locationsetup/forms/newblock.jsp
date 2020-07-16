<%-- 
    Document   : newblock
    Created on : May 29, 2018, 5:04:41 PM
    Author     : RESEARCH
--%>

<%@include file="../../../../../include.jsp" %>
<!DOCTYPE html>
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
                <h4 class="tile-title">Enter Block Details</h4>
                <div class="tile-body">
                    <form id="buildingentryform">
                        <div class="form-group">
                            <label class="control-label">Building Name:</label>
                            <input class="form-control" id="blkname" value="${buildingnamed}" type="text" placeholder="Enter Number Of Blocks">
                            <input class="form-control" id="blkid" value="${buildingided}" type="hidden" placeholder="Enter Number Of Blocks">

                        </div>
                        <div class="form-group">
                            <label class="control-label">Number Of Blocks</label>
                            <input class="form-control" id="blocknumberer" type="number" placeholder="Enter Number Of Blocks">
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureBlockers" type="button">
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
                    <tbody id="enteredBlockersBody">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="saveblockers">
                        Finish
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var blockList = new Set();
    var blockSet = new Set();
    var blockObjectList = [];
    var blocksList = [];
    var OneNameArraied = [];
    var OneNameArrayroom = [];
    var OneNameArrays = [];
    var OneNameArraies = [];

    $(document).ready(function () {
        document.getElementById('saveblockers').disabled = true;
        var buildingname = $('#blkname').val();
        var buildingid = $('#blkid').val();
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

        $('#captureBlockers').click(function () {
            var buildingname = $('#blkname').val();
            var buildingid = $('#blkid').val();
            var numberofblockz = $('#blocknumberer').val();
            var i;
            $.ajax({
                type: 'GET',
                data: {a: buildingid, b: buildingname},
                url: "locationofresources/checkbuildingblockname.htm",
                success: function (results) {
                    console.log(results);
                    blocksList = JSON.parse(results);
                    var set = new Set(blocksList);
                    var j = 1;
                    $('#enteredBlockersBody').html('');
                    for (i = 1; i <= numberofblockz; i++) {
                        var blockNameUpper = ('BLOCK' + ' ' + i);
                        if (set.has(blockNameUpper)) {
                            for (i = Number(numberofblockz) + Number(j); i <= Number(numberofblockz) + Number(numberofblockz); i++) {
                                document.getElementById('saveblockers').disabled = false;
                                $('#enteredBlockersBody').append(
                                        '<tr id="rowger' + i + '">' +
                                        '<td class="center">' + buildingname + '</td>' +
                                        '<td class="center" >BLOCK' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editblkername(\'rowger' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('blocknumberer').value = "";
                            }
                        } else {
                            $('#enteredBlockersBody').html('');
                            for (i = 1; i <= numberofblockz; i++) {

                                document.getElementById('saveblockers').disabled = false;

                                $('#enteredBlockersBody').append(
                                        '<tr id="rowger' + i + '">' +
                                        '<td class="center">' + buildingname + '</td>' +
                                        '<td class="center" >BLOCK' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom" onclick="editblkername(\'rowger' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('blocknumberer').value = "";
                            }

                        }
                    }

                }

            });

            $('#' + i).parent().remove();
        });
    });
    function remove(i) {
        $('#rowger' + i).remove();
        blockList.delete(i);
    }


    function editblkername(id) {
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
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Block Name</label><br>' +
                    '<span id="errormessage" style="color: red"><strong><strong></span>' +
                    '<input  id="editedblknames" type="text" value="' + tableData[1] + '" placeholder="Please Enter Block Name Here" class="myform form-control" oninput="checkblockname();" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                        var name = this.$content.find('#editedblknames').val().toUpperCase();;
                        if (!name) {
                            $('#editedblknames').addClass('error');
                            $.alert('Please Enter Block Name');
                            return false;
                        }
                        $.alert('New Block Name Is' + ' ' + name);

                        var x = document.getElementById('enteredBlockersBody').rows;
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

    function checkblockname() {
        var blockname = $('#editedblknames').val().toUpperCase();

        if (blockSet.has(blockname)) {
            $('#editedblkname').addClass('error');
            $.alert('Block Name' + ' ' + '<strong>' + blockname + '</strong>' + ' ' + 'Already Exists');
        } else {
            $('#editedblkname').removeClass('error');
        }

    }

    $('#saveblockers').click(function () {
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
                        $('#divSection7').show();

                        var tablebody = document.getElementById("enteredBlockersBody");
                        var x = document.getElementById("enteredBlockersBody").rows.length;
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
                            });
                        }
                        if (blockObjectList.length > 0) {
                            var buildingid = $('#blkid').val();
                            var buildingname = $('#blkname').val();
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

                                        $('#enteredBlockersBody').html('');
                                        document.getElementById('blocknumberer').value = "";
                                        blockObjectList = [];

                                        ajaxSubmitData('locationofresources/addfloortoblock.htm', 'floorblkcontent', 'res=' + resed + '&a='+buildingid+'&b='+buildingname+'&d=0&ofst=1&maxR=100&sStr=', 'POST'); 

                                    }
                                }
                            });
                        }
                    }
                },
                NO: function () {
                    $.confirm({
                        title: 'Message!',
                        content: 'Would You Like To Add Room(s) To A Block?',
                        type: 'blue',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Yes',
                                btnClass: 'btn-green',
                                action: function () {
                                    $('#divSection1').hide();
                                    $('#divSection2').hide();
                                    $('#divSection7').hide();
                                    $('#divSection8').show();
                                    var buildingid = $('#blkid').val();
                                    var buildingname = $('#blkname').val();
                                    var count = $('#incrementx').html();
                                    var tablebody = document.getElementById("enteredBlockersBody");
                                    var x = document.getElementById("enteredBlockersBody").rows.length;
                                    for (var i = 0; i < x; i++) {
                                        var xcount = parseInt(count) + 1;
                                        ;
                                        $('#incrementx').html(xcount);
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
                                            buildingid: buildingid,
                                            blockxid: i
                                        });
                                    }

                                    for (var x in blockObjectList) {
                                        console.log(blockObjectList[x].blocknames + '-----' + blockObjectList[x].buildingid);
                                        OneNameArraied.push({
                                            floorname: 'FLOOR 1',
                                            buildingid: blockObjectList[x].buildingid,
                                            blockxid: blockObjectList[x].blockxid,
                                            floorid: x
                                        });
                                    }
                                    console.log(OneNameArraied);

                                    $.ajax({
                                        type: 'GET',
                                        cache: false,
                                        dataType: 'text',
                                        data: {buildingid: buildingid, buildingname: buildingname, blockObjectList: JSON.stringify(blockObjectList), floors: JSON.stringify(OneNameArraied)},
                                        url: "locationofresources/addNewblock.htm",
                                        success: function (res) {
                                            if (JSON.parse(res).length !== 0) {
                                                $('#enteredBlockersBody').html('');
                                                buildingObjectList = [];
                                                document.getElementById('blocknumberer').value = "";
                                                ajaxSubmitData('locationofresources/addroomtofloor.htm', 'roomfloorcontent', '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'POST');
                                            }
                                        }
                                    });
                                }
                            },
                            NO: function () {
                                var buildingid = $('#blkid').val();
                                var buildingname = $('#blkname').val();
                                var count = $('#incrementx').html();
                                var tablebody = document.getElementById("enteredBlockersBody");
                                var x = document.getElementById("enteredBlockersBody").rows.length;
                                for (var i = 0; i < x; i++) {
                                    var xcount = parseInt(count) + 1;
                                    ;
                                    $('#incrementx').html(xcount);
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
                                        buildingid: buildingid,
                                        blockxid: i
                                    });
                                }

                                for (var x in blockObjectList) {
                                    OneNameArraied.push({
                                        floorname: 'FLOOR 1',
                                        buildingid: blockObjectList[x].buildingid,
                                        blockxid: blockObjectList[x].blockxid,
                                        floorid: x
                                    });
                                }
                                console.log(OneNameArraied);
                                for (var y in OneNameArraied) {
                                    OneNameArraies.push({
                                        roomname: 'ROOM 1',
                                        buildingid: OneNameArraied[y].buildingid,
                                        floorid: OneNameArraied[y].blockxid,
                                        roomid: y
                                    });
                                }
                                console.log(OneNameArraies);

                                $.ajax({
                                    type: 'GET',
                                    cache: false,
                                    dataType: 'text',
                                    data: {buildingid: buildingid, buildingname: buildingname, blockObjectList: JSON.stringify(blockObjectList), floors: JSON.stringify(OneNameArraied), rooms: JSON.stringify(OneNameArraies)},
                                    url: "locationofresources/addNewblockz.htm",
                                    success: function (results) {
                                        if (results === 'success') {
                                            document.getElementById('buildingname').value = "";
                                            $.toast({
                                                heading: 'Success',
                                                text: 'Block Added Successfully.',
                                                icon: 'success',
                                                hideAfter: 2000,
                                                position: 'bottom-center'
                                            });
                                            ajaxSubmitData('locationofresources/viewbuildingsinfacility.htm', 'viewblkrooms', 'act=a&buildingId=' + buildingid + '&buildingname=' + buildingname + '', 'POST');
                                            window.location = '#close';
                                        } else {
                                            $.toast({
                                                heading: 'Error',
                                                text: 'An unexpected error occured while trying to add Blocks.',
                                                icon: 'error'
                                            });
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


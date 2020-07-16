<%-- 
    Document   : addlocationofresources
    Created on : May 15, 2018, 12:15:49 PM
    Author     : RESEARCH
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            <label class="control-label">Building Name</label>
                            <input class="form-control myform" id="buildingnamez" type="text" readonly="true" value="${buildingname}">
                            <input class="form-control myform" id="buildingidz" type="hidden" value="${buildingid}">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Number Of Blocks</label>
                            <input class="form-control myform" id="blocknumberz" type="number" placeholder="Enter Number Of Blocks">
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureOtherBlock" type="button">
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
                    <tbody id="enteredOtherBlocksBody">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="saveotherblocks">
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
    var blocksList = [];
    var blockObjectList = [];
    var OneNameArraied = [];
    var OneNameArrayroom = [];

    var OneNameArrays = [];
    var OneNameArraies = [];
    document.getElementById('saveotherblocks').disabled = true;

    $(document).ready(function () {
        var buildingname = $('#buildingnamez').val();
        var buildingid = $('#buildingidz').val();


        $.ajax({
            type: 'GET',
            data: {a: buildingid, b: buildingname},
            url: "locationofresources/checkbuildingblockname.htm",
            success: function (results) {
                blocksList = JSON.parse(results);
                console.log(blocksList);
                for (var index in blocksList) {
                    var data = blocksList[index].toString().toUpperCase();
                    console.log(data);
                    if (!blockSet.has(data)) {
                        blockSet.add(data);
                    }
                }
                
            }

        });

        $('#captureOtherBlock').click(function () {
            var numberofotherblock = $('#blocknumberz').val();
            var buildingname = $('#buildingnamez').val();
            var buildingid = $('#buildingidz').val();
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
                    $('#enteredOtherBlocksBody').html('');
                    for (i = 1; i <= numberofotherblock; i++) {
                        var blockNameUpper = ('BLOCK' + ' ' + i);
                        if (set.has(blockNameUpper)) {
                            for (i = Number(numberofotherblock) + Number(j); i <= Number(numberofotherblock) + Number(numberofotherblock); i++) {
                                document.getElementById('saveotherblocks').disabled = false;
                                $('#enteredOtherBlocksBody').append(
                                        '<tr id="rowffg' + i + '">' +
                                        '<td class="center">' + buildingname + '</td>' +
                                        '<td class="center" >BLOCK' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editotherblkname(\'rowffg' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('blocknumberz').value = "";
                            }
                        } else {
                            $('#enteredOtherBlocksBody').html('');
                            for (i = 1; i <= numberofotherblock; i++) {
                                document.getElementById('saveotherblocks').disabled = false;

                                $('#enteredOtherBlocksBody').append(
                                        '<tr id="rowffg' + i + '">' +
                                        '<td class="center">' + buildingname + '</td>' +
                                        '<td class="center" >BLOCK' + ' ' + i + '</td>' +
                                        '<td class="center"><span class="badge badge-info icon-custom"  onclick="editotherblkname(\'rowffg' + i + '\');"><i class="fa fa-edit"></i></span></td>' +
                                        '<td class="center"><span class="badge badge-danger icon-custom" onclick="remove(\'' + i + '\')"><i class="fa fa-trash-o"></i></span></td></tr>'
                                        );
                                document.getElementById('blocknumberz').value = "";
                            }
                        }
                    }

                }

            });

            $('#' + i).parent().remove();

        });

    });

    function remove(i) {
        $('#rowffg' + i).remove();
        blockList.delete(i);
    }

    function editotherblkname(id) {
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
                    '<input  id="editedtheblockname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Block Name Here" class="name form-control myform" oninput="checkblockname();" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                        var name = this.$content.find('.name').val().toUpperCase();
                        if (!name) {
                            $('#editedtheblockname').addClass('error');
                            $.alert('Please Enter Block Name');
                            return false;
                        }
                        var x = document.getElementById('enteredOtherBlocksBody').rows;
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
        var blockname = $('#editedtheblockname').val().toUpperCase();

        if (blockSet.has(blockname)) {
            $('#editedtheblockname').addClass('error');
            $.alert('Block Name' + ' ' + '<strong>' + blockname + '</strong>' + ' ' + 'Already Exists');
        } else {
            $('#editedtheblockname').removeClass('error');
        }

    }

    $('#saveotherblocks').click(function () {

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
                        $('#divSection22').hide();
                        $('#divSection4').hide();
                        $('#divSection7').show();

                        var tablebody = document.getElementById("enteredOtherBlocksBody");
                        var x = document.getElementById("enteredOtherBlocksBody").rows.length;
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
                                blocknames: tableData[1]
                            });
                        }
                        if (blockObjectList.length > 0) {
                            var buildingid = $('#buildingidz').val();
                            var buildingname = $('#buildingnamez').val();
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
                                        $('#enteredOtherBlocksBody').html('');
                                        document.getElementById('blocknumberz').value = "";
                                        blockObjectList = [];
                                        ajaxSubmitData('locationofresources/registerFloor.htm', 'floorblkcontent', 'res=' + resed + '&a='+buildingid+'&b='+buildingname+'&d=0&ofst=1&maxR=100&sStr=', 'POST');
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
                                    $('#divSection22').hide();
                                    $('#divSection7').hide();
                                    $('#divSection8').show();
                                    var buildingid = $('#buildingidz').val();
                                    var buildingname = $('#buildingnamez').val();
                                    var count = $('#incrementx').html();
                                    var tablebody = document.getElementById("enteredOtherBlocksBody");
                                    var x = document.getElementById("enteredOtherBlocksBody").rows.length;
                                    for (var i = 0; i < x; i++) {
                                        var xcount = parseInt(count) + 1;
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

                                    $.ajax({
                                        type: 'GET',
                                        cache: false,
                                        dataType: 'text',
                                        data: {buildingid: buildingid, buildingname: buildingname, blockObjectList: JSON.stringify(blockObjectList), floors: JSON.stringify(OneNameArraied)},
                                        url: "locationofresources/addNewblock.htm",
                                        success: function (res,facilityblockid,blocknames) {
                                            if (JSON.parse(res).length !== 0) {
                                                $('#enteredOtherBlocksBody').html('');
                                                document.getElementById('blocknumberz').value = "";
                                                ajaxSubmitData('locationofresources/addroomtofloor.htm', 'roomfloorcontented', 'res=' + res + '&facilityblockid='+facilityblockid+'&blockname='+blocknames+'&d=0&ofst=1&maxR=100&sStr=', 'POST');
                                            }

                                        }
                                    });

                                }
                            },
                            NO: function () {
                                var buildingid = $('#buildingidz').val();
                                var buildingname = $('#buildingnamez').val();
                                var count = $('#incrementx').html();
                                var tablebody = document.getElementById("enteredOtherBlocksBody");
                                var x = document.getElementById("enteredOtherBlocksBody").rows.length;
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
                                        console.log(results);
                                        if (results !== '') {
                                            document.getElementById('blocknumberz').value = "";
                                            $.toast({
                                                heading: 'Success',
                                                text: 'Block Added Successfully.',
                                                icon: 'success',
                                                hideAfter: 2000,
                                                position: 'bottom-center'
                                            });
                                            ajaxSubmitData('locationofresources/managebuilding.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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

//    function editotherblknamez(id) {
//        $.confirm({
//            title: 'Change Block Name!',
//            content: '' +
//                    '<form action="" class="formName">' +
//                    '<div class="form-group">' +
//                    '<label>Enter Block Name</label>' +
//                    '<input  id="editedotherblkname" type="text" placeholder="Please Enter Block Name Here" class="myform form-control" required />' +
//                    '</div>' +
//                    '</form>',
//            buttons: {
//                formSubmit: {
//                    text: 'SAVE',
//                    btnClass: 'btn-green',
//                    action: function () {
//                        var name = this.$content.find('#editedotherblkname').val();
//                        if (!name) {
//                            $('#editedotherblkname').addClass('error');
//                            $.alert('Please Enter Block Name');
//                            return false;
//                        }
//                        $.alert('New Block Name Is' + ' ' + name);
//
//                        var u = document.getElementById('enteredOtherBlocksBody').rows;
//                        var i = u[id].cells;
//                        i[1].innerHTML = name;
//                    }
//                },
//                cancel: function () {
//                    //close
//                },
//            },
//            onContentReady: function () {
//                // bind to events
//                var jc = this;
//                this.$content.find('form').on('submit', function (e) {
//                    // if the user submits the form by pressing enter in the field.
//                    e.preventDefault();
//                    jc.$$formSubmit.trigger('click'); // reference the button and click it
//                });
//            }
//        });
//    }
</script>

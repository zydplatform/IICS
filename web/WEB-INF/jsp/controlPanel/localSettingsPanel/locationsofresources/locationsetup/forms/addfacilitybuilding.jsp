<%-- 
    Document   : addfacilitybuilding
    Created on : May 22, 2018, 7:00:32 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<style>
    .error
    {
        border:2px solid red;
    }

    .myform{
        width:100% !important;
    }
</style>
<div class="col-md-4">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h4 class="tile-title">Enter Building Details</h4>
                <div class="tile-body">
                    <form id="buildingentryforms">
                        <div class="form-group">
                            <label class="control-label">Current Facility</label>
                            <input class="form-control myform" id="facilityidz" value="${FacilityLists.facilityid}" type="hidden">
                            <input class="form-control myform" id="facilitynamez" value="${FacilityLists.facilityname}" type="text" readonly="true">
                        </div>
                        <div class="form-group">
                            <label class="control-label">Building Name</label>
                            <input class="form-control myform" oninput="checkbuildingname();" id="buildingname" type="text" placeholder="Enter Building Name">
                        </div>
                    </form>
                </div>
                <div class="tile-footer">
                    <button class="btn btn-primary" id="captureBuilding" type="button">
                        <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                        Add Building
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
                <h4 class="tile-title">Entered Building(s).</h4>
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Facility</th>
                            <th>Building Name</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody id="enteredBuildingsBody">

                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-right">
                    <button type="button" class="btn btn-primary" id="savebuildings">
                        Finish
                    </button>
                </div>
            </div>
            <span id="incrementx" class="hidedisplaycontent">0</span>
        </div>
    </div>
</div>
<script>
    var buildingList = new Set();
    var buildingObjectList = [];
    var OneNameArray = [];
    var OneNameArrays = [];
    var OneNameArrayroom = [];
    var OneNameArrayes = [];
    document.getElementById('savebuildings').disabled = true;
    document.getElementById('captureBuilding').disabled = true;
    function checkbuildingname() {
        var buildingname = document.getElementById('buildingname').value;
        var facilityid = document.getElementById('facilityidz').value;
        if (buildingname.length > 0) {
            document.getElementById('captureBuilding').disabled = true;
            $.ajax({
                type: 'POST',
                data: {facilityid: facilityid, buildingname: buildingname},
                url: "locationofresources/checkfacilitybuildingname.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'existing') {
                        $('#buildingname').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: buildingname + ' Already Exists',
                        });
                        document.getElementById('captureBuilding').disabled = true;
                        document.getElementById('buildingname').value = "";
                    } else {
                        $('#buildingname').removeClass('error');
                        document.getElementById('captureBuilding').disabled = false;
                    }
                }
            });
        }
    }

    var buildingnames = [];
    var buildingnamestestSet = new Set();
    $('#captureBuilding').click(function () {
        var facId = $('#facilityidz').val();
        var facName = $('#facilitynamez').val();
        var buildingName = $('#buildingname').val();
        var count = $('#incrementx').html();
        document.getElementById('facilityidz').value = facId;
        document.getElementById('facilitynamez').value = facName;
        document.getElementById('buildingname').value = "";
        if (buildingName !== '') {
            if (buildingnamestestSet.has(buildingName)) {
                $.alert({
                    title: '',
                    content: '<div class="center">' + '<font size="5">' + '<strong class="text-danger">' + buildingName + '</strong> &nbsp;Already Exists!!</font></div>',
                    type: 'red',
                    typeAnimated: true,
                });
            } else {
                document.getElementById('savebuildings').disabled = false;
                var xcount = parseInt(count) + 1;
                $('#incrementx').html(xcount);
                $('#enteredBuildingsBody').append(
                        '<tr id="rowfg' + facId + '">' +
                        '<td class="center">' + facName + '</td>' +
                        '<td class="center" >' + '<a onclick="editbldname();">' + buildingName + '</a>' + '</td>' +
                        '<td class="center">' +
                        '<span class="badge badge-danger icon-custom" onclick="remove(\'' + facId + '\')">' +
                        '<i class="fa fa-trash-o"></i></span></td></tr>'
                        );
                document.getElementById("buildingentryforms").reset();
                $('#buildingname').css('border', '2px solid #6d0a70');
                $('#facilityid').css('border', '2px solid #6d0a70');
                $('#facilityname').css('border', '2px solid #6d0a70');
                var data = {
                    buildingName: buildingName,
                    facilityid: facId,
                    facilityname: facName,
                    buildingxid: xcount
                };
                buildingnamestestSet.add(buildingName);
                buildingList.add(facId);
                buildingObjectList.push(data);
            }

        } else {

            $('#buildingname').focus();
            $('#buildingname').css('border', '2px solid #f50808c4');
        }
    });
  
    function remove(facId) {
        $('#rowfg' + facId).remove();
        buildingnamestestSet.delete(facId);
    }

    $('#savebuildings').click(function () {

        $.confirm({
            title: 'Message!',
            content: 'Would You Like To Add Block(s) To A Building?',
            type: 'blue',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                        if (buildingObjectList.length > 0) {
                            var data = {
                                buildings: JSON.stringify(buildingObjectList)
                            };
                            $.ajax({
                                type: 'POST',
                                data: data,
                                url: 'locationofresources/savenewbuildings.htm',
                                success: function (res) {
                                    if (JSON.parse(res).length !== 0) {

                                        document.getElementById('buildingname').value = "";
                                        $('#divSection1').hide();
                                        $('#divSection2').show();
                                        ajaxSubmitData('locationofresources/addblock.htm', 'blockcontent', 'res=' + res + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'POST');

                                        $('#enteredBuildingsBody').html('');
                                        buildingObjectList = [];
                                    }
                                }
                            });
                        }

                    }
                },
                NO: function () {
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

                                    //code for adding building-building-floor
                                    var facilityid = $('#facilityidz').val();
                                    for (var x in buildingObjectList) {
                                        OneNameArray.push({
                                            blockname:'BLOCK 1',
                                            facilityid: buildingObjectList[x].facilityid,
                                            buildingxid: buildingObjectList[x].buildingxid,
                                            blockid: x
                                        });
                                    }
                                    $.ajax({
                                        type: 'GET',
                                        cache: false,
                                        dataType: 'text',
                                        data: {facilityid: facilityid, buildingObjectList: JSON.stringify(buildingObjectList), blocks: JSON.stringify(OneNameArray)},
                                        url: "locationofresources/addNewbuildingz.htm",
                                        success: function (resed) {
                                            console.log("JSON.stringify(resed)---------------"+resed);
                                            if (JSON.parse(resed).length !== 0) {
                                                console.log(resed);
                                                ajaxSubmitData('locationofresources/addfloor.htm', 'floorblkcontents', 'res=' + resed + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            }
                                        }
                                    });
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
                                                //code for building-building-building

                                                var facilityid = $('#facilityidz').val();
                                                for (var x in buildingObjectList) {
                                                    console.log(buildingObjectList[x].buildingName + '-----' + buildingObjectList[x].facilityid);
                                                    OneNameArray.push({
                                                        blockname: 'BLOCK 1',
                                                        facilityid: buildingObjectList[x].facilityid,
                                                        buildingxid: buildingObjectList[x].buildingxid,
                                                        blockid: x
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
                                                    data: {facilityid: facilityid, buildingObjectList: JSON.stringify(buildingObjectList), blocks: JSON.stringify(OneNameArray), floors: JSON.stringify(OneNameArrays)},
                                                    url: "locationofresources/addNewbuildings.htm",
                                                    success: function (res) {
                                                        $('#divSection1').hide();
                                                        $('#divSection2').hide();
                                                        $('#divSection5').hide();
                                                        $('#divSection4').show();
                                                        
                                                        if (JSON.parse(res).length !== 0) {
                                                            $('#enteredBuildingsBody').html('');
                                                            ajaxSubmitData('locationofresources/addnewrooms.htm', 'roomfloorcontents', 'res=' + res + '&d=0&ofst=1&maxR=100&sStr=', 'POST');

                                                        }
                                                    }
                                                });

                                            }
                                        },
                                        NO: function () {

                                            var facilityid = $('#facilityidz').val();
                                            for (var x in buildingObjectList) {
                                                console.log(buildingObjectList[x].buildingName + '-----' + buildingObjectList[x].facilityid);
                                                OneNameArray.push({
                                                    blockname: 'BLOCK 1',
                                                    facilityid: buildingObjectList[x].facilityid,
                                                    buildingxid: buildingObjectList[x].buildingxid,
                                                    blockid: x
                                                });
                                            }
                                            console.log(OneNameArray);
                                            for (var p in OneNameArray) {
                                                OneNameArrays.push({
                                                    floorname: 'FLOOR 1',
                                                    blockid: OneNameArray[p].blockid,
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
                                                data: {facilityid: facilityid, buildingObjectList: JSON.stringify(buildingObjectList), blocks: JSON.stringify(OneNameArray), floors: JSON.stringify(OneNameArrays), rooms: JSON.stringify(OneNameArrayroom)},
                                                url: "locationofresources/addNewbuilding.htm",
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

                }
            }
        });
    });


</script>

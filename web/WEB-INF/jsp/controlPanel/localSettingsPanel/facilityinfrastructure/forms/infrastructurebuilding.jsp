<%-- 
    Document   : infrastructurebuilding
    Created on : Sep 12, 2019, 1:40:47 PM
    Author     : USER 1
--%>

<div class="col-md-12">
    <fieldset>
        <div class="stepwizard col-md-offset-3">
            <div class="stepwizard-row setup-panel">
                <div class="stepwizard-step">
                    <a href="#step-1" type="button" class="btn btn-primary btn-circle" id="step01">1</a>
                    <p>Step 1</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-2" type="button" class="btn btn-default btn-circle" id="step02">2</a>
                    <p>Step 2</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-3" type="button" class="btn btn-default btn-circle" id="step03">3</a>
                    <p>Step 3</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-4" type="button" class="btn btn-default btn-circle" id="step04">4</a>
                    <p>Step 4</p>
                </div>
            </div>
        </div>
        <form id="buildingentryforms">
            <div class="setup-content" id="step-1">
                <div class="col-xs-6 col-md-offset-3">
                    <div class="col-md-12">
                        <h4><span class="badge badge-info">Step 1</span>:Create Building</h4> 
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <div id="errorZonemsg"></div>
                                    <label class="control-label">Current Facility</label>
                                    <input class="form-control myform" id="facilityidz" value="${FacilityLists.facilityid}" type="hidden">
                                    <input class="form-control myform" id="facilitynamez" value="${FacilityLists.facilityname}" type="text" readonly="true">
                                </div>
                            </div>
                            <div class="clear-fix"></div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Building Name</label>
                                    <input class="form-control myform"  id="buildingnamezz" type="text" placeholder="Enter Building Name">
                                </div>
                            </div>
                            <div id="defaultfloorandroombodyx" class="col-md-12">

                            </div>
                        </div>
                        <div class="tile-footer">
                            <div>
                                <button class="btn btn-primary nextBtn btn-lg pull-right" type="button" id="captureBuildingz">Next Step</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="setup-content" id="step-2">
                <div class="col-xs-6 col-md-offset-3">
                    <div class="col-md-12">
                        <h4><span class="badge badge-info">Step 2</span>:Create More Floors</h4>
                        <table style="border:whitesmoke;" class="table table-responsive xv" align="center">
                            <tbody>
                                <tr>
                                    <td></td>
                                    <td><b>Building Name</b></td>
                                    <td>:<strong id="building"></strong></td> 
                                </tr>
                                <tr>
                                    <td></td>
                                    <td><b><br>Number Of Floors</b></td>
                                    <td>:<input   maxlength="7" required type="text" id="bayNumber"  class="col-md-12" placeholder="Enter number of floors" style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" />
                                        <span id="error"></span></td> 
                                </tr>
                            </tbody>
                        </table>     
                        <div id="listofbays" style="display: none;">
                            <h5>Add Floors to building:<strong  id="buildingxx"></strong></h5>
                            <div id="zonebays" style="overflow: auto; max-height: 150px"></div>
                        </div>
                        <button class="btn btn-primary nextBtn btn-lg pull-right" type="button" >Next Step</button>
                    </div>
                </div>
            </div>
            <div class="setup-content" id="step-3">
                <div class="col-xs-6 col-md-offset-3">
                    <div class="col-md-12">
                        <h4><span class="badge badge-info">Step 3</span>:Create Rooms</h4>
                        <div id="createdRows" style="max-height: 250px;overflow-y: scroll;"></div>
                        <button class="btn btn-primary nextBtn btn-lg pull-right" type="button" >Next Step</button>
                    </div>
                </div>
            </div>
            <div class="setup-content" id="step-4">
                <div class="col-xs-6 col-md-offset-3">
                    <div class="col-md-12">
                        <h4><span class="badge badge-info">Step 4</span>:Add Room labels</h4>
                        <div id="createdcells" style="max-height: 250px;overflow-y: scroll;"></div>                
                        <button class="btn btn-success savezone btn-lg pull-right" type="button">Finish</button>
                    </div>
                </div>
            </div>
        </form> 
    </fieldset>
</div>
<div class="row">
    <div class="col-md-12" id="addrmblk">
        <div id="addfacilitybldx" class="supplierCatalogDialog">
            <div>

                <div id="divSection1">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Add More Buildings to Facility</h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="content">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var buildingArray = [];
    var floorArray = [];
    var roomArray = [];
    var roomNumberArray = [];
    var roomLabelsFinalArray = [];
    var roomCellsArray = [];
    var Cellsarraytest = [];
    var rowNumberArray = [];
    $(document).ready(function () {
        $('#step01').addClass('disabled');
        $('#step03').addClass('disabled');
        $('#step02').addClass('disabled');
        $('#step04').addClass('disabled');
         $('.nextBtn').hide();
        var Existingzone = ${jsonCreatedzone};
        var ExistingZoneNameSet = new Set();
        for (var x in Existingzone) {
            if (Existingzone.hasOwnProperty(x)) {

                ExistingZoneNameSet.add(Existingzone[x].buildingname);
            }
        }
        $('#buildingnamezz').on('input keyup', function (e) {
            var inputzone = $(this).val().toUpperCase();
             var regex = /^([a-zA-Z])[a-zA-Z_-]*[\w_-]*[\S]$|^([a-zA-Z])[0-9_-]*[\S]$|^[a-zA-Z]*[\S]$/;
                var testname = regex.test(inputzone);
            if (ExistingZoneNameSet.has(inputzone)) {
                $('#buildingnamezz').focus();
                $('#buildingnamezz').addClass('error');
                $.alert({
                    title: 'Alert!',
                    content: inputzone + ' Already Exists',
                });
                $('#defaultfloorandroombody').html('');
                $('.nextBtn').hide();
                $('.savezone').hide();
                $('#step02').addClass('disabled');
                $('#step03').addClass('disabled');
                $('#step04').addClass('disabled');
            } else if(testname!=true) {
                 $.confirm({
                title: 'Info',
                content: 'Building name format not allowed',
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
                           $('#buildingnamezz').val('');
                        }
                    }
                }
            });
                
            }
            else{
                if (e.key === "Enter") {
                    $(this).attr("disabled", "disabled");
                   
                    $('#defaultfloorandroombodyx').append(
                            '<table class="table table-sm table-bordered">' +
                            '<thead>' +
                            '<tr>' +
                            '<th>Floor name</th>' +
                            '<th>Edit</th>' +
                            '<th>Room name</th>' +
                            '<th>Edit</th>' +
                            ' </tr>' +
                            '</thead>' +
                            '<tbody id="defaultfloorandroombody">' +
                            '<tr id="rowrm">' +
                            '<td class="center"> Floor 1</td>' +
                            '<td class="center"><span class="badge badge-info icon-custom" onclick="editfloornamexx(\'rowrm\');"><i class="fa fa-edit"></i></span></td>' +
                            '<td class="center" >Room 1 </td>' +
                            '<td class="center"><span class="badge badge-info icon-custom" onclick="editroomnamexxz(\'rowrm\');"><i class="fa fa-edit"></i></span></td></tr>' +
                            '</tbody>' +
                            '</table>'
                            );
                    $('.nextBtn').show();
                    $('.savezone').show();

                }
            }
        });
        var navListItems = $('div .setup-panel div a'),
                allWells = $('.setup-content'),
                allNextBtn = $('.nextBtn');

        allWells.hide();
        navListItems.click(function (e) {
            e.preventDefault();
            var $target = $($(this).attr('href')),
                    $item = $(this);
            navListItems.removeClass('btn-primary').addClass('btn-default');
            $item.addClass('btn-primary');
            allWells.hide();
            $target.show();
            $target.find('input:eq(0)').focus();

        });
        allNextBtn.click(function () {
            var curStep = $(this).closest(".setup-content"),
                    curStepBtn = curStep.attr("id"),
                    nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a");
            var building = $('#buildingnamezz').val();
            if (curStepBtn === 'step-1') {
                $('#step01').addClass('disabled');
                $('#step03').addClass('disabled');
                $('#step04').addClass('disabled');
                $('#listofbays').hide();
                if (!isEmpty(building)) {
                    $('#building').html(building.toUpperCase().replace(/\s+/g, ''));
                    $('#transactionlimit').show();
                    var buildingk = building;
                    //var buildingidx=
                    buildingArray.push({
                        buildingname: buildingk.toUpperCase().replace(/\s+/g, ''),
                        buildingid: 1
                    });
                    nextStepWizard.removeAttr('disabled').trigger('click');
                } else {
                    document.getElementById('buildingnamezz').style.borderColor = "red";
                }
            } else if (curStepBtn === 'step-2') {
                $('#step01').addClass('disabled');
                $('#step02').addClass('disabled');
                $('#step04').addClass('disabled');
                $('#createdRows').html('');
                var baynumber = $('#bayNumber').val();
                if (!isEmpty(baynumber)) {
                    $('.nextBtn').prop('disabled', false);
                    // console.log(sMecha[1]);           
                    var bzone = building.toUpperCase().replace(/\s+/g, '');
                    var tableData = $('#rowrm').closest('tr')
                            .find('td')
                            .map(function () {
                                return $(this).text();
                            }).get();
                    var defaultfloor = tableData[0];
                    var buildingfloor = bzone + '-' + defaultfloor;
                    floorArray.push({
                        floorname: buildingfloor.toUpperCase(),
                        floorid: 1,
                        building: 1
                    });
                    for (var i = 0; i < baynumber; i++) {
                        var x = i + 2;
                        var floorname = $('#zonelabelsx' + x).val();
                        var zoneName = bzone + '-' + floorname;

                        floorArray.push({
                            floorname: zoneName.toUpperCase(),
                            floorid: x,
                            building: 1
                        });
                    }

                    for (var x in floorArray) {
                        var n = x + 1;
                        $('#createdRows').append('<div class="col-md-12"><label class="col-md-12">Floor <strong style="color:green">  ' + floorArray[x].floorname + '</strong></label>\n\
                                        <label class="col-md-3">Number Of Rooms:</label><input maxlength="10"  required type="text" id="vv-' + floorArray[x].floorid + '"  class="col-md-2"  style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" oninput="checkroomlimit(this);"/><span id="errorxxVk' + floorArray[x].floorid + '"></span></div><hr>');

                    }
                    var Testbay = new Set();
                    for (var i = 0; i < baynumber; i++) {
                        var p = parseInt(i) + 1;
                        var kk = $('#zonelabelsx' + p).val();
                        if (kk !== '') {
                            // document.getElementById('zonelabelsx' + p).style.borderColor = "";
                            $('#errorxx' + p).html(' ');
                            if (Testbay.has(p)) {
                            } else {
                                Testbay.add(p);
                            }
                        } else {
                            console.log('position----' + p + '-----field Empty');
                            $('#errorxx' + p).html('<span class="text-danger">*Field Required</span>');
                            document.getElementById('zonelabelsx' + p).style.borderColor = "red";
                        }
                    }
                    var Testbay = new Set();
                    for (var i = 0; i < baynumber; i++) {
                        var p = parseInt(i) + 1;
                        var kk = $('#zonelabelsx' + p).val();
                        if (kk !== '') {
                            // document.getElementById('zonelabelsx' + p).style.borderColor = "";
                            $('#errorxx' + p).html(' ');
                            if (Testbay.has(p)) {
                            } else {
                                Testbay.add(p);
                            }
                        } else {
                            console.log('position----' + p + '-----field Empty');
                            $('#errorxx' + p).html('<span class="text-danger">*Field Required</span>');
                            document.getElementById('zonelabelsx' + p).style.borderColor = "red";
                        }
                    }
                    if (parseInt(Testbay.size) === parseInt(baynumber)) {
                        nextStepWizard.removeAttr('disabled').trigger('click');
                        Testbay.clear();
                    } else {
                        buildingArray = [];
                    }
                }
            } else if (curStepBtn === 'step-3') {
                $('#step01').addClass('disabled');
                $('#step02').addClass('disabled');
                $('#createdcells').html('');
                for (var r = 0; r < parseInt(floorArray.length); r++) {
                    //x = r + 1;
                    //var id = $('#vv-' + floorArray[r].floorid);
                    var RowNumber = $('#vv-' + floorArray[r].floorid).val();
                    //zonebaysArray[x].zonebaylabel

                    rowNumberArray.push({
                        bayrows: RowNumber,
                        bayrowsid: r,
                        floorid: floorArray[r].floorid
                    });
                }
                var tableData = $('#rowrm').closest('tr')
                        .find('td')
                        .map(function () {
                            return $(this).text();
                        }).get();
                var defaultroom = tableData[2];
                roomLabelsFinalArray.push({
                    BayrowtestArray: defaultroom,
                    bayrowidxxx: 0,
                    bayid: 1,
                    rowidpos: 0
                });
                for (var v in rowNumberArray) {
                    for (var k = 0; k < rowNumberArray[v].bayrows; k++) {
                        var n = k + 1;

                        for (var x in floorArray) {
                            if (parseInt(floorArray[x].floorid) === parseInt(rowNumberArray[v].floorid)) {
                                $('#createdcells').append('<div class="col-md-12"><label class="col-md-12">Room <strong style="color:green">' + floorArray[x].floorname + '-00' + n + '</strong></label>\n\
                                     <label class="col-md-3">Room label:</label><input required type="text" id="room' + floorArray[x].floorid + '-00' + n + '"  class="col-md-2"  style="padding:10px;" onblur="roomLableInputHandler(this)" data-room-label="' + floorArray[x].floorname + '-00' + n + '" data-temp-room-id="' + rowNumberArray[v].bayrowsid + '" data-temp-floor-id="' + rowNumberArray[v].floorid + '" data-temp-k="' + k + '"/><span id="errorxxVkCell' + floorArray[x].floorname + '-00' + n + '--' + rowNumberArray[v].bayrowsid + '-' + k + '" ></span></div><hr>');
                                // var roomlabel =  $('#' + floorArray[x].floorname + '-00' + n + '--' + rowNumberArray[v].bayrowsid + '-' + k + ).val();


//                                roomLabelsFinalArray.push({
//                                    BayrowtestArray: floorArray[x].floorname + '-00' + n,
//                                    bayrowidxxx: rowNumberArray[v].bayrowsid,
//                                    bayid: rowNumberArray[v].floorid,
//                                    rowidpos: k
//                                });

                            }
                        }
                    }

                }
                var TestRow = new Set();
                for (var r = 0; r < parseInt(floorArray.length); r++) {
                    var kRow = $('#vv-' + floorArray[r].floorid).val();
                    var p = floorArray[r].floorid;
                    if (kRow !== '') {
                        // document.getElementById('vv-' + p).style.borderColor = "";
                        $('#errorxxVk' + p).html(' ');
                        if (TestRow.has(p)) {
                        } else {
                            TestRow.add(p);
                        }
                    }  else {
                        console.log('position----' + p + '-----field Empty');
                        $('#errorxxVk' + p).html('<span class="text-danger">*Field Required</span>');
                        document.getElementById('vv-' + p).style.borderColor = "red";
                    }
                }
                if (parseInt(TestRow.size) === parseInt(floorArray.length)) {
                    nextStepWizard.removeAttr('disabled').trigger('click');
                    TestRow.clear();
                } else {
                    rowNumberArray = [];
                }
                //nextStepWizard.removeAttr('disabled').trigger('click');

            } else {
            }
            $(".form-group").removeClass("has-error");
        });

        $('div.setup-panel div a.btn-primary').trigger('click');
        $('.savezone').click(function () {
            $.confirm({
                title: 'Message!',
                content: 'Would You Like To Add more structures?',
                type: 'blue',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $('#step01').addClass('disabled');
                            $('#step02').addClass('disabled');
                            for (var q = 0; q < parseInt(roomLabelsFinalArray.length); q++) {
                                var cellvalue = $('#' + roomLabelsFinalArray[q].BayrowtestArray + '--' + roomLabelsFinalArray[q].bayrowidxxx + '-' + roomLabelsFinalArray[q].rowidpos).val();
                                roomCellsArray.push({
                                    rowcells: cellvalue,
                                    rowlabel: roomLabelsFinalArray[q].BayrowtestArray,
                                    cellid: q,
                                    rowid: roomLabelsFinalArray[q].bayrowidxxx,
                                    rowidx: roomLabelsFinalArray[q].rowidpos
                                });
                            }
                            var TestCell = new Set();
                            for (var q = 0; q < parseInt(roomLabelsFinalArray.length); q++) {
                                var cellVk = $('#' + roomLabelsFinalArray[q].BayrowtestArray + '--' + roomLabelsFinalArray[q].bayrowidxxx + '-' + roomLabelsFinalArray[q].rowidpos).val();
                                var p = roomLabelsFinalArray[q].BayrowtestArray + '--' + roomLabelsFinalArray[q].bayrowidxxx + '-' + roomLabelsFinalArray[q].rowidpos;
                                if (cellVk !== '') {
                                    //  document.getElementById(p).style.borderColor = "";
                                    $('#errorxxVkCell' + p).html(' ');
                                    if (TestCell.has(p)) {
                                    } else {
                                        TestCell.add(p);
                                    }
                                } else {
                                    console.log('position----' + p + '-----field Empty');
                                    $('#errorxxVkCell' + p).html('<span class="text-danger">*Field Required</span>');
                                    document.getElementById(p).style.borderColor = "red";

                                }
                            }
                            if (parseInt(TestCell.size) === parseInt(roomCellsArray.length)) {
                                for (var t in roomCellsArray) {
                                    var z;
                                    var i = 0;
                                    for (z = 1; z <= parseInt(roomCellsArray[t].rowcells); z++) {
                                        //var letter = String.fromCharCode(i);//
                                        var letter = generateLetters(i);
                                        i = i + 1;
                                        Cellsarraytest.push({
                                            celllabel: roomCellsArray[t].rowlabel + '-' + letter,
                                            rowid: roomCellsArray[t].rowid,
                                            rowidpos: roomCellsArray[t].rowidx
                                        });
                                    }
                                }
                                $.ajax({
                                    type: 'GET',
                                    cache: false,
                                    dataType: 'text',
                                    data: {buildings: JSON.stringify(buildingArray), floors: JSON.stringify(floorArray), rooms: JSON.stringify(roomLabelsFinalArray)},
                                    url: "facilityinfrastructure/createbuilding.htm",
                                    success: function (data) {
                                        var response = JSON.parse(data);
                                        var messages = response[0].messages;
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
                                            });

                                        } else {
                                            $('supplierCatalogDialog').html('');
                                            ajaxSubmitData('facilityinfrastructure/building.htm', 'content', '', 'GET');
                                            initDialog('supplierCatalogDialog');
                                        }
                                    }
                                });
                                buildingArray = [];
                                floorArray = [];
                                floorRowsArray = [];
                                roomCellsArray = [];
                                roomLabelsFinalArray = [];
                                Cellsarraytest = [];
                                TestCell.clear();

                            } else {
                                roomCellsArray = [];
                            }


                        }
                    },
                    NO: function () {
                        $('#step01').addClass('disabled');
                        $('#step02').addClass('disabled');
                        for (var q = 0; q < parseInt(roomLabelsFinalArray.length); q++) {
                            var cellvalue = $('#' + roomLabelsFinalArray[q].BayrowtestArray + '--' + roomLabelsFinalArray[q].bayrowidxxx + '-' + roomLabelsFinalArray[q].rowidpos).val();
                            roomCellsArray.push({
                                rowcells: cellvalue,
                                rowlabel: roomLabelsFinalArray[q].BayrowtestArray,
                                cellid: q,
                                rowid: roomLabelsFinalArray[q].bayrowidxxx,
                                rowidx: roomLabelsFinalArray[q].rowidpos
                            });
                        }
                        var TestCell = new Set();
                        for (var q = 0; q < parseInt(roomLabelsFinalArray.length); q++) {
                            var cellVk = $('#' + roomLabelsFinalArray[q].BayrowtestArray + '--' + roomLabelsFinalArray[q].bayrowidxxx + '-' + roomLabelsFinalArray[q].rowidpos).val();
                            var p = roomLabelsFinalArray[q].BayrowtestArray + '--' + roomLabelsFinalArray[q].bayrowidxxx + '-' + roomLabelsFinalArray[q].rowidpos;
                            if (cellVk !== '') {
                                //  document.getElementById(p).style.borderColor = "";
                                $('#errorxxVkCell' + p).html(' ');
                                if (TestCell.has(p)) {
                                } else {
                                    TestCell.add(p);
                                }
                            } else {
                                console.log('position----' + p + '-----field Empty');
                                $('#errorxxVkCell' + p).html('<span class="text-danger">*Field Required</span>');
                                document.getElementById(p).style.borderColor = "red";

                            }
                        }
                        if (parseInt(TestCell.size) === parseInt(roomCellsArray.length)) {
                            for (var t in roomCellsArray) {
                                var z;
                                var i = 0;
                                for (z = 1; z <= parseInt(roomCellsArray[t].rowcells); z++) {
                                    //var letter = String.fromCharCode(i);//
                                    var letter = generateLetters(i);
                                    i = i + 1;
                                    Cellsarraytest.push({
                                        celllabel: roomCellsArray[t].rowlabel + '-' + letter,
                                        rowid: roomCellsArray[t].rowid,
                                        rowidpos: roomCellsArray[t].rowidx
                                    });
                                }
                            }
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {buildings: JSON.stringify(buildingArray), floors: JSON.stringify(floorArray), rooms: JSON.stringify(roomLabelsFinalArray)},
                                url: "facilityinfrastructure/createbuilding.htm",
                                success: function (data) {
                                    var response = JSON.parse(data);
                                    var messages = response[0].messages;
                                    var buildingids = response[0].buildingids;
                                    if (messages.length === 0) {
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Building Created Successfully.',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'top-center'
                                        });
                                        window.location = '#close';
                                        ajaxSubmitData('facilityinfrastructure/manageinfrastructure.htm', 'workpane', '', 'GET');
                                    } else {
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
                                        });

                                    }
                                }
                            });
                            buildingArray = [];
                            floorArray = [];
                            floorRowsArray = [];
                            roomCellsArray = [];
                            roomLabelsFinalArray = [];
                            Cellsarraytest = [];
                            TestCell.clear();

                        } else {
                            roomCellsArray = [];
                        }

                    }
                }
            });

        });


        $('#bayNumber').keyup(function () {
            floorArray = [];
            $('#zonebays').html(' ');
            var baynumber = $('#bayNumber').val();
            var zonek = $('#building').html();
            var xzone = zonek.toUpperCase();
            $('#buildingxx').html(xzone);
            if (parseInt(baynumber) > 20) {
                $.confirm({
                    title: 'Info',
                    content: 'Maximum floor number is 10',
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
                $('#error').html('<span style="color:red">*Enter a valid Floor number.*</span>');
                $('#bayNumber').focus();

            } else if (baynumber === '') {
                $('#error').html('<span style="color:red">*Field Required.*</span>');
                $('#bayNumber').focus();
            } else {
                $('#error').hide();
                $('#listofbays').show();
                for (var i = 0; i < baynumber; i++) {
                    var x = i + 2;
                    $('#zonebays').append('<div class="col-md-12"><label class="col-md-3">Building <strong style="color:green">' + xzone + '</strong>- Floor Label' + x + '</label><input  maxlength="20" required type="text" id="zonelabelsx' + x + '"  class="col-md-3 textvalidatebay"  style="padding:8px;" oninput="checkregex(this)" /><span id="errorxx' + x + '"></span></div><hr>');
                }
            }
        });
    });
    function checkregex(obj){
        var floorlabel = $(obj).val();
        var regex = /^([a-zA-Z])[a-zA-Z_-]*[\w_-]*[\S]$|^([a-zA-Z])[0-9_-]*[\S]$|^[a-zA-Z]*[\S]$/;
        var testname = regex.test(floorlabel);
        if (testname != true) {
            $.confirm({
                            title: 'Info',
                            content: 'Floor format not allowed',
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
                                       $(obj).val('');
                                    }
                                }
                            }
                        });
             $(obj).addClass('error')
            //$(obj).attr("disabled", "disabled");
        }else{
            $(obj).removeClass('error');
        }
        
    }
    function checkroomlimit(obj){
        var roomnumber = $(obj).val();
       if (parseInt(roomnumber) > 20) {
            $.confirm({
                title: 'Info',
                content: 'Maximum number of room is 20',
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
                            $(obj).val('');
                        }
                    }
                }
            });
        }
    }
    function trim(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    function isEmpty(obj) {
        for (var key in obj) {
            if (obj.hasOwnProperty(key))
                return false;
        }
        return true;
    }
    function closemanage() {
        $('#buildingnamezz').val('');
        $('#bayNumber').val('');
        buildingArray = [];
        floorArray = [];
        floorRowsArray = [];
        roomCellsArray = [];
        roomLabelsFinalArray = [];
        Cellsarraytest = [];
        ajaxSubmitData('facilityinfrastructure/manageinfrastructure.htm', 'workpane', '', 'GET');
    }
    function generateLetters(i) {
        var letters = [
            "A", "B", "C", "D", "E", "F",
            "G", "H", "I", "J", "K", "L",
            "M", "N", "O", "P", "Q", "R",
            "S", "T", "U", "V", "W", "X",
            "Y", "Z"
        ];
        if (parseInt(i) < 26) {
            return letters[i];
        }
        var j = parseInt(i) / 26;
        return generateLetters(parseInt(j) - 1) + '' + letters[(parseInt(i) % 26)];

    }

    function editfloornamexx(id) {
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
                    '<input  id="editedFloornamez" type="text" value="' + tableData[0] + '" placeholder="Please Enter Floor Name Here" class="name form-control myform" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                        var name = this.$content.find('.name').val();
                        if (!name) {
                            $('#editedFloornamez').addClass('error');
                            $.alert('Please Enter Floor Name');
                            return false;
                        }
                        $.alert('New Floor Name Is ' + name);
                        var x = document.getElementById('defaultfloorandroombody').rows;
                        var y = x[id].cells;
                        y[0].innerHTML = name;
                    }
                },
                cancel: function () {
                    //close
                }
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
// change default room name
    function editroomnamexxz(id) {
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
                    '<input  id="editedRoomname" type="text" value="' + tableData[2] + '" placeholder="Please Enter Room Name Here" class="name form-control myform" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                        var name = this.$content.find('.name').val();
                        var namecase = name.charAt(0).toUpperCase() + name.substr(1).toLowerCase();
                        if (!namecase) {
                            $('#editedRoomname').addClass('error');
                            $.alert('Please Enter Room Name');
                            return false;
                        }
                        $.alert('New Room Name Is ' + namecase);
                        var x = document.getElementById('defaultfloorandroombody').rows;
                        var y = x[id].cells;
                        y[2].innerHTML = namecase;
                    }
                },
                cancel: function () {
                    //close
                }
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
    function roomLableInputHandler(obj) {
        var data = $(obj);
        var roomLabel = data.val();
        var tempRoomId = data.data('temp-room-id');
        var tempFloorId = data.data('temp-floor-id');
        var k = data.data('temp-k');
        var regex = /[#@!~`"';+=^%$\(\){}\|,<>*&:]/;
        var testname = (roomLabel.match(regex) ? true : false);
      
        if (testname === true) {
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
                        keys: ['enter', 'shift'],
                        action: function () {
                           $(obj).val('');
                        }
                    }
                }
            });
        }else{
        roomLabelsFinalArray.push({
            BayrowtestArray: roomLabel,
            bayrowidxxx: tempRoomId,
            bayid: tempFloorId,
            rowidpos: k
        });
    }
 }
</script>
<%-- 
    Document   : addNewbays
    Created on : May 14, 2018, 4:17:19 PM
    Author     : user
--%>

<!--Add bays-->
<div id="addnewBaYZX">
    <br>
    <div class="col-md-12" id="addnewBayStep1">
        <h2>Add Bays</h2>
        <table style="border:whitesmoke;" class="table table-responsive xv" align="center">
            <tbody>
                <tr>
                    <td></td>                        
                    <td><b>Zone Label</b></td>
                    <td>
                        <div class="form-group">
                            <select class="form-control" id="captureSelectedBay">
                                <option selected=" " disabled=" ">---- Select Zone ----</option>
                                <c:forEach items="${CreatedZone}" var="facZone">
                                    <option value="${facZone.zoneid}-${facZone.zoneName}">${facZone.zoneName}</option>
                                </c:forEach>                        
                            </select>
                        </div> 
                    </td>
                <tr style="display:none;" id="capturebayNumber">
                    <td><div id="errortestv2"></div></td>
                    <td><b><br>Number Of Bays</b></td>
                    <td><input maxlength="2" required type="text" id="bayNumberV2" placeholder="Bay Number" style="padding:5px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" />                                                          
                </tr>                    
            </tbody>
        </table> 
        <span class="hidedisplaycontent" id="zoneNameV2"></span>
        <span class="hidedisplaycontent" id="zoneidV2"></span>
        <hr>
        <div id="zonebaysListV2" class="hidedisplaycontent">
            <h6>List Of Bays</h6><hr>
            <div id="errorbaymsgV2"></div>
            <div id="zonebaysV2" style="max-height: 250px;overflow-y: scroll;"></div>
            <div id="savebaybtn">
                <button type="submit" onclick="savedataV2();" class="btn btn-primary pull-righ"><i class="fa fa-save"></i>&nbsp;Save</button>
            </div>
        </div>
    </div>
    <div id="addnewBayStep2" class="hidedisplaycontent">
        <div id="addnewBayStep2msg"></div>
        <h2>Add Rows</h2>
        <div id="addnewBayListStep2a"></div>
        <div class="modal-footer">
            <button type="submit" class="btn btn-primary pull-right" onclick="addnewBayListStep2abtn()"><i class="fa fa-save"></i>&nbsp;Save</button>
        </div>
    </div> 
    <div id="addnewBayStep3" class="hidedisplaycontent">
        <div id="addnewBayStep3msg"></div>
        <h2>Add Cells</h2>
        <div id="addnewBayListStep3a"></div><br>
        <div class="modal-footer">
            <button type="submit" class="btn btn-success pull-right"  onclick="addnewBayListStep3abtn()">Finish</button>
        </div>
    </div> 
</div>
<script>
    var baylabeLSet = new Set();
    var baylabelTags = new Array();
    var bayscreated = 0;
    $(document).ready(function () {
        $('#captureSelectedBay').change(function () {
            var selectedzone = $(this).val();
            $('#capturebayNumber').show();
            $('#zonebaysListV2').hide();
            var p = new Array();
            p = selectedzone.split('-');
            var zonename = p[1];
            var zoneid = p[0];
            $('#zoneNameV2').html(zonename);
            $('#zoneidV2').html(zoneid);
            $('#bayNumberV2').val('');
            $.ajax({
                type: 'GET',
                cache: false,
                dataType: 'JSON',
                data: {selectedzoneid: zoneid, selectedzonename: zonename},
                url: "localsettigs/checkBaystatus.htm",
                success: function (data, textStatus, jqXHR) {
                    for (var x in data) {
                        if (data.hasOwnProperty(x)) {
                            baylabelTags = data[x].baylabel.split('-');
                            baylabeLSet.add(baylabelTags[1]);
                        }
                    }
                }
            });
        });

        $('#bayNumberV2').keyup(function () {
            $('#zonebaysV2').html('');
            $('#zonebaysListV2').show();
            var baynumber = $(this).val();
            var zoneName = document.getElementById('zoneNameV2').innerHTML;
            bayscreated = baynumber;
            for (var i = 0; i < baynumber; i++) {
                var x = i + 1;
                $('#zonebaysV2').append('<div class="col-md-12"><label class="col-md-3">Zone <strong style="color:green">' + zoneName + '</strong>- Bay Label ' + x + '</label><input  oninput="generateBaysV2(this.id);" maxlength="2" placeholder="Bay label"required type="text" data-id="' + baynumber + '"id="zonelabelsx' + x + '"  class="col-md-3"  style="padding:8px;" onkeydown="return ((event.keyCode >= 65 && event.keyCode <= 90) || event.keyCode == 8);" /><span id="errorxx2' + x + '"></span></div><hr>');
            }
        });
    });
    //functions 
    var createBaysets = new Set();
    var previousvalue = '';
    function generateBaysV2(id) {
        var createbayTag = $('#' + id).val().toUpperCase();
        previousvalue = createbayTag;
        var p = new Array();
        p = id.split('x');
        var baytotal = $('#' + id).attr('data-id');
        if (baylabeLSet.has(createbayTag)) {
            $('#errorbaymsgV2').html('<span style="color:red;">*Error Bay Label ' + createbayTag + ' Already used!!!</span>');
            $('#' + id).focus();
            for (var i = parseInt(p[1]); i < parseInt(baytotal); i++) {
                var n = i + 1;
                $('#' + p[0] + 'x' + n).prop('disabled', true);
            }

        } else {
            $('#errorbaymsgV2').html(' ');
            for (var i = parseInt(p[1]); i < parseInt(baytotal); i++) {
                var n = i + 1;
                $('#' + p[0] + 'x' + n).prop('disabled', false);
                //console.log('----------------'+p[0]+'x'+ n); 
            }
            if (createbayTag !== '') {
                if (createBaysets.has(createbayTag)) {
                    $('#errorbaymsgV2').html('<span style="color:red;">*Error Bay Label ' + createbayTag + ' Already used!!!</span>');
                } else {
                    createBaysets.add(createbayTag);
                }
            }
        }
    }
    var baysname = [];
    var addRowsListdivtest1aRowsArray = [];
    var addCellsListdivtest1aRowsArray = [];
    var addRowsListdivtest1aRowsArrayFinal = [];
    var addCellsListdivtest1aRowsArrayFinal = [];
    var OneRowNameArray = [];
    var OneCellNameArray = [];
    var addCellsListdivtest1aRowsArrayFinalOnBays = [];
    function savedataV2() {
        $('#errortest').html('');
        $('#errorbaymsgV2').html('');
        var id = $('#zoneidV2').html();
        var zonename = $('#zoneNameV2').html();
        for (var i = 1; i <= bayscreated; i++) {
            var baylabell = $('#zonelabelsx' + i).val().toUpperCase();
            if (baylabell !== '') {
                baysname.push({
                    baylabel: zonename + '-' + baylabell,
                    id: i
                });
            } else {
                $('#errorbaymsgV2').html('<span style="color:red;">*Error Bay Label Required!!!</span>');
            }
        }
        var Testbay = new Set();
        for (var i = 0; i < bayscreated; i++) {
            var p = parseInt(i) + 1;
            var kk = $('#zonelabelsx' + p).val();
            if (kk !== '') {
                document.getElementById('zonelabelsx' + p).style.borderColor = "";
                $('#errorxx2' + p).html(' ');
                if (Testbay.has(p)) {
                } else {
                    Testbay.add(p);
                }
            } else {
                console.log('position----' + p + '-----field Empty');
                $('#errorxx2' + p).html('<span class="text-danger">*Field Required</span>');
                document.getElementById('zonelabelsx' + p).style.borderColor = "red";
            }
        }
        if (parseInt(Testbay.size) === parseInt(bayscreated)) {
            console.log(baysname.length + ' ===' + bayscreated);
            if (baysname.length !== 0) {
                $('#errortest').html('');
                $.confirm({
                    title: '',
                    content: 'Do you wish to Add Rows?',
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        Yes: {
                            text: 'Yes',
                            btnClass: 'btn-blue',
                            action: function () {
                                //.log(baysname);
                                $('#addnewBayStep1').hide();
                                $('#addnewBayStep2').show();
                                for (var x in baysname) {
                                    var n = x + 1;
                                    $('#addnewBayListStep2a').append('<div class="col-md-12"><label class="col-md-12">Bay <strong style="color:green">  ' + baysname[x].baylabel + '</strong></label>\n\
                                        <label class="col-md-3">Number Of Rows:</label><input maxlength="2" required type="text" id="createvxrows' + baysname[x].id + '"  class="col-md-2"  style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" /><span id="errorxxvb' + baysname[x].id + '"></span></div><hr>');
                                }
                            }
                        },
                        No: function () {
                            //$.alert('Selected no'); 
                            //generate rows
                            for (var x in baysname) {
                                //var n = x + 1;
                                //console.log(baysname[x].baylabel + '-----' + baysname[x].id);
                                OneRowNameArray.push({
                                    BayrowtestArray: baysname[x].baylabel + '-00' + 1,
                                    bayid: baysname[x].id,
                                    rowid: x
                                });

                            }
                            //generate cells//
                            var letter = generateLetters(0);
                            //var letter = String.fromCharCode(65);
                            for (var p in OneRowNameArray) {
                                OneCellNameArray.push({
                                    celllabel: OneRowNameArray[p].BayrowtestArray + '-' + letter,
                                    rowid: OneRowNameArray[p].rowid
                                });
                            }
                            //console.log(baysname);
                            //console.log(OneRowNameArray);
                            //console.log(OneCellNameArray);
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {zoneid: id, bays: JSON.stringify(baysname), rows: JSON.stringify(OneRowNameArray), cells: JSON.stringify(OneCellNameArray)},
                                url: "localsettigs/addNewBays.htm",
                                success: function (data) {
                                    if (data === 'success') {
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Bays Added Successfully.',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'bottom-center'
                                        });
                                        ajaxSubmitData('localsettigs/manageshelvingtab.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                        window.location = '#close';
                                        //$('#bayslist').show();
                                        //$('#addnewBay').hide();                       


                                    } else {
                                        $.toast({
                                            heading: 'Error',
                                            text: 'An unexpected error occured while trying to add Bays.',
                                            icon: 'error'
                                        });
                                        window.location = '#close';
                                        // $('#bayslist').show();
                                        //  $('#addnewBay').hide();
                                    }
                                }
                            });
                        }
                    }
                });
            } else {
                $('#errortest').html('<span style="color:red;">*Error Bay Number Required!!!</span>');
            }
            Testbay.clear();
        } else {
            baysname = [];
        }

        //console.log(baysname);
    }
    //
    var divtest1count = 0;
    function generateRowsListStep2(id) {
        if (id !== ' ') {
            divtest1count++;
            var rownumber = $('#' + id).val();
            if (rownumber !== '') {
                addRowsListdivtest1aRowsArray.push({
                    bayrows: rownumber,
                    bayrowsid: divtest1count,
                    zonebayid: id
                });
            } else {
                $('#addnewBayStep2msg').html('<span style="color:red;">*Error Some Input Fields are Empty!!!</span>');
            }
        }

    }
    function addnewBayListStep2abtn() {
        var zoneid = $('#zoneidV2').html();
        for (var v in baysname) {
            var rownumber = $('#createvxrows' + baysname[v].id).val();
            /* if (rownumber !== '') {
             
             } else {
             $('#addnewBayStep2msg').html('<span style="color:red;">*Error Some Input Fields are Empty!!!</span>');
             }*/
            addRowsListdivtest1aRowsArray.push({
                bayrows: rownumber,
                bayrowsid: v,
                zonebayid: baysname[v].id
            });
        }
        var TestRow = new Set();
        for (var v in baysname) {
            var kRow = $('#createvxrows' + baysname[v].id).val();
            if (kRow !== '') {
                document.getElementById('createvxrows' + baysname[v].id).style.borderColor = "";
                $('#errorxxvb' + baysname[v].id).html(' ');
                if (TestRow.has(baysname[v].id)) {
                } else {
                    TestRow.add(baysname[v].id);
                }
            } else {
                console.log('position----' + baysname[v].id + '-----field Empty');
                $('#errorxxvb' + baysname[v].id).html('<span class="text-danger">*Field Required</span>');
                document.getElementById('createvxrows' + baysname[v].id).style.borderColor = "red";
            }
        }
        if (parseInt(TestRow.size) === parseInt(baysname.length)) {
            $.confirm({
                title: '',
                content: 'Do you wish to Add Cell?',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    Yes: {
                        text: 'Yes',
                        btnClass: 'btn-blue',
                        action: function () {
                            $('#addnewBayStep2').hide();
                            $('#addnewBayStep3').show();
                            //computation for adding cells displays
                            //console.log(zoneid);
                            //console.log(baysname);
                            // console.log(addRowsListdivtest1aRowsArray);
                            for (var v in addRowsListdivtest1aRowsArray) {
                                for (var k = 0; k < addRowsListdivtest1aRowsArray[v].bayrows; k++) {
                                    var n = k + 1;
                                    for (var x in baysname) {
                                        if (parseInt(baysname[x].id) === parseInt(addRowsListdivtest1aRowsArray[v].zonebayid)) {
                                            $('#addnewBayListStep3a').append('<div class="col-md-12"><label class="col-md-12">Cell <strong style="color:green">' + baysname[x].baylabel + '-00' + n + '</strong></label>\n\
                                                         <label class="col-md-3">Number Of Cells:</label><input maxlength="2" required type="text" id="' + baysname[x].baylabel + '-00' + n + '--' + addRowsListdivtest1aRowsArray[v].bayrowsid + '-' + k + '"  class="col-md-2"  style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" /><span id="errorxxVkCell2' + baysname[x].baylabel + '-00' + n + '--' + addRowsListdivtest1aRowsArray[v].bayrowsid + '-' + k + '"></span></div><hr>');
                                            addRowsListdivtest1aRowsArrayFinal.push({
                                                BayrowtestArray: baysname[x].baylabel + '-00' + n,
                                                bayrowidxxx: addRowsListdivtest1aRowsArray[v].bayrowsid,
                                                bayid: addRowsListdivtest1aRowsArray[v].zonebayid,
                                                rowidpos: k
                                            });
                                        }
                                    }
                                }
                            }
                        }
                    },
                    No: function () {
                        for (var v in addRowsListdivtest1aRowsArray) {
                            for (var k = 0; k < addRowsListdivtest1aRowsArray[v].bayrows; k++) {
                                var n = k + 1;
                                for (var x in baysname) {
                                    if (parseInt(baysname[x].id) === parseInt(addRowsListdivtest1aRowsArray[v].zonebayid)) {
                                        addRowsListdivtest1aRowsArrayFinal.push({
                                            BayrowtestArray: baysname[x].baylabel + '-00' + n,
                                            bayrowidxxx: addRowsListdivtest1aRowsArray[v].bayrowsid,
                                            bayid: addRowsListdivtest1aRowsArray[v].zonebayid,
                                            rowidpos: k
                                        });
                                    }
                                }
                            }
                        }
                        var i = 0;
                        for (var t in addRowsListdivtest1aRowsArrayFinal) {
                            var letter = generateLetters(i);
                            i = i + 1;
                            addCellsListdivtest1aRowsArrayFinalOnBays.push({
                                celllabel: addRowsListdivtest1aRowsArrayFinal[t].BayrowtestArray + '-' + letter,
                                rowid: addRowsListdivtest1aRowsArrayFinal[t].bayrowidxxx,
                                rowidpos: addRowsListdivtest1aRowsArrayFinal[t].rowidpos
                            });
                        }
                        $.ajax({
                            type: 'GET',
                            cache: false,
                            dataType: 'text',
                            data: {zoneid: zoneid, bays: JSON.stringify(baysname), rows: JSON.stringify(addRowsListdivtest1aRowsArrayFinal), cells: JSON.stringify(addCellsListdivtest1aRowsArrayFinalOnBays)},
                            url: "localsettigs/addNewBaysAndRows.htm",
                            success: function (data) {
                                if (data === 'success') {
                                    $.toast({
                                        heading: 'Success',
                                        text: 'Bays Added Successfully.',
                                        icon: 'success',
                                        hideAfter: 2000,
                                        position: 'bottom-center'
                                    });
                                    ajaxSubmitData('localsettigs/manageshelvingtab.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    window.location = '#close';
                                    //$('#bayslist').show();
                                    //$('#addnewBay').hide();                       

                                } else {
                                    $.toast({
                                        heading: 'Error',
                                        text: 'An unexpected error occured while trying to add Bays.',
                                        icon: 'error'
                                    });
                                    window.location = '#close';
                                    // $('#bayslist').show();
                                    //  $('#addnewBay').hide();
                                }
                                addRowsListdivtest1aRowsArrayFinal = [];
                                addCellsListdivtest1aRowsArrayFinalOnBays = [];
                            }
                        });
                    }
                }
            });
            TestRow.clear();
        } else {
            addRowsListdivtest1aRowsArray = [];
        }
    }
    function addnewBayListStep3abtn() {
        var zoneid = $('#zoneidV2').html();
        //modifications kisitu
        for (var q = 0; q < parseInt(addRowsListdivtest1aRowsArrayFinal.length); q++) {
            var cellvalue = $('#' + addRowsListdivtest1aRowsArrayFinal[q].BayrowtestArray + '--' + addRowsListdivtest1aRowsArrayFinal[q].bayrowidxxx + '-' + addRowsListdivtest1aRowsArrayFinal[q].rowidpos).val();
            addCellsListdivtest1aRowsArray.push({
                rowcells: cellvalue,
                rowlabel: addRowsListdivtest1aRowsArrayFinal[q].BayrowtestArray,
                cellid: q,
                rowid: addRowsListdivtest1aRowsArrayFinal[q].bayrowidxxx,
                rowidx: addRowsListdivtest1aRowsArrayFinal[q].rowidpos
            });
            //console.log(cellvalue);
        }

        var TestCell = new Set();
        for (var q = 0; q < parseInt(addRowsListdivtest1aRowsArrayFinal.length); q++) {
            var cellk = $('#' + addRowsListdivtest1aRowsArrayFinal[q].BayrowtestArray + '--' + addRowsListdivtest1aRowsArrayFinal[q].bayrowidxxx + '-' + addRowsListdivtest1aRowsArrayFinal[q].rowidpos).val();
            var p = addRowsListdivtest1aRowsArrayFinal[q].BayrowtestArray + '--' + addRowsListdivtest1aRowsArrayFinal[q].bayrowidxxx + '-' + addRowsListdivtest1aRowsArrayFinal[q].rowidpos;
            if (cellk !== '') {
                document.getElementById(p).style.borderColor = "";
                $('#errorxxVkCell2' + p).html(' ');
                if (TestCell.has(p)) {
                } else {
                    TestCell.add(p);
                }
            } else {
                console.log('position----' + p + '-----field Empty');
                $('#errorxxVkCell2' + p).html('<span class="text-danger">*Field Required</span>');
                document.getElementById(p).style.borderColor = "red";
            }
        }
        if (parseInt(TestCell.size) === parseInt(addCellsListdivtest1aRowsArray.length)) {
            for (var t in addCellsListdivtest1aRowsArray) {
                var z;
                var i = 0;
                for (z = 1; z <= parseInt(addCellsListdivtest1aRowsArray[t].rowcells); z++) {
                    var letter = generateLetters(i);
                    i = i + 1;//
                    //var letter = String.fromCharCode(i);
                    addCellsListdivtest1aRowsArrayFinal.push({
                        celllabel: addCellsListdivtest1aRowsArray[t].rowlabel + '-' + letter,
                        rowid: addCellsListdivtest1aRowsArray[t].rowid,
                        rowidpos: addCellsListdivtest1aRowsArray[t].rowidx
                    });
                }
            }
            $.ajax({
                type: 'GET',
                cache: false,
                dataType: 'text',
                data: {zoneid: zoneid, bays: JSON.stringify(baysname), rows: JSON.stringify(addRowsListdivtest1aRowsArrayFinal), cells: JSON.stringify(addCellsListdivtest1aRowsArrayFinal)},
                url: "localsettigs/addNewBaysRowsAndCells.htm",
                success: function (data) {
                    if (data === 'success') {
                        $.toast({
                            heading: 'Success',
                            text: 'Bays Added Successfully.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                        ajaxSubmitData('localsettigs/manageshelvingtab.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        window.location = '#close';
                        //$('#bayslist').show();
                        //$('#addnewBay').hide();                       

                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'An unexpected error occured while trying to add Bays.',
                            icon: 'error'
                        });
                        window.location = '#close';
                        // $('#bayslist').show();
                        //  $('#addnewBay').hide();
                    }
                }
            });
            TestCell.clear();
        } else {
            addCellsListdivtest1aRowsArray = [];
        }

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
</script>                                    

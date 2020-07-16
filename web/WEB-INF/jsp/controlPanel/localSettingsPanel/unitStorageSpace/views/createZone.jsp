<%-- 
    Document   : createZone
    Created on : Apr 3, 2018, 8:45:20 AM
    Author     : IICSRemote
--%>
<%@include file="../../../../include.jsp" %>
<style>
    .xv  tr td{border: whitesmoke;}
</style>
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

    <form role="form" action="">
        <div class="setup-content" id="step-1">
            <div class="col-xs-6 col-md-offset-3">
                <div class="col-md-12">
                    <h4>Step 1:Create Zone</h4>
                    <div class="form-group">
                        <div id="errorZonemsg"></div>
                        <label class="control-label">Zone Label</label>
                        <input  type="text" id="zonex" required="required" class="form-control" placeholder="Enter Zone Label"/>
                    </div>
                    <div>
                        <button class="btn btn-primary nextBtn btn-lg pull-right" type="button">Next Step</button>
                    </div>                
                </div>
            </div>
        </div>
        <div class="setup-content" id="step-2">
            <div class="col-xs-6 col-md-offset-3">
                <div class="col-md-12">
                    <h4>Step 2:Create Bays</h4>
                    <table style="border:whitesmoke;" class="table table-responsive xv" align="center">
                        <tbody>
                            <tr>
                                <td></td>
                                <td><b>Zone Label</b></td>
                                <td>:<strong id="zone"></strong></td> 
                            </tr>
                            <tr>
                                <td></td>
                                <td><b><br>Storage Mechanism</b></td>
                                <td><select class="form-control" id="sMechanism" required>
                                        <option value="">----- Select Storage Mechanism-------</option>
                                        <c:forEach items="${StorageMechanism}" var="smechanism">
                                            <option value="${smechanism.sMechanismid},${smechanism.sMechanismName}">${smechanism.sMechanismName}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><b><br>Number Of Bays</b></td>
                                <td>:<input   maxlength="2" required type="text" id="bayNumber"  class="col-md-6" placeholder="Enter number of bays" style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" />
                                    <button class="col-md-5 btn btn-primary" id="add_bay">Create bays</button><span id="error"></span></td> 
                            </tr>
                        </tbody>
                    </table>     
                    <div id="listofbays" style="display: none;">
                        <h5>Add New Bays to Zone:<strong  id="zonexx"></strong></h5>
                        <div id="zonebays" style="max-height: 250px;overflow-y: scroll;"></div>
                    </div>
                    <button class="btn btn-primary nextBtn btn-lg pull-right" type="button" >Next Step</button>
                </div>
            </div>
        </div>
        <div class="setup-content" id="step-3">
            <div class="col-xs-6 col-md-offset-3">
                <div class="col-md-12">
                    <h4>Step 3:Create Rows</h4>
                    <div id="createdRows" style="max-height: 500px;overflow-y: scroll;"></div>
                    <button class="btn btn-primary nextBtn btn-lg pull-right" type="button" >Next Step</button>
                </div>
            </div>
        </div>
        <div class="setup-content" id="step-4">
            <div class="col-xs-6 col-md-offset-3">
                <div class="col-md-12">
                    <h4>Step 4:Create Cells</h4>
                    <div id="createdcells" style="max-height: 500px;overflow-y: scroll;"></div>                
                    <button class="btn btn-success savezone btn-lg pull-right" type="button">Finish</button>
                </div>
            </div>
        </div>
    </form>
</fieldset>
<script>
    var zonesArray = [];
    var zonebaysArray = [];
    var baysRowsArray = [];
    var rowCellsArray = [];
    var rowLabelsFinalArray = [];
    var Cellsarraytest = [];
    var rowNumberArray = [];
    $(document).ready(function () {
        $('#step01').addClass('disabled');
        $('#step03').addClass('disabled');
        $('#step02').addClass('disabled');
        $('#step04').addClass('disabled');
        var Existingzone = ${jsonCreatedzone};
        var ExistingZoneNameSet = new Set();
        for (var x in Existingzone) {
            if (Existingzone.hasOwnProperty(x)) {

                ExistingZoneNameSet.add(Existingzone[x].zoneName);
            }
        }
        $('#zonex').on('input', function () {
            var inputzone = $(this).val().toUpperCase();
            // console.log('vvvv---' + inputzone);
            if (ExistingZoneNameSet.has(inputzone)) {
                $('#errorZonemsg').html('<span style="color:red;">*Error Zone ' + inputzone + ' Already Exists!!!</span>');
                $('#zonex').focus();
                $('.nextBtn').hide();
                $('.savezone').hide();
                $('#step02').addClass('disabled');
                $('#step03').addClass('disabled');
                $('#step04').addClass('disabled');
            } else {
                $('#errorZonemsg').html(' ');
                $('.nextBtn').show();
                $('.savezone').show();
            }
        });
        var navListItems = $('div.setup-panel div a'),
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
            var zone = $('#zonex').val();
            if (curStepBtn === 'step-1') {
                $('#step01').addClass('disabled');
                $('#step03').addClass('disabled');
                $('#step04').addClass('disabled');
                $('#listofbays').hide();
                if (!isEmpty(zone)) {
                    $('#zone').html(zone.toUpperCase().replace(/\s+/g, ''));
                    $('#transactionlimit').show();
                    var zonek = zone;
                    zonesArray.push({
                        zoneName: zonek.toUpperCase().replace(/\s+/g, ''),
                        zoneid: 1
                    });
                    nextStepWizard.removeAttr('disabled').trigger('click');
                } else {
                    document.getElementById('zonex').style.borderColor = "red";
                }
            } else if (curStepBtn === 'step-2') {
                $('#step01').addClass('disabled');
                $('#step02').addClass('disabled');
                $('#step04').addClass('disabled');
                $('#createdRows').html('');
                var sMechanism = $('#sMechanism').val();
                var baynumber = $('#bayNumber').val();
                if (!isEmpty(sMechanism) && !isEmpty(baynumber)) {
                    $('.nextBtn').prop('disabled', false);
                    var sMecha = new Array();
                    sMecha = sMechanism.split(',');
                    // console.log(sMecha[1]);           
                    var bzone = zone.toUpperCase().replace(/\s+/g, '');
                    for (var i = 0; i < baynumber; i++) {
                        var x = i + 1;
                        var zonebayname = $('#zonelabelsx' + x).val();
                        var zoneName = bzone + '-' + zonebayname;
                        zonebaysArray.push({
                            zonebaylabel: zoneName.toUpperCase(),
                            zonebayid: x,
                            baymechanism: sMecha[0],
                            zoneid: 1
                        });
                    }
                    for (var x in zonebaysArray) {
                        var n = x + 1;
                        $('#createdRows').append('<div class="col-md-12"><label class="col-md-12">Bay <strong style="color:green">  ' + zonebaysArray[x].zonebaylabel + '</strong></label>\n\
                                        <label class="col-md-3">Number Of Rows:</label><input maxlength="2"  required type="text" id="vv-' + zonebaysArray[x].zonebayid + '"  class="col-md-2"  style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" /><span id="errorxxVk' + zonebaysArray[x].zonebayid + '"></span></div><hr>');

                    } 
                    var Testbay = new Set();
                    for (var i = 0; i < baynumber; i++) {
                         var p = parseInt(i) + 1;
                         var kk = $('#zonelabelsx'+p).val();
                         if(kk !==''){
                            document.getElementById('zonelabelsx'+p).style.borderColor = "";
                            $('#errorxx'+ p).html(' ');
                            if(Testbay.has(p)){                                
                            }else{
                                Testbay.add(p);
                            }                            
                         }else{
                            console.log('position----'+p+'-----field Empty');                            
                            $('#errorxx'+ p).html('<span class="text-danger">*Field Required</span>');
                            document.getElementById('zonelabelsx'+p).style.borderColor = "red";
                         }                         
                    }
                    var Testbay = new Set();
                    for (var i = 0; i < baynumber; i++) {
                        var p = parseInt(i) + 1;
                        var kk = $('#zonelabelsx' + p).val();
                        if (kk !== '') {
                            document.getElementById('zonelabelsx' + p).style.borderColor = "";
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
                        zonebaysArray = [];
                    }
                }
            } else if (curStepBtn === 'step-3') {
                $('#step01').addClass('disabled');
                $('#step02').addClass('disabled');
                $('#createdcells').html('');
                debugger
                for (var r = 0; r < parseInt(zonebaysArray.length); r++) {
                    //x = r + 1;
                    var RowNumber = $('#vv-' + zonebaysArray[r].zonebayid).val();
                    //zonebaysArray[x].zonebaylabel
                    rowNumberArray.push({
                        bayrows: RowNumber,
                        bayrowsid: r,
                        zonebayid: zonebaysArray[r].zonebayid
                    });
                }
                for (var v in rowNumberArray) {
                    for (var k = 0; k < rowNumberArray[v].bayrows; k++) {
                        var n = k + 1;
                        for (var x in zonebaysArray) {
                            if (parseInt(zonebaysArray[x].zonebayid) === parseInt(rowNumberArray[v].zonebayid)) {
                                $('#createdcells').append('<div class="col-md-12"><label class="col-md-12">Cell <strong style="color:green">' + zonebaysArray[x].zonebaylabel + '-00' + n + '</strong></label>\n\
                                     <label class="col-md-3">Number Of Cells:</label><input maxlength="2" required type="text" id="' + zonebaysArray[x].zonebaylabel + '-00' + n + '--' + rowNumberArray[v].bayrowsid + '-' + k + '"  class="col-md-2"  style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" /><span id="errorxxVkCell' + zonebaysArray[x].zonebaylabel + '-00' + n + '--' + rowNumberArray[v].bayrowsid + '-' + k + '"></span></div><hr>');
                                rowLabelsFinalArray.push({
                                    BayrowtestArray: zonebaysArray[x].zonebaylabel + '-00' + n,
                                    bayrowidxxx: rowNumberArray[v].bayrowsid,
                                    bayid: rowNumberArray[v].zonebayid,
                                    rowidpos: k
                                });
                            }
                        }
                    }

                }
                var TestRow = new Set();
                for (var r = 0; r < parseInt(zonebaysArray.length); r++) {
                    var kRow = $('#vv-' + zonebaysArray[r].zonebayid).val();
                    var p = zonebaysArray[r].zonebayid;
                    if (kRow !== '') {
                        document.getElementById('vv-' + p).style.borderColor = "";
                        $('#errorxxVk' + p).html(' ');
                        if (TestRow.has(p)) {
                        } else {
                            TestRow.add(p);
                        }
                    } else {
                        console.log('position----' + p + '-----field Empty');
                        $('#errorxxVk' + p).html('<span class="text-danger">*Field Required</span>');
                        document.getElementById('vv-' + p).style.borderColor = "red";
                    }
                }
                if (parseInt(TestRow.size) === parseInt(zonebaysArray.length)) {
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
            $('#step01').addClass('disabled');
            $('#step02').addClass('disabled');
            for (var q = 0; q < parseInt(rowLabelsFinalArray.length); q++) {
                var cellvalue = $('#' + rowLabelsFinalArray[q].BayrowtestArray + '--' + rowLabelsFinalArray[q].bayrowidxxx + '-' + rowLabelsFinalArray[q].rowidpos).val();
                rowCellsArray.push({
                    rowcells: cellvalue,
                    rowlabel: rowLabelsFinalArray[q].BayrowtestArray,
                    cellid: q,
                    rowid: rowLabelsFinalArray[q].bayrowidxxx,
                    rowidx: rowLabelsFinalArray[q].rowidpos
                });
            }
            var TestCell = new Set();
            for (var q = 0; q < parseInt(rowLabelsFinalArray.length); q++) {
                var cellVk = $('#' + rowLabelsFinalArray[q].BayrowtestArray + '--' + rowLabelsFinalArray[q].bayrowidxxx + '-' + rowLabelsFinalArray[q].rowidpos).val();
                var p = rowLabelsFinalArray[q].BayrowtestArray + '--' + rowLabelsFinalArray[q].bayrowidxxx + '-' + rowLabelsFinalArray[q].rowidpos;
                if (cellVk !== '') {
                    document.getElementById(p).style.borderColor = "";
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
            if (parseInt(TestCell.size) === parseInt(rowCellsArray.length)) {
                for (var t in rowCellsArray) {
                    var z;
                    var i = 0;
                    for (z = 1; z <= parseInt(rowCellsArray[t].rowcells); z++) {
                        //var letter = String.fromCharCode(i);//
                        var letter = generateLetters(i);
                        i = i + 1;
                        Cellsarraytest.push({
                            celllabel: rowCellsArray[t].rowlabel + '-' + letter,
                            rowid: rowCellsArray[t].rowid,
                            rowidpos: rowCellsArray[t].rowidx
                        });
                    }
                }
                $.ajax({
                    type: 'GET',
                    cache: false,
                    dataType: 'text',
                    data: {zones: JSON.stringify(zonesArray), bays: JSON.stringify(zonebaysArray), rows: JSON.stringify(rowLabelsFinalArray), cells: JSON.stringify(Cellsarraytest)},
                    url: "localsettigs/createZones.htm",
                    success: function (data) {
                        if (data === 'success') {
                            $.toast({
                                heading: 'Success',
                                text: 'Zone Created Successfully.',
                                icon: 'success',
                                hideAfter: 2000,
                                position: 'bottom-center'
                            });
                            window.location = '#close';
                            ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        } else {
                            $.toast({
                                heading: 'Error',
                                text: 'An unexpected error occured while trying to Create Zone.',
                                icon: 'error'
                            });
                            window.location = '#close';
                        }
                    }
                });
                zonesArray = [];
                zonebaysArray = [];
                baysRowsArray = [];
                rowCellsArray = [];
                rowLabelsFinalArray = [];
                Cellsarraytest = [];
                TestCell.clear();

            } else {
                rowCellsArray = [];
            }
        });

        $('#add_bay').prop('disabled', true);
        $('#bayNumber').keyup(function () {
            zonebaysArray = [];
            $('#zonebays').html(' ');
            var baynumber = $('#bayNumber').val();
            var zonek = $('#zone').html();
            var xzone = zonek.toUpperCase();
            $('#zonexx').html(xzone);
            if (parseInt(baynumber) === 0 || parseInt(baynumber) === 00) {
                $('#error').html('<span style="color:red">*Enter a valid Bay number.*</span>');
                $('#bayNumber').focus();

            } else if (baynumber === '') {
                $('#error').html('<span style="color:red">*Field Required.*</span>');
                $('#bayNumber').focus();
            } else {
                $('#error').hide();
                $('#listofbays').show();
                for (var i = 0; i < baynumber; i++) {
                    var x = i + 1;
                    $('#zonebays').append('<div class="col-md-12"><label class="col-md-3">Zone <strong style="color:green">' + xzone + '</strong>- Bay Label ' + x + '</label><input   maxlength="2" required type="text" id="zonelabelsx' + x + '"  class="col-md-3 textvalidatebay"  style="padding:8px;" onkeydown="return ((event.keyCode >= 65 && event.keyCode <= 90) || event.keyCode == 8);" /><span id="errorxx' + x + '"></span></div><hr>');
                }
            }
        });
        // var zonecheck = $('#zonex').val();
    });
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
        $('#zonex').val('');
        $("#sMechanism option:selected").prop("selected", false);
        $('#bayNumber').val('');
        zonesArray = [];
        zonebaysArray = [];
        baysRowsArray = [];
        rowCellsArray = [];
        rowLabelsFinalArray = [];
        Cellsarraytest = [];
        ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
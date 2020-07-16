<%-- 
    Document   : multiplezones
    Created on : Apr 30, 2018, 7:20:01 PM
    Author     : IICSRemote
--%>
<%@include file="../../../../include.jsp" %>
<style>
    .xv tr td{border: whitesmoke;}
    #zonesequence{font-size: 1.3em;color:whitesmoke;background:#8B008B;padding: 4px;}
</style>
<fieldset id="pageReloadxv" >
    <span id="counttotal" class="hidedisplaycontent"></span>
    <legend align="center" id="zonesequence">Zone  <span id="incrementcount">1</span> of <span id="totalnumber"></span></legend>
    <div id="vvv">
        <div class="stepwizard col-md-offset-3">
            <div class="stepwizard-row setup-panel2">
                <div class="stepwizard-step">
                    <a href="#step1" type="button" class="btn btn-primary btn-circle" id="step001">1</a>
                    <p>Step 1</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step2" type="button" class="btn btn-default btn-circle" id="step002">2</a>
                    <p>Step 2</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step3" type="button" class="btn btn-default btn-circle" id="step003">3</a>
                    <p>Step 3</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step4" type="button" class="btn btn-default btn-circle" id="step004">4</a>
                    <p>Step 4</p>
                </div>
            </div>
        </div>
        <form role="form" action="">
            <div class="setup-content2" id="step1">
                <div class="col-xs-6 col-md-offset-3">
                    <div class="col-md-12">
                        <h4>Step 1:Create Zone</h4>
                        <div class="form-group">
                            <div id="errorZonemsgNew"></div>
                            <label class="control-label">Zone Label</label>
                            <input  type="text" id="zonexNew" required="required" class="form-control" placeholder="Enter Zone Label" autofocus="autofocus"/>
                        </div>
                        <button class="btn btn-primary nextBtn2 btn-lg pull-right" type="button">Next Step</button>
                    </div>
                </div>
            </div>
            <div class="setup-content2" id="step2">
                <div class="col-xs-6 col-md-offset-3">
                    <div class="col-md-12">
                        <h4>Step 2:Create Bays</h4>
                        <table style="border:whitesmoke;" class="table table-responsive xv" align="center">
                            <tbody>
                                <tr>
                                    <td></td>
                                    <td><b>Zone Label</b></td>
                                    <td>:<strong id="zone2"></strong></td> 
                                </tr>
                                <tr>
                                    <td></td>
                                    <td><b><br>Storage Mechanism</b></td>
                                    <td><select class="form-control" id="sMechanism2" required>
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
                                    <td>:<input   maxlength="2" required type="text" id="bayNumber2" onkeyup="getbayNumber2(this.id)"  class="col-md-6" placeholder="Enter number of bays" style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" />
                                        <button class="col-md-5 btn btn-primary" id="add_bay2">Create bays</button><span id="error2"></span></td> 
                                </tr>
                            </tbody>
                        </table>     
                        <div id="listofbays2" style="display: none;">
                            <hr><h5>Add New Bays to Zone:<strong  id="zonexx2"></strong></h5><hr>
                            <div id="zonebays2" style="max-height: 250px;overflow-y: scroll;"></div>
                        </div>
                        <button class="btn btn-primary nextBtn2 btn-lg pull-right" type="button" >Next Step</button>
                    </div>
                </div>
            </div>
            <div class="setup-content2" id="step3">
                <div class="col-xs-6 col-md-offset-3">
                    <div class="col-md-12">
                        <h4>Step 3:Create Rows</h4>
                        <div id="createdRows2" style="max-height: 500px;overflow-y: scroll;"></div>
                        <button class="btn btn-primary nextBtn2 btn-lg pull-right" type="button" >Next Step</button>
                    </div>
                </div>
            </div>
            <div class="setup-content2" id="step4">
                <div class="col-xs-6 col-md-offset-3">
                    <div class="col-md-12">
                        <h4>Step 4:Create Cells</h4>
                        <div id="createdcells2" style="max-height: 500px;overflow-y: scroll;"></div>
                        <button class="btn btn-success savezone2 btn-lg pull-right" type="button">Finish</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</fieldset>
<script>
    var zonesArray = [];
    var zonebaysArray = [];
    var baysRowsArray = [];
    var rowCellsArray = [];
    var rowLabelsFinalArray = [];
    var rowNumberArray = [];
    var Cellsarraytest = [];
    var ExistingZoneNameSet = new Set();
    $(document).ready(function () {
        $('#step001').addClass('disabled');
        $('#step002').addClass('disabled');
        $('#step003').addClass('disabled');
        $('#step004').addClass('disabled');
        var Existingzone = ${jsonCreatedzone};
        for (var x in Existingzone) {
            if (Existingzone.hasOwnProperty(x)) {
                ExistingZoneNameSet.add(Existingzone[x].zoneName);
            }
        }
        $('#zonexNew').keyup(function () {
            var inputzone2 = $(this).val().toUpperCase();
            // console.log('vvvv---' + inputzone2);
            if (ExistingZoneNameSet.has(inputzone2)) {
                $('#errorZonemsgNew').html('<span style="color:red;">*Error Zone ' + inputzone2 + ' Already Exists!!!</span>');
                $('#zonexNew').focus();
                $('.nextBtn').hide();
                $('.savezone').hide();
                $('#step002').addClass('disabled');
                $('#step003').addClass('disabled');
                $('#step004').addClass('disabled');
            } else {
                $('#errorZonemsgNew').html(' ');
                $('.nextBtn').show();
                $('.savezone').show();
            }
        });
        var navListItems2 = $('div.setup-panel2 div a'),
                allWells2 = $('.setup-content2'),
                allNextBtn2 = $('.nextBtn2');

        allWells2.hide();
        navListItems2.click(function (e) {
            e.preventDefault();
            var $target2 = $($(this).attr('href')),
                    $item2 = $(this);
            navListItems2.removeClass('btn-primary').addClass('btn-default');
            $item2.addClass('btn-primary');
            allWells2.hide();
            $target2.show();
            $target2.find('input:eq(0)').focus();

        });
        allNextBtn2.click(function () {
            var curStep2 = $(this).closest(".setup-content2"),
                    curStepBtn2 = curStep2.attr("id"),
                    nextStepWizard = $('div.setup-panel2 div a[href="#' + curStepBtn2 + '"]').parent().next().children("a");

            var zone = $('#zonexNew').val();
            console.log(curStepBtn2);
            if (curStepBtn2 === 'step1') {
                $('#step001').addClass('disabled');
                $('#step003').addClass('disabled');
                $('#step004').addClass('disabled');
                $('#listofbays2').hide();
                if (!isEmpty(zone)) {
                    $('#zone2').html(zone.toUpperCase().replace(/\s+/g, ''));
                    $('#transactionlimit2').show();
                    var zonek = zone;
                    zonesArray.push({
                        zoneName: zonek.toUpperCase().replace(/\s+/g, ''),
                        zoneid: 1
                    });
                    nextStepWizard.removeAttr('disabled').trigger('click');
                } else {
                    document.getElementById('zonexNew').style.borderColor = "red";
                }
                //console.log(zonesArray);
            } else if (curStepBtn2 === 'step2') {
                $('#step001').addClass('disabled');
                $('#step002').addClass('disabled');
                $('#step004').addClass('disabled');
                $('#createdRows2').html('');
                var sMechanism = $('#sMechanism2').val();
                var baynumber = $('#bayNumber2').val();
                if (!isEmpty(sMechanism) && !isEmpty(baynumber)) {
                    var sMecha = new Array();
                    sMecha = sMechanism.split(',');
                    // console.log(sMecha[1]);           
                    var bzone = zone.toUpperCase().replace(/\s+/g, '');
                    for (var i = 0; i < baynumber; i++) {
                        var x = i + 1;
                        var zonebayname = $('#zonelabelsx2' + x).val();
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
                        $('#createdRows2').append('<div class="col-md-12"><label class="col-md-12">Bay <strong style="color:green"> ' + zonebaysArray[x].zonebaylabel + '</strong></label>\n\
                                        <label class="col-md-3">Number Of Rows:</label><input maxlength="2" required type="text" id="xx-' + zonebaysArray[x].zonebayid + '"  class="col-md-2"  style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" /><span id="errorxxVk2' + zonebaysArray[x].zonebayid + '"></span></div><hr>');
                    }

                    //nextStepWizard.removeAttr('disabled').trigger('click');
                    var Testbay = new Set();
                    for (var i = 0; i < baynumber; i++) {
                         var p = parseInt(i) + 1;
                         var kk = $('#zonelabelsx2'+p).val();
                         if(kk !==''){
                            document.getElementById('zonelabelsx2'+p).style.borderColor = "";
                            $('#errorxx2'+ p).html(' ');
                            if(Testbay.has(p)){                                
                            }else{
                                Testbay.add(p);
                            }                            
                         }else{
                            console.log('position----'+p+'-----field Empty');                            
                            $('#errorxx2'+ p).html('<span class="text-danger">*Field Required</span>');
                            document.getElementById('zonelabelsx2'+p).style.borderColor = "red";
                         }                         
                    }
                     if(parseInt(Testbay.size)=== parseInt(baynumber)){
                         nextStepWizard.removeAttr('disabled').trigger('click');
                         Testbay.clear();
                     }else{
                         zonebaysArray =[];
                     }  

                }
            } else if (curStepBtn2 === 'step3') {
                $('#step001').addClass('disabled');
                $('#step002').addClass('disabled');
                $('#createdcells2').html('');
                for (var r = 0; r < parseInt(zonebaysArray.length); r++) {
                    var RowNumber = $('#xx-' + zonebaysArray[r].zonebayid).val();
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
                                $('#createdcells2').append('<div class="col-md-12"><label class="col-md-12">Cell <strong style="color:green">' + zonebaysArray[x].zonebaylabel + '-00' + n + '</strong></label>\n\
                                            <label class="col-md-3">Number Of Cells:</label><input maxlength="2" required type="text" id="' + zonebaysArray[x].zonebaylabel + '-00' + n + '--' + rowNumberArray[v].bayrowsid + '-' + k + '"  class="col-md-2"  style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" /><span id="errorxxVkCell2' + zonebaysArray[x].zonebaylabel + '-00' + n + '--' + rowNumberArray[v].bayrowsid + '-' + k + '"></span></div><hr>');
                                /*Bayrowtest.push({
                                 BayrowtestArray: zonebaysArray[x].zonebaylabel + '-00' + n,
                                 bayrowidxxx: baysRowsArray[v].bayrowsid,
                                 bayid: baysRowsArray[v].zonebayid,
                                 rowidpos: k
                                 });*/
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
                    var RowNumberk = $('#xx-' + zonebaysArray[r].zonebayid).val();
                    var p = zonebaysArray[r].zonebayid;
                    if (RowNumberk !== '') {
                        document.getElementById('xx-' + p).style.borderColor = "";
                        $('#errorxxVk2' + p).html(' ');
                        if (TestRow.has(p)) {
                        } else {
                            TestRow.add(p);
                        }
                    } else {
                        console.log('position----' + p + '-----field Empty');
                        $('#errorxxVk2' + p).html('<span class="text-danger">*Field Required</span>');
                        document.getElementById('xx-' + p).style.borderColor = "red";
                    }
                }
                if (parseInt(TestRow.size) === parseInt(zonebaysArray.length)) {
                    nextStepWizard.removeAttr('disabled').trigger('click');
                    TestRow.clear();
                } else {
                    rowNumberArray = [];
                }
            } else {
            }
            $(".form-group").removeClass("has-error");
        });
        $('div.setup-panel2 div a.btn-primary').trigger('click');
        $('.savezone2').click(function () {
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
            if(parseInt(TestCell.size) === parseInt(rowCellsArray.length)){
                            for (var t in rowCellsArray) {
                var z;
                var i = 0;
                for (z = 1; z <= parseInt(rowCellsArray[t].rowcells); z++) {
                    var letter = generateLetters(i);
                    i = i + 1;
                    // var letter = String.fromCharCode(i);
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
                dataType: 'JSON',
                data: {zones: JSON.stringify(zonesArray), bays: JSON.stringify(zonebaysArray), rows: JSON.stringify(rowLabelsFinalArray), cells: JSON.stringify(Cellsarraytest)},
                url: "localsettigs/createZones.htm",
                success: function (data) {
                }
            });
            var totalnum = $('#counttotal').html();
            var total_all = $('#totalnumber').html();
            // console.log('--num-----'+totalnum);
            // checkcount(totalnum);
            //var countx = $('#incrementcount').html();
            var countx = $('#incrementcount').html();
            var cstep = parseInt(countx) + 1;
            if (parseInt(cstep) === parseInt(total_all)) {
                $('#incrementcount').html(total_all);
                // console.log(total_all + ' of ' + total_all);
            } else {
                //var updatecount = totalnumx - 1;
                $('#incrementcount').html(cstep);
                // console.log(cstep + '  of ***' + total_all);
            }
            var test = parseInt(totalnum) - 1;
            if (parseInt(test) > 0) {
                $('#counttotal').html(test);
                var inputname = $('#zonexNew').val().toUpperCase();
                //console.log(inputname);
                ExistingZoneNameSet.add(inputname);
                //console.log(ExistingZoneNameSet);
                var nextStepWz = $('div.setup-panel2 div a[href="#step1"]').parent().children("a");
                nextStepWz.removeAttr('disabled').trigger('click');
                //fields to clear
                $('#zonexNew').val('');
                $("#sMechanism2 option:selected").prop("selected", false);
                $('#bayNumber2').val('');
                zonesArray = [];
                zonebaysArray = [];
                baysRowsArray = [];
                rowCellsArray = [];
                rowNumberArray = [];
                rowLabelsFinalArray = [];
                Cellsarraytest = [];
            } else if (parseInt('0') === parseInt(test)) {
                window.location = '#close';
                ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                zonesArray = [];
                zonebaysArray = [];
                baysRowsArray = [];
                rowNumberArray = [];
                rowCellsArray = [];
                rowLabelsFinalArray = [];
                Cellsarraytest = [];
            } else {
                window.location = '#close';
                ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                zonesArray = [];
                zonebaysArray = [];
                baysRowsArray = [];
                rowCellsArray = [];
                rowNumberArray = [];
                rowLabelsFinalArray = [];
                Cellsarraytest = [];
            }
            }else{
                rowCellsArray = [];
            }


        });
        $('#add_bay2').prop('disabled', true);
    });
    function getbayNumber2(id) {
        zonebaysArray = [];
        $('#zonebays2').html(' ');
        var baynumber = $('#' + id).val();
        var zonek = $('#zone2').html();
        var xzone = zonek.toUpperCase();
        $('#zonexx2').html(xzone);
        if (parseInt(baynumber) === 0 || parseInt(baynumber) === 00) {
            $('#error2').html('<span style="color:red">*Enter a valid Bay number.*</span>');
            $('#' + id).focus();

        } else if (baynumber === '') {
            $('#error2').html('<span style="color:red">*Field Required.*</span>');
            $('#' + id).focus();
        } else if ((baynumber !== '') && (parseInt(baynumber) !== 0)) {
            $('#error2').hide();
            $('#listofbays2').show();
            for (var i = 0; i < baynumber; i++) {
                var x = i + 1;
                $('#zonebays2').append('<div class="col-md-12"><label class="col-md-3">Zone <strong style="color:green">' + xzone + '</strong>- Bay Label ' + x + '</label><input   maxlength="2" required type="text" id="zonelabelsx2' + x + '"  class="col-md-3"  style="padding:8px;" onkeydown="return ((event.keyCode >= 65 && event.keyCode <= 90) || event.keyCode == 8);" /><span id="errorxx2' + x + '"></span></div><hr>');
            }
        }
    }
    function checkcount(totalnumx) {
        var test = totalnumx - 1;
        if (parseInt(test) > 0) {
            $('#totalnumber').html(test);
            var inputname = $('#zonexNew').val().toUpperCase();
            //console.log(inputname);
            ExistingZoneNameSet.add(inputname);
            //console.log(ExistingZoneNameSet);
            var nextStepWz = $('div.setup-panel2 div a[href="#step1"]').parent().children("a");
            nextStepWz.removeAttr('disabled').trigger('click');
            //fields to clear
            $('#zonexNew').val('');
            $("#sMechanism2 option:selected").prop("selected", false);
            $('#bayNumber2').val('');
            zonesArray = [];
            zonebaysArray = [];
            baysRowsArray = [];
            rowCellsArray = [];
            rowNumberArray = [];
            rowLabelsFinalArray = [];
            Cellsarraytest = [];
        } else if (parseInt('0') === parseInt(test)) {
            window.location = '#close';
            ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            zonesArray = [];
            zonebaysArray = [];
            baysRowsArray = [];
            rowCellsArray = [];
            rowNumberArray = [];
            rowLabelsFinalArray = [];
            Cellsarraytest = [];
        } else {
            window.location = '#close';
            ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            zonesArray = [];
            zonebaysArray = [];
            baysRowsArray = [];
            rowCellsArray = [];
            rowNumberArray = [];
            rowLabelsFinalArray = [];
            Cellsarraytest = [];
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
        $('#zonexNew').val('');
        $("#sMechanism2 option:selected").prop("selected", false);
        $('#bayNumber2').val('');
        zonesArray = [];
        zonebaysArray = [];
        baysRowsArray = [];
        rowCellsArray = [];
        rowNumberArray = [];
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
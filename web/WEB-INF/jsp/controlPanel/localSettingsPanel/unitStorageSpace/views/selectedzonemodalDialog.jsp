<%-- 
    Document   : selectmodalDialog
    Created on : Apr 10, 2018, 3:03:29 PM
    Author     : IICSRemote
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<style>
    .xv td{border: whitesmoke;}
</style>
<div class="row">
    <div class="col-md-12">
        <div id="managebaydialogxxx" class="modalDialogShelve">
            <c:if test="${divtest == 1}">
                <div class="container">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Manage Registered Bay</h2>
                        <hr>
                    </div>
                    <div class="scrollbar tile" id="content">
                        <div class="tile">
                            <div>
                                <button class="btn btn-secondary" id="backtobays" style="display: none;"><i class="fa fa-arrow-left"></i>&nbsp;Back</button>
                                <button class="btn btn-primary pull-right" id="addbayz"><i class="fa fa-plus-circle"></i>&nbsp;Add Bay</button>
                            </div>
                            <!--Add bays-->
                            <div id="addnewBay" style="display: none;">
                                <br>
                                <div class="col-md-12">
                                    <h5>Add Bays</h5><hr>
                                    <table style="border:whitesmoke;" class="table table-responsive xv" align="center">
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td><b>Zone Label</b></td>
                                                <td><strong id="zoneV" style="color:green">${selectedbayMap.zonelabel}</strong></td> 
                                            </tr>                                                    
                                            <tr>
                                                <td> <div id="error"></div><div id="errortest"></div></td>
                                                <td><b><br>Number Of Bays</b></td>
                                                <td><input maxlength="2" required type="text" id="bayNumberV" placeholder="Bay Number" style="padding:5px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" />                                                          
                                            </tr>
                                        </tbody>
                                    </table> 
                                    <div id="zonebaysListV" class="hidedisplaycontent">
                                        <div id="errorbaymsg"></div>
                                        <div id="zonebaysV" style="max-height: 250px;overflow-y: scroll;"></div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" onclick="savedata(this.id);" class="btn btn-primary" id="${selectedbayMap.zoneid}"><i class="fa fa-save"></i>&nbsp;Save</button>
                                </div>
                            </div>
                            <div id="bayslist">
                                <div class="row">
                                    <h5>List of Bays in Zone &nbsp;<h5 id="zoneTitle">${selectedbayMap.zonelabel}</h5> </h5>
                                </div><br>
                                <div class="tile-body" id="">
                                    <table class="table table-hover table-bordered" id="sampleTable">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>Bay Label</th>
                                                <th>Add Rows</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% int j = 1;%>
                                            <c:forEach items="${selectedbayDetails}" var="a">
                                                <tr id="">
                                                    <td><%=j++%></td>
                                                    <td align="center">${a.baylabel2}</td>
                                                    <td align="center">
                                                        <button  class="btn btn-sm btn-secondary" data-lastrecord="${a.lastRowrecord}" data-id="${a.baylabel}" onclick="ShowRowscapture(${a.zonebayid}, $(this).attr('data-id'), $(this).attr('data-lastrecord'))"><i class="fa fa-fw fa-lg fa-plus-circle"></i></button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table> 
                                </div>
                                <div class="modal-footer">
                                    <!--<button type="button" class="btn btn-secondary" id="printbaylabels" disabled="disabled"><i class="fa fa-print"></i> Print</button>-->
                                </div>
                            </div>
                            <!--Sub Sections --1--Starts--->
                            <div id="addRowsListdivtest1" class="hidedisplaycontent">
                                <div id="erroraddRowsListdivtest1amsg"></div>
                                <div id="addRowsListdivtest1a"></div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-sm btn-primary pull-right" id="${selectedbayMap.zoneid}" onclick="addRowsListdivtest1abtn(this.id)"><i class="fa fa-save"></i>&nbsp;Save</button>
                                </div>
                            </div>   
                            <div id="addCellListdivtest1" class="hidedisplaycontent">
                                <div id="erroraddCellListdivtest1amsg"></div>
                                <div id="addCellListdivtest1a"></div><br>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-sm btn-success pull-right" id="${selectedbayMap.zoneid}" onclick="addCellListdivtest1abtn(this.id)">Finish</button>
                                </div>
                            </div> 
                            <!--Sub Sections --1-- Ends--->
                            <!--Add more Rows -->
                            <div id="addRowsList" class="hidedisplaycontent">
                                <div class="col-md-12">
                                    <button class="btn btn-sm btn-secondary" onclick="addbackMain()"><i class="fa fa-arrow-left"></i>&nbsp;Back</button>
                                    <h5>Add Rows</h5><hr>
                                    <table style="border:whitesmoke;" class="table table-responsive xv" align="center">
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td><b>Bay Label</b></td>
                                                <td>:<strong id="rowVx" style="color:green"></strong></td> 
                                            </tr>                                                    
                                            <tr>
                                                <td> <div id="errorVx"></div></td>
                                                <td><b><br>Number Of Rows</b></td>
                                                <td>:<input   maxlength="2" required type="text" id="rowNumberVx" placeholder="Row Number" style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" />
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="modal-footer">
                                        <span id="zonebayid" class="hidedisplaycontent"></span>
                                        <button type="submit" class="btn btn-sm btn-primary" id="addRows"><i class="fa fa-save"></i>&nbsp;Save</button>
                                    </div>
                                </div>
                            </div>
                            <!--Sub Sections --2--Starts--->
                            <div id="addRows2Listdivtest1" class="hidedisplaycontent">
                                <div id="erroraddRows2Listdivtest1amsg"></div>
                                <span id="lstrows" class="hidedisplaycontent"></span>
                                <span id="zonebayidsubSection2" class="hidedisplaycontent"></span>  
                                <strong id="rowLastlabel"></strong>
                                <div id="addRows2Listdivtest1a"></div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-success pull-right"onclick="addRows2Listdivtest1abtn()">Finish</button>
                                </div>
                            </div>   
                            <!--Sub Sections --2-- Ends--->
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${divtest == 2}">
                <div class="container">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Manage Registered Rows</h2>
                        <hr>
                    </div>
                    <div class="scrollbar tile" id="content">  
                        <div class="tile">
                            <div id="BayShowtestList">
                                <div class="row">
                                    <h5>Number of Rows in zone&nbsp;<h5 id="zoneTitle">${selectedrowMap.zonelabel}</h5> </h5>
                                </div>
                                <div class="tile-body" id="">
                                    <table class="table table-hover table-bordered" id="sampleTable">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th class="center">Bay Label</th>
                                                <th class="center">No.of Rows</th>
                                                <th class="center">View Rows</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% int k = 1;%>
                                            <c:forEach items="${bayListinZone}" var="by">
                                                <tr>
                                                    <td><%=k++%></td>
                                                    <td class="center">${by.baylabel2}</td>
                                                    <td class="center"><button class="btn btn-sm btn-primary btn-circle">${by.rowcount}</button></td>
                                                    <td class="center"><button class="btn btn-sm btn-primary" id="${by.zonebayid}" data-name="${by.baylabel2}" onclick="showbayrows(this.id, $(this).attr('data-name'))"><i class="fa fa-fw fa-lg fa-dedent"></i></button></td>
                                                </tr>
                                            </c:forEach>                                          
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div id="showRows" class="hidedisplaycontent">                                 
                                <div class="row">
                                    <h5>List of Rows in Bay&nbsp; <h5 id="selectRowName"></h5><h5 id="zoneTitle" class="hidedisplaycontent">${selectedrowMap.zonelabel}</h5> </h5>
                                </div>
                                <div id="rowLists">
                                    <button class="btn btn-secondary pull-right" onclick="backtoBayShowtestList()"><i class="fa fa-arrow-left"></i>&nbsp;Back</button><br><br>                            
                                    <div class="tile-body" id="">
                                        <div id="showbayselectTableRowsList"></div>
                                    </div>
                                    <div class="modal-footer">
                                        <!--<button type="button" class="btn btn-secondary" id="printrowLabels" disabled="disabled"><i class="fa fa-print"></i> Print</button>-->
                                    </div>
                                </div>                                
                            </div>
                            <!--Add more Cells -->
                            <div id="addCellsList" class="hidedisplaycontent">
                                <div class="col-md-12">
                                    <button class="btn btn-secondary pull-right" onclick="addbackMain2()"><i class="fa fa-arrow-left"></i>&nbsp;Back</button><br>
                                    <h5>Add Cells</h5><hr>
                                    <table style="border:whitesmoke;" class="table table-responsive xv" align="center">
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td><b>Row Label</b></td>
                                                <td>:<strong id="cellVk" style="color:green"></strong></td> 
                                            </tr>                                                    
                                            <tr>
                                                <td> <div id="errorVk"></div></td>
                                                <td><b><br>Number Of Cells</b></td>
                                                <td>:<input   maxlength="2" required type="text" id="cellNumberVk" placeholder="Cell Number" style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" />
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="modal-footer">
                                        <span id="rowid" class="hidedisplaycontent"></span>
                                        <button type="submit" class="btn btn-sm btn-primary" id="addCells"><i class="fa fa-save"></i>&nbsp;Save</button>
                                    </div>
                                </div>
                            </div>                
                        </div>
                    </div>
                </div>
            </c:if> 
            <c:if  test="${divtest == 3}">
                <div class="container">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Manage Registered Cells</h2>
                        <hr>                        
                    </div>
                    <div class="scrollbar tile" id="content">
                        <div class="tile">
                            <div class="row">
                                <h5>List of Cells in Zone &nbsp;<h5 id="zoneTitle">${selectedcellMap.zonelabel}</h5>                               
                            </div>                   
                            <div id="showprintPDF1">
                                <!--<div>
                                    <button type="button" class="pull-right btn btn-secondary" id="printcellLabels"><i class="fa fa-print"></i> Print All</button>
                                    <button type="button" class="pull-right btn btn-secondary hidedisplaycontent" id="printselectedcells" data-id="${selectedcellMap.zonelabel}" onclick="printuserselectCell($(this).attr('data-id'))"><i class="fa fa-print"></i> Print&nbsp;(<span id="addcellscount"></span>)cell label(s)</button>
                                </div><br><br>-->

                                <div class="tile-body" id="">                                
                                    <table class="table table-hover table-bordered" id="sampleTable">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>Cell Label</th>
                                                <th>Lock / UnLock</th>
                                                <!--<th>Print Cell Label(s)</th>-->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% int v = 1;%>
                                            <c:forEach items="${selectedcellDetails}" var="b">
                                                <tr id="">
                                                    <td><%=v++%></td>
                                                    <td align="center">${b.celllabel}</td>
                                                    <c:if test="${b.cellstate == false}">
                                                        <td align="center">
                                                            <label class="switch">
                                                                <input type="checkbox" class="slidernm1" id="${b.cellid}" data-id="${b.celllabel}" data-idx="${b.zoneid}" value="false" onclick="sliderCellF(${b.cellid}, $(this).val(), $(this).attr('data-id'), $(this).attr('data-idx'))" checked="checked">
                                                                <span class="slider round"></span>
                                                            </label>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${b.cellstate == true}">
                                                        <td align="center">
                                                            <label class="switch">
                                                                <input type="checkbox" class="slidernm2" id="${b.cellid}" data-id="${b.celllabel}" data-idx="${b.zoneid}" value="true" onclick="sliderCellT(${b.cellid}, $(this).val(), $(this).attr('data-id'), $(this).attr('data-idx'))">
                                                                <span class="slider round"></span>
                                                            </label>
                                                        </td>
                                                    </c:if> 
                                                    <!--<td align="center"><input type="checkbox" name="selectedCells[]" value="${b.celllabel}" onchange="if (this.checked) {
                                                                checkedoruncheckedcellElement(this.value, 'checked');
                                                            } else {
                                                                checkedoruncheckedcellElement(this.value, 'unchecked');
                                                            }"/>
                                                    </td>-->
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table> 
                                </div>                                
                            </div>
                            <!--<div id="showprintcontent" style="height: 400px;"></div>-->
                            <div class="modal-footer">
                                <!---<button type="button" class="btn btn-secondary" id="printcellLabels"><i class="fa fa-print"></i> Print</button>--->                               
                            </div>
                        </div>                                         
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div> 
<script>
    var bayscreated = 0;
    var addRows2Listdivtest1aArray = [];
    var addCell2Listdivtest1aArray = [];
    var addCell2Listdivtest1aArrayFinal = [];
    $(document).ready(function () {
        $('#sampleTable').DataTable();
        window.location = '#managebaydialogxxx';
        initDialog('modalDialogShelve');
    <c:if test="${divtest == 1}">
        var jsonbaylabels = ${jsonselectedbay};
        $('#printbaylabels').click(function () {
            var jsonbaylabels = ${jsonselectedbay};
            var zoneName = $('#zoneTitle').html();
            var idx = 1;
            $.ajax({
                type: 'GET',
                cache: false,
                dataType: 'text',
                data: {Tags: JSON.stringify(jsonbaylabels), zonetitle: zoneName, printbtn: idx},
                url: "localsettigs/printzoneTagsALL.htm",
                success: function (data) {
                    if (data === 'success') {
                        $.toast({
                            heading: 'Success',
                            text: 'Bay Labels Printed Successfully.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                    }
                }
            });
        });
        //console.log(jsonbaylabels);
        $('#addbayz').click(function () {
            $('#bayslist').hide();
            $('#addnewBay').show();
            $('#backtobays').show();
            $('#addbayz').hide();
        });
        //Back button
        $('#backtobays').click(function () {
            $('#bayslist').show();
            $('#addbayz').show();
            $('#addnewBay').hide();
            $('#backtobays').hide();
        });
        $('#bayNumberV').keyup(function () {
            $('#errortest').html('');
            $('#errorbaymsg').html('');
            $('#zonebaysListV').show();
            $('#zonebaysV').html('');
            var baynumber = $(this).val();
            //console.log(baynumber);
            var zonename = $('#zoneV').html();
            bayscreated = baynumber;
            for (var i = 0; i < baynumber; i++) {
                var x = i + 1;
                $('#zonebaysV').append('<div class="col-md-12"><label class="col-md-3">Zone <strong style="color:green">' + zonename + '</strong>- Bay Label ' + x + '</label><input  oninput="generateBays(this.id);" maxlength="2" placeholder="Bay label"required type="text" data-id="' + baynumber + '"id="zonelabelsx' + x + '"  class="col-md-3"  style="padding:8px;" onkeydown="return ((event.keyCode >= 65 && event.keyCode <= 90) || event.keyCode == 8);" /><span id="errorxx3' + x + '"></span></div><hr>');
            }
        });
        var OneRowArrayCreate = [];
        var OneCellArrayCreate = [];
        $('#addRows').click(function () {
            var baylabelx = $('#rowVx').html();
            var bayidx = $('#zonebayid').html();
            var rowNumber = $('#rowNumberVx').val();
            var lastrowrecordx = $('#lstrows').html();
            if (rowNumber !== '') {
                $.confirm({
                    title: '',
                    content: 'Do you wish to Add Cells?',
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        Yes: {
                            text: 'Yes',
                            btnClass: 'btn-blue',
                            action: function () {
                                $('#addRowsList').hide();
                                $('#addRows2Listdivtest1').show();
                                var lastrowNumber = parseInt(lastrowrecordx) + 1;
                                var newTotalrow = parseInt(lastrowNumber) + parseInt(rowNumber);
                                if (parseInt(lastrowrecordx) !== 0) {
                                    $('#rowLastlabel').html('<label class="info">Last Row Label was:<b style="color:green">' + baylabelx + '-00' + lastrowrecordx + '</b></label>');
                                }
                                for (var m = lastrowNumber; m < parseInt(newTotalrow); m++) {
                                    $('#addRows2Listdivtest1a').append('<div class="col-md-12"><label class="col-md-12">Row <strong style="color:green">' + baylabelx + '-00' + m + '</strong></label>\n\
                                            <label class="col-md-3">Number Of Cells:</label><input maxlength="2" required type="text" id="' + baylabelx + '-00' + m + '--' + m + '"  class="col-md-2"  style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" /></div><hr>');
                                    addRows2Listdivtest1aArray.push({
                                        BayrowtestArray: baylabelx + '-00' + m,
                                        bayid: bayidx,
                                        rowidpos: m
                                    });
                                }
                                //console.log(addRows2Listdivtest1aArray);
                            }
                        },
                        No: function () {
                            //$.alert('selected No');
                            var lastrowNumber = parseInt(lastrowrecordx) + 1;
                            var newTotalrow = parseInt(lastrowNumber) + parseInt(rowNumber);
                            for (var m = lastrowNumber; m < parseInt(newTotalrow); m++) {
                                OneRowArrayCreate.push({
                                    BayrowtestArray: baylabelx + '-00' + m,
                                    bayid: bayidx,
                                    rowid: m
                                });
                            }
                            //generate cells
                            //var letter = String.fromCharCode(65);
                            var letter = generateLetters(0);
                            for (var h in OneRowArrayCreate) {
                                OneCellArrayCreate.push({
                                    celllabel: OneRowArrayCreate[h].BayrowtestArray + '-' + letter,
                                    rowid: OneRowArrayCreate[h].rowid
                                });
                            }
                            //console.log(OneRowArrayCreate);
                            // console.log(OneCellArrayCreate);
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {bayid: bayidx, rows: JSON.stringify(OneRowArrayCreate), cells: JSON.stringify(OneCellArrayCreate)},
                                url: "localsettigs/addNewRows.htm",
                                success: function (data) {
                                    if (data === 'success') {
                                        $.toast({
                                            heading: 'Success',
                                            text: 'Rows Added Successfully.',
                                            icon: 'success',
                                            hideAfter: 2000,
                                            position: 'bottom-center'
                                        });
                                        //$('#bayslist').show();
                                        //$('#addnewBay').hide();
                                        ajaxSubmitData('localsettigs/manageshelvingtab.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                        window.location = '#close';

                                    } else {
                                        $.toast({
                                            heading: 'Error',
                                            text: 'An unexpected error occured while trying to add Rows.',
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
                //console.log(baylabelx +'-'+bayidx +'---'+rowNumber);
            } else {
                $('#errorVx').html('<span style="color:red;">*Error Field is Required!!!</span>');
            }
        });
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
    </c:if>
    <c:if test="${divtest == 2}">
        $('#printrowLabels').click(function () {
            var jsonrowlabels = ${jsonselectedRow};
            var zoneName = $('#zoneTitle').html();
            var idx = 2;
            $.ajax({
                type: 'GET',
                cache: false,
                dataType: 'text',
                data: {Tags: JSON.stringify(jsonrowlabels), zonetitle: zoneName, printbtn: idx},
                url: "localsettigs/printzoneTagsALL.htm",
                success: function (data) {
                    if (data === 'success') {
                        $.toast({
                            heading: 'Success',
                            text: 'Row Labels Printed Successfully.',
                            icon: 'success',
                            hideAfter: 2000,
                            position: 'bottom-center'
                        });
                    }
                }
            });
        });
        $('#addCells').click(function () {
            var cellinput = $('#cellNumberVk').val();
            var rowlabel = $('#cellVk').html();
            var rowid = $('#rowid').html();
            if (cellinput !== '') {
                $.ajax({
                    type: 'GET',
                    cache: false,
                    dataType: 'text',
                    data: {rowidx: rowid, cellNumbers: cellinput, rowlabeL: rowlabel},
                    url: "localsettigs/addNewCells.htm",
                    success: function (data) {
                        if (data === 'success') {
                            $.toast({
                                heading: 'Success',
                                text: 'Cells Added Successfully.',
                                icon: 'success',
                                hideAfter: 2000,
                                position: 'bottom-center'
                            });
                            //$('#bayslist').show();
                            //$('#addnewBay').hide();
                            ajaxSubmitData('localsettigs/manageshelvingtab.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            window.location = '#close';
                        }
                    }
                });
            } else {
                $('#errorVk').html('<span style="color:red;">*Error Input Field Required!!!</span>');
            }
        });
    </c:if>
    <c:if test="${divtest == 3}">
        $('#printcellLabels').click(function () {
            var jsoncellLabels = ${jsonselectedCell};
            var zoneName = $('#zoneTitle').html();
            var idx = 3;
            $.ajax({
                type: 'GET',
                cache: false,
                dataType: 'text',
                data: {Tags: JSON.stringify(jsoncellLabels), zonetitle: zoneName, printbtn: idx},
                url: "localsettigs/printzoneTagsALL.htm",
                success: function (textStatus) {

                    $.toast({
                        heading: 'Success',
                        text: 'CeLL Labels Printed Successfully.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    //ajaxSubmitData('localsettigs/manageshelvingtab.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    //window.location = '#close';
                    var objbuilder = '';
                    objbuilder += ('<object width="100%" height="100%" data="data:application/pdf;base64,');
                    objbuilder += (textStatus);
                    objbuilder += ('" type="application/pdf" class="internal">');
                    objbuilder += ('<embed src="data:application/pdf;base64,');
                    objbuilder += (textStatus);
                    objbuilder += ('" type="application/pdf"  />');
                    objbuilder += ('</object>');
                    $('#showprintPDF1').hide();
                    $('#showprintcontent').html(objbuilder);
                    /* var win = window.open("#", "_blank");
                     var title = "Print Cell Labels";
                     win.document.write('<html><title>' + title + '</title><body style="margin-top: 0px; margin-left: 0px; margin-right: 0px; margin-bottom: 0px;">');
                     win.document.write(objbuilder);
                     win.document.write('</body></html>');
                     layer = jQuery(win.document);*/
                }, error: function (textStatus) {

                }
            });
        });
    </c:if>
    });
    //functions for Bays Section on a given zone
    <c:if test="${divtest == 1}">
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
    var jsonbaylabels = ${jsonselectedbay};
    var createBaysets = new Set();
    var previousvalue = '';
    function generateBays(id) {
        var baylabeLSet = new Set();
        var baylabelTags = new Array();
        for (var x in jsonbaylabels) {
            if (jsonbaylabels.hasOwnProperty(x)) {
                baylabelTags = jsonbaylabels[x].baylabel.split('-');
                baylabeLSet.add(baylabelTags[1]);
            }
        }
        var createbayTag = $('#' + id).val().toUpperCase();
        previousvalue = createbayTag;
        var p = new Array();
        p = id.split('x');
        var baytotal = $('#' + id).attr('data-id');
        if (baylabeLSet.has(createbayTag)) {
            $('#errorbaymsg').html('<span style="color:red;">*Error Bay Label ' + createbayTag + ' Already used!!!</span>');
            $('#' + id).focus();
            for (var i = parseInt(p[1]); i < parseInt(baytotal); i++) {
                var n = i + 1;
                $('#' + p[0] + 'x' + n).prop('disabled', true);
            }

        } else {
            $('#errorbaymsg').html(' ');
            for (var i = parseInt(p[1]); i < parseInt(baytotal); i++) {
                var n = i + 1;
                $('#' + p[0] + 'x' + n).prop('disabled', false);
            }
            if (createbayTag !== '') {
                if (createBaysets.has(createbayTag)) {
                    $('#errorbaymsg').html('<span style="color:red;">*Error Bay Label ' + createbayTag + ' Already used!!!</span>');
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
    function savedata(id) {
        $('#errortest').html('');
        $('#errorbaymsg').html('');
        var zonename = $('#zoneTitle').html();
        for (var i = 1; i <= bayscreated; i++) {
            var baylabell = $('#zonelabelsx' + i).val().toUpperCase();
            if (baylabell !== '') {
                baysname.push({
                    baylabel: zonename + '-' + baylabell,
                    id: i
                });
            } else {
                $('#errorbaymsg').html('<span style="color:red;">*Error Bay Label Required!!!</span>');
            }
        }
        var Testbay = new Set();
        for (var i = 0; i < bayscreated; i++) {
            var p = parseInt(i) + 1;
            var kk = $('#zonelabelsx' + p).val();
            if (kk !== '') {
                document.getElementById('zonelabelsx' + p).style.borderColor = "";
                $('#errorxx3' + p).html(' ');
                if (Testbay.has(p)) {
                } else {
                    Testbay.add(p);
                }
            } else {
                console.log('position----' + p + '-----field Empty');
                $('#errorxx3' + p).html('<span class="text-danger">*Field Required</span>');
                document.getElementById('zonelabelsx' + p).style.borderColor = "red";
            }
        }
        if (parseInt(Testbay.size) === parseInt(bayscreated)) {
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
                                //console.log(baysname);
                                $('#addnewBay').hide();
                                $('#backtobays').hide();
                                $('#addRowsListdivtest1').show();
                                for (var x in baysname) {
                                    var n = x + 1;
                                    $('#addRowsListdivtest1a').append('<div class="col-md-12"><label class="col-md-12">Bay <strong style="color:green">  ' + baysname[x].baylabel + '</strong></label>\n\
                                        <label class="col-md-3">Number Of Rows:</label><input maxlength="2" required type="text" id="' + baysname[x].id + '"  class="col-md-2"  style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" /></div><hr>');
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
                            //generate cells
                            var letter = generateLetters(0);
                            for (var p in OneRowNameArray) {
                                OneCellNameArray.push({
                                    celllabel: OneRowNameArray[p].BayrowtestArray + '-' + letter,
                                    rowid: OneRowNameArray[p].rowid
                                });
                            }
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
            addRowsListdivtest1aRowsArray = [];
            addCellsListdivtest1aRowsArray = [];
            addRowsListdivtest1aRowsArrayFinal = [];
            addCellsListdivtest1aRowsArrayFinal = [];
            OneRowNameArray = [];
            OneCellNameArray = [];
            addCellsListdivtest1aRowsArrayFinalOnBays = [];
        }
        //console.log(baysname);
    }
    function addRowsListdivtest1abtn(zoneid) {
        for (var v in baysname) {
            var rownumber = $('#' + baysname[v].id).val();
            addRowsListdivtest1aRowsArray.push({
                bayrows: rownumber,
                bayrowsid: v,
                zonebayid: baysname[v].id
            });
        }

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
                        $('#addRowsListdivtest1').hide();
                        $('#addCellListdivtest1').show();
                        //computation for adding cells displays
                        for (var v in addRowsListdivtest1aRowsArray) {
                            for (var k = 0; k < addRowsListdivtest1aRowsArray[v].bayrows; k++) {
                                var n = k + 1;
                                for (var x in baysname) {
                                    if (parseInt(baysname[x].id) === parseInt(addRowsListdivtest1aRowsArray[v].zonebayid)) {
                                        $('#addCellListdivtest1a').append('<div class="col-md-12"><label class="col-md-12">Cell <strong style="color:green">' + baysname[x].baylabel + '-00' + n + '</strong></label>\n\
                                            <label class="col-md-3">Number Of Cells:</label><input maxlength="2" required type="text" id="' + baysname[x].baylabel + '-00' + n + '--' + addRowsListdivtest1aRowsArray[v].bayrowsid + '-' + k + '"  class="col-md-2"  style="padding:10px;" onkeypress="return (event.charCode === 8 || event.charCode === 0 || event.charCode === 13) ? null : event.charCode >= 48 && event.charCode <= 57" /></div><hr>');
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
                    //modification needed for adding cells
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
                                addRowsListdivtest1aRowsArrayFinal = [];
                                addCellsListdivtest1aRowsArrayFinalOnBays = [];
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
                                addRowsListdivtest1aRowsArrayFinal = [];
                                addCellsListdivtest1aRowsArrayFinalOnBays = [];
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
    }
    function addCellListdivtest1abtn(zoneid) {
        for (var q = 0; q < parseInt(addRowsListdivtest1aRowsArrayFinal.length); q++) {
            var cellvalue = $('#' + addRowsListdivtest1aRowsArrayFinal[q].BayrowtestArray + '--' + addRowsListdivtest1aRowsArrayFinal[q].bayrowidxxx + '-' + addRowsListdivtest1aRowsArrayFinal[q].rowidpos).val();
            addCellsListdivtest1aRowsArray.push({
                rowcells: cellvalue,
                rowlabel: addRowsListdivtest1aRowsArrayFinal[q].BayrowtestArray,
                cellid: q,
                rowid: addRowsListdivtest1aRowsArrayFinal[q].bayrowidxxx,
                rowidx: addRowsListdivtest1aRowsArrayFinal[q].rowidpos
            });
        }
        for (var t in addCellsListdivtest1aRowsArray) {
            var z;
            var i = 0;
            for (z = 1; z <= parseInt(addCellsListdivtest1aRowsArray[t].rowcells); z++) {
                var letter = generateLetters(i);
                i = i + 1;
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
    }
    function addRows2Listdivtest1abtn() {
        var bayid = $('#zonebayidsubSection2').html();
        for (var w in addRows2Listdivtest1aArray) {
            var cellvalue = $('#' + addRows2Listdivtest1aArray[w].BayrowtestArray + '--' + addRows2Listdivtest1aArray[w].rowidpos).val();
            if (cellvalue !== '') {
                addCell2Listdivtest1aArray.push({
                    rowcells: cellvalue,
                    rowlabel: addRows2Listdivtest1aArray[w].BayrowtestArray,
                    cellid: w,
                    rowid: addRows2Listdivtest1aArray[w].rowidpos
                });
            } else {
                $('#erroraddRows2Listdivtest1amsg').html('<span style="color:red;">*Error Some Input Fields are Empty!!!</span>');
            }
        }

        for (var t in addCell2Listdivtest1aArray) {
            var z;
            var i = 0;
            for (z = 1; z <= parseInt(addCell2Listdivtest1aArray[t].rowcells); z++) {
                var letter = generateLetters(i);
                i = i + 1;
                addCell2Listdivtest1aArrayFinal.push({
                    celllabel: addCell2Listdivtest1aArray[t].rowlabel + '-' + letter,
                    rowid: addCell2Listdivtest1aArray[t].rowid,
                    rowidpos: addCell2Listdivtest1aArray[t].rowid
                });
            }
        }
        $.ajax({
            type: 'GET',
            cache: false,
            dataType: 'text',
            data: {zonebayid: bayid, rows: JSON.stringify(addRows2Listdivtest1aArray), cells: JSON.stringify(addCell2Listdivtest1aArrayFinal)},
            url: "localsettigs/addNewRowsCells.htm",
            success: function (data) {
                //alert(data);
                if (data === 'success') {
                    $.toast({
                        heading: 'Success',
                        text: 'Details Added Successfully.',
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
                        text: 'An unexpected error occured while trying to add Content.',
                        icon: 'error'
                    });
                    window.location = '#close';
                    // $('#bayslist').show();
                    //  $('#addnewBay').hide();
                }
            }
        });

    }
    function ShowRowscapture(bayid, baylabel, lastrowrecord) {
        $('#addRowsList').show();
        $('#bayslist').hide();
        $('#addnewBay').hide();
        $('#addbayz').hide();
        //console.log(bayid);
        //console.log(baylabel);
        $('#rowVx').html(baylabel);
        $('#zonebayid').html(bayid);
        $('#zonebayidsubSection2').html(bayid);
        $('#lstrows').html(lastrowrecord);
    }
    function addbackMain() {
        $('#addbackMain').hide();
        $('#bayslist').show();
        $('#addRowsList').hide();
        $('#addbayz').show();
    }
    </c:if>
    <c:if test="${divtest == 2}">
    function ShowCellscapture(rowid, rowlabel) {
        $('#addCellsList').show();
        $('#rowLists').hide();
        $('#cellVk').html(rowlabel);
        $('#rowid').html(rowid);
    }
    function addbackMain2() {
        $('#addCellsList').hide();
        $('#rowLists').show();
    }
    function showbayrows(id, selectbay) {
        $('#selectRowName').html(selectbay);
        $('#BayShowtestList').hide();
        $('#showRows').show();
        ajaxSubmitData('localsettigs/selectedBaysList.htm', 'showbayselectTableRowsList', 'zonebayid=' + id + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function backtoBayShowtestList() {
        $('#BayShowtestList').show();
        $('#showRows').hide();
    }
    </c:if>
    <c:if test="${divtest == 3}">
    /*
     function selectALLcellscheckedorunchecked(source, status) {
     $('#printselectedcells').hide();
     if (status === 'checked') {
     checkboxes = document.getElementsByName('selectedCells[]');
     for (var i in checkboxes) {
     checkboxes[i].checked = true;
     if(typeof checkboxes[i].value !== 'undefined'){
     var data = checkboxes[i].value; 
     if(selecteduserlistSet.has(data)){
     selecteduserlistSet.delete(data); 
     }else{
     selecteduserlistSet.add(data);                         
     }
     }                
     }
     $('#printcellLabels').show();
     $('#printselectedcells').hide();
     } else if (status === 'unchecked') {
     checkboxes = document.getElementsByName('selectedCells[]'); 
     for (var i in checkboxes) {             
     var data = checkboxes[i].value;
     checkboxes[i].checked = false;
     selecteduserlistSet.delete(data);               
     }
     $('#printcellLabels').hide();
     $('#printselectedcells').hide();
     }
     }*/
    var selecteduserlistSet = new Set();
    function checkedoruncheckedcellElement(value, status) {
        var jsoncellLabels = ${jsonselectedCell};
        var cellsize = jsoncellLabels.length;
        $('#printcellLabels').hide();
        if (status === 'checked') {
            selecteduserlistSet.add(value);
        } else if (status === 'unchecked') {
            selecteduserlistSet.delete(value);
        } else {
        }
        if (parseInt(selecteduserlistSet.size) === 0) {
            document.getElementById('printselectedcells').style.display = 'none';
            document.getElementById('printcellLabels').style.display = 'block';
        } else if (parseInt(selecteduserlistSet.size) > 0 && parseInt(selecteduserlistSet.size) !== parseInt(cellsize)) {
            document.getElementById('addcellscount').innerHTML = selecteduserlistSet.size;
            document.getElementById('printselectedcells').style.display = 'block';
        } else if (parseInt(selecteduserlistSet.size) === parseInt(cellsize)) {
            document.getElementById('printselectedcells').style.display = 'none';
            document.getElementById('printcellLabels').style.display = 'block';
        }
    }
    var userselectObj = [];
    function printuserselectCell(zoneName) {
        if (parseInt(selecteduserlistSet.size) !== 0) {
            var SelectedcellsObj = Array.from(selecteduserlistSet);
            for (var x in SelectedcellsObj) {
                userselectObj.push({
                    celllabel: SelectedcellsObj[x]
                });
            }
            $.ajax({
                type: 'GET',
                cache: false,
                dataType: 'text',
                data: {Tags: JSON.stringify(userselectObj), zonetitle: zoneName},
                url: "localsettigs/printselectedcellLabels.htm",
                success: function (textStatus) {
                    userselectObj = [];
                    $.toast({
                        heading: 'Success',
                        text: 'CeLL Labels Printed Successfully.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    //console.log(textStatus);
                    var objbuilder = '';
                    objbuilder += ('<object width="100%" height="100%" data="data:application/pdf;base64,');
                    objbuilder += (textStatus);
                    objbuilder += ('" type="application/pdf" class="internal">');
                    objbuilder += ('<embed src="data:application/pdf;base64,');
                    objbuilder += (textStatus);
                    objbuilder += ('" type="application/pdf"  />');
                    objbuilder += ('</object>');
                    $('#showprintPDF1').hide();
                    $('#showprintcontent').html(objbuilder);
                }, error: function (textStatus) {

                }
            });

        }
    }
    function sliderCellF(cellidz, valuex, cellLabel, zoneidvv) {
        if (valuex === 'false') {
            //console.log('false--->>>> set to true-----' + cellidz);
            var zstate = 'true';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Lock Cell ' + cellLabel,
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {cellstate: zstate, cellid: cellidz},
                                url: "localsettigs/activateDeactivatecell.htm",
                                success: function (data) {}
                            });
                            $('.slidernm1').val("true");
                        }
                    },
                    cancel: function () {
                        window.location = '#close';
                        ajaxSubmitDataNoLoader('localsettigs/viewUnitZoneBay.htm', 'managebaydialog', 'act=a&selectedzoneid=' + zoneidvv + ' &myid=3 &c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        } else if (valuex === 'true') {
            //console.log('true--->>>> set to false----' + cellidz);
            var zstate = 'false';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Unlock Cell ' + cellLabel,
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-success',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {cellstate: zstate, cellid: cellidz},
                                url: "localsettigs/activateDeactivatecell.htm",
                                success: function (data) {}
                            });
                            $('.slidernm1').val("false");
                        }
                    },
                    cancel: function () {
                        window.location = '#close';
                        ajaxSubmitDataNoLoader('localsettigs/viewUnitZoneBay.htm', 'managebaydialog', 'act=a&selectedzoneid=' + zoneidvv + ' &myid=3 &c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        }
    }
    function sliderCellT(cellidz, valuex, cellLabel, zoneidvv) {
        if (valuex === 'true') {
            //console.log('true--->>>> set to false----' + cellidz);
            var zstate = 'false';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Unlock Cell ' + cellLabel,
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-suceess',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {cellstate: zstate, cellid: cellidz},
                                url: "localsettigs/activateDeactivatecell.htm",
                                success: function (data) {}
                            });
                            $('.slidernm2').val("false");
                        }
                    },
                    cancel: function () {
                        window.location = '#close';
                        ajaxSubmitDataNoLoader('localsettigs/viewUnitZoneBay.htm', 'managebaydialog', 'act=a&selectedzoneid=' + zoneidvv + ' &myid=3 &c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        } else if (valuex === 'false') {
            // console.log('false--->>>> set to true-----' + cellidz);
            var zstate = 'true';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Lock Cell ' + cellLabel,
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {cellstate: zstate, cellid: cellidz},
                                url: "localsettigs/activateDeactivatecell.htm",
                                success: function (data) {}
                            });
                            $('.slidernm2').val("true");
                        }
                    },
                    cancel: function () {
                        window.location = '#close';
                        ajaxSubmitDataNoLoader('localsettigs/viewUnitZoneBay.htm', 'managebaydialog', 'act=a&selectedzoneid=' + zoneidvv + ' &myid=3 &c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        }
    }
    </c:if>
</script>


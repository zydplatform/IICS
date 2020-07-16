<%-- 
    Document   : assigndesignassets
    Created on : Jun 13, 2018, 3:47:16 PM
    Author     : RESEARCH
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
    <div class="row">
        <div class="col-md-11 col-sm-11 right">
            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                <div class="btn-group" role="group">
                    <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-sliders" aria-hidden="true"></i>
                    </button>
                    <div class="dropdown-menu dropdown-menu-left">
                        <a class="dropdown-item" href="#"  id="assignassets">Not Assigned Assets</a>
                        <a class="dropdown-item" href="#" id="deassignassets">Assigned Assets</a>
                    </div>
                </div>
            </div>
        </div>
    </div><br>
    <div style="margin: 10px;">
        <div id="showcontent1">
            <fieldset style="min-height:100px;">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <h5 class="tile-title">Not Assigned Assets</h5>
                            <div class="tile-body">
                                <input id="id" type="hidden"/>
                                <input id="name" type="hidden"/>
                                <input id="identifier" type="hidden"/>
                                <table class="table table-hover table-bordered" id="assetsassignTable">
                                    <thead>
                                        <tr>
                                            <th class="center">No.</th>
                                            <th class="center">Asset Name</th>
                                            <th class="center">Asset Unique Identifier</th>
                                            <th class="center">Assign Assets<span  id="selectoption" ><a href="javascript:selectToggleCheckBox(true, 'selectObj');" onClick="selectallassigncheckboxs(this.id);"><font color="green"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj', ${model.size});" onClick="unselectallassigncheckboxs(this.id);"><font color="red">None</font></a></span></th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%int i = 1;%>
                                        <c:forEach items="${viewAllUnAssignedAssets}" var="va">
                                            <tr id="${va.assetsid}">
                                                <td class="center"><%=i++%></td>
                                                <td class="center">${va.assetsname}</td>
                                                <td class="center">${va.assetidentifier}</td>
                                                <td align="center">
                                                    <input type="checkbox" name="selectObj" id="${va.assetsid}"  data-id="${va.assetsname}" data-ided="${va.assetidentifier}" value="${va.assetsid}" onChange="if (this.checked) {
                                                                checkedoruncheckedunassigned(this.id, $(this).attr('data-id'), $(this).attr('data-ided'), 'checked');
                                                            } else {
                                                                checkedoruncheckedunassigned(this.id, $(this).attr('data-id'), $(this).attr('data-ided'), 'unchecked');
                                                            }"/>
                                                </td>
                                                <td class="center" style="display:none"><a class="btn btn-sm btn-danger ${va.assetsid}" id="${va.assetsid}"  data-id="${va.assetsname}" data-ided="${va.assetidentifier}" data-status="Not Assigned" onclick="transferdata(this.id, $(this).attr('data-id'), $(this).attr('data-ided'))" href="#"><span id="schstatus${va.assetsid}"></span></a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <table align="right">
                    <tr>
                        <td colspan="2" align="right">
                            <div id="selectObjBtns" style="display:none">
                                <input type="button" value="Assign Assets" class='btn btn-purple' onClick="assignassets();"/>
                            </div>
                        </td>
                        <td colspan="2" align="right">
                            <div id="selectedObjBtns" style="display:none">
                                <input type="button" value="Assign Assets" class='btn btn-purple' onClick="assignallassets();"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
    </div> 
    <div id="showcontent2" class="hidedisplaycontent">
        <fieldset>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h5 class="tile-title">Assigned Assets</h5>
                        <div class="tile-body">
                            <table class="table table-hover table-bordered" id="assetsdeassignTable">
                                <input id="idz" type="hidden"/>
                                <input id="namez" type="hidden"/>
                                <input id="identifierz" type="hidden"/>
                                <thead>
                                    <tr>
                                        <th class="center">No.</th>
                                        <th class="center">Asset Name</th>
                                        <th class="center">Asset Unique Identifier</th>
                                        <th class="center">Asset Current Room</th>
                                        <th class="center">De-Assign Assets<span  id="selectoptions" ><a href="javascript:selectToggleCheckBox(true, 'selectObj');" onclick="selectalldeassigncheckboxs(this.id);"><font color="red"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj', ${model.size});" onClick="unselectalldeassigncheckboxs(this.id);"><font color="green">None</font></a></span></th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <%int j = 1;%>
                                    <c:forEach items="${viewAllAssignedAsset}" var="va">
                                        <tr id="${va.assetsid}">
                                            <td class="center"><%=j++%></td>
                                            <td class="center">${va.assetsname}</td>
                                            <td class="center">${va.assetidentifier}</td>
                                            <td class="center">${va.roomname}</td>
                                            <td align="center">
                                                <input type="checkbox" name="selectObj" id="${va.assetsid}"  data-id="${va.assetsname}" data-ided="${va.assetidentifier}" value="${va.assetsid}" onChange="if (this.checked) {
                                                            checkedoruncheckedassigned(this.id, $(this).attr('data-id'), $(this).attr('data-ided'), 'checked');
                                                        } else {
                                                            checkedoruncheckedassigned(this.id, $(this).attr('data-id'), $(this).attr('data-ided'), 'unchecked');
                                                        }"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
            <table align="right">
                <tr>
                    <td colspan="2" align="right">
                        <div id="selectObjBtn" style="display:none">
                            <input type="button" value="De-Assign Assets" class='btn btn-purple' onClick="deassignassets();"/>
                        </div>
                    </td>
                    <td colspan="2" align="right">
                        <div id="selectedObjBtn" style="display:none">
                            <input type="button" value="De-Assign Assets" class='btn btn-purple' onClick="deassignallassets();"/>
                        </div>
                    </td>
                </tr>
            </table>

        </fieldset> 
    </div>
</div>
<!------Do not delete this section Assign------>
<div id="showOndialogz" class="hidedisplaycontent">
    <div id="showOptionz"></div>
</div>
<div id="showBlockOndialogz" class="hidedisplaycontent">
    <div id="showBlockOptionz"></div>
</div>
<div id="showRoomOndialogz" class="hidedisplaycontent">
    <div id="showRoomOptionz"></div>
</div>

<script>

    $('#assetsassignanddeassignTable').DataTable();

    $('#assignassets').click(function () {
        $('#showcontent1').show();
        $('#showcontent2').hide();
    });
    $('#deassignassets').click(function () {
        $('#showcontent1').hide();
        $('#showcontent2').show();

    });

    function transferdata(assetid, assetname, assetidentifier) {
        console.log("assetid" + assetid);
        console.log("assetname" + assetname);
        console.log("assetidentifier" + assetidentifier);
        document.getElementById('id').value = assetid;
        document.getElementById('name').value = assetname;
        document.getElementById('identifier').value = assetidentifier;

    }

    function selectallassigncheckboxs(id) {
        var $table = $('#assetsassignTable');
        var $tdCheckbox = $table.find('tbody input:checkbox');
        $tdCheckbox.prop('checked', true);
        showDiv('selectedObjBtns');
    }

    function unselectallassigncheckboxs(id) {
        var $table = $('#assetsassignTable');
        var $tdCheckbox = $table.find('tbody input:checkbox');
        $tdCheckbox.prop('checked', false);
        hideDiv('selectedObjBtns');
    }

    function selectalldeassigncheckboxs(id) {
        var $table = $('#assetsdeassignTable');
        var $tdCheckbox = $table.find('tbody input:checkbox');
        $tdCheckbox.prop('checked', true);
        showDiv('selectedObjBtn');
    }

    function unselectalldeassigncheckboxs(id) {
        var $table = $('#assetsdeassignTable');
        var $tdCheckbox = $table.find('tbody input:checkbox');
        $tdCheckbox.prop('checked', false);
        hideDiv('selectedObjBtn');
    }

    var assignset = new Set();

    var addremoveasset = [];
    function checkedoruncheckedunassigned(assetid, assetname, assetidentifier, type) {

        document.getElementById('id').value = assetid;
        document.getElementById('name').value = assetname;
        document.getElementById('identifier').value = assetidentifier;
        if (type === 'checked') {
            assignset.add(assetid);
            showDiv('selectObjBtns');

            hideDiv('selectoption');

        } else {
            assignset.delete(
                    assetid
                    );
            hideDiv('selectObjBtns');

            showDiv('selectoption');

        }

    }

    var deassignset = new Set();

    var addremovedeassignasset = [];
    function checkedoruncheckedassigned(assetid, assetname, assetidentifier, type) {

        document.getElementById('idz').value = assetid;
        document.getElementById('namez').value = assetname;
        document.getElementById('identifierz').value = assetidentifier;
        if (type === 'checked') {
            deassignset.add(assetid);
            showDiv('selectObjBtn');

            hideDiv('selectoptions');

        } else {
            deassignset.delete(
                    assetid
                    );
            hideDiv('selectObjBtn');

            showDiv('selectoptions');

        }

        console.log(deassignset);

    }

    function building(buildingid) {

        $('#selectblock').append('');
        $.ajax({
            type: 'GET',
            cache: false,
            dataType: 'JSON',
            data: {id: buildingid, section: parseInt(1)},
            url: "assetsmanagement/assignedblocksorRooms.htm",
            success: function (data) {
                console.log(data);
                var jsonblocks = data;
                for (var x in jsonblocks) {
                    var datashowblk = jsonblocks[x];
                    $('#selectblock').append('<option value="' + datashowblk.facilityblockid + '">' + datashowblk.blockname + '</option>');
                }
            }
        });
    }

    function blocks(blockid) {

        $('#selectfloor').append('');
        $.ajax({
            type: 'GET',
            cache: false,
            dataType: 'JSON',
            data: {id: blockid, section: parseInt(2)},
            url: "assetsmanagement/assignedblocksorRooms.htm",
            success: function (data) {
                console.log(data);
                var jsonfloors = data;
                for (var x in jsonfloors) {
                    var datashowfl = jsonfloors[x];
                    $('#selectfloor').append('<option value="' + datashowfl.blockfloorid + '-' + datashowfl.floorname + '">' + datashowfl.floorname + '</option>');
                }
            }
        });
    }

    function floors(floorid) {

        $('#selectfloor').append('');
        $.ajax({
            type: 'GET',
            cache: false,
            dataType: 'JSON',
            data: {id: floorid, section: parseInt(3)},
            url: "assetsmanagement/assignedblocksorRooms.htm",
            success: function (data) {
                console.log(data);
                var jsonrooms = data;
                for (var x in jsonrooms) {
                    var datashowrm = jsonrooms[x];
                    $('#selectroom').append('<option value="' + datashowrm.blockroomid + '-' + datashowrm.roomname + '">' + datashowrm.roomname + '</option>');
                }
            }
        });
    }

    function deassignassets() {
        var assetid = $('#idz').val();
        var assetname = $('#namez').val();
        var assetidentifier = $('#identifierz').val();
        $.confirm({
            title: 'De-Assign Asset',
            content: 'Are You Sure You Would Like To De-Assign ?',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'OK',
                    btnClass: 'btn-red',
                    action: function () {
                        var jsonbuilding = ${jsonbuildings}
                        for (var x in jsonbuilding) {
                            var datashow = jsonbuilding[x];
                            $('#showOptionz').append('<option value="' + datashow.buildingid + '">' + datashow.buildingname + '</option>');
                        }
                        var showdialogcontent = $('#showOndialogz').html();
                        $.confirm({
                            title: 'De-Assign Asset!',
                            content: '' +
                                    '<form action="" class="formName">' +
                                    '<div class="form-group">' +
                                    '<label>Select Building</label>' +
                                    '<select class="form-control new_search" id="selectbuildings" onchange="building(this.value)">' +
                                    '<option>-----Select Building-----</option>' +
                                    '<div>' + showdialogcontent + '</div>' +
                                    '</select>' +
                                    '<label>Select Block</label>' +
                                    '<select class="form-control new_search" id="selectblock" onchange="blocks(this.value)">' +
                                    '<option>-----Select Block-----</option>' +
                                    '</select>' +
                                    '<label>Select Floor</label>' +
                                    '<select class="form-control new_search" id="selectfloor" onchange="floors(this.value)">' +
                                    '<option>-----Select Floor-----</option>' +
                                    '</select>' +
                                    '<label>Select Room</label>' +
                                    '<select class="form-control new_search" id="selectroom">' +
                                    '<option>-----Select Room-----</option>' +
                                    '</select>' +
                                    '</div>' +
                                    '</form>',
                            buttons: {
                                formSubmit: {
                                    text: 'Save',
                                    btnClass: 'btn-blue',
                                    action: function () {
                                        var selectroom = this.$content.find('#selectroom').val();
                                        var fields = selectroom.split('-');
                                        var roomid = fields[0];
                                        var roomname = fields[1];
                                        $.ajax({
                                            type: 'GET',
                                            data: {assetvalues: JSON.stringify(Array.from(deassignset)), blockroomid: roomid},
                                            url: "assetsmanagement/deassignassets.htm",
                                            success: function (data, textStatus, jqXHR) {

                                                $.alert({
                                                    title: 'Alert!',
                                                    content: 'Assets Successfully De-Assigned',
                                                });

                                                ajaxSubmitData('assetsmanagement/assigndeassignassets.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            }
                                        });

                                    }
                                },
                                cancel: function () {
                                }
                            },
                            onContentReady: function () {
                                var jc = this;
                                this.$content.find('form').on('submit', function (e) {
                                    e.preventDefault();
                                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                                });
                            }
                        });

                    }
                },
                NO: function () {
                }
            }
        });
    }
    var assignasset = [];
    function assignassets() {
        var assetid = $('#id').val();
        var assetname = $('#name').val();
        var assetidentifier = $('#identifier').val();

        if (assignset.size !== 0) {
            $.confirm({
                title: 'Assign ' + assetname,
                content: 'Are You Sure You Would Like To Assign' + ' ' + assetname + ' ' + assetidentifier + ' ' + '?',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'OK',
                        btnClass: 'btn-green',
                        action: function () {

                            var jsonbuilding = ${jsonbuildings}
                            for (var x in jsonbuilding) {
                                var datashow = jsonbuilding[x];
                                $('#showOptionz').append('<option value="' + datashow.buildingid + '">' + datashow.buildingname + '</option>');
                            }
                            var showdialogcontent = $('#showOndialogz').html();
                            $.confirm({
                                title: 'Assign Asset!',
                                content: '' +
                                        '<form action="" class="formName">' +
                                        '<div class="form-group">' +
                                        '<label>Enter Classification Name</label>' +
                                        '<input type="text" placeholder="Classification Name" id="editedclassname" value="' + assetname + ' ' + assetidentifier + '" class="name form-control" required />' +
                                        '<input placeholder="Classification Name" id="editedclassid" value="' + assetid + '" class="name form-control" type="hidden" required />' +
                                        '</div>' +
                                        '<div class="form-group">' +
                                        '<label>Select Building</label>' +
                                        '<select class="form-control new_search" id="selectbuildings" onchange="building(this.value)">' +
                                        '<option>-----Select Building-----</option>' +
                                        '<div>' + showdialogcontent + '</div>' +
                                        '</select>' +
                                        '<label>Select Block</label>' +
                                        '<select class="form-control new_search" id="selectblock" onchange="blocks(this.value)">' +
                                        '<option>-----Select Block-----</option>' +
                                        '</select>' +
                                        '<label>Select Floor</label>' +
                                        '<select class="form-control new_search" id="selectfloor" onchange="floors(this.value)">' +
                                        '<option>-----Select Floor-----</option>' +
                                        '</select>' +
                                        '<label>Select Room</label>' +
                                        '<select class="form-control new_search" id="selectroom">' +
                                        '<option>-----Select Room-----</option>' +
                                        '</select>' +
                                        '</div>' +
                                        '</form>',
                                buttons: {
                                    formSubmit: {
                                        text: 'Save',
                                        btnClass: 'btn-blue',
                                        action: function () {
                                            var selectroom = this.$content.find('#selectroom').val();
                                            var fields = selectroom.split('-');
                                            var roomid = fields[0];
                                            var roomname = fields[1];
                                            $.ajax({
                                                type: 'GET',
                                                data: {assetvalues: JSON.stringify(Array.from(assignset)), blockroomid: roomid},
                                                url: "assetsmanagement/assignassets.htm",
                                                success: function (data, textStatus, jqXHR) {

                                                    $.alert({
                                                        title: 'Alert!',
                                                        content: 'Assets Successfully Assigned',
                                                    });

                                                    ajaxSubmitData('assetsmanagement/assigndeassignassets.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                }
                                            });

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
                    },
                    NO: function () {
                    }
                }
            });

        } else {

        }

    }


</script>
<%-- 
    Document   : viewroomsinbuilding
    Created on : May 30, 2018, 4:26:26 PM
    Author     : RESEARCH
--%>

<%@include file="../../../../../include.jsp"%>
<div class="row">
    <div class="col-md-6" id="enterFac">
        <font size="3">
        <div class="form-group">
            <label for="exampleInputEmail1">Current Building:</label>
            <b>${buildingnamez}</b>
            <input class="form-control" id="buildingid" type="hidden" value="${buildingidz}">
            <input class="form-control" id="buildingname" type="hidden" value="${buildingnamez}">
        </div>
        </font>
    </div>
    <div class="col-md-2" id="BldFac">
        <button class="btn btn-primary pull-left" type="button" onclick="ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"  id="addfr"  href="#"><i class="fa fa-backward"></i>BACK</button>
    </div>
    <div class="col-md-4" id="BldFac">
        <button class="btn btn-primary pull-right" onclick="addbuildrooms();" type="button" id="addfrblks"  href="#" style="float: right"><i class="fa fa-plus-circle"></i>Add Room(s)</button>
    </div>
</div>
<fieldset>
    <table class="table table-hover table-bordered col-md-12" id="blockTables">
        <thead>
            <tr>
                <th class="center">No</th>
                <th class="center">Room Name</th>
                <th class="center">Deactivate/Activate Room</th>
                <th class="center">Manage Room</th>
            </tr>
        </thead>
        <tbody class="col-md-12" id="viewblocktable">
            <% int i = 1;%>
            <% int u = 1;%>
            <% int x = 1;%>
            <% int y = 1;%>
            <% int j = 1;%>
            <c:forEach items="${viewRoomsInBuilding}" var="b">
                <tr id="${b.buildingroomid}">
                    <td><%=i++%></td>
                    <td class="center">${b.buildingroomname}</td>
                    <c:if test="${b.isactive == true}">
                        <td align="center">
                            <label class="switch">
                                <input type="checkbox"  class="sliderxx" data-buildingroomid="${b.buildingroomid}" data-buildingroomname="${b.buildingroomname}" value="true" onclick="sliderTb($(this).attr('data-buildingroomid'), $(this).attr('data-buildingroomname'), $(this).val())" checked>
                                <span class="slider round"></span>
                            </label>
                        </td>
                    </c:if>
                    <c:if test="${b.isactive == false}">
                        <td align="center">
                            <label class="switch">
                                <input type="checkbox"  class="sliderxx2" data-buildingroomid="${b.buildingroomid}" data-buildingroomname="${b.buildingroomname}" id="ad<%=u++%>" value="false" onclick="sliderFb($(this).attr('data-buildingroomid'), $(this).attr('data-buildingroomname'), $(this).val());" >
                                <span class="slider round"></span>
                            </label>
                        </td>
                    </c:if>
                    <td class="center">
                        <div class="btn-group" role="group">
                            <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-sliders" aria-hidden="true"></i>
                            </button>
                            <div class="dropdown-menu dropdown-menu-left">
                                <a class="dropdown-item" href="#!" onclick="editroomname(this.id);" id="editrm<%=x++%>">Edit Room Name</a>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table> 
</fieldset>
<div class="row">
    <div class="col-md-12">
        <div id="addFacBLdrooms" class="supplierCatalogDialog">
            <div>
                <div id="divSection40">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title"><b>Add Room(s) To ${buildingnamez}</b></h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="roomcontents">

                    </div>                                        
                </div>
            </div>
        </div>
    </div>
</div>
<script>
//    function addbuildrooms() {
//        window.location = '#addFacBLdrooms';
//        initDialog('supplierCatalogDialog');
//
//        var buildingid = $('#buildingid').val();
//        var buildingname = $('#buildingname').val();
//
//        ajaxSubmitData('locationofresources/addotherroom.htm', 'roomcontents', 'tablerowid=' + buildingid + '&tableData=' + buildingname + '&nvb=0', 'GET');
//    }

    function editroomname(value) {
        var tablerowid = $('#' + value).closest('tr').attr('id');
        var tableData = $('#' + tablerowid).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();

        $.confirm({
            title: 'Edit Room Name!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Room Name</label>' +
                    '<input oninput"checkbuildingnamez();"  id="editedRMname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Room Name Here" class="name form-control" required />' +
                    '<input  id="editedRMid" type="hidden" value="' + tablerowid + '" placeholder="Please Enter Building Name Here" class="name form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {

                        var name = this.$content.find('.name').val();
                        if (!name) {
                            $('#editedRMname').addClass('error');
                            $.alert('Please Enter Room Name');
                            return false;
                        }
                        var buildingid = $('#buildingid').val();
                        var roomid = $('#editedRMid').val();
                        var roomname = $('#editedRMname').val();

                        var data = {
                            buildingid: buildingid,
                            buildingroomid: roomid,
                            buildingroomname: roomname

                        };

                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "locationofresources/Updatebuildingroom.htm",
                            data: data,
                            success: function (response) {
                                ajaxSubmitData('locationofresources/viewbuildingsinfacility.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'POST');
                            }

                        });

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

    function sliderTb(buildingroomid, name, valuex) {
        if (valuex === 'true') {
            var roomstatus = 'false';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Deactivate' + ' ' + name,
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
                                data: {isactive: roomstatus, buildingroomid: buildingroomid},
                                url: "locationofresources/activateDeactivateroom.htm",
                                success: function (data) {
                                    console.log(data);
                                    ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                            $('.sliderxx').val("false");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        } else if (valuex === 'false') {
            var roomstatus = 'true';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate' + ' ' + name,
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {isactive: roomstatus, buildingroomid: buildingroomid},
                                url: "locationofresources/activateDeactivateroom.htm",
                                success: function (data) {
                                    ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                            $('.sliderxx').val("true");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });

        }
    }
    function sliderFb(buildingroomid, name, valuex) {
        if (valuex === 'false') {
            var roomstatus = 'true';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate' + ' ' + name,
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {isactive: roomstatus, buildingroomid: parseInt(buildingroomid)},
                                url: "locationofresources/activateDeactivateroom.htm",
                                success: function (data) {
                                    ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                            $('.sliderxx2').val("true");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        } else if (valuex === 'true') {
            var roomstatus = 'false';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Deactivate' + ' ' + name,
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
                                data: {isactive: roomstatus, buildingroomid: buildingroomid},
                                url: "locationofresources/activateDeactivateroom.htm",
                                success: function (data) {
                                    ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                            $('.sliderxx2').val("false");
                        }
                    },
                    cancel: function () {
                        ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        }
    }
</script>

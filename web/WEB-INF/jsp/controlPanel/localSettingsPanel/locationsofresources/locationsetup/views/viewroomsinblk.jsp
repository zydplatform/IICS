<%-- 
    Document   : viewroomsinblk
    Created on : May 17, 2018, 1:19:23 PM
    Author     : RESEARCH
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    body {
        font-family: 'Merriweather Sans', arial, verdana;
    }

    .locationsbreadcrumb  {
        /*centering*/
        display: inline-block;
        box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.35);
        overflow: hidden;
        border-radius: 5px;
        /*Lets add the numbers for each link using CSS counters. flag is the name of the counter. to be defined using counter-reset in the parent element of the links*/
        counter-reset: flag; 
    }

    .locationsbreadcrumb a {
        text-decoration: none;
        outline: none;
        display: block;
        float: left;
        font-size: 12px;
        line-height: 36px;
        color: white;
        /*need more margin on the left of links to accomodate the numbers*/
        padding: 0 10px 0 60px;
        background: #666;
        background: linear-gradient(#666, #333);
        position: relative;
    }
    /*since the first link does not have a triangle before it we can reduce the left padding to make it look consistent with other links*/
    .locationsbreadcrumb a:first-child {
        padding-left: 46px;
        border-radius: 5px 0 0 5px; /*to match with the parent's radius*/
    }
    .locationsbreadcrumb a:first-child:before {
        left: 14px;
    }
    .locationsbreadcrumb a:last-child {
        border-radius: 0 5px 5px 0; /*this was to prevent glitches on hover*/
        padding-right: 20px;
    }

    /*hover/active styles*/
    .locationsbreadcrumb a.active, .locationsbreadcrumb a:hover{
        background: #800080;
        background: linear-gradient(#800080, #800080);
    }
    .locationsbreadcrumb a.active:after, .locationsbreadcrumb a:hover:after {
        background: #800080;
        background: linear-gradient(135deg, #BA55D3, #000);
    }

    /*adding the arrows for the breadcrumbs using rotated pseudo elements*/
    .locationsbreadcrumb a:after {
        content: '';
        position: absolute;
        top: 0; 
        right: -18px; /*half of square's length*/
        /*same dimension as the line-height of .breadcrumb a */
        width: 36px; 
        height: 36px;
        /*as you see the rotated square takes a larger height. which makes it tough to position it properly. So we are going to scale it down so that the diagonals become equal to the line-height of the link. We scale it to 70.7% because if square's: 
        length = 1; diagonal = (1^2 + 1^2)^0.5 = 1.414 (pythagoras theorem)
        if diagonal required = 1; length = 1/1.414 = 0.707*/
        transform: scale(0.707) rotate(45deg);
        /*we need to prevent the arrows from getting buried under the next link*/
        z-index: 1;
        /*background same as links but the gradient will be rotated to compensate with the transform applied*/
        background: #666;
        background: linear-gradient(135deg, #666, #333);
        /*stylish arrow design using box shadow*/
        box-shadow: 
            2px -2px 0 2px rgba(0, 0, 0, 0.4), 
            3px -3px 0 2px rgba(255, 255, 255, 0.1);
        /*
                5px - for rounded arrows and 
                50px - to prevent hover glitches on the border created using shadows*/
        border-radius: 0 5px 0 50px;
    }
    /*we dont need an arrow after the last link*/
    .locationsbreadcrumb a:last-child:after {
        content: none;
    }
    /*we will use the :before element to show numbers*/
    .locationsbreadcrumb a:before {
        content: counter(flag);
        counter-increment: flag;
        /*some styles now*/
        border-radius: 100%;
        width: 20px;
        height: 20px;
        line-height: 20px;
        margin: 8px 0;
        position: absolute;
        top: 0;
        left: 30px;
        background: #444;
        background: linear-gradient(#444, #222);
        font-weight: bold;
    }


    .flat a, .flat a:after {
        background: white;
        color: black;
        transition: all 0.5s;
    }
    .flat a:before {
        background: white;
        color: white;
        box-shadow: 0 0 0 1px #ccc;
    }
    .flat a:hover, .flat a.active, 
    .flat a:hover:after, .flat a.active:after{
        background: #800080;

    }
</style>
<div class="row">
    <div class="col-md-12">
        <div class="form-group">
            <input class="form-control" id="bldid" type="hidden" value="${buildingid}">
            <input class="form-control" id="bldname" type="hidden" value="${buildingname}">
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label">Select Block:</label>
                    <select class="form-control floor_search myform" onchange="filterFloorsNRooms()" id="selectBlocks">
                        <option class="textbolder" value="0">ALL</option>
                        <c:forEach items="${viewBlockList}" var="b">
                            <option class="textbolder" value="${b.facilityblockid}">${b.blockname}</option>
                        </c:forEach>
                    </select>
                    <select class="form-control floor_search myform hidedisplaycontent" id="selectBlock">

                    </select>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label">Select Floor:</label>
                    <select class="form-control floor_search myform" id="searchFloor" onchange="viewFloorRooms()">
                        <option class="textbolder" value="0">ALL</option>
                        <c:forEach items="${viewFloorList}" var="f">
                            <option class="textbolder" value="${f.blockfloorid}">${f.floorname}</option>
                        </c:forEach>
                    </select>
                    <select class="form-control floor_search myform hidedisplaycontent" onchange="otherRooms()" id="searchFloors">

                    </select>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="tile">
    <div class="tile-body" id="filterRooms">
        <fieldset>
            <table class="table table-hover table-bordered" id="RoomTable">
                <thead>
                    <tr>
                        <th class="center">No.</th>
                        <th class="center">Room Name</th>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or  hasAuthority('PRIVILEGE_RESOURCELOCATIONSMANAGEROOM')">        
                    <th class="center">Edit Room</th>
                </security:authorize> 
                </tr>
                </thead>
                <tbody>
                    <% int n = 1;%>
                    <% int d = 1;%>
                    <% int b = 1;%>
                    <% int t = 1;%>
                    <c:forEach items="${viewBlockRoomsList}" var="v">
                        <tr id="${v.blockroomid}">
                            <td class="center"><%=n++%></td>
                            <td class="center">${v.roomname}</td>
                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or  hasAuthority('PRIVILEGE_RESOURCELOCATIONSMANAGEROOM')">        
                        <td class="center">
                            <a href="#!" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit" onclick="editrmname(${v.blockroomid});" id="editbld<%=b++%>"><i class="fa fa-edit"></i></a>
                        </td>
                    </security:authorize> 
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </fieldset>
    </div>
</div>

<script>
    $('#RoomTable').DataTable();

    function filterFloorsNRooms() {
        var facilityblockid = document.getElementById("selectBlocks").value;
        var buildingid = $('#bldid').val();
        var buildingname = $('#bldname').val();
        console.log("--------------facilityblockid1111" + facilityblockid);

        $.ajax({
            type: 'POST',
            url: 'locationofresources/fetchBlkFloors.htm',
            data: {facilityblockid: facilityblockid, buildingId: buildingid},
            success: function (data) {
                var res = JSON.parse(data);
                console.log("-----------------response----------------------" + data);
                if (res !== '' && res.length > 0) {
                    ajaxSubmitData('locationofresources/viewBlockRooms.htm', 'filterRooms', 'facilityblockid=' + facilityblockid + '&buildingId=' + buildingid + '&buildingname=' + buildingname + '&nvb=0', 'GET');
                    $('#searchFloor').hide();
                    $('#searchFloors').show();
                    $('#searchFloors').append('<option class="classpost" value="' + 0 + '">' + 'ALL' + '</option>');
                    for (i in res) {
                        $('#searchFloors').append('<option class="classpost" id="' + res[i].blockfloorid + '" value="' + res[i].blockfloorid + '" data-floorname="' + res[i].floorname + ' ">' + res[i].floorname + '</option>');
                    }
                } else {
                    //
                    $('#searchFloor').hide();
                    $('#searchFloors').show();
                    $('#searchFloors').append('<option class="classpost" value="' + 0 + '">' + 'ALL' + '</option>');
                }
            }
        });
    }

    function viewFloorRooms() {
        var blockfloorid = document.getElementById("searchFloor").value;
        var buildingid = $('#bldid').val();
        var buildingname = $('#bldname').val();

        $.ajax({
            type: 'POST',
            url: 'locationofresources/fetchFlrRooms.htm',
            data: {blockfloorid: blockfloorid, buildingId: buildingid},
            success: function (data) {
                var res = JSON.parse(data);
                console.log("-----------------response----------------------" + data);
                if (res !== '' && res.length > 0) {
                    ajaxSubmitData('locationofresources/viewFlrRooms.htm', 'filterRooms', 'blockfloorid=' + blockfloorid + '&buildingId=' + buildingid + '&buildingname=' + buildingname + '&nvb=0', 'GET');
                    $('#selectBlocks').hide();
                    $('#selectBlock').show();
                    for (i in res) {
                        $('#selectBlock').append('<option class="classpost" id="' + res[i].facilityblockid + '" value="' + res[i].facilityblockid + '" data-floorname="' + res[i].blockname + ' ">' + res[i].blockname + '</option>');
                    }
                } else {
                    $('#selectBlocks').hide();
                    $('#selectBlock').show();
                    $('#selectBlock').append('<option class="classpost" value="' + 0 + '">' + 'ALL' + '</option>');
                }
            }
        });

    }

    function otherRooms() {
        var blockfloor = document.getElementById('searchFloors').value;
        var blockfloorid = parseInt($('#searchFloors').val());
        var floorname = $("#" + blockfloor).data("floorname");
        var buildingid = $('#bldid').val();
        var buildingname = $('#bldname').val();

        ajaxSubmitData('locationofresources/viewFlrRooms.htm', 'filterRooms', 'blockfloorid=' + blockfloorid + '&buildingId=' + buildingid + '&buildingname=' + buildingname + '&nvb=0', 'GET');
    }

    function editrmname(value) {
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
                    '<input oninput="checkroomname();"  id="editedrmname" type="text" value="' + tableData[1] + '" class="name form-control myform" required />' +
                    '<input  id="editedrmid" type="hidden" value="' + tablerowid + '" class="name myform form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {

                        var name = this.$content.find('.name').val();
                        if (!name) {
                            $('#editedrmname').addClass('error');
                            $.alert('Please Enter Room Name');
                            return false;
                        }
                        //var facilityblockid = $('#buildingid').val();
                        var blockroomid = $('#editedrmid').val();
                        var roomname = $('#editedrmname').val();
                        var floorid = $('#floorid').val();
                        var floorname = $('#floorname').val();

                        var data = {
                            // buildingid: buildingid,
                            blockroomid: blockroomid,
                            roomname: roomname
                        };

                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "locationofresources/Updatefloorroom.htm",
                            data: data,
                            success: function (response) {
                                window.location = '#close';
                                ajaxSubmitData('locationofresources/managebuilding.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }

                        });

                        $.alert('New Room Name Is ' + name);
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

    function checkroomname() {
        var roomname = $('#editedblkrmname').val();
        var floorid = $('#floorid').val();

        if (roomname.size > 0) {
            $.ajax({
                type: 'POST',
                data: {floorid: floorid, roomname: roomname},
                url: "locationofresources/checkEditedRoomNames.htm",
                success: function (data) {
                    console.log("-----data--------" + data)
                    if (data === 'existing') {
                        $('#editedblkrmname').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: roomname + ' Already Exists',
                        });
                    } else {
                        $('#editedblkrmname').removeClass('error');
                    }
                }
            });
        }
    }


//    function addblkrooms() {
//
//        window.location = '#addBLKrooms';
//        initDialog('supplierCatalogDialog');
//
//        ajaxSubmitData('locationofresources/addthefloorroom.htm', 'levelroomcontents', 'tablerowid=${floorid}&tableData=${floorname}&a=${blkid}&b=${blkname}' + '&nvb=0', 'GET');
//    }
//
//    function removeroomsfromblock(id) {
//        $.confirm({
//            title: 'Message!',
//            content: 'Do You Seriously Want To Delete This Room?',
//            type: 'red',
//            typeAnimated: true,
//            buttons: {
//                tryAgain: {
//                    text: 'Yes',
//                    btnClass: 'btn-red',
//                    action: function () {
//                        var tablerowid = $('#' + id).closest('tr').attr('id');
//                        $.ajax({
//                            type: 'POST',
//                            data: {blockroomid: tablerowid},
//                            url: "locationofresources/removeroomfromBlock",
//                            success: function (data, textStatus, jqXHR) {
//                                if (data === 'success') {
//                                    $.alert({
//                                        title: 'Alert!',
//                                        content: 'Room Successfully Removed',
//                                    });
//                                    $('#' + tablerowid).remove();
//
//                                    ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                                }
//                            }
//
//                        });
//                    }
//                },
//                No: function () {
//                    ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                }
//            }
//        });
//
//    }
//
//    function sliderDR(blockroomid, name, valuex) {
//        if (valuex === 'true') {
//            var roomstatus = 'false';
//            $.confirm({
//                title: 'Message!',
//                content: 'Your about to De-Assign' + ' ' + name,
//                type: 'red',
//                typeAnimated: true,
//                buttons: {
//                    tryAgain: {
//                        text: 'Yes',
//                        btnClass: 'btn-red',
//                        action: function () {
//                            $.ajax({
//                                type: 'GET',
//                                cache: false,
//                                dataType: 'text',
//                                data: {roomstatus: roomstatus, blockroomid: blockroomid},
//                                url: "locationofresources/assignDeassignroom.htm",
//                                success: function (data) {
//                                    // ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                                }
//                            });
//                            $('.sliderxx').val("false");
//                        }
//                    },
//                    cancel: function () {
//                        ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                    }
//                }
//            });
//        } else if (valuex === 'false') {
//            var roomstatus = 'true';
//            $.confirm({
//                title: 'Message!',
//                content: 'Your about to Assign' + ' ' + name,
//                type: 'green',
//                typeAnimated: true,
//                buttons: {
//                    tryAgain: {
//                        text: 'Yes',
//                        btnClass: 'btn-green',
//                        action: function () {
//                            $.ajax({
//                                type: 'GET',
//                                cache: false,
//                                dataType: 'text',
//                                data: {roomstatus: roomstatus, blockroomid: blockroomid},
//                                url: "locationofresources/assignDeassignroom.htm",
//                                success: function (data) {
//                                    //ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                                }
//                            });
//                            $('.sliderxx').val("true");
//                        }
//                    },
//                    cancel: function () {
//                        ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                    }
//                }
//            });
//
//        }
//    }
//    function sliderAR(blockroomid, name, valuex) {
//        if (valuex === 'false') {
//            var roomstatus = (valuex === 'false');
//            $.confirm({
//                title: 'Message!',
//                content: 'Your about to Assign' + ' ' + name,
//                type: 'green',
//                typeAnimated: true,
//                buttons: {
//                    tryAgain: {
//                        text: 'Yes',
//                        btnClass: 'btn-green',
//                        action: function () {
//                            $.ajax({
//                                type: 'GET',
//                                cache: false,
//                                dataType: 'text',
//                                data: {roomstatus: roomstatus, blockroomid: parseInt(blockroomid)},
//                                url: "locationofresources/assignDeassignroom.htm",
//                                success: function (data) {
//                                    //ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                                }
//                            });
//                            $('.sliderxx2').val("true");
//                        }
//                    },
//                    cancel: function () {
//                        ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                    }
//                }
//            });
//        } else if (valuex === 'true') {
//            var roomstatus = (valuex === 'true');
//            $.confirm({
//                title: 'Message!',
//                content: 'Your about to De-Assign' + ' ' + name,
//                type: 'red',
//                typeAnimated: true,
//                buttons: {
//                    tryAgain: {
//                        text: 'Yes',
//                        btnClass: 'btn-red',
//                        action: function () {
//                            $.ajax({
//                                type: 'GET',
//                                cache: false,
//                                dataType: 'text',
//                                data: {roomstatus: roomstatus, blockroomid: blockroomid},
//                                url: "locationofresources/assignDeassignroom.htm",
//                                success: function (data) {
//                                    //ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                                }
//                            });
//                            $('.sliderxx2').val("false");
//                        }
//                    },
//                    cancel: function () {
//                        ajaxSubmitData('locationofresources/managebuilding.htm', 'content1', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                    }
//                }
//            });
//        }
//    }

</script>
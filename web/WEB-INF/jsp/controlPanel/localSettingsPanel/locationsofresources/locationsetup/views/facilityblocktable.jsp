<%-- 
    Document   : facilityblocktable
    Created on : May 17, 2018, 4:49:43 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<style>
    #overlayop {
        background: rgba(0,0,0,0.5);
        color: #FFFFFF;
        position: fixed;
        height: 100%;
        width: 100%;
        z-index: 5000;
        top: 0;
        left: 0;
        float: left;
        text-align: center;
        padding-top: 25%;
    }
    .error
    {
        border:2px solid red;
    }

    .container {padding:20px;}
    .form-control {width:120px;}
    .popover {max-width:400px;}

    #popover-content-logout > * {
        background-color:#ff0000 !important;
    }

</style>
<div class="row">
    <input class="form-control myform" id="facilityidz" value="${FacilityListed.facilityid}" type="hidden">
    <input class="form-control myform" id="facilitynamez" value="${FacilityListed.facilityname}" type="hidden" readonly="true">
    <c:if test="${not empty BuildingsLists}">
        <table class="table table-hover table-bordered" id="ViewlocationsTab">
            <thead>
                <tr>
                    <th class="center">No.</th>
                    <th class="center">Building Name</th>
                    <th class="center">No. Of Blocks In Building</th>
                    <th class="center">No. Of Floors In Building</th>
                    <th class="center">No. Of Rooms In Building</th>
                    <th class="center">Manage Building</th>
                </tr>
            </thead>
            <tbody>
                <% int u = 1;%>
                <% int k = 1;%>
                <% int a = 1;%>
                <% int r = 1;%>
                <% int nb = 1;%>
                <% int nf = 1;%>
                <% int nr = 1;%>
                <% int v = 1;%>
                <% int o = 1;%>
                <% int b = 1;%>
                <% int m = 1;%>
                <c:forEach items="${BuildingsLists}" var="B">
                    <tr id="${B.buildingid}">
                        <td class="center"><%=k++%></td>
                        <td class="center">${B.buildingname}</td>
                        <td class="center">
                            <c:if test="${B.blocksize == 0}">
                                <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${B.buildingname} Has no block(s) please click manage button to add block(s)" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red; color: white" data-buildingid="${a.facilityblockid}" data-blockname="${a.blockname}">
                                    <span id="blocksz">${B.blocksize}</span>
                                </a>
                            </c:if>
                            <c:if test="${B.blocksize > 0}">
                                <a><button id="viewrmz" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: #00bfff;; color: white" onclick="viewblocksinbuilding(${B.buildingid}, '${B.buildingname}');"><span id="blocksz">${B.blocksize}</span></button></a>
                                    </c:if>
                        </td>
                        <td class="center">
                            <c:if test="${B.floorsinbuilding == 0}">
                                <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${B.buildingname} Has no floor(s)" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red; color: white" data-buildingid="${a.facilityblockid}" data-blockname="${a.blockname}">
                                    <span id="blocksz">${B.floorsinbuilding}</span>
                                </a>
                            </c:if>
                            <c:if test="${B.floorsinbuilding > 0}">
                                <a><button id="viewrmz" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: #00bfff; color: white" onclick="viewfloorsinbuilding(${B.buildingid}, '${B.buildingname}');"><span id="blocksz">${B.floorsinbuilding}</span></button></a>
                                    </c:if>
                        </td>
                        <td class="center">
                            <c:if test="${B.roomsinbuilding == 0}">
                                <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${B.buildingname} Has no room(s)" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red; color: white" data-buildingid="${a.facilityblockid}" data-blockname="${a.blockname}">
                                    <span id="blocksz">${B.roomsinbuilding}</span>
                                </a>
                            </c:if>
                            <c:if test="${B.roomsinbuilding > 0}">
                                <a><button id="viewrmz" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: #00bfff;; color: white" onclick="viewroomsinbuilding(${B.buildingid}, '${B.buildingname}');"><span id="blocksz">${B.roomsinbuilding}</span></button></a>
                                    </c:if>
                        </td>
                        <td class="center">
                            <div class="btn-group" role="group">
                                <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-sliders" aria-hidden="true"></i>
                                </button>
                                <div class="dropdown-menu dropdown-menu-left">
                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or  hasAuthority('PRIVILEGE_RESOURCELOCATIONSEDITBULIDING')">        
                                        <a class="dropdown-item" href="#!" onclick="editbuilding(this.id);" id="editbld<%=a++%>">Edit Building Name</a>
                                    </security:authorize>      
                                    <span class="dropdown-item" style="cursor: pointer;" onclick="addblocks(this.id);" id="addb<%=nb++%>">Add Block(s)</span>
                                    <span class="dropdown-item" style="cursor: pointer;" onclick="addfloors(this.id);" id="addf<%=nf++%>">Add Floor(s)</span>
                                    <span class="dropdown-item" style="cursor: pointer;" onclick="addrooms(this.id);" id="addr<%=nr++%>">Add Room(s)</span>
<!--                                    //<span class="dropdown-item" style="cursor: pointer;" onclick="deletebuilding(this.id);" id="deletem<%=b++%>">Delete Building</span>-->
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div id="overlayop" style="display: none;">
            <img src="static/img2/loader.gif" alt="Loading" /><br/>
            Please Wait...
        </div>
    </c:if>
    <c:if test="${empty BuildingsLists}">
        <div class="row">
            <div class="col-md-12">
                <b class="center"><strong><font size="4">NO BUILDING(S) REGISTERED FOR <b>${FacilityListed.facilityname}</b></font></strong></b>
            </div>
        </div>
    </c:if>
</div>
<div class="row">
    <div class="col-md-12" id="addfacblock">
        <div id="addfacblocks" class="supplierCatalogDialog">
            <div>
                <div id="divSection22">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Add Block(s) To Building</h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="blockcontents">

                    </div>                                        
                </div>
                <div id="divSection7" class="hidedisplaycontent">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Add Floor(s) To A Block</h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="floorblkcontent">

                    </div>                                        
                </div>

                <div id="divSection8" class="hidedisplaycontent">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Add Room(s) To A Floor</h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="roomfloorcontent">

                    </div>                                        
                </div>
                
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12" id="addfacfloor">
        <div id="addfacfloors" class="supplierCatalogDialog">
            <div>
                <div id="divSection89">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Add Floor(s) To Building</h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="floorcontents">

                    </div>                                        
                </div>
                <div id="divSection90" class="hidedisplaycontent">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Add Room(s) To A Floor</h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="roomcontent">

                    </div>                                        
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12" id="addfacroom">
        <div id="addfacrooms" class="supplierCatalogDialog">
            <div>
                <div id="divSection91">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Add Room(s) To Building</h2>
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
    $(document).ready(function () {
        $('#ViewlocationsTab').DataTable();
    });


    $('.pop1').each(function (i, obj) {
        $(this).popover({
            html: true,
            content: function () {
                var id = $(this).attr('id');
                var popup = $('#popover-content-login' + id).html();
                return popup;

            }
        });
    });

    function viewblocksinbuilding(buildingId, buildingName) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "locationofresources/viewBlocks.htm",
            data: {buildingId: buildingId, buildingname: buildingName},
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Blocks In' + ' ' + buildingName + '</strong>',
                    content: '' + data,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
//        ajaxSubmitData('locationofresources/viewbuildingsinfacility.htm', 'viewblkrooms', 'act=a&buildingId=' + buildingId + '&buildingname=' + buildingName + '', 'POST');
    }

    function viewfloorsinbuilding(buildingId, buildingName) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "locationofresources/viewfacblockfloors.htm",
            data: {buildingId: buildingId, buildingname: buildingName},
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Floors In' + ' ' + buildingName + '</strong>',
                    content: '' + data,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
//        ajaxSubmitData('locationofresources/viewbuildingsinfacility.htm', 'viewblkrooms', 'act=a&buildingId=' + buildingId + '&buildingname=' + buildingName + '', 'POST');
    }

    function viewfloorsinbuilding(buildingId, buildingName) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "locationofresources/viewfacblockfloors.htm",
            data: {buildingId: buildingId, buildingname: buildingName},
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Floors In' + ' ' + buildingName + '</strong>',
                    content: '' + data,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
//        ajaxSubmitData('locationofresources/viewbuildingsinfacility.htm', 'viewblkrooms', 'act=a&buildingId=' + buildingId + '&buildingname=' + buildingName + '', 'POST');
    }

    function viewroomsinbuilding(buildingId, buildingName) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "locationofresources/viewFloorrooms.htm",
            data: {buildingId: buildingId, buildingname: buildingName},
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Rooms In' + ' ' + buildingName + '</strong>',
                    content: '' + data,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
//        ajaxSubmitData('locationofresources/viewbuildingsinfacility.htm', 'viewblkrooms', 'act=a&buildingId=' + buildingId + '&buildingname=' + buildingName + '', 'POST');
    }

    function deletebuilding(value) {
        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');

        $('#buildingidz').val(tablerowid);
        $('#buildingnamez').val(tableData[1]);

        ajaxSubmitData('locationofresources/deleteBuilding.htm', '', 'tablerowid=' + tablerowid + '&tableData=' + tableData[1] + '&nvb=0', 'GET');

    }
    function editbldname(value) {
        var tablerowid = $('#' + value).closest('tr').attr('id');
        var tableData = $('#' + tablerowid).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();

        $.confirm({
            title: 'Edit Building Name!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Building Name</label>' +
                    '<input oninput="checkeditedbuildingname();"  id="editedbldname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Building Name Here" class="name form-control" required />' +
                    '<input  id="editedbldid" type="hidden" value="' + tablerowid + '" placeholder="Please Enter Building Name Here" class="myform form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {

                        var name = this.$content.find('.name').val();
                        if (!name) {
                            $('#editedbldname').addClass('error');
                            $.alert('Please Enter Building Name');
                            return false;
                        }
                        var facilityid = $('#facilityid').val();
                        var buildingname = $('#editedbldname').val();
                        var buildingid = $('#editedbldid').val();

                        var data = {
                            facilityid: facilityid,
                            buildingname: buildingname,
                            buildingid: buildingid

                        };

                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "locationofresources/Updatefacilitybuilding.htm",
                            data: data,
                            success: function (response) {
                                window.location = '#close';
                                ajaxSubmitData('locationofresources/managebuilding.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }

                        });

                        $.alert('New Building Name Is ' + name);
                    }
                },
                cancel: function () {
                },
            },
            onContentReady: function () {
                this.$content.find('.form-control').css('width', '100%')
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click');
                });
            }
        });
    }


    function checkeditedbuildingname() {
        var buildingname = $('#editedbldname').val();
        var facilityid = document.getElementById('facilityidz').value;

        if (buildingname.size > 0) {
            $.ajax({
                type: 'POST',
                data: {facilityid: facilityid, buildingname: buildingname},
                url: "locationofresources/checkfacilitybuildingname.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'existing') {
                        $('#editedbldname').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: buildingname + ' Already Exists',
                        });
                    } else {
                        $('#editedbldname').removeClass('error');
                    }
                }
            });
        }
    }

    function addblocks(value) {
        window.location = '#addfacblocks';
        initDialog('supplierCatalogDialog');

        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');

        $('#buildingidz').val(tablerowid);
        $('#buildingnamez').val(tableData[1]);

        ajaxSubmitData('locationofresources/addotherblock.htm', 'blockcontents', 'tablerowid=' + tablerowid + '&tableData=' + tableData[1] + '&nvb=0', 'GET');
    }
    
    function addfloors(value) {
        window.location = '#addfacfloors';
        initDialog('supplierCatalogDialog');

        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');

        $('#buildingidz').val(tablerowid);
        $('#buildingnamez').val(tableData[1]);

        ajaxSubmitData('locationofresources/addfloors.htm', 'floorcontents', 'tablerowid=' + tablerowid + '&tableData=' + tableData[1] + '&nvb=0', 'GET');

    }
    
    function addrooms(value) {
        window.location = '#addfacrooms';
        initDialog('supplierCatalogDialog');

        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');

        $('#buildingidz').val(tablerowid);
        $('#buildingnamez').val(tableData[1]);

        ajaxSubmitData('locationofresources/addtherooms.htm', 'roomcontents', 'tablerowid=' + tablerowid + '&tableData=' + tableData[1] + '&nvb=0', 'GET');

    }

    function sliderTB(buildingid, name, valuex) {
        if (valuex === 'true') {
            var bldstatus = 'false';
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
                                data: {isactive: bldstatus, buildingid: buildingid},
                                url: "locationofresources/activateDeactivatebuilding.htm",
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
            var bldstatus = 'true';
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
                                data: {isactive: bldstatus, buildingid: buildingid},
                                url: "locationofresources/activateDeactivatebuilding.htm",
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
    function sliderFB(buildingid, name, valuex) {
        if (valuex === 'false') {
            var bldstatus = 'true';
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
                                data: {isactive: bldstatus, buildingid: parseInt(buildingid)},
                                url: "locationofresources/activateDeactivatebuilding.htm",
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
            var bldstatus = 'false';
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
                                data: {isactive: bldstatus, buildingid: buildingid},
                                url: "locationofresources/activateDeactivatebuilding.htm",
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
    
   
        
        
    }
</script>
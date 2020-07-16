<%@include file = "../../../../include.jsp" %>

<div class="row">
    <input class="form-control myform" id="facilityidz" value="${FacilityListed.facilityid}" type="hidden">
    <input class="form-control myform" id="facilityname" value="${FacilityListed.facilityname}" type="hidden" readonly="true">
    <table class="table  table-bordered" id="viewtable">    
        <thead>   
            <tr>   
                <th class="center">No.</th>  
                <th class="center">Building Name</th>   
                <th class="center">No. Of Floors In Building</th>   
                <th class="center">No. Of Rooms In Building</th>  
                <th class="center">Manage Building</th>
                <!--<th class="center">Update</th>-->
                <!--<th class="center">Delete</th>-->
            </tr>
        </thead> 
        <tbody>
            <% int k = 1;%>  
            <% int a = 1;%>  
            <% int nf = 1;%> 
            <% int nr = 1;%>
            <c:forEach items="${buildingLists}" var="B">
                <tr id="${B.buildingid}">
                    <td class="center"><%=k++%></td>
                    <td class="center">${B.buildingname}</td>
                    <td class="center">
                        <c:if test="${B.floorsize == 0}">
                            <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="${B.buildingname} Has no floor(s)" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red; color: white">
                                <span id="floorsz">${B.floorsize}</span>
                            </a>
                        </c:if>
                        <c:if test="${B.floorsize > 0}">
                            <a  data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" data-content="click here to view floor(s)" href="#!"><button id="viewrmz" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: #008000; color: white" onclick="viewfloorsinbuilding(${B.buildingid}, '${B.buildingname}');"><span id="floorsz">${B.floorsize}</span></button></a>    
                                </c:if>
                    </td>
                    <td class="center">
                        <c:if test="${B.roomsinbuilding == 0}">
                            <a data-container="body"  data-toggle="popover" data-placement="top" data-content="${B.buildingname} Has no room(s)" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red; color: white" data-buildingid="${a.floorid}" data-blockname="${a.floorname}">
                                <span id="floorsz">${B.roomsinbuilding}</span>
                            </a>
                        </c:if>
                        <c:if test="${B.roomsinbuilding > 0}">
                            <a><button id="viewrmz" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: #008000;; color: white" onclick="viewroomsinbuilding(${B.buildingid}, '${B.buildingname}');"><span id="floorsz">${B.roomsinbuilding}</span></button></a>
                                </c:if>
                    </td>
                    <td data-label="Manage" align="center">
                        <div class="btn-group" role="group">
                            <button class="btn btn-sm  btn-primary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-lg fa-dedent" aria-hidden="true"></i></button>
                            <div class="dropdown-menu dropdown-menu-left">        

                                <span class="dropdown-item" style="cursor: pointer;" onclick="addfloors(this.id);" id="addf<%=nf++%>">Add more Floor(s)</span>
                                <span class="dropdown-item" style="cursor: pointer;" onclick="addrooms(this.id);" id="addr<%=nr++%>">Add more Room(s)</span>  
                                <span class="dropdown-item" style="cursor: pointer;" onclick="editBuildingname(${B.buildingid});">Update building</span>
                                <span class="dropdown-item" style="cursor: pointer;" onclick="updatefloor(${B.buildingid});" id="" data-toggle="popover">Update floor</span>
                                <span class="dropdown-item" style="cursor: pointer;" onclick="updateroom(${B.buildingid});" data-toggle="popover">Update room</span>
                                <span class="dropdown-item" style="cursor: pointer;" onclick="mergeroom(${B.buildingid});" data-toggle="popover">Merge room</span>
                                <span class="dropdown-item" style="cursor: pointer;" onclick="partitionroom(${B.buildingid});" data-toggle="popover">Partition room</span>

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
</div>

<div class="row">
    <div class="col-md-12" id="addfacblock">
        <div id="addfacblocks" class="supplierCatalogDialog">
            <div>
                <div id="divSection22">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Add Floor(s) In Building</h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="floorcontents">
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
                        <h2 class="modalDialog-title">Add Room(s) In Floor</h2>
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
    var updatefloordialog = null;
    var updateroomdialog = null;
    var mergedialog = null;
    var roomarray =[];
    var roomIds = [];
    var  roomids =[];
    var roomarrayss =[];
       $('#viewtable').DataTable();
  
    $('[data-toggle="popover"]').popover();
    function viewfloorsinbuilding(buildingId, buildingName) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "facilityinfrastructure/viewfloorsinbuilding.htm",
            data: {buildingid: buildingId, buildingname: buildingName},
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

    function addfloors(value) {
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

        ajaxSubmitData('facilityinfrastructure/addfloors.htm', 'floorcontents', 'tablerowid=' + tablerowid + '&tableData=' + tableData[1] + '&nvb=0', 'GET');

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

        ajaxSubmitData('facilityinfrastructure/managerooms.htm', 'roomcontents', 'tablerowid=' + tablerowid + '&tableData=' + tableData[1] + '&nvb=0', 'GET');

    }

    function editBuildingname(id) {
        $('#buildingid').val(id);
        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        $.confirm({
            title: 'Change Building Name!',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            closeIcon: true,
            theme: 'modern',
            icon: 'fa fa-question-circle',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Building Name</label><br>' +
                    '<span id="errormessage" style="color: red"><strong><strong></span>' +
                    '<input  id="editedBuildingnamez" type="text" value="' + tableData[1] + '" placeholder="Please Enter Building Name Here" class="name form-control myform" oninput="checkregex(this);" required />' +
                    '<span id= "errorxx">' +
                    '</span>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                        var buildingid = id;
                        var buildingname = $('#editedBuildingnamez').val().toUpperCase();
                        if (buildingname.trim().length === 0 || buildingname === undefined) {
                            $('#errorxx').html('<span style="color:red">*Field Required.*</span>');
                            $(obj).focus();
                            return false;
                        } else {
                            $.ajax({
                                type: 'POST',
                                data: {buildingid: buildingid, buildingname: buildingname},
                                url: 'facilityinfrastructure/updatebuilding.htm',
                                success: function () {
                                    $.toast({
                                        heading: 'Success',
                                        text: 'Building Updated Successfully.',
                                        icon: 'success',
                                        hideAfter: 2000,
                                        position: 'top-center'
                                    });
                                    ajaxSubmitData('facilityinfrastructure/manageinfrastructure.htm', 'workpane', '', 'GET');
                                }
                            });
                        }

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
    function checkregex(obj) {

        var Existingbuild = ${existingbuilding};
        var ExistingbuildNameSet = new Set();
        for (var x in Existingbuild) {
            if (Existingbuild.hasOwnProperty(x)) {

                ExistingbuildNameSet.add(Existingbuild[x].buildingname);
            }
        }
        var buildingname = $(obj).val().toUpperCase();
        var regex = /^([a-zA-Z])[a-zA-Z_-]*[\w_-]*[\S]$|^([a-zA-Z])[0-9_-]*[\S]$|^[a-zA-Z]*[\S]$/;
        var testname = regex.test(buildingname);
        if (testname != true) {
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
                            $(obj).val('');
                        }
                    }
                }
            });
        } else if (ExistingbuildNameSet.has(buildingname)) {
            $(obj).focus();
            $(obj).addClass('error');
            $.alert({
                title: 'Alert!',
                content: buildingname + ' Already Exists',
            });
            $(obj).val('');
        } else {
            return true;
        }

    }



    function updatefloor(buildingId) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "facilityinfrastructure/viewfloorlist.htm",
            data: {buildingid: buildingId},
            success: function (data) {
                updatefloordialog = $.confirm({
                    title: '<strong class="center">Floor list</strong>',
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

    function updateroom(buildingid)

    {
        $.ajax({
            type: "GET",
            cache: false,
            url: "facilityinfrastructure/roomlist.htm",
            data: {buildingid: buildingid},
            success: function (data) {
                updateroomdialog = $.confirm({
                    title: '<strong class="center">Room list</strong>',
                    content: '' + data,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });

    }
    function mergeroom(value) {
        $.ajax({

            type: "GET",
            cache: false,
            url: "facilityinfrastructure/mergeroom.htm",
            data: {buildingid: value},
            success: function (data) {
                mergedialog = $.confirm({
                    title: '<strong class="center">Merge room</strong>',
                    content: '' + data,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    buttons: {
                        formSubmit: {
                            text: 'MERGE',
                            btnClass: 'btn-green',
                            action: function () {
                                $.ajax({
                                    type: 'GET',
                                    cache: false,
                                    dataType: 'text',
                                    url: "facilityinfrastructure/savemerge.htm",
                                    data: {rooms: JSON.stringify(roomarray), roomIds:JSON.stringify(roomIds)},
                                    success: function (data) {
                                         $.toast({
                                        heading: 'Success',
                                        text: 'Merge Successfull.',
                                        icon: 'success',
                                        hideAfter: 2000,
                                        position: 'top-center'
                                    });
                                    ajaxSubmitData('facilityinfrastructure/manageinfrastructure.htm', 'workpane', '', 'GET');
                                    }
                                });

                            }
                        },
                        cancel: function () {
                            //close
                        }
                    }


                });
            }
        });

    }

  function partitionroom(value){
                $.ajax({
            type: "GET",
            cache: false,
            url: "facilityinfrastructure/partitionroom.htm",
            data: {buildingid: value},
            success: function (data) {
                partitionroomdialog =$.confirm({
                    title: '<strong class="center">Partition rooms in </strong>',
                    content: '' + data,
                    boxWidth: '40%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                                buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {
                            $.ajax({
                                    type: 'GET',
                                    cache: false,
                                    dataType: 'text',
                                    url: "facilityinfrastructure/savepartition.htm",
                                    data: {rooms: JSON.stringify(roomarrayss), roomIds: JSON.stringify(roomids)},
                                    success: function (data) {
                                         $.toast({
                                        heading: 'Success',
                                        text: 'Partition Successfull.',
                                        icon: 'success',
                                        hideAfter: 2000,
                                        position: 'top-center'
                                    });
                                    ajaxSubmitData('facilityinfrastructure/manageinfrastructure.htm', 'workpane', '', 'GET');
                                    }
                                });

                    }
                },
                cancel: function () {
                    //close
                },
            }

                });
            }
        });
    }

</script>
<%-- 
    Document   : viewblksinbuilding
    Created on : May 21, 2018, 1:03:51 PM
    Author     : RESEARCH
--%>

<%@include file="../../../../../include.jsp"%>

<div class="row">
    <div class="col-md-12">
        <div class="form-group">
            <input class="form-control" id="buildingid" type="hidden" value="${buildingidz}">
            <input class="form-control" id="buildingname" type="hidden" value="${buildingnamez}">
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <span><b>BUILDING:&nbsp;
            </b></span> <h5><span class="badge badge-secondary"><strong>${buildingnamez}</strong></span></h5> 
    </div>
</div>
<div class="tile">
    <div class="tile-body">
        <fieldset>
            <table class="table table-hover table-bordered col-md-12" id="blockTables">
                <thead>
                    <tr>
                        <th class="center">No</th>
                        <th class="center">Block Name</th>
                        <th class="center">Edit Block</th>
                    </tr>
                </thead>
                <tbody class="col-md-12" id="viewblocktable">
                    <% int i = 1;%>
                    <% int u = 1;%>
                    <% int x = 1;%>
                    <% int y = 1;%>
                    <% int j = 1;%>
                    <c:forEach items="${viewBlocksInFacility}" var="a">
                        <tr id="${a.facilityblockid}">
                            <td><%=i++%></td>
                            <td class="center">${a.blockname}</td>
                            <td class="center">
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or  hasAuthority('PRIVILEGE_RESOURCELOCATIONSEDITBLOCK')">        
                                    <a href="#!" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit" onclick="editblkname(${a.facilityblockid});" id="editbld<%=j++%>"><i class="fa fa-edit"></i></a>
                                    </security:authorize> 
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table> 
        </fieldset>
    </div>
</div>

<script>
    $('[data-toggle="popover"]').popover();
    $('#blockTables').DataTable();
    function editblkname(value) {
        var tablerowid = $('#' + value).closest('tr').attr('id');
        console.log("data-----jj--------------" + tablerowid[1]);
        var tableData = $('#' + tablerowid).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        console.log("data-------------------" + tableData[1]);
        $.confirm({
            title: 'Edit Block Name!',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Block Name</label>' +
                    '<input oninput="checkEditedBlockName();"  id="editedblkname" type="text" value="' + tableData[1] + '" placeholder="Please Enter Block Name Here" class="name form-control myform" required />' +
                    '<input  id="editedblkid" type="hidden" value="' + tablerowid + '" placeholder="Please Enter Building Name Here" class="name form-control" required />' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'SAVE',
                    btnClass: 'btn-green',
                    action: function () {

                        var name = this.$content.find('.name').val();
                        if (!name) {
                            $('#editedblkname').addClass('error');
                            $.alert('Please Enter Block Name');
                            return false;
                        }
                        var buildingid = $('#buildingid').val();
                        var facilityblockid = $('#editedblkid').val();
                        var blockname = $('#editedblkname').val();
                        var buildingname = $('#buildingname').val();

                        var data = {
                            buildingid: buildingid,
                            facilityblockid: facilityblockid,
                            blockname: blockname

                        };

                        $.ajax({
                            type: "POST",
                            cache: false,
                            url: "locationofresources/Updatefacilityblock.htm",
                            data: data,
                            success: function (response) {
                                window.location = '#close';
                               ajaxSubmitData('locationofresources/managebuilding.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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

    function checkEditedBlockName() {
        var buildingid = $('#buildingid').val();
        var blockname = $('#editedblkname').val();

        if (blockname.size > 0) {
            $.ajax({
                type: 'POST',
                data: {buildingid: buildingid, blockname: blockname},
                url: "locationofresources/checkBlockNames.htm",
                success: function (data, textStatus, jqXHR) {
                    if (data === 'existing') {
                        $('#editedblkname').addClass('error');
                        $.alert({
                            title: 'Alert!',
                            content: blockname + ' Already Exists',
                        });
                    } else {
                        $('#editedblkname').removeClass('error');
                    }
                }
            });
        }
    }
</script>
<%-- 
    Document   : GroupForm
    Created on : Jul 20, 2018, 2:50:36 PM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row" >
    <div class="col-md-4">
        <div class="row" style="overflow: auto; height: 350px;" id="">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Enter Group Details</h4>
                    <div class="tile-body">
                        <form>
                            <div class="form-group">
                                <label class="control-label">Group Name.</label>
                                <input class="accessrightsgroupname form-control" type="text">
                            </div>
                            <div class="form-group">
                                <label class="control-label">Group More Info.</label>
                                <textarea class="accessrightgroupinfo form-control" id="groupinfo" rows="3"></textarea>                            </div>
                        </form>
                    </div>
                    <div class="tile-footer">
                        <button class="btn btn-primary" onclick="addNewAccessGroup();" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            Add Group
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-8">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h4 class="tile-title">Entered Groups.</h4>
                    <input id="facilityaddComponentsdivs" value="0" type="hidden">
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Group Name</th>
                                <th>Granted Access</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody id="enteredGroupAccessRightsBody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function addNewAccessGroup() {
        var groupname = $('.accessrightsgroupname').val();
        var groupdescription = $('.accessrightgroupinfo').val();
        if (!groupname) {
            $.alert('provide a valid name');
            return false;
        }
        if (!groupdescription) {
            $.alert('provide a valid More Info');
            return false;
        }
        $.confirm({
            title: 'Add Activities!',
            content: 'Do You Want To Add Access Activites?',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {groupname: groupname, groupdescription: groupdescription},
                            url: "localaccessrightsmanagement/saveaccessrightsgroup.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data !== '') {
                                    $.ajax({
                                        type: 'GET',
                                        data: {data: 'data', groupid: data},
                                        url: "localaccessrightsmanagement/components.htm",
                                        success: function (data, textStatus, jqXHR) {
                                            $('#enteredGroupAccessRightsBody').append('<tr><td>' + groupname + '</td>' +
                                                    '<td><button type="button" class="btn btn-primary btn-sm" onclick=""><i class="fa fa-dedent"><span class="badge badge-light" id="SpanFacilityGroupAssignedComponents">0</span>Components(s)</i></button></td>' +
                                                    '<td> <span  title="Delete Of This Group." onclick=""  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');
                                            $.confirm({
                                                title: 'Select Component Activities',
                                                content: '' + data,
                                                type: 'purple',
                                                boxWidth: '80%',
                                                useBootstrap: false,
                                                typeAnimated: true,
                                                buttons: {
                                                    close: function () {
                                                    }
                                                }
                                            });
                                        }
                                    });
                                } else {
                                    $.confirm({
                                        title: 'Encountered an error!',
                                        icon: 'fa fa-warning',
                                        content: 'Something went Wrong, Contact System Admin',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                            }
                                        }
                                    });
                                }
                            }
                        });
                    }
                },
                No: function () {
                    $.ajax({
                        type: 'POST',
                        data: {groupname: groupname, groupdescription: groupdescription},
                        url: "localaccessrightsmanagement/saveaccessrightsgroup.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data !== '') {
                                $('#enteredGroupAccessRightsBody').append('<tr><td>' + groupname + '</td>' +
                                        '<td><button type="button" class="btn btn-primary btn-sm" onclick=""><i class="fa fa-dedent"><span class="badge badge-light">0</span>Components(s)</i></button></td>' +
                                        '<td> <span  title="Delete Of This Group." onclick=""  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></td></tr>');
                            } else {
                                $.confirm({
                                    title: 'Encountered an error!',
                                    icon: 'fa fa-warning',
                                    content: 'Something went Wrong, Contact System Admin',
                                    type: 'red',
                                    typeAnimated: true,
                                    buttons: {
                                        close: function () {
                                        }
                                    }
                                });
                            }
                        }
                    });
                }
            }
        });
    }
</script>
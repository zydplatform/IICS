<%-- 
    Document   : GroupsTable
    Created on : Jul 20, 2018, 12:58:40 PM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div >
    <div class="row">
        <div class="col-md-12">
            <button onclick="addnewfacilityaccessrightsgroup();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add New Group</button>
        </div>
    </div>
    <div style="margin: 10px;">
        <fieldset style="min-height:100px;">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body"><br><br>
                            <table class="table table-hover table-bordered" id="AccessRightsGroupPrivileges">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Group Name</th>
                                        <th>Active</th>
                                        <th>Granted Access</th>
                                        <th>Granted Components</th>
                                        <th>Update | Delete</th>
                                    </tr>
                                </thead>
                                <tbody >
                                    <% int j = 1;%>
                                    <% int i = 1;%>
                                <c:forEach items="${accessRightsGroupList}" var="a">
                                    <tr>
                                        <td><%=j++%></td>
                                        <td>${a.accessrightgroupname}</td>
                                        <td align="center">
                                            <div class="toggle-flip">
                                                <label>
                                                    <input  type="checkbox"<c:if test="${a.active==true}">checked="true"</c:if>><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td align="center">
                                            <button type="button" class="btn btn-primary btn-sm" onclick="viewgroupassignedComponents(${a.accessrightsgroupid}, '${a.accessrightgroupname}',${a.componentscount});">
                                                <i class="fa fa-dedent">
                                                </i>
                                            </button>
                                        </td>
                                        <td align="center">
                                            <button type="button" class="btn btn-primary btn-sm" onclick="viewaddgroupassignedComponents(${a.accessrightsgroupid}, '${a.accessrightgroupname}',${a.componentscount});">
                                                <i class="fa fa-plus">
                                                    <span class="badge badge-light">${a.componentscount}</span>
                                                    Components(s)
                                                </i>
                                            </button>
                                        </td>
                                        <td align="center">
                                            <span  title="Edit Of This Group." onclick="editAccessGroupDetails(${a.accessrightsgroupid}, '${a.accessrightgroupname}', '${a.description}');"  class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                                            |
                                            <span  title="Delete Of This Group." onclick="deleteAccessGroupDetails(${a.accessrightsgroupid});"  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
    </div> 
</div>
<script>
    $('#AccessRightsGroupPrivileges').DataTable();
    function addnewfacilityaccessrightsgroup() {
        $.ajax({
            type: 'GET',
            data: {add: 'group'},
            url: "localaccessrightsmanagement/addGroupForm.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'Add New Group!',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '70%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Finish',
                            btnClass: 'btn-purple',
                            action: function () {
                                ajaxSubmitData('localaccessrightsmanagement/localaccessrightsmanagementhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        }
                    }
                });
            }
        });
    }
    function editAccessGroupDetails(accessrightsgroupid, accessrightgroupname, description) {
        $.confirm({
            title: 'Update Group!',
            content: '' + '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Group Name</label>' +
                    '<input type="text" value="' + accessrightgroupname + '"  class="updateaccessrightsgroupname form-control" required />' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label>Group More Info</label>' +
                    '<textarea class="updateaccessrightgroupinfo form-control" id="groupinfo" rows="3">' + description + '</textarea>' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var name = this.$content.find('.updateaccessrightsgroupname').val();
                        var description = this.$content.find('.updateaccessrightgroupinfo').val();
                        if (!name) {
                            $.alert('provide a valid name');
                            return false;
                        }
                        if (!description) {
                            $.alert('provide a valid More Info');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {name: name, description: description, accessrightsgroupid: accessrightsgroupid},
                            url: "localaccessrightsmanagement/updategroup.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('localaccessrightsmanagement/localaccessrightsmanagementhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {

                }
            }
        });
    }
    function deleteAccessGroupDetails(accessrightsgroupid) {
        $.confirm({
            title: 'Delete Access Rights Group!',
            content: 'Are You Sure You Want To Delete This Group?',
            type: 'red',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes,Delete',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {accessrightsgroupid: accessrightsgroupid},
                            url: "localaccessrightsmanagement/deleteaccessrightgroup.htm",
                            success: function (data, textStatus, jqXHR) {
                                ajaxSubmitData('localaccessrightsmanagement/localaccessrightsmanagementhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
    function viewgroupassignedComponents(accessrightsgroupid, accessrightsgroupname, componentscount) {
        if (componentscount > 0) {
            $.ajax({
                type: 'GET',
                data: {groupid: accessrightsgroupid},
                url: "localaccessrightsmanagement/viewgroupassignedComponents.htm",
                success: function (data, textStatus, jqXHR) {
                    window.location = '#viewGroupGrantedRightsAccess';
                    $('#viewGroupGrantedRightsAccessdiv').html(data);
                    document.getElementById('GroupGrantedRightsTitle').innerHTML = accessrightsgroupname + ' ' + 'Granted Rights';
                    initDialog('viewGroupGrantedRightsAccessclass');
                }
            });
        } else {
            $.confirm({
                title: 'Components!',
                icon: 'fa fa-warning',
                content: 'No Granted Rights !!',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    close: function () {

                    }
                }
            });
        }
    }
    function viewaddgroupassignedComponents(accessrightsgroupid, accessrightsgroupname, componentscount) {
        if (componentscount > 0) {
            $.ajax({
                type: 'GET',
                data: {accessrightsgroupid: accessrightsgroupid},
                url: "localaccessrightsmanagement/viewgroupassignedComponentsandadd.htm",
                success: function (data, textStatus, jqXHR) {
                    document.getElementById('GroupCompGrantedRightsTitle').innerHTML = accessrightsgroupname + ' ' + 'Granted Rights Components';
                    window.location = '#viewGroupGrantedRightsAccessComponent';
                    $('#viewGroupGrantedRightsAccessCompdiv').html(data);
                    initDialog('viewGroupGrantedRightsAccessDialog');
                }
            });
        } else {
            $.confirm({
                title: 'NO ASSIGNED COMPONENTS!',
                icon: 'fa fa-warning',
                content: 'No Granted Rights!! Do You Want To Add Components!!',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                data: {accessrightsgroupid: accessrightsgroupid},
                                url: "localaccessrightsmanagement/addreleasedfacilitygroupcomponents.htm",
                                success: function (data, textStatus, jqXHR) {
                                    $.confirm({
                                        title: 'ADD MORE COMPONENTS FOR GROUP!',
                                        content: '' + data,
                                        boxWidth: '70%',
                                        useBootstrap: false,
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                ajaxSubmitData('localaccessrightsmanagement/localaccessrightsmanagementhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            }
                                        }
                                    });
                                }
                            });
                        }
                    },
                    close: function () {

                    }
                }
            });
        }
    }
</script>
<%-- 
    Document   : developerkeysHome
    Created on : Mar 24, 2018, 10:28:03 AM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <button onclick="createnewdeveloperkey();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add New Developer Key</button>
    </div>
</div><br>
<div style="">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <c:if test="${act=='b'}">
                        <button onclick="developerkeysbackbutton(${systemmoduleidclicked});" class="btn btn-secondary pull-left" type="button"><i class="fa fa-fw fa-lg fa-backward"></i>Back</button>
                    </c:if>
                    <div class="tile-body">

                        <table class="table table-hover table-bordered" id="devkys">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Component Name</th>
                                    <th>Sub Components</th>
                                    <th>More Info</th>
                                    <th>Tagged Privilege Key</th>
                                    <th>Status</th>
                                    <th>Update</th>
                                </tr>
                            </thead>
                            <tbody id="tableFacilityOwner">
                                <% int j = 1;%>
                                <% int p = 1;%>
                                <% int k = 1;%>
                                <c:forEach items="${systemroleslist}" var="a">
                                    <tr id="${a.privilegeid}">
                                        <td><%=j++%></td>
                                        <td>${a.componentname}</td>
                                        <c:choose>
                                            <c:when test="${a.subcomponentcount ==0}">
                                                <td align="center">
                                                    ${a.subcomponentcount}
                                                </td>
                                            </c:when>    
                                            <c:otherwise>
                                                <td align="center"><a href="#!" title="View  Sub Components" onclick="viewsubsystemmodulecomp(this.id);" href="#" id="${a.systemmoduleid}">${a.subcomponentcount}</a></td>

                                            </c:otherwise>
                                        </c:choose>
                                        <td align="center"><a onclick="taggedprivilegemoreinfo('${a.privilege}', '${a.description}');" href="#!"> <i class="fa fa-fw fa-lg fa-dedent"></i></a></td>
                                        <td align="center"><a onclick="taggedprivilegekey('${a.privilegekey}');" href="#!"> <i class="fa fa-fw fa-lg fa-dedent"></i></a></td>

                                        <td><c:if test="${a.privilegestatus==true}">Active</c:if><c:if test="${a.privilegestatus==null}">Not Set</c:if><c:if test="${a.privilegestatus==false}">Not Set</c:if></td>
                                        <td align="center"><c:if test="${a.privilegestatus==true}"><a href="#!" title="Update The System Module" onclick="updatedeveloperkeys('${a.privilegekey}',${a.privilegeid}, '${a.privilege}', '${a.description}');" href="#"><i class="fa fa-fw fa-lg fa-edit"></i></a></c:if><c:if test="${a.privilegestatus==null}"><a href="#" title="Add Privilege To The System Module" onclick="adddeveloperkeys(${a.systemmoduleid});" href="#"><i class="fa fa-fw fa-lg fa-plus"></i></a></c:if><c:if test="${a.privilegestatus==false}"><a href="#" title="Add Privilege To The System Module" onclick="adddeveloperkeys(${a.systemmoduleid});" href="#"><i class="fa fa-fw fa-lg fa-plus"></i></a></c:if></td>                                                  
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
<div class="modal fade" id="Modal2" tabindex="-1" role="dialog" aria-labelledby="Modal2" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ModalLabel">Update Privilege Key</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input  type="hidden" id="privilegekeyupdateid">
                <form class="form-horizontal">
                    <div class="form-group row">
                        <label class="control-label col-md-2">Privilege:</label>
                        <div class="col-md-8">
                            <input class="form-control col-md-10" type="text" id="privilegename">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-2">Privilege Key:</label>
                        <div class="col-md-8">
                            <input class="form-control col-md-10" type="text" id="privilegekeyupdate">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-2">More Info:</label>
                        <div class="col-md-8">
                            <textarea class="form-control col-md-10" id="privmoreinfo" rows="2"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="saveupdatedprivilegekey();">Save Update</button>
                <button type="button" class="btn btn-secondary btn-md" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="createprivilegekey" tabindex="-1" role="dialog" aria-labelledby="Modal2" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ModalLabel">Create Privilege Key</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <input id="createdsystemmoduleid" type="hidden">
            <div class="modal-body" id="privilegeslistdiv">
                <p>Loading Data Please Wait.................</p>
            </div>
            <div class="modal-footer">
                <button id="saveassignedprivilege" type="button" class="btn btn-primary" onclick="saveassignedprivilegekey();" style="display: none;">Save Assignment</button>
                <button type="button" class="btn btn-secondary btn-md" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addnewdeveloperkey" tabindex="-1" role="dialog" aria-labelledby="Modal2" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ModalLabel">Create Privilege/Developer Key</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="createprivform">
                    <div class="form-group row">
                        <label class="control-label col-md-2">Privilege:</label>
                        <div class="col-md-8">
                            <input class="form-control col-md-10" type="text" id="createprivilegename" placeholder="Enter Privilege Here">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-2">Privilege Key:</label>
                        <div class="col-md-8">
                            <input class="form-control col-md-10" type="text" id="createdprivilegekey" placeholder="Enter Privilege Key">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-2">More Info:</label>
                        <div class="col-md-8">
                            <textarea class="form-control col-md-10" id="createprivmoreinfo" rows="2" placeholder="Enter More Info "></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button  type="button" class="btn btn-primary" onclick="savenewprivilegekey();">Save</button>
                <button type="button" class="btn btn-secondary btn-md" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#devkys').DataTable();
    });
    $(function () {
        $('[data-toggle="popover"]').popover();
    });
    function viewsubsystemmodulecomp(systemmoduleid) {
        ajaxSubmitDataNoLoader('activitiesandaccessrights/developerkeysmanagement.htm', 'content3', 'act=b&systemmoduleid=' + systemmoduleid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function updatedeveloperkeys(key, privilegeid, privilege, description) {
        document.getElementById('privilegekeyupdateid').value = privilegeid;
        document.getElementById('privilegekeyupdate').value = key;
        document.getElementById('privilegename').value = privilege;
        $('#privmoreinfo').text(description);
        $('#Modal2').modal('show');
    }
    function adddeveloperkeys(systemmoduleid) {
        document.getElementById('createdsystemmoduleid').value = systemmoduleid;
        ajaxSubmitDataNoLoader('activitiesandaccessrights/privilegeslist.htm', 'privilegeslistdiv', 'act=b&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        $('#createprivilegekey').modal('show');

    }
    function saveupdatedprivilegekey() {
        var privilegekeyupdateid = $('#privilegekeyupdateid').val();
        var privilegekey = $('#privilegekeyupdate').val();
        var privilege = $('#privilegename').val();
        var description = $('#privmoreinfo').val();
        if (privilegekey !== '') {
            $.ajax({
                type: 'POST',
                data: {privilegekeyid: privilegekeyupdateid, privilegekey: privilegekey, privilege: privilege, description: description, type: 'update'},
                url: "activitiesandaccessrights/saveorupdateprivilegekey.htm",
                success: function (data, textStatus, jqXHR) {
                    $('#Modal2').modal('hide');
                    $.toast({
                        heading: 'Success',
                        text: 'Updated Success Fully !!!',
                        icon: 'success',
                        hideAfter: 3000,
                        position: 'bottom-center'
                    });
                    ajaxSubmitDataNoLoader('activitiesandaccessrights/developerkeysmanagement.htm', 'content3', 'act=a&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        }
    }
    var checkedprivilege = new Set();
    function addorassignprivilege(privilegeid, type, id) {
        if (type === 'checked') {
            if (checkedprivilege.size === 0) {
                checkedprivilege.add(privilegeid);
            } else {
                $.toast({
                    heading: 'Error',
                    text: 'Only One Privilege Key Can Be Assigned !!!',
                    icon: 'error',
                    hideAfter: 3000,
                    position: 'bottom-center'
                });
                $('#' + id).prop('checked', false);
            }
        } else {
            checkedprivilege.delete(privilegeid);
        }
        if (checkedprivilege.size === 0) {
            document.getElementById('saveassignedprivilege').style.display = 'none';
        } else {
            document.getElementById('saveassignedprivilege').style.display = 'block';
        }
    }
    function saveassignedprivilegekey() {
        var systemmoduleid = $('#createdsystemmoduleid').val();
        $.ajax({
            type: 'POST',
            data: {systemmoduleid: systemmoduleid, values: JSON.stringify(Array.from(checkedprivilege))},
            url: "activitiesandaccessrights/saveassignedprivilegekeytosystemmodule.htm",
            success: function (data, textStatus, jqXHR) {
                $('#createprivilegekey').modal('hide');
                $.toast({
                    heading: 'Success',
                    text: 'Success fully Saved !!!',
                    icon: 'success',
                    hideAfter: 3000,
                    position: 'bottom-center'
                });
                ajaxSubmitDataNoLoader('activitiesandaccessrights/developerkeysmanagement.htm', 'content3', 'act=a&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            }
        });
    }
    function createnewdeveloperkey() {
        document.getElementById('createprivform').reset();
        $('#addnewdeveloperkey').modal('show');
    }
    function savenewprivilegekey() {
        var createprivilegename = $('#createprivilegename').val();
        var createprivilegekey = $('#createdprivilegekey').val();
        var createprivmoreinfo = $('#createprivmoreinfo').val();
        if (createprivilegename !== '' && createprivilegekey !== '') {
            $.ajax({
                type: 'POST',
                data: {privilegename: createprivilegename, privilegekey: createprivilegekey, privmoreinfo: createprivmoreinfo},
                url: "activitiesandaccessrights/savenewprivilegekeydetails.htm",
                success: function (data, textStatus, jqXHR) {
                    document.getElementById('createprivform').reset();
                    $.toast({
                        heading: 'Success',
                        text: 'Success fully Saved !!!',
                        icon: 'success',
                        hideAfter: 3000,
                        position: 'bottom-center'
                    });
                }
            });
        }
    }
    function developerkeysbackbutton(systemmoduleid) {
        ajaxSubmitDataNoLoader('activitiesandaccessrights/developerkeysmanagement.htm', 'content3', 'act=c&systemmoduleid=' + systemmoduleid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function taggedprivilegekey(key) {
        if (key === '') {
            $.confirm({
                title: 'Tagged Privilege Key!',
                content: 'No Privilege Key  Set For This Component ',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Close',
                        btnClass: 'btn-red',
                        action: function () {
                        }
                    }
                }
            });
        } else {
            $.confirm({
                title: 'Tagged Privilege Key!',
                content: 'Key: ' + key,
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Close',
                        btnClass: 'btn-purple',
                        action: function () {
                        }
                    }
                }
            });
        }
    }
    function taggedprivilegemoreinfo(privilege, description) {
        if (description === '') {
            $.confirm({
                title: privilege,
                content: 'No More Infomation On This Privilege Key',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Close',
                        btnClass: 'btn-red',
                        action: function () {
                        }
                    }
                }
            });
        } else {
            $.confirm({
                title: privilege,
                content: description,
                type: 'purple',
                boxWidth: '500px',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Close',
                        btnClass: 'btn-purple',
                        action: function () {
                        }
                    }
                }
            });
        }
    }
</script>
<%-- 
    Document   : activitiesandaccessrightstabs
    Created on : Mar 21, 2018, 10:20:40 AM
    Author     : RESEARCH
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<style>
    #overlay2 {
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
</style>
<div class="app-title" id="">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>

    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li> 
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                    <li class="last active"><a href="#">Activities & Access Rights</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <main id="main">
            <security:authorize access="hasRole('ROLE_ROOTADMIN')">
                <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                <label class="tabLabels" for="tab1">Modules & Components</label>
            </security:authorize>

            <security:authorize access="hasRole('PRIVILEGE_GRANTACCESSRIGHTSUNIVERSAL') or hasRole('ROLE_ROOTADMIN')">
                <input id="tab2" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab2">Facility Access Rights</label>
            </security:authorize>

            <security:authorize access="hasRole('ROLE_ROOTADMIN')">
                <input id="tab3" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab3">Developer Keys</label>  
            </security:authorize>

            <section class="tabContent" id="content1">
                <div >
                    <div class="row">
                        <div class="col-md-12">
                            <button onclick="addnewcomponentdialog();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add System Module</button>
                        </div>
                    </div>
                    <div style="margin: 10px;">
                        <fieldset style="min-height:100px;">
                            <input value="${systemmoduleclicked}" id="systemmoduleclicked" type="hidden">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile">
                                        <c:if test="${act=='b'}">
                                            <button onclick="systemmodulebackbutton(${systemmoduleclicked});" class="btn btn-secondary pull-left" type="button"><i class="fa fa-fw fa-lg fa-backward"></i>Back</button>
                                        </c:if>
                                        <div class="tile-body"><br><br>
                                            <table class="table table-hover table-bordered" id="sampleTable">
                                                <thead>
                                                    <tr>
                                                        <th>No</th>
                                                            <c:if test="${act=='a'}">
                                                            <th>System Module Name</th>
                                                            </c:if>
                                                            <c:if test="${act=='b'}">
                                                            <th>Component Name</th>
                                                            </c:if>
                                                        <th>Sub Components</th>
                                                        <th>Status</th>
                                                        <th>Has Privilege</th>
                                                        <th>Update | Delete</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% int i = 1;%>
                                                    <% int p = 1;%>
                                                    <% int j = 1;%>
                                                    <c:forEach items="${systemmodules}" var="a">
                                                        <tr id="${a.systemmoduleid}">
                                                            <td><%=p++%></td>
                                                            <td>${a.systemmodulename}</td>
                                                            <c:choose>
                                                                <c:when test="${a.subcomponentcount ==0}">
                                                                    <td align="center">
                                                                        ${a.subcomponentcount}
                                                                    </td>
                                                                </c:when>    
                                                                <c:otherwise>
                                                                    <td align="center">
                                                                        <a href="#!" style="color: purple;" title="View Sub-Components For ${a.systemmodulename}" onClick="ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=b&i=${a.systemmoduleid}', 'GET');"> ${a.subcomponentcount}</a>
                                                                    </td> 
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <td align="center">
                                                                <div class="toggle-flip">
                                                                    <label>
                                                                        <input id="<%=i++%>ppp" type="checkbox"<c:if test="${a.status==true}">checked="checked"</c:if> onchange="if (this.checked) {
                                                                                    disableoractivatemodule(${a.systemmoduleid}, 'checked', this.id, '${a.systemmodulename}');
                                                                                } else {
                                                                                    disableoractivatemodule(${a.systemmoduleid}, 'unchecked', this.id, '${a.systemmodulename}');
                                                                                }"><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Active" data-toggle-off="Disabled"></span>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                            <c:if test="${a.hasprivilege==true}"><td align="center">Yes</td></c:if>
                                                            <c:if test="${a.hasprivilege==false}"><td align="center">No</td></c:if>
                                                                <td align="center">
                                                                    <span title="Update The System Module"  class="icon-custom" onclick="updatesystemmodule(this.id, '${a.description}', '${a.activity}');" id="up<%=j++%>"><i class="fa fa-fw fa-lg fa-edit"></i></span>
                                                                | 
                                                                <a href="#!" title="Delete The System Module" onclick="deletesystemmodule(${a.subcomponentcount},${a.systemmoduleid}, '${a.description}', '${a.activity}', '${systemmoduleclicked}', '${a.systemmodulename}');"><i class="fa fa-fw fa-lg fa-remove"></i></a>
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
                        <div id="overlay2" style="display: none;">
                            <img src="static/img2/loader.gif" alt="Loading" /><br/>
                            Please Wait...
                        </div>
                    </div> 
                </div>
            </section>
            <section class="tabContent" id="content2">
                facility
            </section>
            <section class="tabContent" id="content3">

            </section>
        </main>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="updatesystemmodule" class="supplierCatalogDialog updatesystemmodule">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2">X</a>
                    <h2 class="modalDialog-title">Update System Module/Component</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div id="updateSystemModuleSubComponentsdiv">
                                        <form class="form-horizontal">
                                            <div class="form-group row">
                                                <label class="control-label col-md-4">Sub-Component Name:</label>
                                                <div class="col-md-8">
                                                    <input class="form-control col-md-8" type="text" id="updatesystemmodulename" placeholder="Enter Sub-Component Name">
                                                </div>
                                            </div>
                                            <input  type="hidden" value="" id="systemmoduleid">
                                            <input  type="hidden" value="" id="originsubcomponentsnumber">
                                            <div class="form-group row">
                                                <label class="control-label col-md-4">More Info</label>
                                                <div class="col-md-8">
                                                    <textarea class="form-control col-md-8" rows="2" id="updatedescription" placeholder="Enter More Information"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="control-label col-md-4">Item Type:</label>
                                                <div class="col-md-8">
                                                    <select class="form-control col-md-8" id="updateitemtype">
                                                        <option value="Module">System Module</option>
                                                        <option value="Component">Module Sub Component</option>
                                                        <option value="Activity">Module Activity</option>
                                                    </select>                                            
                                                </div>
                                            </div>
                                            <div id="activitymoduletype" style="display: block;">
                                                <p style="color: red; display: none;" id="worningmessageerr">You Can Only Increase Sub Components But Not Reduction !!</p>
                                                <div style="display: none;" id="updatedenternumberofcomponents">
                                                    <div class="form-group row" >
                                                        <label class="control-label col-md-4">No. Of Sub Components:</label>
                                                        <div class="col-md-8">
                                                            <input class="form-control col-md-8" type="number" oninput="updatedsubcomponentswithsubcomp();" id="update_enter_numberof_components" placeholder="Enter No. Of Components">
                                                        </div>
                                                    </div> 
                                                </div>
                                                <div id="have_subcomponents" style="display: none;">
                                                    <div class="form-group row" >
                                                        <label class="control-label col-md-4">Add Sub-Components:</label>
                                                        <div class="col-md-8">
                                                            <div class="row">
                                                                <div class="col-md-3">
                                                                    <div class="form-check">
                                                                        <label class="form-check-label">
                                                                            <input class="form-check-input"  onclick="havesubcomponentwithout(this.value);" value="yes"type="radio" name="gender">Yes
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <div class="form-check">
                                                                        <label class="form-check-label">
                                                                            <input class="form-check-input" onclick="havesubcomponentwithout(this.value);" checked="true" value="no" type="radio" name="gender">No
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <p style="color: red; display: none;" id="worningmessageerr5">Must Be Greater Than 0 !!</p>
                                                <div style="display: none;" id="updatedwithoutenternumberofcomponents">
                                                    <div class="form-group row" >
                                                        <label class="control-label col-md-4"> Enter No. Of Sub Components:</label>
                                                        <div class="col-md-8">
                                                            <input class="form-control col-md-8" oninput="updatewithoutsubcomp();" value="1" type="number" min="1" id="updatewithout_enter_numberof_components" placeholder="Enter No. Of Components">
                                                        </div>
                                                    </div> 
                                                </div>
                                            </div>
                                        </form><br>
                                        <hr>
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <button onclick="saveupdatedsystemmodule();" class="btn btn-primary" id="saveupdatedcompn" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Update</button>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary" href="#" data-dismiss="modal"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="addsystemmodule" class="supplierCatalogDialog">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: none;">X</a>
                    <h2 class="modalDialog-title" id="titleoralreadyheading">Add New System Module</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div id="systemModuleAdSubComponentsdiv">
                                    <form class="form-horizontal" id="add_comp">
                                        <div class="form-group row">
                                            <label class="control-label col-md-4">Module/Component Name:</label>
                                            <div class="col-md-8">
                                                <input class="form-control col-md-8" type="text" id="component_name" placeholder="Enter Module/Component Name">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-4">More Info:</label>
                                            <div class="col-md-8">
                                                <textarea class="form-control col-md-8" id="description" rows="2" placeholder="Enter your More Info"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-4">Item Type:</label>
                                            <div class="col-md-8">
                                                <select class="form-control col-md-8" id="itemtype">
                                                    <option value="Module">System Module</option>
                                                </select>                                            
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-4">Status:</label>
                                            <div class="col-md-8">
                                                <select class="form-control col-md-8" id="status">
                                                    <option value="Active">Active</option>
                                                    <option value="Disabled">Disabled</option>
                                                </select>                                            
                                            </div>
                                        </div>
                                        <div class="form-group row" >
                                            <label class="control-label col-md-4">Add Sub-Components:</label>
                                            <div class="col-md-8">
                                                <div class="row">
                                                    <div class="col-md-3">
                                                        <div class="form-check">
                                                            <label class="form-check-label">
                                                                <input class="form-check-input"  onclick="addsub_components(this.id);" value="yes" id="Yes" type="radio" name="gender">Yes
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-check">
                                                            <label class="form-check-label">
                                                                <input class="form-check-input" onclick="addsub_components(this.id);" checked="true" value="No" id="no" type="radio" name="gender">No
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <p style="color: red; display: none;" id="worningmessageerr1">Must Be Greater Than 0!!</p>
                                        <div style="display: none;" id="enternumberofcomponents">
                                            <div class="form-group row" >
                                                <label class="control-label col-md-4">Enter No. Of Sub Components:</label>
                                                <div class="col-md-8">
                                                    <input class="form-control col-md-8" type="number" oninput="checkeinputvalue();" min="1" value="1" id="enter_numberof_components" placeholder="Enter No. Of Components">
                                                </div>
                                            </div> 
                                        </div>
                                    </form><br>
                                    <hr>
                                    <div class="row">
                                        <div class="col-md-4">
                                        </div>
                                        <div class="col-md-4">
                                        </div>
                                        <div class="col-md-4">
                                            <button class="btn btn-primary " id="savebtn1" type="button" onclick="saveNewcomponent();"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary" href="#" data-dismiss="modal" ><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="systemmoduleattachments" class="supplierCatalogDialog systemmoduleattachment">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: none;">X</a>
                    <h2 class="modalDialog-title" id="titleostaffdattachmentsdddreadyheading">System Attachments</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <input id="innitialsystemmoduleclickedfirst" type="hidden">
                                    <div class="tile" id="systemmoduleattachmentsdiv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Getting Groups Please Wait...........</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $('#updateitemtype').change(function () {
        var activitytype = $('#updateitemtype').val();
        if (activitytype === 'Activity') {
            document.getElementById('activitymoduletype').style.display = 'none';
        } else {
            document.getElementById('activitymoduletype').style.display = 'block';
        }
    });
    function updatewithoutsubcomp() {
        var updatewithout_enter_numberof_components = $('#updatewithout_enter_numberof_components').val();
        if (updatewithout_enter_numberof_components < 1) {
            document.getElementById('saveupdatedcompn').disabled = true;
            document.getElementById('worningmessageerr5').style.display = 'block';
        } else {
            document.getElementById('saveupdatedcompn').disabled = false;
            document.getElementById('worningmessageerr5').style.display = 'none';
        }
    }
    $('#sampleTable').DataTable();
    breadCrumb();
    $('#tab3').click(function () {
        ajaxSubmitDataNoLoader('activitiesandaccessrights/developerkeysmanagement.htm', 'content3', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab2').click(function () {
        ajaxSubmitDataNoLoader('activitiesandaccessrights/assignedfacilityaccessrights.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab1').click(function () {
        ajaxSubmitDataNoLoader('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    function updatesystemmodule(id, desc, activity) {
        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        document.getElementById('systemmoduleid').value = tablerowid;
        document.getElementById('updatesystemmodulename').value = tableData[1];
        if (desc === '') {
            $('#updatedescription').text('No More Info');
        } else {
            $('#updatedescription').text(desc);
        }

        var selectedsysmpdid = $('#systemmoduleclicked').val();
        if (selectedsysmpdid === 'a') {
        } else {
            $("#updateitemtype option[value='Module']").remove();
        }
        $('#updateitemtype').val(activity);

        if (activity === 'Activity') {
            document.getElementById('activitymoduletype').style.display = 'none';
        } else {
            document.getElementById('activitymoduletype').style.display = 'block';
        }
        if (parseInt(tableData[2]) === 0) {
            document.getElementById('originsubcomponentsnumber').value = 0;
            document.getElementById('have_subcomponents').style.display = 'block';
            document.getElementById('updatedenternumberofcomponents').style.display = 'none';
        } else {
            document.getElementById('have_subcomponents').style.display = 'none';
            document.getElementById('update_enter_numberof_components').value = parseInt(tableData[2]);
            document.getElementById('originsubcomponentsnumber').value = parseInt(tableData[2]);
            document.getElementById('updatedenternumberofcomponents').style.display = 'block';
        }
        window.location = '#updatesystemmodule';
        initDialog('updatesystemmodule');
    }
    var updatecomponentdata = [];
    function saveupdatedsystemmodule() {
        var systemmoduleid = $('#systemmoduleid').val();
        var updatesystemmodulename = $('#updatesystemmodulename').val();
        var updatedescription = $('#updatedescription').val();
        var updateitemtype = $('#updateitemtype').val();
        var newnumberofsubcomponents = $('#update_enter_numberof_components').val();
        var originanlnumberofsubcomp = $('#originsubcomponentsnumber').val();
        var activitytype = $('#updateitemtype').val();
        var currentselectedsystemmodule2 = $('#systemmoduleclicked').val();
        if (activitytype === 'Activity') {
            if (updatesystemmodulename !== '') {
                $.ajax({
                    type: 'POST',
                    data: {systemmoduleid: systemmoduleid, systemmodulename: updatesystemmodulename, description: updatedescription, itemtype: updateitemtype},
                    url: "activitiesandaccessrights/updatesystemmoduledetails.htm",
                    success: function (data, textStatus, jqXHR) {
                        window.location = '#close';
                        $.toast({
                            heading: 'Success',
                            text: 'Updated Successfully !!!',
                            icon: 'success',
                            hideAfter: 3000,
                            position: 'bottom-center'
                        });
                        if (currentselectedsystemmodule2 === 'a') {
                            ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        } else {
                            ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=b&i=' + currentselectedsystemmodule2 + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                        }
                    }
                });
            }
        } else {
            if (parseInt(originanlnumberofsubcomp) === 0 && havesubcomponentwithoutit === 'yes') {
                var updatewithout_enter_numberof_component = $('#updatewithout_enter_numberof_components').val();

                updatecomponentdata.push({
                    systemmoduleid: systemmoduleid,
                    systemmodulename: updatesystemmodulename,
                    description: updatedescription,
                    itemtype: updateitemtype
                });
                ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrightsaddsubcomponents.htm', 'updateSystemModuleSubComponentsdiv', 'act=b&numberofsubcomponents=' + updatewithout_enter_numberof_component + '&savetype=update&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
            } else if (parseInt(originanlnumberofsubcomp) === 0 && havesubcomponentwithoutit === 'no') {
                if (updatesystemmodulename !== '') {
                    $.ajax({
                        type: 'POST',
                        data: {systemmoduleid: systemmoduleid, systemmodulename: updatesystemmodulename, description: updatedescription, itemtype: updateitemtype},
                        url: "activitiesandaccessrights/updatesystemmoduledetails.htm",
                        success: function (data, textStatus, jqXHR) {
                            window.location = '#close';
                            $.toast({
                                heading: 'Success',
                                text: 'Updated Successfully !!!',
                                icon: 'success',
                                hideAfter: 3000,
                                position: 'bottom-center'
                            });
                            if (currentselectedsystemmodule2 === 'a') {
                                ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            } else {
                                ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=b&i=' + currentselectedsystemmodule2 + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                            }
                        }
                    });
                }
            } else {
                if (parseInt(newnumberofsubcomponents) === parseInt(originanlnumberofsubcomp)) {
                    var currentselectedsystemmodule = $('#systemmoduleclicked').val();
                    if (updatesystemmodulename !== '') {
                        $.ajax({
                            type: 'POST',
                            data: {systemmoduleid: systemmoduleid, systemmodulename: updatesystemmodulename, description: updatedescription, itemtype: updateitemtype},
                            url: "activitiesandaccessrights/updatesystemmoduledetails.htm",
                            success: function (data, textStatus, jqXHR) {
                                window.location = '#close';
                                $.toast({
                                    heading: 'Success',
                                    text: 'Updated Successfully !!!',
                                    icon: 'success',
                                    hideAfter: 2000,
                                    position: 'bottom-center'
                                });
                                if (currentselectedsystemmodule === 'a') {
                                    ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                } else {
                                    ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=b&i=' + currentselectedsystemmodule + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                                }
                            }
                        });
                    }
                } else {
                    var updatednewsubcompno = parseInt(newnumberofsubcomponents) - parseInt(originanlnumberofsubcomp);

                    updatecomponentdata.push({
                        systemmoduleid: systemmoduleid,
                        systemmodulename: updatesystemmodulename,
                        description: updatedescription,
                        itemtype: updateitemtype
                    });
                    ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrightsaddsubcomponents.htm', 'updateSystemModuleSubComponentsdiv', 'act=b&numberofsubcomponents=' + updatednewsubcompno + '&savetype=update&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            }
        }
    }
    var data = {};
    function saveNewcomponent() {
        var componentname = $('#component_name').val();
        var description = $('#description').val();
        var itemtype = $('#itemtype').val();
        var status = $('#status').val();
        if (componentname !== '' && description !== '') {
            if (status === 'Active') {
                data = {componentname: componentname, description: description, activity: itemtype, status: true};
            } else {
                data = {componentname: componentname, description: description, activity: itemtype, status: false};
            }
        }
        var numberofsubcomponents = $('#enter_numberof_components').val();
        if (hassubcombonents === 'yes') {
            if (componentname !== '' && description !== '') {
                if (parseInt(numberofsubcomponents) !== 0) {
                    ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrightsaddsubcomponents.htm', 'systemModuleAdSubComponentsdiv', 'act=b&numberofsubcomponents=' + numberofsubcomponents + '&savetype=save&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                } else {
                    $.confirm({
                        title: 'Number Of Sub-Compoents!',
                        content: 'Enter Number Of Sub-Compoents',
                        type: 'red',
                        typeAnimated: true,
                        buttons: {
                            close: function () {
                            }
                        }
                    });
                }
            } else {
                $.confirm({
                    title: 'Missing Fields!',
                    content: 'Enter Missing Fields',
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                        }
                    }
                });
            }
        } else {
            if (componentname !== '') {
                $.ajax({
                    type: 'POST',
                    data: {component: JSON.stringify(data), act: 'withoutsubcomponents'},
                    dataType: 'text',
                    url: "activitiesandaccessrights/savecomponentandsubcomponent.htm",
                    success: function (data, textStatus, jqXHR) {
                        if (data === 'success') {
                            data = [];
                            $.confirm({
                                title: 'Success!',
                                content: 'Saved Success Fully ',
                                type: 'orange',
                                typeAnimated: true,
                                buttons: {
                                    close: function () {
                                    }
                                }
                            });

                            window.location = '#close';
                            ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    }
                });
            } else {
                $.confirm({
                    title: 'Missing Fields!',
                    content: 'Enter Missing Fields',
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                        }
                    }
                });
            }
        }


    }
    var hassubcombonents = 'no';
    function addsub_components(id) {
        if (id === 'Yes') {
            hassubcombonents = 'yes';
            document.getElementById('enternumberofcomponents').style.display = 'block';
        } else {
            hassubcombonents = 'no';
            document.getElementById('enter_numberof_components').value = '';
            document.getElementById('enternumberofcomponents').style.display = 'none';
        }
    }

    var subcomponentsdata = [];
    function  savesub_components_details() {
        var currentselectedsystemmodule = $('#systemmoduleclicked').val();
        var numberofsubcomponents = $('#numberofsub').val();
        var componentname = $('#subcomponentname').val();
        var description = $('#subcomponentdescription').val();
        var type = $('#subcomponenttype').val();
        var status = $('#subcomponentstatus').val();
        if (componentname !== '' && description !== '') {
            subcomponentsdata.push({
                componentname: componentname,
                description: description,
                status: status,
                activity: type
            });
        } else {
            $.confirm({
                title: 'Missing Fields!',
                content: 'Fill in Missing Fields !!',
                icon: 'fa fa-warning',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    close: function () {
                    }
                }
            });
        }
        for (j = 1; j < numberofsubcomponents; j++) {
            var componentnamej = $('#subcomponentname' + j).val();
            var descriptionj = $('#subcomponentdescription' + j).val();
            var typej = $('#subcomponenttype' + j).val();
            var statusj = $('#subcomponentstatus' + j).val();
            if (componentnamej !== '' && descriptionj !== '') {
                subcomponentsdata.push({
                    componentname: componentnamej,
                    description: descriptionj,
                    status: statusj,
                    activity: typej
                });
            } else {
                $.confirm({
                    title: 'Missing Fields!',
                    content: 'Fill in Missing Fields !!',
                    icon: 'fa fa-warning',
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                        }
                    }
                });
            }

        }

        if (subcomponentsdata !== [] || subcomponentsdata !== '[]' || subcomponentsdata.length !== 0) {
            var savetype = $('#savetype').val();
            if (savetype === 'update') {
                $.ajax({
                    type: 'POST',
                    data: {act: 'update', subcomponents: JSON.stringify(subcomponentsdata), component: JSON.stringify(updatecomponentdata)},
                    dataType: 'text',
                    url: "activitiesandaccessrights/savecomponentandsubcomponent.htm",
                    success: function (data, textStatus, jqXHR) {
                        if (data === 'success') {
                            $.confirm({
                                title: 'Success!',
                                content: 'Saved Success Fully ',
                                type: 'orange',
                                typeAnimated: true,
                                buttons: {
                                    close: function () {
                                        subcomponentsdata = [];
                                        updatecomponentdata = [];
                                        window.location = '#close';
                                        if (currentselectedsystemmodule === 'a') {
                                            ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                        } else {
                                            ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=b&i=' + currentselectedsystemmodule + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                                        }
                                    }
                                }
                            });
                        } else {
                        }
                    }
                });
            } else {
                $.ajax({
                    type: 'POST',
                    data: {act: 'withsubcomponents', subcomponents: JSON.stringify(subcomponentsdata), component: JSON.stringify(data)},
                    dataType: 'text',
                    url: "activitiesandaccessrights/savecomponentandsubcomponent.htm",
                    success: function (data, textStatus, jqXHR) {
                        if (data === 'success') {
                            $.confirm({
                                title: 'Success!',
                                content: 'Saved Success Fully ',
                                type: 'orange',
                                typeAnimated: true,
                                buttons: {
                                    close: function () {
                                        subcomponentsdata = [];
                                        data = [];
                                        window.location = '#close';
                                        ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                }
                            });

                        } else {
                        }
                    }
                });
            }
        } else {

        }
    }
    function disableoractivatemodule(id, type, id2, systemmodulename) {
        document.getElementById('overlay2').style.display = 'block';
        $.ajax({
            type: 'POST',
            data: {type: 'diactivate', systemmoduleid: id},
            url: "activitiesandaccessrights/getsubmodulesorcomponentsmodule.htm",
            success: function (data, textStatus, jqXHR) {
                var response = JSON.parse(data);
                document.getElementById('overlay2').style.display = 'none';
                if (type === 'checked') {
                    $.confirm({
                        title: 'Are you sure?!',
                        content: 'Your Activating ' + systemmodulename + ' With ' + response.length + ' ' + 'Sub Components',
                        type: 'red',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Yes, Activate',
                                btnClass: 'btn-red',
                                action: function () {
                                    document.getElementById('overlay2').style.display = 'block';
                                    $.ajax({
                                        type: 'POST',
                                        data: {systemmoduleid: id, type: 'activate', values: data},
                                        url: "activitiesandaccessrights/diactivateoractivatesystemmodule.htm",
                                        success: function (data, textStatus, jqXHR) {
                                            document.getElementById('overlay2').style.display = 'none';
                                            $.confirm({
                                                title: 'Activate Component!',
                                                content: 'Activated Successfully',
                                                type: 'orange',
                                                typeAnimated: true,
                                                buttons: {
                                                    close: function () {
                                                        $('#' + id2).prop('checked', true);
                                                    }
                                                }
                                            });
                                        }
                                    });
                                }
                            },
                            close: function () {
                                document.getElementById('overlay2').style.display = 'none';
                                $('#' + id2).prop('checked', false);
                            }
                        }
                    });
                } else {
                    $.confirm({
                        title: 'Are you sure?!',
                        content: 'Your Disabling/deactivating ' + systemmodulename + ' With ' + response.length + ' ' + ' Sub Components',
                        type: 'red',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Yes, Deactivate',
                                btnClass: 'btn-red',
                                action: function () {
                                    document.getElementById('overlay2').style.display = 'block';
                                    $.ajax({
                                        type: 'POST',
                                        data: {systemmoduleid: id, type: 'diactivate', values: data},
                                        url: "activitiesandaccessrights/diactivateoractivatesystemmodule.htm",
                                        success: function (data, textStatus, jqXHR) {
                                            document.getElementById('overlay2').style.display = 'none';
                                            $.confirm({
                                                title: 'Deactivate Component!',
                                                content: 'Deactivated Successfully',
                                                type: 'orange',
                                                typeAnimated: true,
                                                buttons: {
                                                    close: function () {
                                                        document.getElementById('overlay2').style.display = 'none';
                                                        $('#' + id2).prop('checked', false);
                                                    }
                                                }
                                            });
                                        }
                                    });
                                }
                            },
                            close: function () {
                                document.getElementById('overlay2').style.display = 'none';
                                $('#' + id2).prop('checked', true);
                            }
                        }
                    });
                }
            }
        });

    }
    var havesubcomponentwithoutit = 'no';
    function havesubcomponentwithout(value) {
        if (value === 'yes') {
            havesubcomponentwithoutit = 'yes';
            document.getElementById('updatedwithoutenternumberofcomponents').style.display = 'block';
        } else {
            havesubcomponentwithoutit = 'no';
            document.getElementById('updatewithout_enter_numberof_components').value = 1;
            document.getElementById('updatedwithoutenternumberofcomponents').style.display = 'none';
        }
    }
    function updatedsubcomponentswithsubcomp() {
        var newsubcomponentsnumber = $('#update_enter_numberof_components').val();
        var originsubcomponentsnumber = $('#originsubcomponentsnumber').val();
        if (parseInt(newsubcomponentsnumber) < parseInt(originsubcomponentsnumber)) {
            document.getElementById('worningmessageerr').style.display = 'block';
            document.getElementById('saveupdatedcompn').disabled = true;
        } else {
            document.getElementById('saveupdatedcompn').disabled = false;
            document.getElementById('worningmessageerr').style.display = 'none';
        }
    }
    function checkeinputvalue() {
        var inputvalue = $('#enter_numberof_components').val();
        if (parseInt(inputvalue) < 1) {
            document.getElementById('worningmessageerr1').style.display = 'block';
            document.getElementById('savebtn1').disabled = true;
        } else {
            document.getElementById('savebtn1').disabled = false;
            document.getElementById('worningmessageerr1').style.display = 'none';
        }
    }
    function deletesystemmodule(subcomponentcount, systemmoduleid, description, activity, systemmoduleclicked, systemmodulename) {
        if (subcomponentcount < 1) {
            $.confirm({
                title: 'Delete System Module!',
                content: 'Are You Sure You Want To Delete This System Module ?',
                type: 'red',
                icon: 'fa fa-warning',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes, Delete',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {systemmoduleid: systemmoduleid},
                                url: "activitiesandaccessrights/deletesystemmodule.htm",
                                success: function (data, textStatus, jqXHR) {
                                    if (data === 'success') {
                                        $.confirm({
                                            title: 'Delete System Module!',
                                            content: 'Deleted SuccessFully !!!',
                                            type: 'orange',
                                            icon: 'fa fa-warning',
                                            typeAnimated: true,
                                            buttons: {
                                                tryAgain: {
                                                    text: 'Close',
                                                    btnClass: 'btn-orange',
                                                    action: function () {
                                                        if (systemmoduleclicked === 'a') {
                                                            ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                        } else {
                                                            ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=b&i=' + systemmoduleclicked + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                                                        }
                                                    }
                                                }
                                            }
                                        });
                                    }
                                }
                            });
                        }
                    },
                    close: function () {
                    }
                }
            });
        } else {
            $.confirm({
                title: 'Delete Failed!',
                content: systemmodulename + ' ' + 'Can Not Be Deleted Because Of <a href="#!">' + subcomponentcount + ' Attachment(s)</a>',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Ok',
                        btnClass: 'btn-red',
                        action: function () {
                            window.location = '#systemmoduleattachments';
                            initDialog('systemmoduleattachment');
                            ajaxSubmitData('activitiesandaccessrights/getcascadingsystemmodulesubcomponents.htm', 'systemmoduleattachmentsdiv', 'act=a&systemmoduleid=' + systemmoduleid + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        }
                    },
                    close: function () {

                    }
                }
            });

        }
    }
    function systemmodulebackbutton(systemmoduleclicked) {
        ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=c&i=' + systemmoduleclicked + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function addnewcomponentdialog() {
        window.location = '#addsystemmodule';
        initDialog('supplierCatalogDialog');
    }

</script>

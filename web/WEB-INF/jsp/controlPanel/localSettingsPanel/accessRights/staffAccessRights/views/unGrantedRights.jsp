<%-- 
    Document   : unGrantedRights
    Created on : Jul 23, 2018, 2:24:36 PM
    Author     : IICS
--%>

<style>
    .stylish-input-group .input-group-addon{
        background: white !important;
    }
    .stylish-input-group .form-control{
        box-shadow:0 0 0;
        border-color:#ccc;
    }
    .stylish-input-group button{
        border:0;
        background:transparent;
    }

    .h-scroll {
        background-color: #fcfdfd;
        height: 260px;
        overflow-y: scroll;
    }
    #xx{
        margin-left: 1.5em;
    }
</style>
<link href="static/mainpane/css/hummingbird-treeview.css" rel="stylesheet">
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    #facilityoverlayXXXXxUn {
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
<c:if test="${ not empty staffcomponentstreelist}">
    <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
        <!-- <div id="treeview_container" class="hummingbird-treeview"> -->
        <ul id="staffUnGrantedRight" class="hummingbird-base">
            <span id="expandAllxxxxxx6" class="icon-custom" style="color: #56050c;">Expand All</span>| <span id="collapseAllxxxxxx6" style="color: #56050c;" class="icon-custom">Contract All</span> (Un Granted Staff Rights) <br>
            <c:forEach items="${staffcomponentstreelist}" var="components">
                <li>
                    <i class="fa fa-minus"></i><c:if test="${components.assigned==true}">&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/></c:if><c:if test="${components.assigned==false}">&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label>  ${components.componentname}</label>&nbsp;<c:if test="${components.hasprivilege==true && components.activity=='Activity' && components.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input id="${components.privilegeid}" onchange="if (this.checked) {
                                checkedOrUncheckedUngratedStaff('checked', this.id);
                            } else {
                                checkedOrUncheckedUngratedStaff('unchecked', this.id);
                            }" type="checkbox"></c:if>
                        <ul style="display: block;" id="xx">
                        <c:forEach items="${components.systemSubcomponenets}" var="components1">
                            <li>
                                <c:if test="${components1.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components1.size>0}"><i class="fa fa-plus"></i></c:if><c:if test="${components1.assigned==true}">&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/></c:if><c:if test="${components1.assigned==false}">&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label>  ${components1.componentname}</label>&nbsp;<c:if test="${components1.hasprivilege==true && components1.activity=='Activity' && components1.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input id="${components1.privilegeid}" onchange="if (this.checked) {
                                            checkedOrUncheckedUngratedStaff('checked', this.id);
                                        } else {
                                            checkedOrUncheckedUngratedStaff('unchecked', this.id);
                                        }" type="checkbox"></c:if>
                                    <ul id="xx">
                                    <c:forEach items="${components1.systemSubcomponenets}" var="components2">
                                        <li>
                                            <c:if test="${components2.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components2.size>0}"><i class="fa fa-plus"></i></c:if> <c:if test="${components2.assigned==true}">&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/></c:if><c:if test="${components2.assigned==false}">&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label>  ${components2.componentname}</label>&nbsp;<c:if test="${components2.hasprivilege==true && components2.activity=='Activity' && components2.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input id="${components2.privilegeid}" onchange="if (this.checked) {
                                                        checkedOrUncheckedUngratedStaff('checked', this.id);
                                                    } else {
                                                        checkedOrUncheckedUngratedStaff('unchecked', this.id);
                                                    }" type="checkbox"></c:if>
                                                <ul id="xx">
                                                <c:forEach items="${components2.systemSubcomponenets}" var="components3">
                                                    <li>
                                                        <c:if test="${components3.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components3.size>0}"><i class="fa fa-plus"></i></c:if> <c:if test="${components3.assigned==true}">&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/></c:if><c:if test="${components3.assigned==false}">&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label>  ${components3.componentname}</label>&nbsp;<c:if test="${components3.hasprivilege==true && components3.activity=='Activity' && components3.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input id="${components3.privilegeid}" onchange="if (this.checked) {
                                                                    checkedOrUncheckedUngratedStaff('checked', this.id);
                                                                } else {
                                                                    checkedOrUncheckedUngratedStaff('unchecked', this.id);
                                                                }" type="checkbox"></c:if>
                                                            <ul id="xx">
                                                            <c:forEach items="${components3.systemSubcomponenets}" var="components4">
                                                                <li>
                                                                    <c:if test="${components4.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components4.size>0}"><i class="fa fa-plus"></i></c:if> <c:if test="${components4.assigned==true}">&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/></c:if><c:if test="${components4.assigned==false}">&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label>  ${components4.componentname}</label>&nbsp;<c:if test="${components4.hasprivilege==true && components4.activity=='Activity' && components4.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input id="${components4.privilegeid}" onchange="if (this.checked) {
                                                                                checkedOrUncheckedUngratedStaff('checked', this.id);
                                                                            } else {
                                                                                checkedOrUncheckedUngratedStaff('unchecked', this.id);
                                                                            }" type="checkbox"></c:if>
                                                                        <ul id="xx">
                                                                        <c:forEach items="${components4.systemSubcomponenets}" var="components5">
                                                                            <li>
                                                                                <c:if test="${components5.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components5.size>0}"><i class="fa fa-plus"></i></c:if> <c:if test="${components5.assigned==true}">&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/></c:if><c:if test="${components5.assigned==false}">&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label>  ${components5.componentname}</label>&nbsp;<c:if test="${components5.hasprivilege==true && components5.activity=='Activity' && components5.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input id="${components5.privilegeid}" onchange="if (this.checked) {
                                                                                            checkedOrUncheckedUngratedStaff('checked', this.id);
                                                                                        } else {
                                                                                            checkedOrUncheckedUngratedStaff('unchecked', this.id);
                                                                                        }" type="checkbox"></c:if>
                                                                                    <ul id="xx">
                                                                                    <c:forEach items="${components5.systemSubcomponenets}" var="components6">
                                                                                        <li>
                                                                                            <c:if test="${components6.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components6.size>0}"><i class="fa fa-plus"></i></c:if> <c:if test="${components6.assigned==true}">&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/></c:if><c:if test="${components6.assigned==false}">&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label>  ${components6.componentname}</label>&nbsp;<c:if test="${components6.hasprivilege==true && components6.activity=='Activity' && components6.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input id="${components6.privilegeid}" onchange="if (this.checked) {
                                                                                                        checkedOrUncheckedUngratedStaff('checked', this.id);
                                                                                                    } else {
                                                                                                        checkedOrUncheckedUngratedStaff('unchecked', this.id);
                                                                                                    }" type="checkbox"></c:if>
                                                                                                <ul>
                                                                                                <c:forEach items="${components6.systemSubcomponenets}" var="components7">
                                                                                                    <li>
                                                                                                        <c:if test="${components7.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components7.size>0}"><i class="fa fa-plus"></i></c:if> <c:if test="${components7.assigned==true}">&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/></c:if><c:if test="${components7.assigned==false}">&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label>  ${components7.componentname}</label>&nbsp;<c:if test="${components7.hasprivilege==true && components7.activity=='Activity' && components7.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input id="${components7.privilegeid}" onchange="if (this.checked) {
                                                                                                                    checkedOrUncheckedUngratedStaff('checked', this.id);
                                                                                                                } else {
                                                                                                                    checkedOrUncheckedUngratedStaff('unchecked', this.id);
                                                                                                                }" type="checkbox"></c:if>   
                                                                                                        </li>  
                                                                                                </c:forEach>  
                                                                                            </ul>
                                                                                        </li>   
                                                                                    </c:forEach> 
                                                                                </ul>
                                                                            </li> 
                                                                        </c:forEach>  
                                                                    </ul>
                                                                </li>  
                                                            </c:forEach>  
                                                        </ul>
                                                    </li>  
                                                </c:forEach>
                                            </ul>
                                        </li>   
                                    </c:forEach>
                                </ul>
                            </li>  
                        </c:forEach>
                    </ul>
                </li> 
            </c:forEach>
        </ul>
    </div>  
</c:if>
<c:if test="${empty staffcomponentstreelist}">
    <h3 style="margin-top: 5%; margin-left: 5%;"><span class="badge badge-secondary"><strong>No UN ASSIGNED ACTIVITIES TO THIS STAFF IN THE GROUP</strong></span></h3>
    <h5 style="margin-left: 20%;"><span class="badge badge-danger"><strong>All Activities In This Group Already Assigned</strong></span></h5> 
</c:if>
<div id="facilityoverlayXXXXxUn" style="display: none;">
    <img src="static/img2/loader.gif" alt="Loading" /><br/>
    Please Wait...
</div>
<div class="row">
    <div class="col-md-12">
        <button class="btn btn-primary" style="display: none;" onclick="savestaffungrantedgroupright();" id="savestaffungrantedgrouprightsbtn">Save</button>
    </div>
</div>
<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
            document.getElementById('staffgrantedscomponentsLoader').style.display = 'none';
            $("#staffUnGrantedRight").hummingbird();
            $("#collapseAllxxxxxx6").click(function () {
                $("#staffUnGrantedRight").hummingbird("collapseAll");
            });
            $("#expandAllxxxxxx6").click(function () {
                $("#staffUnGrantedRight").hummingbird("expandAll");
            });
            var ungratedStaffRights = new Set();
            function checkedOrUncheckedUngratedStaff(type, privilegeid) {
                if (type === 'checked') {
                    ungratedStaffRights.add(privilegeid);
                } else {
                    ungratedStaffRights.delete(privilegeid);
                }
                if (ungratedStaffRights.size > 0) {
                    document.getElementById('savestaffungrantedgrouprightsbtn').style.display = 'block';
                } else {
                    document.getElementById('savestaffungrantedgrouprightsbtn').style.display = 'none';
                }
            }
            function savestaffungrantedgroupright() {
                var stafffacilityunitdI = $('#GratedUnitsGroupsComponentsSlectId').val();
                var staffgroupid = $('#staffGratedGroupsSlectId').val();
                var comp = $('#staffGratedGroupsComponentsSlectId').val();
                if (ungratedStaffRights.size > 0) {
                    $.confirm({
                        title: 'Selected Activities!',
                        icon: 'fa fa-warning',
                        content: 'Are You Sure You Want To Assign Staff ' + ' ' + ungratedStaffRights.size + ' ' + 'Activities?',
                        type: 'red',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Yes,Assign',
                                btnClass: 'btn-purple',
                                action: function () {
                                    document.getElementById('facilityoverlayXXXXxUn').style.display = 'block';
                                    $.ajax({
                                        type: 'POST',
                                        data: {privileges: JSON.stringify(Array.from(ungratedStaffRights)), staffgroupid: staffgroupid, stafffacilityunitdI: stafffacilityunitdI},
                                        url: "localaccessrightsmanagement/savesavestaffungrantedgroupright.htm",
                                        success: function (data, textStatus, jqXHR) {
                                            ungratedStaffRights.clear();
                                            
                                            $.confirm({
                                                title: 'Staff Access Rights',
                                                content: 'Assigned Successfully',
                                                type: 'purple',
                                                typeAnimated: true,
                                                buttons: {
                                                    close: function () {
                                                        document.getElementById('facilityoverlayXXXXxUn').style.display = 'none';
                                                        document.getElementById('staffgrantedscomponentsforgrouptree').innerHTML = '';
                                                        $("#staffGratedGroupsComponentsSlectId option[id='defgroupCompstaffsselectid']").attr("selected", "selected");
                                                        $('#DefaulgroupCompntsselectid' + comp).remove();
                                                    }
                                                }
                                            });
                                        }
                                    });
                                }},
                            close: function () {

                            }
                        }
                    });
                } else {
                    $.confirm({
                        title: 'Selected Activities!',
                        icon: 'fa fa-warning',
                        content: 'Nothing Selected !!',
                        type: 'red',
                        typeAnimated: true,
                        buttons: {
                            close: function () {
                            }
                        }
                    });
                }

            }
</script>
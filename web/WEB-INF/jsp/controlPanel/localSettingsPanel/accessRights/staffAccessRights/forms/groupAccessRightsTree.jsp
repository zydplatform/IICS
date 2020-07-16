<%-- 
    Document   : groupAccessRightsTree
    Created on : Jul 22, 2018, 7:09:25 PM
    Author     : Grace-K
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<style>
    #facilityassignedoverlay {
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
    .fontsz{
        font-size: 16px !important;
    }
</style>
<link href="static/mainpane/css/hummingbird-treeview.css" rel="stylesheet">
<div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
    <!-- <div id="treeview_container" class="hummingbird-treeview"> -->
    <ul id="groupsrightstreeview" class="hummingbird-base">
        <span id="expandAllxxx3" class="icon-custom" style="color: #56050c;">Expand All</span>| <span id="collapseAllxxx3" style="color: #56050c;" class="icon-custom">Contract All</span> <br>
        <c:forEach items="${facilitygroupscomponentslist}" var="components">
            <c:if test="${components.assigned==true}">
                <li>
                    <i class="fa fa-minus"></i>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/> <label> ${components.componentname}</label>&nbsp;<c:if test="${components.hasprivilege==true && components.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components.accessrightgroupprivilegeid}" onchange="if(this.checked){
                        checkorUncheckedStaffSubComponent('checked',this.value); 
                    }else{
                      checkorUncheckedStaffSubComponent('unchecked',this.value);   
                    }  " type="checkbox"></c:if>
                    <ul style="display: block;" id="xx">
                        <c:forEach items="${components.subComponents}" var="components1">
                            <c:if test="${components1.assigned==true}">
                                <li>
                                    <c:if test="${components1.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components1.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/> <label>${components1.componentname}</label>&nbsp;<c:if test="${components1.hasprivilege==true && components1.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components1.accessrightgroupprivilegeid}" onchange="if(this.checked){
                                                checkorUncheckedStaffSubComponent('checked',this.value); 
                                            }else{
                                              checkorUncheckedStaffSubComponent('unchecked',this.value);   
                                            }  " type="checkbox"></c:if>
                                        <ul id="xx">
                                        <c:forEach items="${components1.subComponents}" var="components2">
                                            <c:if test="${components2.assigned==true}">
                                                <li>
                                                    <c:if test="${components2.size<1}"><i class="fa fa-dot-circle-o"></i></c:if><c:if test="${components2.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/> <label>${components2.componentname}</label>&nbsp;<c:if test="${components2.hasprivilege==true && components2.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components2.accessrightgroupprivilegeid}" onchange="if(this.checked){
                                                            checkorUncheckedStaffSubComponent('checked',this.value); 
                                                        }else{
                                                          checkorUncheckedStaffSubComponent('unchecked',this.value);   
                                                        }  " type="checkbox"></c:if>
                                                        <ul id="xx">
                                                        <c:forEach items="${components2.subComponents}" var="components3">
                                                            <c:if test="${components3.assigned==true}">
                                                                <li>
                                                                    <c:if test="${components3.size<1}"><i class="fa fa-dot-circle-o"></i></c:if><c:if test="${components3.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/> <label>${components3.componentname}</label>&nbsp;<c:if test="${components3.hasprivilege==true && components3.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components3.accessrightgroupprivilegeid}" onchange="if(this.checked){
                                                                                checkorUncheckedStaffSubComponent('checked',this.value); 
                                                                            }else{
                                                                              checkorUncheckedStaffSubComponent('unchecked',this.value);   
                                                                            }  " type="checkbox"></c:if>
                                                                        <ul id="xx">
                                                                        <c:forEach items="${components3.subComponents}" var="components4">
                                                                            <c:if test="${components4.assigned==true}">
                                                                                <li>
                                                                                    <c:if test="${components4.size<1}"><i class="fa fa-dot-circle-o"></i></c:if><c:if test="${components4.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/>  <label>${components4.componentname}</label>&nbsp;<c:if test="${components4.hasprivilege==true && components4.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components4.accessrightgroupprivilegeid}" onchange="if(this.checked){
                                                                                                checkorUncheckedStaffSubComponent('checked',this.value); 
                                                                                            }else{
                                                                                              checkorUncheckedStaffSubComponent('unchecked',this.value);   
                                                                                            }  " type="checkbox"></c:if>
                                                                                        <ul id="xx">
                                                                                        <c:forEach items="${components4.subComponents}" var="components5">
                                                                                            <c:if test="${components5.assigned==true}">
                                                                                                <li>
                                                                                                    <c:if test="${components5.size<1}"><i class="fa fa-dot-circle-o"></i></c:if><c:if test="${components5.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp; <img src="static/images/disabledsmall.png" title="Un Assigned"/> <label>${components5.componentname}</label> &nbsp;<c:if test="${components5.hasprivilege==true && components5.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components5.accessrightgroupprivilegeid}" onchange="if(this.checked){
                                                                                                                checkorUncheckedStaffSubComponent('checked',this.value); 
                                                                                                            }else{
                                                                                                              checkorUncheckedStaffSubComponent('unchecked',this.value);   
                                                                                                            }  " type="checkbox"></c:if>
                                                                                                        <ul id="xx">
                                                                                                        <c:forEach items="${components5.subComponents}" var="components6">
                                                                                                            <c:if test="${components6.assigned==true}">
                                                                                                                <li>
                                                                                                                    <c:if test="${components6.size<1}"><i class="fa fa-dot-circle-o"></i></c:if><c:if test="${components6.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp; <img src="static/images/disabledsmall.png" title="Un Assigned"/> <label>${components6.componentname}</label> &nbsp;<c:if test="${components6.hasprivilege==true && components6.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components6.accessrightgroupprivilegeid}" onchange="if(this.checked){
                                                                                                                                checkorUncheckedStaffSubComponent('checked',this.value); 
                                                                                                                            }else{
                                                                                                                              checkorUncheckedStaffSubComponent('unchecked',this.value);   
                                                                                                                            }  " type="checkbox"></c:if>
                                                                                                                        <ul id="xx">
                                                                                                                        <c:forEach items="${components6.subComponents}" var="components7">
                                                                                                                            <c:if test="${components7.assigned==true}">
                                                                                                                                <li>
                                                                                                                                    <c:if test="${components7.size<1}"><i class="fa fa-dot-circle-o"></i></c:if><c:if test="${components7.size>0}"><i class="fa fa-plus"></i></c:if> &nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/> <label>${components7.componentname}</label> &nbsp;<c:if test="${components7.hasprivilege==true && components7.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components7.accessrightgroupprivilegeid}" onchange="if(this.checked){
                                                                                                                                            checkorUncheckedStaffSubComponent('checked',this.value); 
                                                                                                                                        }else{
                                                                                                                                          checkorUncheckedStaffSubComponent('unchecked',this.value);   
                                                                                                                                        }  " type="checkbox"></c:if>
                                                                                                                                </li>
                                                                                                                            </c:if>
                                                                                                                        </c:forEach>  
                                                                                                                    </ul>
                                                                                                                </li>  
                                                                                                            </c:if>
                                                                                                        </c:forEach> 
                                                                                                    </ul>
                                                                                                </li>   
                                                                                            </c:if>
                                                                                        </c:forEach>  
                                                                                    </ul>
                                                                                </li>   
                                                                            </c:if>
                                                                        </c:forEach>  
                                                                    </ul>
                                                                </li>  
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </li>  
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </li>  
                            </c:if>

                        </c:forEach>
                    </ul>
                </li>  
            </c:if>

        </c:forEach>
    </ul>
</div>
<div id="facilityassignedoverlay" style="display: none;">
    <img src="static/img2/loader.gif" alt="Loading" /><br/>
    Please Wait...
</div>
<div class="row">
    <div class="col-md-12">
        <button class="btn btn-primary" id="savestaffgroupaccessrightsassignmentbtns" style="display: none;" onclick="savestaffgroupaccessrightsassignment();">Save</button>
    </div>
</div>
<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
            $("#collapseAllxxx3").click(function () {
                $("#groupsrightstreeview").hummingbird("collapseAll");
            });
            $("#expandAllxxx3").click(function () {
                $("#groupsrightstreeview").hummingbird("expandAll");
            });

            document.getElementById('gettinggroupscomponentstructurediv').style.display = 'none';
            $("#groupsrightstreeview").hummingbird();
            function savestaffgroupaccessrightsassignment() {
                var stafffacilityunitid = $('#stafffacilityassignedunits').val();
                var groupreleasecomponentgroupid = $('#groupreleasecomponentgroupid').val();
                var groupcomponentid = $('#groupreleasecomponentId').val();

                if (accessrightgroupprivilegeSelected.size > 0) {
                    $.confirm({
                        title: 'Save Assigned Activities!',
                        icon: 'fa fa-warning',
                        content: 'Are You Sure You Want To Save' + ' ' + accessrightgroupprivilegeSelected.size + ' ' + 'Activities?',
                        type: 'purple',
                        typeAnimated: true,
                        buttons: {
                            tryAgain: {
                                text: 'Yes,Save',
                                btnClass: 'btn-purple',
                                action: function () {
                                    document.getElementById('facilityassignedoverlay').style.display = 'block';
                                    $.ajax({
                                        type: 'POST',
                                        data: {values: JSON.stringify(Array.from(accessrightgroupprivilegeSelected)), stafffacilityunitid: JSON.stringify(stafffacilityunitid), groupid: groupreleasecomponentgroupid},
                                        url: "localaccessrightsmanagement/savenewstaffassignedactivitiespriv.htm",
                                        success: function (data, textStatus, jqXHR) {
                                            accessrightgroupprivilegeSelected.clear();
                                            document.getElementById('savestaffgroupaccessrightsassignmentbtns').style.display='none'; 
                                            
                                            document.getElementById('facilityassignedoverlay').style.display = 'none';
                                            document.getElementById('stafffacilityunitid_forms').reset();
                                            document.getElementById('releasedgroupscomponentsforgrouptree').innerHTML = '';
                                            
                                            $("#groupreleasecomponentId option[id='defaultgroupCompntsselectid']").attr("selected", "selected");
                                            $('#groupCompntsselectid' + groupcomponentid).remove();

                                            $.confirm({
                                                title: 'Save Activities!',
                                                content: 'Saved Successfully !!',
                                                type: 'purple',
                                                typeAnimated: true,
                                                buttons: {
                                                    close: function () {
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
            var accessrightgroupprivilegeSelected=new Set();
            function checkorUncheckedStaffSubComponent(type,accessrightgroupprivilegeid){
               if(type==='checked'){
                  accessrightgroupprivilegeSelected.add(accessrightgroupprivilegeid);
               }else{
                 accessrightgroupprivilegeSelected.delete(accessrightgroupprivilegeid); 
               } 
               if(accessrightgroupprivilegeSelected.size>0){
                  document.getElementById('savestaffgroupaccessrightsassignmentbtns').style.display='block'; 
               }else{
                    document.getElementById('savestaffgroupaccessrightsassignmentbtns').style.display='none'; 
               }
            }
</script>
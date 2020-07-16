<%-- 
    Document   : subComponents
    Created on : Jul 20, 2018, 5:10:20 PM
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
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    #facilityoverlay {
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
<div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
    <!-- <div id="treeview_container" class="hummingbird-treeview"> -->
    <ul id="treeview" class="hummingbird-base">
        <span id="expandAllxxxx4" class="icon-custom" style="color: #56050c;">Expand All</span>| <span id="collapseAllxxxx4" style="color: #56050c;" class="icon-custom">Contract All</span> <br>
        <c:forEach items="${customList}" var="components">
            <c:if test="${components.assigned==true}">
                <li>
                    <i class="fa fa-minus"></i> &nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/> <label> ${components.systemmodule.componentname}</label> &nbsp; <c:if test="${components.systemmodule.hasprivilege==true && components.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components.systemmodule.privilegeid}" onchange="if(this.checked){
                        checkorUncheckedSubComponent('checked',this.value); 
                    }else{
                      checkorUncheckedSubComponent('unchecked',this.value);   
                    }  " type="checkbox"></c:if>
                    <ul style="display: block;" id="xx">
                        <c:forEach items="${components.customSystemmoduleList}" var="components1">
                            <c:if test="${components1.assigned==true}">
                                <li>
                                    <c:if test="${components1.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components1.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/>  <label> ${components1.systemmodule.componentname}</label> &nbsp;<c:if test="${components1.systemmodule.hasprivilege==true && components1.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components1.systemmodule.privilegeid}" onchange="if(this.checked){
                                    checkorUncheckedSubComponent('checked',this.value);
                                    }else{
                                      checkorUncheckedSubComponent('unchecked',this.value);  
                                    }" type="checkbox"></c:if>
                                        <ul id="xx">
                                        <c:forEach items="${components1.customSystemmoduleList}" var="components2">
                                            <c:if test="${components2.assigned==true}">
                                                <li>
                                                    <c:if test="${components2.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components2.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/>  <label> ${components2.systemmodule.componentname}</label>&nbsp;<c:if test="${components2.systemmodule.hasprivilege==true && components2.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components2.systemmodule.privilegeid}" onchange="if(this.checked){
                                                        checkorUncheckedSubComponent('checked',this.value); 
                                                    }else{
                                                        checkorUncheckedSubComponent('unchecked',this.value); 
                                                    }" type="checkbox"></c:if>
                                                        <ul id="xx">
                                                        <c:forEach items="${components2.customSystemmoduleList}" var="components3">
                                                            <c:if test="${components3.assigned==true}">
                                                                <li>
                                                                    <c:if test="${components3.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components3.submodules>0}"><i class="fa fa-plus"></i></c:if> &nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/> <label>${components3.systemmodule.componentname}</label>&nbsp;<c:if test="${components3.systemmodule.hasprivilege==true && components3.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components3.systemmodule.privilegeid}" onchange="if(this.checked){
                                                                        checkorUncheckedSubComponent('checked',this.value); 
                                                                    }else{
                                                                        checkorUncheckedSubComponent('unchecked',this.value); 
                                                                    }" type="checkbox"></c:if>
                                                                        <ul id="xx">
                                                                        <c:forEach items="${components3.customSystemmoduleList}" var="components4">
                                                                            <c:if test="${components4.assigned==true}">
                                                                                <li>
                                                                                    <c:if test="${components4.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components4.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/>  <label>${components4.systemmodule.componentname}</label>&nbsp;<c:if test="${components4.systemmodule.hasprivilege==true && components4.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components4.systemmodule.privilegeid}" onchange="if(this.checked){
                                                                                        checkorUncheckedSubComponent('checked',this.value); 
                                                                                    }else{
                                                                                        checkorUncheckedSubComponent('unchecked',this.value); 
                                                                                    }" type="checkbox"></c:if>
                                                                                        <ul id="xx">
                                                                                        <c:forEach items="${components4.customSystemmoduleList}" var="components5">
                                                                                            <c:if test="${components5.assigned==true}">
                                                                                                <li>
                                                                                                    <c:if test="${components5.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components5.submodules>0}"><i class="fa fa-plus"></i></c:if> &nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/> <label>${components5.systemmodule.componentname}</label>&nbsp; <c:if test="${components5.systemmodule.hasprivilege==true && components5.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components5.systemmodule.privilegeid}" onchange="if(this.checked){
                                                                                                        checkorUncheckedSubComponent('checked',this.value); 
                                                                                                    }else{
                                                                                                        checkorUncheckedSubComponent('unchecked',this.value); 
                                                                                                    }" type="checkbox"></c:if>
                                                                                                        <ul id="xx">
                                                                                                        <c:forEach items="${components5.customSystemmoduleList}" var="components6">
                                                                                                            <c:if test="${components6.assigned==true}">
                                                                                                                <li>
                                                                                                                    <c:if test="${components6.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components6.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/>  <label>${components6.systemmodule.componentname}</label>&nbsp;<c:if test="${components6.systemmodule.hasprivilege==true && components6.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components6.systemmodule.privilegeid}" onchange="if(this.checked){
                                                                                                                        checkorUncheckedSubComponent('checked',this.value); 
                                                                                                                    }else{
                                                                                                                        checkorUncheckedSubComponent('unchecked',this.value); 
                                                                                                                    }" type="checkbox"></c:if>
                                                                                                                        <ul id="xx">
                                                                                                                        <c:forEach items="${components6.customSystemmoduleList}" var="components7">
                                                                                                                            <c:if test="${components7.assigned==true}">
                                                                                                                                <li>
                                                                                                                                    <c:if test="${components7.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components7.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/>   <label>${components7.systemmodule.componentname}</label>&nbsp; <c:if test="${components7.systemmodule.hasprivilege==true && components7.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span><input value="${components7.systemmodule.privilegeid}" onchange="if(this.checked){
                                                                                                                                        checkorUncheckedSubComponent('checked',this.value); 
                                                                                                                                    }else{
                                                                                                                                        checkorUncheckedSubComponent('unchecked',this.value); 
                                                                                                                                    }" type="checkbox"></c:if>
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
<div id="facilityoverlay" style="display: none;">
    <img src="static/img2/loader.gif" alt="Loading" /><br/>
    Please Wait...
</div>
<input type="hidden" id="transferredcreatedgroupid" value="${createdgroupid}">
<input type="hidden" id="transferredsystemmoduleids" value="${systemmoduleid}">
<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
    $("#collapseAllxxxx4").click(function () {
        $("#treeview").hummingbird("collapseAll");
    });
    $("#expandAllxxxx4").click(function () {
        $("#treeview").hummingbird("expandAll");
    });
    document.getElementById('gettingcomponentstructurediv').style.display = 'none';

    $("#treeview").hummingbird();

    function savegroupaccessrightsassignment() {
        var creatgroupid = $('#transferredcreatedgroupid').val();
        var systemmoduleid = $('#transferredsystemmoduleids').val();

        if (privilegesSelected.size > 0) {
            $.confirm({
                title: 'Selected Activities!',
                icon: 'fa fa-warning',
                content: 'Are You Sure You Want Save' + ' ' + privilegesSelected.size + ' ' + 'Activities for this Group?',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes,Save',
                        btnClass: 'btn-purple',
                        action: function () {
                            document.getElementById('facilityoverlay').style.display = 'block';
                            $.ajax({
                                type: 'POST',
                                data: {values: JSON.stringify(Array.from(privilegesSelected)), accessgrouprightsid: creatgroupid},
                                url: "localaccessrightsmanagement/savegroupassignedaccessrights.htm",
                                success: function (data, textStatus, jqXHR) {
                                    privilegesSelected.clear();
                                     document.getElementById('savegroupaccessrightsassignmentbtns').style.display='none';
                                    $.confirm({
                                        title: 'Save Group Activities!',
                                        content: 'Saved Successfully!!',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                document.getElementById('releasecomponentsforgrouptree').innerHTML = '';
                                                var facilitycomponents = $('#facilityaddComponentsdivs').val();
                                                if (facilitycomponents !== '') {
                                                    var addcount = parseInt(facilitycomponents) + 1;
                                                    document.getElementById('facilityaddComponentsdivs').value = addcount;
                                                    document.getElementById('SpanFacilityGroupAssignedComponents').innerHTML = addcount;
                                                } else {
                                                    document.getElementById('facilityaddComponentsdivs').value = parseInt(facilitycomponents);
                                                    document.getElementById('SpanFacilityGroupAssignedComponents').innerHTML = facilitycomponents;
                                                }
                                                $('#SelectOption' + systemmoduleid).remove();
                                                $("#groupreleasecomponentid option[id='defaultComponentsselectid']").attr("selected", "selected");

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
    var privilegesSelected=new Set();
    function checkorUncheckedSubComponent(type,privilegeid){
        if(type==='checked'){
          privilegesSelected.add(privilegeid);
        }else{
         privilegesSelected.delete(privilegeid); 
        }
        if(privilegesSelected.size>0){
            document.getElementById('savegroupaccessrightsassignmentbtns').style.display='block';
        }else{
           document.getElementById('savegroupaccessrightsassignmentbtns').style.display='none';  
        }
    }
</script>

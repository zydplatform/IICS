<%-- 
    Document   : grantedRights
    Created on : Jul 23, 2018, 10:44:09 AM
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
    #facilityoverlayXXXX {
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
<c:if test="${ not empty staffcomponentstreelist}">
    <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
        <!-- <div id="treeview_container" class="hummingbird-treeview"> -->
        <ul id="staffGrantedRight" class="hummingbird-base">
            <span id="expandAllxxxxx5" class="icon-custom" style="color: #56050c;">Expand All</span>| <span id="collapseAllxxxxx5" style="color: #56050c;" class="icon-custom">Contract All</span> <br>
            <c:forEach items="${staffcomponentstreelist}" var="components">
                <c:if test="${components.assigned==true}">
                    <li>
                        <i class="fa fa-minus"></i>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label> ${components.componentname}</label>&nbsp;<c:if test="${components.hasprivilege==true && components.activity=='Activity'}">
                            <span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components.privilegeid}" onchange="if(this.checked){unAssignStaffAssignedRights('checked',this.value);}else{unAssignStaffAssignedRights('unchecked',this.value);}" type="checkbox">
                                    </c:if>
                        <ul style="display: block;" id="xx">
                            <c:forEach items="${components.systemSubcomponenets}" var="components1">
                                <c:if test="${components1.assigned==true}">
                                    <li>
                                        <c:if test="${components1.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components1.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label>  ${components1.componentname}</label>&nbsp;<c:if test="${components1.hasprivilege==true && components1.activity=='Activity'}">
                                            <span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components1.privilegeid}" onchange="if(this.checked){unAssignStaffAssignedRights('checked',this.value);}else{unAssignStaffAssignedRights('unchecked',this.value);}" type="checkbox">
                                                    </c:if>
                                        <ul id="xx">
                                            <c:forEach items="${components1.systemSubcomponenets}" var="components2">
                                                <c:if test="${components2.assigned==true}">
                                                    <li>
                                                        <c:if test="${components2.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components2.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label> ${components2.componentname}</label>&nbsp;<c:if test="${components2.hasprivilege==true && components2.activity=='Activity'}">
                                                            <span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components2.privilegeid}" onchange="if(this.checked){unAssignStaffAssignedRights('checked',this.value);}else{unAssignStaffAssignedRights('unchecked',this.value);}" type="checkbox">
                                                                    </c:if>
                                                        <ul id="xx">
                                                            <c:forEach items="${components2.systemSubcomponenets}" var="components3">
                                                                <c:if test="${components3.assigned==true}">
                                                                    <li>
                                                                        <c:if test="${components3.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components3.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/><label>${components3.componentname}</label>&nbsp;<c:if test="${components3.hasprivilege==true && components3.activity=='Activity'}">
                                                                            <span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components3.privilegeid}" onchange="if(this.checked){unAssignStaffAssignedRights('checked',this.value);}else{unAssignStaffAssignedRights('unchecked',this.value);}" type="checkbox">
                                                                                    </c:if>
                                                                        <ul id="xx">
                                                                            <c:forEach items="${components3.systemSubcomponenets}" var="components4">
                                                                                <c:if test="${components4.assigned==true}">
                                                                                    <li>
                                                                                        <c:if test="${components4.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components4.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label> ${components4.componentname}</label>&nbsp;<c:if test="${components4.hasprivilege==true && components4.activity=='Activity'}">
                                                                                            <span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components4.privilegeid}" onchange="if(this.checked){unAssignStaffAssignedRights('checked',this.value);}else{unAssignStaffAssignedRights('unchecked',this.value);}" type="checkbox">
                                                                                                    </c:if>
                                                                                        <ul id="xx">
                                                                                            <c:forEach items="${components4.systemSubcomponenets}" var="components5">
                                                                                                <c:if test="${components5.assigned==true}">
                                                                                                    <li>
                                                                                                        <c:if test="${components5.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components5.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/>  <label> ${components5.componentname}</label>&nbsp;<c:if test="${components5.hasprivilege==true && components5.activity=='Activity'}">
                                                                                                            <span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components5.privilegeid}" onchange="if(this.checked){unAssignStaffAssignedRights('checked',this.value);}else{unAssignStaffAssignedRights('unchecked',this.value);}" type="checkbox">
                                                                                                                    </c:if>
                                                                                                        <ul id="xx">
                                                                                                            <c:forEach items="${components5.systemSubcomponenets}" var="components6">
                                                                                                                <c:if test="${components6.assigned==true}">
                                                                                                                    <li>
                                                                                                                        <c:if test="${components6.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components6.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label>${components6.componentname}</label>&nbsp;<c:if test="${components6.hasprivilege==true && components6.activity=='Activity'}">
                                                                                                                            <span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components6.privilegeid}" onchange="if(this.checked){unAssignStaffAssignedRights('checked',this.value);}else{unAssignStaffAssignedRights('unchecked',this.value);}" type="checkbox">
                                                                                                                                    </c:if>
                                                                                                                        <ul id="xx">
                                                                                                                            <c:forEach items="${components6.systemSubcomponenets}" var="components7">
                                                                                                                                <c:if test="${components6.assigned==true}">
                                                                                                                                    <li>
                                                                                                                                        <c:if test="${components7.size<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components7.size>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label>${components7.componentname}</label>&nbsp;<c:if test="${components7.hasprivilege==true && components7.activity=='Activity'}">
                                                                                                                                            <span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components7.privilegeid}" onchange="if(this.checked){unAssignStaffAssignedRights('checked',this.value);}else{unAssignStaffAssignedRights('unchecked',this.value);}" type="checkbox">
                                                                                                                                        </c:if>  
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
    <div class="row">
    <div class="col-md-12">
        <button class="btn btn-primary" id="savestaffgroupaccessrightsdeassignbtns" style="display: none;" onclick="savestaffgroupaccessrightsdeassigned();">Deassign</button>
    </div>
</div>
</c:if>
<c:if test="${empty staffcomponentstreelist}">
    <h3 style="margin-top: 5%; margin-left: 5%;"><span class="badge badge-secondary"><strong>No ASSIGNED ACTIVITIES TO THIS STAFF IN THE GROUP</strong></span></h3>
    <h5 style="margin-left: 20%;"><span class="badge badge-danger"><strong>First Assign Activities Access tO This Staff In The Group</strong></span></h5> 
</c:if>
<div id="facilityoverlayXXXX" style="display: none;">
    <img src="static/img2/loader.gif" alt="Loading" /><br/>
    Please Wait...
</div>
<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
    document.getElementById('staffgrantedscomponentsLoader').style.display = 'none';
    $("#staffGrantedRight").hummingbird();
    $("#collapseAllxxxxx5").click(function () {
        $("#staffGrantedRight").hummingbird("collapseAll");
    });
    $("#expandAllxxxxx5").click(function () {
        $("#staffGrantedRight").hummingbird("expandAll");
    });
    var deassignstaff=new Set();
    function unAssignStaffAssignedRights(type,privilegeid){
        if(type==='checked'){
          deassignstaff.add(privilegeid);
        }else{
          deassignstaff.delete(privilegeid);
        }
        if(deassignstaff.size>0){
            document.getElementById('savestaffgroupaccessrightsdeassignbtns').style.display='block';
        }else{
            document.getElementById('savestaffgroupaccessrightsdeassignbtns').style.display='none';
        }
    }
    function savestaffgroupaccessrightsdeassigned(){
         var stafffacilityunit = $('#GratedUnitsGroupsComponentsSlectId').val();
          var staffGratedGroupsSlectId = $('#staffGratedGroupsSlectId').val();
          console.log('hhhhhhhhhhhhhh::::' +stafffacilityunit);
          console.log('gggggggggg:'+staffGratedGroupsSlectId);
        if(deassignstaff.size>0){
             $.confirm({
                title: 'Remove Staff Access Rights!',
                content: 'Are You Sure You Want To Remove '+deassignstaff.size+' '+'Staff Access Rights??',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-purple',
                        action: function(){
                           $.ajax({
                             type: 'POST',
                             data:{stafffacilityunit:stafffacilityunit,staffGratedGroupsSlectId:staffGratedGroupsSlectId,values:JSON.stringify(Array.from(deassignstaff))},
                             url: "localaccessrightsmanagement/savestaffgroupaccessrightsdeassigned.htm",
                             success: function (data, textStatus, jqXHR) {
                                $.confirm({
                                       title: 'De-assign!',
                                       content: 'De-assigned Successfully !!!',
                                       type: 'purple',
                                       typeAnimated: true,
                                       buttons: {
                                           close: function () {
                                              window.location='#close';
                                              ajaxSubmitDataNoLoader('localaccessrightsmanagement/useraccessrightsmanagement.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
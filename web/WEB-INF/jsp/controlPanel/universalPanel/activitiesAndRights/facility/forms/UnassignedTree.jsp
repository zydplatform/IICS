<%-- 
    Document   : componentTree
    Created on : Mar 23, 2018, 4:05:33 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    .fontsz{
        font-size: 16px !important;
    }
</style>
<link href="static/mainpane/css/hummingbird-treeview.css" rel="stylesheet">
<style>
    #facilityoverlayUnReleased {
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
<button onclick="unreleasedfacilitybackbutton(${facilityid});" class="btn btn-secondary pull-left" type="button"><i class="fa fa-fw fa-lg fa-backward"></i>Back</button><br>
<c:if test="${ not empty customList}">
    <br><br><div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
        <!-- <div id="treeview_container" class="hummingbird-treeview"> -->
        <ul id="facilityUnGrantedRight" class="hummingbird-base">
            <span id="unFacilityexpandAllxx2" class="icon-custom" style="color: #56050c;">Expand All</span>| <span id="unFacilitycollapseAllxx2" style="color: #56050c;" class="icon-custom">Contract All</span>(Un Assigned) <br>
            <c:forEach items="${customList}" var="components">
                    <li>
                        <i class="fa fa-minus"></i> &nbsp;<c:if test="${components.assigned==true }"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label> ${components.componentname}</label>&nbsp;<c:if test="${components.hasprivilege==true && components.activity=='Activity' && components.assigned==false }"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmoreFacility('checked',this.value);}else{checkedoruncheckedAddmoreFacility('unchecked',this.value);}" type="checkbox"> </c:if>
                        <ul style="display: block;" id="xx">
                            <c:forEach items="${components.customSystemmoduleList}" var="components1">
                                    <li>
                                        <c:if test="${components1.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components1.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components1.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components1.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label> ${components1.componentname}</label>&nbsp;<c:if test="${components1.hasprivilege==true && components1.activity=='Activity' && components1.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components1.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmoreFacility('checked',this.value);}else{checkedoruncheckedAddmoreFacility('unchecked',this.value);}" type="checkbox"> </c:if>
                                            <ul id="xx">
                                            <c:forEach items="${components1.customSystemmoduleList}" var="components2">
                                                    <li>
                                                        <c:if test="${components2.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components2.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components2.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components2.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label>${components2.componentname}</label>&nbsp;<c:if test="${components2.hasprivilege==true && components2.activity=='Activity' && components2.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components2.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmoreFacility('checked',this.value);}else{checkedoruncheckedAddmoreFacility('unchecked',this.value);}" type="checkbox"> </c:if>
                                                            <ul id="xx">
                                                            <c:forEach items="${components2.customSystemmoduleList}" var="components3">
                                                                    <li>
                                                                        <c:if test="${components3.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components3.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components3.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components3.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label> ${components3.componentname}</label>&nbsp;<c:if test="${components3.hasprivilege==true && components3.activity=='Activity' && components3.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components3.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmoreFacility('checked',this.value);}else{checkedoruncheckedAddmoreFacility('unchecked',this.value);}" type="checkbox"> </c:if>
                                                                            <ul id="xx">
                                                                            <c:forEach items="${components3.customSystemmoduleList}" var="components4">
                                                                                    <li>
                                                                                        <c:if test="${components4.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components4.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components4.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components4.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label>${components4.componentname}</label>&nbsp;<c:if test="${components4.hasprivilege==true && components4.activity=='Activity' && components4.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components4.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmoreFacility('checked',this.value);}else{checkedoruncheckedAddmoreFacility('unchecked',this.value);}" type="checkbox"> </c:if>
                                                                                            <ul id="xx">
                                                                                            <c:forEach items="${components4.customSystemmoduleList}" var="components5">
                                                                                                    <li>
                                                                                                        <c:if test="${components5.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components5.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components5.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components5.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label>${components5.componentname}</label>&nbsp;<c:if test="${components5.hasprivilege==true && components5.activity=='Activity' && components5.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components5.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmoreFacility('checked',this.value);}else{checkedoruncheckedAddmoreFacility('unchecked',this.value);}" type="checkbox"> </c:if>
                                                                                                            <ul id="xx">
                                                                                                            <c:forEach items="${components5.customSystemmoduleList}" var="components6">
                                                                                                                    <li>
                                                                                                                        <c:if test="${components6.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components6.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components6.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components6.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label> ${components6.componentname}</label>&nbsp;<c:if test="${components6.hasprivilege==true && components6.activity=='Activity' && components6.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components6.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmoreFacility('checked',this.value);}else{checkedoruncheckedAddmoreFacility('unchecked',this.value);}" type="checkbox"> </c:if> 
                                                                                                                            <ul id="xx">
                                                                                                                            <c:forEach items="${components6.customSystemmoduleList}" var="components7">
                                                                                                                                    <li>
                                                                                                                                        <c:if test="${components7.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components7.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components7.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components7.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label>${components7.componentname}</label>&nbsp;<c:if test="${components7.hasprivilege==true && components7.activity=='Activity' && components7.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components7.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmoreFacility('checked',this.value);}else{checkedoruncheckedAddmoreFacility('unchecked',this.value);}" type="checkbox"> </c:if>    
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
    <br>
    <input id="facilityToBeReleaseMoreComponentsId" value="${facilityid}" type="hidden">
    <div class="row">
        <div class="col-md-12">
            <button class="btn btn-primary" id="saveUnAssignedgroupaccessrightsassignFacilitybtn" style="display: none;" onclick="saveUnAssignedgroupaccessrightsFacilityassign();">Save</button>
        </div>
    </div>
    <div id="facilityoverlayUnReleased" style="display: none;">
        <img src="static/img2/loader.gif" alt="Loading" /><br/>
        Please Wait...
    </div>
</c:if>
    
<c:if test="${empty customList}">
    <h3 style="margin-top: 5%; margin-left: 5%;"><span class="badge badge-secondary"><strong>No UN ASSIGNED ACTIVITIES TO THIS FACILITY</strong></span></h3>
    <h5 style="margin-left: 20%;"><span class="badge badge-danger"><strong> Add More Activities</strong></span></h5> 
</c:if>
<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
     $("#facilityUnGrantedRight").hummingbird();
     
     $("#unFacilitycollapseAllxx2").click(function () {
        $("#facilityUnGrantedRight").hummingbird("collapseAll");
    });
    $("#unFacilityexpandAllxx2").click(function () {
        $("#facilityUnGrantedRight").hummingbird("expandAll");
    });
    var releaseMoreFacilityComponentRights=new Set();
   
    function unreleasedfacilitybackbutton(facilityid) {
        $.ajax({
            type: 'GET',
            data: {facilityid: facilityid},
            url: "activitiesandaccessrights/viewReleaseFacilityComponent.htm",
            success: function (data, textStatus, jqXHR) {
                $('#viewreleasefacilityaccessrighhtdiv').html(data);
            }
        });
    }
    function checkedoruncheckedAddmoreFacility(type,privilegeid){
        if(type==='checked'){
            releaseMoreFacilityComponentRights.add(privilegeid);
        }else{
            releaseMoreFacilityComponentRights.delete(privilegeid);
        }
        if(releaseMoreFacilityComponentRights.size>0){
          document.getElementById('saveUnAssignedgroupaccessrightsassignFacilitybtn').style.display='block';  
        }else{
            document.getElementById('saveUnAssignedgroupaccessrightsassignFacilitybtn').style.display='none';
        } 
    }
    function saveUnAssignedgroupaccessrightsFacilityassign(){
        var facilityid=$('#facilityToBeReleaseMoreComponentsId').val();
        $.confirm({
            title: 'Release More Rights',
            content: 'Are You Sure You Want To Release More '+releaseMoreFacilityComponentRights.size+' '+'Activities?',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-purple',
                    action: function(){
                        document.getElementById('facilityoverlayUnReleased').style.display='block';
                        $.ajax({
                            type: 'POST',
                            data:{values:JSON.stringify(Array.from(releaseMoreFacilityComponentRights)),facilityid:facilityid},
                            url: "activitiesandaccessrights/saveunassignedgroupaccessrightsfacilityassign.htm",
                            success: function (data) {
                                releaseMoreFacilityComponentRights.clear();
                               $.confirm({
                                    title: 'Release More Rights',
                                    content: 'Released Success Fully',
                                    type: 'purple',
                                    typeAnimated: true,
                                    buttons: {
                                        close: function () {
                                         document.getElementById('facilityoverlayUnReleased').style.display='none';
                                          unreleasedfacilitybackbutton(facilityid);  
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
</script>
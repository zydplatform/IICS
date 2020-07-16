<%-- 
    Document   : componentTree
    Created on : Mar 23, 2018, 4:05:33 PM
    Author     : RESEARCH
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
<style>
    #facilityoverdeasslayXXX {
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

<button onclick="releasedfacilitybackbutton(${facilityid});" class="btn btn-secondary pull-right" type="button"><i class="fa fa-fw fa-lg fa-backward"></i>Back</button><br><br>
<c:if test="${ not empty customList}">
    <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
        <!-- <div id="treeview_container" class="hummingbird-treeview"> -->
        <ul id="FacilityReleasedRights" class="hummingbird-base">
            <span id="expandAllxxFacilityReleased" class="icon-custom" style="color: #56050c;">Expand All</span>| <span id="collapseAllxxFacilityReleased" style="color: #56050c;" class="icon-custom">Contract All</span> <br>
            <c:forEach items="${customList}" var="components">
                <c:if test="${components.assigned==true}">
                    <li>
                        <i class="fa fa-minus"></i>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label> ${components.componentname}</label>&nbsp;<c:if test="${components.hasprivilege==true && components.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input onchange="if(this.checked){recallFacilityReleasedComponents('checked',this.value);}else{recallFacilityReleasedComponents('unchecked',this.value);}" value="${components.privilegeid}" type="checkbox"> </c:if>
                            <ul style="display: block;" id="xx">
                            <c:forEach items="${components.customSystemmoduleList}" var="components1">
                                <c:if test="${components1.assigned==true}">
                                    <li>
                                        <c:if test="${components1.subModules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components1.subModules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label> ${components1.componentname}</label>&nbsp;<c:if test="${components1.hasprivilege==true && components1.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input onchange="if(this.checked){recallFacilityReleasedComponents('checked',this.value);}else{recallFacilityReleasedComponents('unchecked',this.value);}" value="${components1.privilegeid}" type="checkbox"> </c:if>
                                            <ul id="xx">
                                            <c:forEach items="${components1.customSystemmoduleList}" var="components2">
                                                <c:if test="${components2.assigned==true}">
                                                    <li>
                                                        <c:if test="${components2.subModules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components2.subModules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label>${components2.componentname}</label>&nbsp;<c:if test="${components2.hasprivilege==true && components2.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input onchange="if(this.checked){recallFacilityReleasedComponents('checked',this.value);}else{recallFacilityReleasedComponents('unchecked',this.value);}" value="${components2.privilegeid}" type="checkbox"> </c:if>
                                                            <ul id="xx">
                                                            <c:forEach items="${components2.customSystemmoduleList}" var="components3">
                                                                <c:if test="${components3.assigned==true}">
                                                                    <li>
                                                                        <c:if test="${components3.subModules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components3.subModules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label>${components3.componentname}</label>&nbsp;<c:if test="${components3.hasprivilege==true && components3.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input onchange="if(this.checked){recallFacilityReleasedComponents('checked',this.value);}else{recallFacilityReleasedComponents('unchecked',this.value);}" value="${components3.privilegeid}" type="checkbox"> </c:if>
                                                                            <ul id="xx">
                                                                            <c:forEach items="${components3.customSystemmoduleList}" var="components4">
                                                                                <c:if test="${components4.assigned==true}">
                                                                                    <li>
                                                                                        <c:if test="${components4.subModules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components4.subModules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/><label> ${components4.componentname}</label>&nbsp;<c:if test="${components4.hasprivilege==true && components4.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input onchange="if(this.checked){recallFacilityReleasedComponents('checked',this.value);}else{recallFacilityReleasedComponents('unchecked',this.value);}" value="${components4.privilegeid}" type="checkbox"> </c:if>
                                                                                            <ul id="xx">
                                                                                            <c:forEach items="${components4.customSystemmoduleList}" var="components5">
                                                                                                <c:if test="${components5.assigned==true}">
                                                                                                    <li>
                                                                                                        <c:if test="${components5.subModules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components5.subModules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label> ${components5.componentname}</label>&nbsp;<c:if test="${components5.hasprivilege==true && components5.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input onchange="if(this.checked){recallFacilityReleasedComponents('checked',this.value);}else{recallFacilityReleasedComponents('unchecked',this.value);}" value="${components5.privilegeid}" type="checkbox"> </c:if>
                                                                                                            <ul id="xx">
                                                                                                            <c:forEach items="${components5.customSystemmoduleList}" var="components6">
                                                                                                                <c:if test="${components6.assigned==true}">
                                                                                                                    <li>
                                                                                                                        <c:if test="${components6.subModules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components6.subModules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label> ${components6.componentname}</label>&nbsp;<c:if test="${components6.hasprivilege==true && components6.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input onchange="if(this.checked){recallFacilityReleasedComponents('checked',this.value);}else{recallFacilityReleasedComponents('unchecked',this.value);}" value="${components6.privilegeid}" type="checkbox"> </c:if>  
                                                                                                                            <ul id="xx">
                                                                                                                            <c:forEach items="${components6.customSystemmoduleList}" var="components7">
                                                                                                                                <c:if test="${components7.assigned==true}">
                                                                                                                                    <li>
                                                                                                                                        <c:if test="${components7.subModules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components7.subModules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/>  <label>${components7.componentname}</label>&nbsp;<c:if test="${components7.hasprivilege==true && components7.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input onchange="if(this.checked){recallFacilityReleasedComponents('checked',this.value);}else{recallFacilityReleasedComponents('unchecked',this.value);}" value="${components7.privilegeid}" type="checkbox"> </c:if>   
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
    <div id="saverecalledfacilitycomponentsbtn" style="display: none;">
        <div class="row">
            <button onclick="saverecalledfacilitycomponents();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>
        </div>
    </div>
</c:if>
<div id="facilityoverdeasslayXXX" style="display: none;">
    <img src="static/img2/loader.gif" alt="Loading" /><br/>
    Please Wait...
</div>
<input id="recallthisfacilityreleasedcomponentsinp" value="${facilityid}" type="hidden">
<c:if test="${empty customList}">
    <h3 style="margin-top: 5%; margin-left: 5%;"><span class="badge badge-secondary"><strong>No RELEASED ACTIVITIES TO THIS FACILITY</strong></span></h3>
    <h5 style="margin-left: 20%;"><span class="badge badge-danger"><strong>First Release Activities To This Fcility</strong></span></h5> 
</c:if>
<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
    $("#FacilityReleasedRights").hummingbird();
    $("#collapseAllxxFacilityReleased").click(function () {
        $("#FacilityReleasedRights").hummingbird("collapseAll");
    });
    $("#expandAllxxFacilityReleased").click(function () {
        $("#FacilityReleasedRights").hummingbird("expandAll");
    });
</script>
<script>
    function releasedfacilitybackbutton(facilityid) {
        $.ajax({
            type: 'GET',
            data: {facilityid: facilityid},
            url: "activitiesandaccessrights/viewReleaseFacilityComponent.htm",
            success: function (data, textStatus, jqXHR) {
                $('#viewreleasefacilityaccessrighhtdiv').html(data);
            }
        });
    }
   var recallfacilitycomponents=new Set();
    function recallFacilityReleasedComponents(type,privilegeid){
        if(type==='checked'){
           recallfacilitycomponents.add(privilegeid); 
        }else{
          recallfacilitycomponents.delete(privilegeid);
        }
        if(recallfacilitycomponents.size>0){
            document.getElementById('saverecalledfacilitycomponentsbtn').style.display='block';
        }else{
            document.getElementById('saverecalledfacilitycomponentsbtn').style.display='none';
        }
    }
    function saverecalledfacilitycomponents(){
        var facilityid=$('#recallthisfacilityreleasedcomponentsinp').val();
        if(recallfacilitycomponents.size>0){
               $.confirm({
                    title: 'Recall Facility Component!',
                    content: 'Are You Sure You Want To Recall'+' '+recallfacilitycomponents.size+' '+'Activities?',
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Yes',
                            btnClass: 'btn-purple',
                            action: function(){
                                document.getElementById('facilityoverdeasslayXXX').style.display='block';
                                $.ajax({
                                    type: 'POST',
                                    data:{values:JSON.stringify(Array.from(recallfacilitycomponents)),facilityid:facilityid},
                                    url: "activitiesandaccessrights/saverecalledfacilitycomponents.htm",
                                    success: function (data, textStatus, jqXHR) {
                                          $.confirm({
                                                title: 'Recall Facility Component!!',
                                                content: 'Recall Facility Component Success Fully!',
                                                type: 'purple',
                                                typeAnimated: true,
                                                buttons: {
                                                    close: function () {
                                                     recallfacilitycomponents.clear();
                                                     document.getElementById('facilityoverdeasslayXXX').style.display='none';  
                                                     document.getElementById('saverecalledfacilitycomponentsbtn').style.display='none';
                                                     ajaxSubmitDataNoLoader('activitiesandaccessrights/viewReleaseFacilityComponent.htm', 'viewreleasefacilityaccessrighhtdiv', 'facilityid='+facilityid+'&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
        }else{
                $.confirm({
                    title: 'Recall Facility Component!',
                    content: 'Nothing Selected',
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                            
                        }
                    }
                });
            
        }
    }
</script>
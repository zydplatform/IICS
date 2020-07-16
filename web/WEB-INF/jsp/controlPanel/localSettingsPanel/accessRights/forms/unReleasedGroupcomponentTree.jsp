<%-- 
    Document   : unReleasedGroupcomponentTree
    Created on : Aug 2, 2018, 12:11:55 PM
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
<!DOCTYPE html>
<style>
    #facilityoverlayGroupsdXoX {
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
<c:if test="${not empty customList}">
    <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
        <!-- <div id="treeview_container" class="hummingbird-treeview"> -->
        <ul id="UnReleasedGroupGrantedRight" class="hummingbird-base">
            <span id="unReleasedGroupexpandAllxx2" class="icon-custom" style="color: #56050c;">Expand All</span>| <span id="unReleasedGroupcollapseAllxx2" style="color: #56050c;" class="icon-custom">Contract All</span> <br>
            <c:forEach items="${customList}" var="components">
                <c:if test="${components.assigned==true}">
                   <li>
                    <i class="fa fa-minus"></i> &nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/> <label> ${components.componentname}</label>&nbsp;<c:if test="${components.hasprivilege==true && components.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span> &nbsp;<input onchange="if(this.checked){addmoregroupcomponents('checked',this.value);}else{addmoregroupcomponents('unchecked',this.value);}" value="${components.privilegeid}" type="checkbox"> </c:if>
                    <ul style="display: block;" id="xx">
                        <c:forEach items="${components.customSystemmoduleList}" var="components1">
                            <c:if test="${components1.assigned==true}">
                             <li>
                                <c:if test="${components1.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components1.submodules>0}"><i class="fa fa-plus"></i></c:if> &nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/><label> ${components1.componentname}</label>&nbsp;<c:if test="${components1.hasprivilege==true && components1.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span> &nbsp;<input onchange="if(this.checked){addmoregroupcomponents('checked',this.value);}else{addmoregroupcomponents('unchecked',this.value);}"  value="${components1.privilegeid}" type="checkbox"> </c:if>
                                    <ul id="xx">
                                    <c:forEach items="${components1.customSystemmoduleList}" var="components2">
                                        <c:if test="${components2.assigned==true}">
                                          <li>
                                            <c:if test="${components2.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components2.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/> <label> ${components2.componentname}</label>&nbsp;<c:if test="${components2.hasprivilege==true && components2.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span> &nbsp;<input onchange="if(this.checked){addmoregroupcomponents('checked',this.value);}else{addmoregroupcomponents('unchecked',this.value);}"  value="${components2.privilegeid}" type="checkbox"> </c:if>
                                                <ul id="xx">
                                                <c:forEach items="${components2.customSystemmoduleList}" var="components3">
                                                    <c:if test="${components3.assigned==true}">
                                                        <li>
                                                        <c:if test="${components3.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components3.submodules>0}"><i class="fa fa-plus"></i></c:if> &nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/><label> ${components3.componentname}</label>&nbsp;<c:if test="${components3.hasprivilege==true && components3.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span> &nbsp;<input onchange="if(this.checked){addmoregroupcomponents('checked',this.value);}else{addmoregroupcomponents('unchecked',this.value);}"  value="${components3.privilegeid}" type="checkbox"> </c:if>
                                                            <ul id="xx">
                                                            <c:forEach items="${components3.customSystemmoduleList}" var="components4">
                                                                <c:if test="${components4.assigned==true}">
                                                                   <li>
                                                                    <c:if test="${components4.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components4.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/><label> ${components4.componentname}</label>&nbsp;<c:if test="${components4.hasprivilege==true && components4.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span> &nbsp;<input  onchange="if(this.checked){addmoregroupcomponents('checked',this.value);}else{addmoregroupcomponents('unchecked',this.value);}" value="${components4.privilegeid}" type="checkbox"> </c:if>
                                                                        <ul id="xx">
                                                                        <c:forEach items="${components4.customSystemmoduleList}" var="components5">
                                                                            <c:if test="${components5.assigned==true}">
                                                                              <li>
                                                                                <c:if test="${components5.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components5.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/><label> ${components5.componentname}</label>&nbsp;<c:if test="${components5.hasprivilege==true && components5.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span> &nbsp;<input onchange="if(this.checked){addmoregroupcomponents('checked',this.value);}else{addmoregroupcomponents('unchecked',this.value);}" value="${components5.privilegeid}" type="checkbox"> </c:if>
                                                                                    <ul id="xx">
                                                                                    <c:forEach items="${components5.customSystemmoduleList}" var="components6">
                                                                                        <c:if test="${components6.assigned==true}">
                                                                                          <li>
                                                                                            <c:if test="${components6.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components6.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/><label> ${components6.componentname}</label> &nbsp;<c:if test="${components6.hasprivilege==true && components6.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span> &nbsp;<input onchange="if(this.checked){addmoregroupcomponents('checked',this.value);}else{addmoregroupcomponents('unchecked',this.value);}"  value="${components6.privilegeid}" type="checkbox"> </c:if>
                                                                                                <ul id="xx">
                                                                                                <c:forEach items="${components6.customSystemmoduleList}" var="components7">
                                                                                                    <c:if test="${components6.assigned==true}">
                                                                                                    <li>
                                                                                                        <c:if test="${components7.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components7.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/disabledsmall.png" title="Un Assigned"/><label> ${components7.componentname}</label>&nbsp;<c:if test="${components7.hasprivilege==true && components7.activity=='Activity'}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span> &nbsp;<input onchange="if(this.checked){addmoregroupcomponents('checked',this.value);}else{addmoregroupcomponents('unchecked',this.value);}"  value="${components7.privilegeid}" type="checkbox"> </c:if>    
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
    <br>
    <div class="row">
        <button onclick="saveunreleasedGroupComponents();" style="display: none;" class="btn btn-primary pull-right" id="saveunreleasedgroupComponentsbtn" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>
    </div>
</c:if>
 <div id="facilityoverlayGroupsdXoX" style="display: none;">
    <img src="static/img2/loader.gif" alt="Loading" /><br/>
    Please Wait...
</div>
<c:if test="${empty customList}">
    <h3 style="margin-top: 5%; margin-left: 5%;"><span class="badge badge-secondary"><strong>NO UN ASSIGNED ACTIVITIES</strong></span></h3>
    <h5 style="margin-left: 20%;"><span class="badge badge-danger"><strong>ALL COMPONENTS ASSIGNED</strong></span></h5> 
</c:if>

<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
     $("#UnReleasedGroupGrantedRight").hummingbird();
    $("#unReleasedGroupcollapseAllxx2").click(function () {
        $("#UnReleasedGroupGrantedRight").hummingbird("collapseAll");
    });
    $("#unReleasedGroupexpandAllxx2").click(function () {
        $("#UnReleasedGroupGrantedRight").hummingbird("expandAll");
    });
    var unReleasedGroupComponents= new Set();
    function addmoregroupcomponents(type,privilegeid){
       if(type==='checked'){
         unReleasedGroupComponents.add(privilegeid);
       }else{
         unReleasedGroupComponents.delete(privilegeid); 
       } 
       if(unReleasedGroupComponents.size>0){
           document.getElementById('saveunreleasedgroupComponentsbtn').style.display='block';
       }else{
           document.getElementById('saveunreleasedgroupComponentsbtn').style.display='none';
       }
    }
    function saveunreleasedGroupComponents(){
        var accessrightsgroupid=$('#facilityaccessrightsgroupidComp').val();
        var systemmoduleid=$('#ReleaseUnreleasedFacilitycomponentid').val();
            $.confirm({
                title: 'ADD MORE COMPONENTS TO GROUP',
                content: 'Are You Sure You Want To Add '+unReleasedGroupComponents.size+' '+'Activities?',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-purple',
                        action: function(){
                            document.getElementById('facilityoverlayGroupsdXoX').style.display='block';
                         $.ajax({
                            type: 'POST',
                            data:{values: JSON.stringify(Array.from(unReleasedGroupComponents)), accessgrouprightsid: accessrightsgroupid},
                            url: "localaccessrightsmanagement/savegroupassignedaccessrights.htm",
                            success: function (data, textStatus, jqXHR) {
                                    unReleasedGroupComponents.clear();
                                    $.confirm({
                                        title: 'ADD MORE COMPONENTS TO GROUP!',
                                        content: 'Added Successfully !!',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                document.getElementById('facilityoverlayGroupsdXoX').style.display='none';
                                                $('#ReleaseUnReleasedGroupUndefault' + systemmoduleid).remove();
                                                $("#ReleaseUnreleasedFacilitycomponentid option[id='ReleaseUnReleasedFacilityComponentsselectid']").attr("selected", "selected"); 
                                                document.getElementById('releaseUnReleasedGroupscomponentsinfacility').innerHTML='';
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
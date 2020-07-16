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
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<style>
    #facilityoverlayGrpXXXX {
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
<c:if test="${ not empty customList}">
    <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
        <!-- <div id="treeview_container" class="hummingbird-treeview"> -->
        <ul id="groupUnGrantedRight" class="hummingbird-base">
            <span id="unexpandAllxx2" class="icon-custom" style="color: #56050c;">Expand All</span>| <span id="uncollapseAllxx2" style="color: #56050c;" class="icon-custom">Contract All</span>(Un Assigned) <br>
            <c:forEach items="${customList}" var="components">
                    <li>
                        <i class="fa fa-minus"></i> &nbsp;<c:if test="${components.assigned==true }"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label> ${components.componentname}</label>&nbsp;<c:if test="${components.hasprivilege==true && components.activity=='Activity' && components.assigned==false }"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmore('checked',this.value);}else{checkedoruncheckedAddmore('unchecked',this.value);}" type="checkbox"> </c:if>
                        <ul style="display: block;" id="xx">
                            <c:forEach items="${components.customSystemmoduleList}" var="components1">
                                    <li>
                                        <c:if test="${components1.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components1.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components1.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components1.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label> ${components1.componentname}</label>&nbsp;<c:if test="${components1.hasprivilege==true && components1.activity=='Activity' && components1.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components1.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmore('checked',this.value);}else{checkedoruncheckedAddmore('unchecked',this.value);}" type="checkbox"> </c:if>
                                            <ul id="xx">
                                            <c:forEach items="${components1.customSystemmoduleList}" var="components2">
                                                    <li>
                                                        <c:if test="${components2.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components2.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components2.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components2.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if> <label>${components2.componentname}</label>&nbsp;<c:if test="${components2.hasprivilege==true && components2.activity=='Activity' && components2.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components2.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmore('checked',this.value);}else{checkedoruncheckedAddmore('unchecked',this.value);}" type="checkbox"> </c:if>
                                                            <ul id="xx">
                                                            <c:forEach items="${components2.customSystemmoduleList}" var="components3">
                                                                    <li>
                                                                        <c:if test="${components3.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components3.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components3.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components3.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label> ${components3.componentname}</label>&nbsp;<c:if test="${components3.hasprivilege==true && components3.activity=='Activity' && components3.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components3.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmore('checked',this.value);}else{checkedoruncheckedAddmore('unchecked',this.value);}" type="checkbox"> </c:if>
                                                                            <ul id="xx">
                                                                            <c:forEach items="${components3.customSystemmoduleList}" var="components4">
                                                                                    <li>
                                                                                        <c:if test="${components4.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components4.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components4.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components4.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label>${components4.componentname}</label>&nbsp;<c:if test="${components4.hasprivilege==true && components4.activity=='Activity' && components4.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components4.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmore('checked',this.value);}else{checkedoruncheckedAddmore('unchecked',this.value);}" type="checkbox"> </c:if>
                                                                                            <ul id="xx">
                                                                                            <c:forEach items="${components4.customSystemmoduleList}" var="components5">
                                                                                                    <li>
                                                                                                        <c:if test="${components5.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components5.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components5.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components5.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label>${components5.componentname}</label>&nbsp;<c:if test="${components5.hasprivilege==true && components5.activity=='Activity' && components5.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components5.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmore('checked',this.value);}else{checkedoruncheckedAddmore('unchecked',this.value);}" type="checkbox"> </c:if>
                                                                                                            <ul id="xx">
                                                                                                            <c:forEach items="${components5.customSystemmoduleList}" var="components6">
                                                                                                                    <li>
                                                                                                                        <c:if test="${components6.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components6.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components6.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components6.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label> ${components6.componentname}</label>&nbsp;<c:if test="${components6.hasprivilege==true && components6.activity=='Activity' && components6.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components6.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmore('checked',this.value);}else{checkedoruncheckedAddmore('unchecked',this.value);}" type="checkbox"> </c:if> 
                                                                                                                            <ul id="xx">
                                                                                                                            <c:forEach items="${components6.customSystemmoduleList}" var="components7">
                                                                                                                                    <li>
                                                                                                                                        <c:if test="${components7.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components7.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<c:if test="${components7.assigned==true}"><img src="static/images/authorisedsmall.png" title="Assigned"/> </c:if><c:if test="${components7.assigned==false}"><img src="static/images/disabledsmall.png" title="Un Assigned"/></c:if><label>${components7.componentname}</label>&nbsp;<c:if test="${components7.hasprivilege==true && components7.activity=='Activity' && components7.assigned==false}"><span style="font-size:10px; color:#006600"><b><i class="fontsz">Add</i></b></span>&nbsp;<input value="${components7.privilegeid}" onchange="if(this.checked){checkedoruncheckedAddmore('checked',this.value);}else{checkedoruncheckedAddmore('unchecked',this.value);}" type="checkbox"> </c:if>    
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
    <div id="facilityoverlayGrpXXXX" style="display: none;">
        <img src="static/img2/loader.gif" alt="Loading" /><br/>
        Please Wait...
    </div>
    <div class="row">
        <div class="col-md-12">
            <button class="btn btn-primary" id="saveUnAssignedgroupaccessrightsassignbtn" style="display: none;" onclick="saveUnAssignedgroupaccessrightsassign();">Save</button>
        </div>
    </div>
</c:if>
<c:if test="${empty customList}">
    <h3 style="margin-top: 5%; margin-left: 5%;"><span class="badge badge-secondary"><strong>No UN ASSIGNED ACTIVITIES TO THIS GROUP</strong></span></h3>
    <h5 style="margin-left: 20%;"><span class="badge badge-danger"><strong>First Get More Activities From IICS</strong></span></h5> 
</c:if>
<input type="hidden" id="transferredUncreatedgroupid" value="${groupid}">
<input type="hidden" id="transferredUnsystemmoduleid" value="${componentid}">
<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
                document.getElementById('groupgrantedscomponentsLoader').style.display = 'none';
                $("#groupUnGrantedRight").hummingbird();
                $("#uncollapseAllxx2").click(function () {
                    $("#groupUnGrantedRight").hummingbird("collapseAll");
                });
                $("#unexpandAllxx2").click(function () {
                    $("#groupUnGrantedRight").hummingbird("expandAll");
                });
                function checkedoruncheckedAddmore(type,privilegeid){
                  if(type==='checked'){
                      addMoreGroupComps.add(privilegeid);
                    }else{
                     addMoreGroupComps.delete(privilegeid);   
                    }
                    if(addMoreGroupComps.size>0){
                        document.getElementById('saveUnAssignedgroupaccessrightsassignbtn').style.display='block';
                    }else{
                        document.getElementById('saveUnAssignedgroupaccessrightsassignbtn').style.display='none'; 
                    }
                }
                var addMoreGroupComps=new Set();
                function saveUnAssignedgroupaccessrightsassign() {
                    var creatgroupid = $('#transferredUncreatedgroupid').val();
                    var systemmoduleid = $('#transferredUnsystemmoduleid').val();
                    
                    if (addMoreGroupComps.size > 0) {
                        $.confirm({
                            title: 'Selected Activities!',
                            content: 'Are You Sure You Want Save' + ' ' + addMoreGroupComps.size + ' ' + 'Activities for this Group?',
                            type: 'purple',
                            typeAnimated: true,
                            buttons: {
                                tryAgain: {
                                    text: 'Yes',
                                    btnClass: 'btn-purple',
                                    action: function () {
                                        document.getElementById('facilityoverlayGrpXXXX').style.display='block';
                                        $.ajax({
                                            type: 'POST',
                                            data: {values: JSON.stringify(Array.from(addMoreGroupComps)), accessgrouprightsid: creatgroupid},
                                            url: "localaccessrightsmanagement/savegroupassignedaccessrights.htm",
                                            success: function (data, textStatus, jqXHR) {
                                              $.confirm({
                                                    title: 'Save Group Activities!',
                                                    content: 'Saved Successfully!!',
                                                    type: 'purple',
                                                    typeAnimated: true,
                                                    buttons: {
                                                        close: function () {
                                                            document.getElementById('facilityoverlayGrpXXXX').style.display='none';
                                                            document.getElementById('Accessgroupscomponentsforgrouptree').innerHTML = '';
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

                    }
                }
</script>
<%-- 
    Document   : groupTree
    Created on : Jul 23, 2018, 4:41:28 PM
    Author     : IICS
--%>

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
<link href="static/mainpane/css/hummingbird-treeview.css" rel="stylesheet">
<%@include file="../../../../include.jsp" %>
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
<c:if test="${ not empty customList}">
    <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
        <!-- <div id="treeview_container" class="hummingbird-treeview"> -->
        <ul id="groupGrantedRight" class="hummingbird-base">
            <span id="expandAllxx2" class="icon-custom" style="color: #56050c;">Expand All</span>| <span id="collapseAllxx2" style="color: #56050c;" class="icon-custom">Contract All</span> <br>
            <c:forEach items="${customList}" var="components">
                <c:if test="${components.assigned==true}">
                    <li>
                        <i class="fa fa-minus"></i>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label> ${components.systemmodule.componentname}</label>&nbsp;<c:if test="${components.systemmodule.hasprivilege==true && components.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components.systemmodule.privilegeid}" type="checkbox"> </c:if>
                        <ul style="display: block;" id="xx">
                            <c:forEach items="${components.customSystemmoduleList}" var="components1">
                                <c:if test="${components1.assigned==true}">
                                    <li>
                                        <c:if test="${components1.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components1.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label> ${components1.systemmodule.componentname}</label>&nbsp;<c:if test="${components1.systemmodule.hasprivilege==true && components1.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components1.systemmodule.privilegeid}" type="checkbox"> </c:if>
                                            <ul id="xx">
                                            <c:forEach items="${components1.customSystemmoduleList}" var="components2">
                                                <c:if test="${components2.assigned==true}">
                                                    <li>
                                                        <c:if test="${components2.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components2.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label>${components2.systemmodule.componentname}</label>&nbsp;<c:if test="${components2.systemmodule.hasprivilege==true && components2.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components2.systemmodule.privilegeid}" type="checkbox"> </c:if>
                                                            <ul id="xx">
                                                            <c:forEach items="${components2.customSystemmoduleList}" var="components3">
                                                                <c:if test="${components3.assigned==true}">
                                                                    <li>
                                                                        <c:if test="${components3.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components3.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label>${components3.systemmodule.componentname}</label>&nbsp;<c:if test="${components3.systemmodule.hasprivilege==true && components3.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components3.systemmodule.privilegeid}" type="checkbox"> </c:if>
                                                                            <ul id="xx">
                                                                            <c:forEach items="${components3.customSystemmoduleList}" var="components4">
                                                                                <c:if test="${components4.assigned==true}">
                                                                                    <li>
                                                                                        <c:if test="${components4.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components4.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/><label> ${components4.systemmodule.componentname}</label>&nbsp;<c:if test="${components4.systemmodule.hasprivilege==true && components4.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components4.systemmodule.privilegeid}" type="checkbox"> </c:if>
                                                                                            <ul id="xx">
                                                                                            <c:forEach items="${components4.customSystemmoduleList}" var="components5">
                                                                                                <c:if test="${components5.assigned==true}">
                                                                                                    <li>
                                                                                                        <c:if test="${components5.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components5.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label> ${components5.systemmodule.componentname}</label>&nbsp;<c:if test="${components5.systemmodule.hasprivilege==true && components5.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components5.systemmodule.privilegeid}" type="checkbox"> </c:if>
                                                                                                            <ul id="xx">
                                                                                                            <c:forEach items="${components5.customSystemmoduleList}" var="components6">
                                                                                                                <c:if test="${components6.assigned==true}">
                                                                                                                    <li>
                                                                                                                        <c:if test="${components6.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components6.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/> <label> ${components6.systemmodule.componentname}</label>&nbsp;<c:if test="${components6.systemmodule.hasprivilege==true && components6.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components6.systemmodule.privilegeid}" type="checkbox"> </c:if>  
                                                                                                                            <ul id="xx">
                                                                                                                            <c:forEach items="${components6.customSystemmoduleList}" var="components7">
                                                                                                                                <c:if test="${components7.assigned==true}">
                                                                                                                                    <li>
                                                                                                                                        <c:if test="${components7.submodules<1}"><i class="fa fa-dot-circle-o"></i></c:if> <c:if test="${components7.submodules>0}"><i class="fa fa-plus"></i></c:if>&nbsp;<img src="static/images/authorisedsmall.png" title="Assigned"/>  <label>${components7.systemmodule.componentname}</label>&nbsp;<c:if test="${components7.systemmodule.hasprivilege==true && components7.systemmodule.activity=='Activity'}"><span style="font-size:10px; color:#D82222"><b><i class="fontsz">Discard</i></b></span>&nbsp;<input value="${components7.systemmodule.privilegeid}" type="checkbox"> </c:if>   
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
</c:if>
<c:if test="${empty customList}">
    <h3 style="margin-top: 5%; margin-left: 5%;"><span class="badge badge-secondary"><strong>No ASSIGNED ACTIVITIES TO THIS GROUP</strong></span></h3>
    <h5 style="margin-left: 20%;"><span class="badge badge-danger"><strong>First Assign Activities To This Group</strong></span></h5> 
</c:if>

<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
    document.getElementById('groupgrantedscomponentsLoader').style.display = 'none';
    $("#groupGrantedRight").hummingbird();
    $("#collapseAllxx2").click(function () {
        $("#groupGrantedRight").hummingbird("collapseAll");
    });
    $("#expandAllxx2").click(function () {
        $("#groupGrantedRight").hummingbird("expandAll");
    });
</script>
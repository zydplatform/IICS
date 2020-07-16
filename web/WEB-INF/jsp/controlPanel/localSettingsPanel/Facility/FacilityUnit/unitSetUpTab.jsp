<%-- 
    Document   : unitSetUpTab
    Created on : May 16, 2018, 10:14:05 PM
    Author     : samuelwam
--%>
<%@include file="../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<style>
    #legendHead{
        color: white;
        background-color: purple;
        border-radius: 20%;
        margin-left: 40%;
        border: 6px solid purple;
    }
    #size{
        border: 2px solid purple;
    }

    /*Organogram Tree*/
    /*Now the CSS*/
    * {margin: 0; padding: 0;}

    .tree ul {
        padding-top: 20px; position: relative;

        transition: all 0.5s;
        -webkit-transition: all 0.5s;
        -moz-transition: all 0.5s;
    }

    .tree li {
        float: left; text-align: center;
        list-style-type: none;
        position: relative;
        padding: 40px 10px 0 10px;

        transition: all 0.5s;
        -webkit-transition: all 0.5s;
        -moz-transition: all 0.5s;
    }

    /*We will use ::before and ::after to draw the connectors*/

    .tree li::before, .tree li::after{
        content: '';
        position: absolute; top: 0; right: 50%;
        border-top: 1px solid #ccc;
        width: 50%; height: 20px;
    }
    .tree li::after{
        right: auto; left: 50%;
        border-left: 1px solid #ccc;
    }

    /*We need to remove left-right connectors from elements without 
    any siblings*/
    .tree li:only-child::after, .tree li:only-child::before {
        display: none;
    }

    /*Remove space from the top of single children*/
    .tree li:only-child{ padding-top: 0;}

    /*Remove left connector from first child and 
    right connector from last child*/
    .tree li:first-child::before, .tree li:last-child::after{
        border: 0 none;
    }
    /*Adding back the vertical connector to the last nodes*/
    .tree li:last-child::before{
        border-right: 1px solid #ccc;
        border-radius: 0 5px 0 0;
        -webkit-border-radius: 0 5px 0 0;
        -moz-border-radius: 0 5px 0 0;
    }
    .tree li:first-child::after{
        border-radius: 5px 0 0 0;
        -webkit-border-radius: 5px 0 0 0;
        -moz-border-radius: 5px 0 0 0;
    }

    /*Time to add downward connectors from parents*/
    .tree ul ul::before{
        content: '';
        position: absolute; top: 0; left: 50%;
        border-left: 1px solid #ccc;
        width: 0; height: 20px;
    }

    .tree li a{
        border: 1px solid #ccc;
        padding: 5px 10px;
        text-decoration: none;
        color: #ffffff;
        font-family: arial, verdana, tahoma;
        font-size: 16px;
        display: inline-block;
        background-color: purple;

        border-radius: 5px;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;

        transition: all 0.5s;
        -webkit-transition: all 0.5s;
        -moz-transition: all 0.5s;
    }

    /*Time for some hover effects*/
    /*We will apply the hover effect the the lineage of the element also*/
    .tree li a:hover, .tree li a:hover+ul li a {
        background: #c8e4f8; color: #000; border: 1px solid #94a0b4;
    }
    /*Connector styles on hover*/
    .tree li a:hover+ul li::after, 
    .tree li a:hover+ul li::before, 
    .tree li a:hover+ul::before, 
    .tree li a:hover+ul ul::before{
        border-color:  #94a0b4;
    }

    /*Thats all. I hope you enjoyed it.
    Thanks :)*/
</style>

<div class="app-title" id="">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i>Control Panel: Local Setting</h1>
        <p>Facility Unit Structure!</p>
    </div>

    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Setting</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('localsettigs/configure.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Configure</a></li>
                    <li class="last active"><a href="#">Facility Structure/Unit Set Up</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <main id="main">
          <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_FACILITYSTRUCTURETAB')">
                <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                <label class="tabLabels" for="tab1">Facility Structure</label>
            </security:authorize>
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_FACILITYUNITTAB')">
                <input id="tab2" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab2">Facility Unit</label>
            </security:authorize>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_FACILITYUNITSERVICETAB')">
        <input id="tab3" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab3">Facility Unit Services</label>
        </security:authorize> <div id="tabContent">
                <c:if test="${empty model.structureList}">    
                    <div style="float:right">   
                        <span class="text4" class="ui-state-highlight">${model.message}</span>
                        <div id="AddNewRg" class="form-actions text5">
                            <button data-toggle="modal" data-target="#addNode" class="btn btn-primary pull-right" type="button" onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=b&i=${model.i}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-fw fa-lg fa-plus-circle"></i>Add Hierarchy Node</button>
                        </div>
                    </div>
                </c:if>
                <br>
                <div id="response" class="box box-color box-bordered">   

                    <div id="addnew-pane">
                        <fieldset style="width:95%; margin: 0 auto;" >
                            <legend> 
                                &nbsp;&nbsp;&nbsp; Facility Structure For ${model.facObj.facilityname}-${model.facObj.facilitylevelid.facilitylevelname}
                            </legend>
                            <c:if test="${not empty  model.structureList}">

                                <div class="tree">
                                    <c:forEach items="${model.structureList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                        <ul>
                                            <li>${model.facObj.facilityname}  
                                                <ul>
                                                    <li>
                                                        <a href="#"onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=d&i=${list.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${list.hierachylabel}</a>
                                                        <c:if test="${not empty list.facilitystructureList}">
                                                            <ul>
                                                                <c:forEach items="${list.facilitystructureList}" var="level2">
                                                                    <li>
                                                                        <a href="#"onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=d&i=${level2.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level2.hierachylabel}</a>
                                                                        <c:if test="${not empty level2.facilitystructureList}">    
                                                                            <ul>
                                                                                <c:forEach items="${level2.facilitystructureList}" var="level3">
                                                                                    <li>
                                                                                        <a href="#"onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=d&i=${level3.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level3.hierachylabel}</a>
                                                                                        <c:if test="${not empty level3.facilitystructureList}">    
                                                                                            <ul>
                                                                                                <c:forEach items="${level3.facilitystructureList}" var="level4">
                                                                                                    <li>
                                                                                                        <a href="#"onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=d&i=${level4.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level4.hierachylabel}</a>
                                                                                                        <c:if test="${not empty level4.facilitystructureList}">    
                                                                                                            <ul>
                                                                                                                <c:forEach items="${level4.facilitystructureList}" var="level5">
                                                                                                                    <li>
                                                                                                                        <a href="#"onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=d&i=${level5.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level5.hierachylabel}</a>
                                                                                                                        <c:if test="${not empty level5.facilitystructureList}">    
                                                                                                                            <ul>
                                                                                                                                <c:forEach items="${level5.facilitystructureList}" var="level6">
                                                                                                                                    <li>
                                                                                                                                        <a href="#"onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=d&i=${level6.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level6.hierachylabel}</a>
                                                                                                                                        <c:if test="${not empty level6.facilitystructureList}">    
                                                                                                                                            <ul>
                                                                                                                                                <c:forEach items="${level6.facilitystructureList}" var="level7">
                                                                                                                                                    <li>
                                                                                                                                                        <a href="#"onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=d&i=${level7.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level7.hierachylabel}</a>
                                                                                                                                                        <c:if test="${not empty level7.facilitystructureList}">    
                                                                                                                                                            <ul>
                                                                                                                                                                <c:forEach items="${level7.facilitystructureList}" var="level8">
                                                                                                                                                                    <li>
                                                                                                                                                                        <a href="#"onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=d&i=${level8.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level8.hierachylabel}</a>
                                                                                                                                                                        <c:if test="${not empty level8.facilitystructureList}">    
                                                                                                                                                                            <ul>
                                                                                                                                                                                <c:forEach items="${level8.facilitystructureList}" var="level9">
                                                                                                                                                                                    <li>
                                                                                                                                                                                        <a href="#"onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=d&i=${level9.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level9.hierachylabel}</a>
                                                                                                                                                                                        <c:if test="${not empty level9.facilitystructureList}">  
                                                                                                                                                                                            <ul>
                                                                                                                                                                                                <c:forEach items="${level9.facilitystructureList}" var="level10">
                                                                                                                                                                                                    <li>
                                                                                                                                                                                                        <a href="#"onClick="ajaxSubmitData('facHierarchySetting.htm', 'addnew-pane', 'act=d&i=${level10.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level10.hierachylabel}</a>
                                                                                                                                                                                                    </li>
                                                                                                                                                                                                </c:forEach>
                                                                                                                                                                                            </ul>
                                                                                                                                                                                        </c:if>
                                                                                                                                                                                    </li>
                                                                                                                                                                                </c:forEach>
                                                                                                                                                                            </ul>
                                                                                                                                                                        </c:if>
                                                                                                                                                                    </li>
                                                                                                                                                                </c:forEach>
                                                                                                                                                            </ul>
                                                                                                                                                        </c:if>
                                                                                                                                                    </li>
                                                                                                                                                </c:forEach>
                                                                                                                                            </ul>
                                                                                                                                        </c:if>
                                                                                                                                    </li>
                                                                                                                                </c:forEach>
                                                                                                                            </ul>
                                                                                                                        </c:if>
                                                                                                                    </li>
                                                                                                                </c:forEach>
                                                                                                            </ul>
                                                                                                        </c:if>
                                                                                                    </li>
                                                                                                </c:forEach>
                                                                                            </ul>
                                                                                        </c:if>
                                                                                    </li>
                                                                                </c:forEach>
                                                                            </ul>
                                                                        </c:if>
                                                                    </li>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </c:forEach>
                                </div>
                            </c:if>
                            <c:if test="${empty model.structureList}">
                                <div align="center"><h3>No Registered ${model.facilityType}</h3></div>
                            </c:if>
                        </fieldset>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>

<script>
    $(document).ready(function () {
        breadCrumb();
        $('#sampleTable').DataTable();
        $('#update').click(function () {
            $('#givenamemodal').show();
        });
        $('#tab1').click(function () {
            ajaxSubmitData('facilityUnitSetUp.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });

        $('#tab2').click(function () {
            ajaxSubmitData('facilityUnitSetUp.htm', 'tabContent', 'act=b&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });
        
        $('#tab3').click(function () {
            ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'tabContent', 'act=d&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });
    });
</script>

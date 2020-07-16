<%-- 
    Document   : accessRightsHome
    Created on : Jul 17, 2018, 12:15:16 PM
    Author     : IICS
--%>
<style>
    .select2-container{
        z-index: 9999999 !important;
    }
</style>
<%@include file="../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<div class="app-title" id="">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>

    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li> 
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Settings</a></li>
                    <li class="last active"><a href="#">Activities & Access Rights</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <main id="main">
            <input id="tab2" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab2">Access Rights Groups</label>

            <input id="tab4" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab4">User Access Rights</label>

            <section class="tabContent" id="content2">
                <%@include file="views/GroupsTable.jsp" %>
            </section>
            <section class="tabContent" id="content4">

            </section>

        </main>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="addnewstaffaccessgrouprightsgroupsdialog" class="supplierCatalogDialog addnewgrpaccessgrouprightsdiv">
            <div>
                <div id="head">
                    <a href="#!" title="Close" onclick="closedialog();" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title">Select Group</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="addgrpaccessgrouprightsdiv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Getting Items Please Wait...........</h3>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="viewStaffGrantedRightsAccess" class="supplierCatalogDialog viewStaffGrantedRightsAccessclass">
            <div>
                <div id="head">
                    <a href="#!" title="Close" onclick="closedialog();" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="StaffGrantedRightsTitle">Staff Granted Rights</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="viewStaffGrantedRightsAccessdiv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Getting Items Please Wait...........</h3>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="viewGroupGrantedRightsAccess" class="supplierCatalogDialog viewGroupGrantedRightsAccessclass">
            <div>
                <div id="head">
                    <a href="#!" title="Close" onclick="closedialog();" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="GroupGrantedRightsTitle"> Granted Rights</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="viewGroupGrantedRightsAccessdiv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Getting Items Please Wait...........</h3>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="viewGroupGrantedRightsAccessComponent" class="supplierCatalogDialog viewGroupGrantedRightsAccessDialog">
            <div>
                <div id="head">
                    <a href="#!" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="GroupCompGrantedRightsTitle"> Granted Rights Components</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="viewGroupGrantedRightsAccessCompdiv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Getting Items Please Wait...........</h3>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<script>
    breadCrumb();
    $('#tab4').click(function () {
        ajaxSubmitDataNoLoader('localaccessrightsmanagement/useraccessrightsmanagement.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    function closedialog() {
        window.location = '#close';
        ajaxSubmitDataNoLoader('localaccessrightsmanagement/useraccessrightsmanagement.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>
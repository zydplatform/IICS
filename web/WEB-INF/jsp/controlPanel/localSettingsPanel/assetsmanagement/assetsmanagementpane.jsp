<%-- 
    Document   : assetsmanagementpane
    Created on : Jun 7, 2018, 12:48:25 PM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<style>
    .focus {
        border-color:red;
    }
</style>
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
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Setting</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('localsettigs/manage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Manage</a></li>
                    <li class="last active"><a href="#">Assets Management</a></li>

                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <main id="main">
             <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_ASSETCLASSIFICATIONTAB')">
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Asset Classification</label>
            </security:authorize>   
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_ASSIGNDEASSIGNASSETSTAB')">
            <input id="tab2" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab2">Assign/De-Assign Assets</label>
         </security:authorize>   
            <section class="tabContent" id="content1">
                <div id="viewall">
                    <div class="row">
                        <div class="col-md-12">
                            <button onclick="addnewassetclassification();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Add Asset Classification</button>
                        </div>
                    </div>
                    <div style="margin: 10px;">
                        <fieldset style="min-height:100px;">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile">
                                        <div class="tile-body">
                                            <%@include file="views/viewassetsclassifications.jsp" %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                    </div> 
                </div>
            </section>
            <section class="tabContent" id="content2">
              
            </section>
        </main>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="addnewassetclassification" class="supplierCatalogDialog">
            <div>
                <div id="divSection">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">Add Asset Classification</h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="blockcontents">
                        <%@include file="forms/addassetclassification.jsp" %>
                    </div>                                        
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function addnewassetclassification() {
        window.location = '#addnewassetclassification';
        initDialog('supplierCatalogDialog');
    }
    ajaxSubmitData('assetsmanagement/assigndeassignassets.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    $('#tab2').click(function () {
        ajaxSubmitData('assetsmanagement/assigndeassignassets.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
</script>
<%-- 
    Document   : procurementplanHome
    Created on : Apr 9, 2018, 6:20:05 PM
    Author     : RESEARCH
--%>

<%-- 
    Document   : activitiesandaccessrightstabs
    Created on : Mar 21, 2018, 10:20:40 AM
    Author     : RESEARCH
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>

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
                    <li class="last active"><a href="#">Unit Procurement Plan</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <main id="main">
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_UNITPROCUREMENTPLANTAB')"> 
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Procurement Plan</label>
             </security:authorize>
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_COMPOSEUNITPROCUREMENTPLANTAB')"> 
            <input id="tab2" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab2">Compose Procurement</label>
             </security:authorize>
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PAUSEDUNITPROCUREMENTPLANTAB')"> 
            <input id="tab3" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab3">Paused Procurement</label>
             </security:authorize>
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_APPROVEDUNITPROCUREMENTPLANTAB')"> 
            <input id="tab4" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab4">Approve Facility Units Procurement</label>
           </security:authorize>

            <section class="tabContent" id="content1">
                <div>
                    <div style="margin: 10px;">
                        <fieldset style="min-height:100px;">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile">
                                        <div class="tile-body">
                                            <%@include file="forms/manageProcurementPlan.jsp" %>
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
            <section class="tabContent" id="content3">

            </section>
            <section class="tabContent" id="content4">

            </section>

        </main>
    </div>
</div>

<script>
    jQuery(document).ready(function () {
        breadCrumb();

        $('#procurementtable').DataTable();
    });
    $('#tab2').click(function () {
        ajaxSubmitData('procurementplanmanagement/unprocuredfinancialyearperiods.htm', 'content2', 'act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab3').click(function () {
        ajaxSubmitData('procurementplanmanagement/pausedprocurementplans.htm', 'content3', 'act=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab4').click(function () {
        ajaxSubmitData('procurementplanmanagement/unprocuredfinancialyearperiods.htm', 'content4', 'act=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });

</script>

<%-- 
    Document   : facilityProcurementPlanHome
    Created on : May 7, 2018, 6:13:25 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<style>
    .focus {
        border-color:red;
    }
</style>
<style>
    #overlayfnyr {
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
                    <li class="last active"><a href="#">Facility Procurement Plan</a></li>

                </ul>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <main id="main">
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PROCUREMENTPLANFINANCIALYEARSTAB')"> 
                <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                <label class="tabLabels" for="tab1">Financial Years</label>
            </security:authorize> 
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_FACILITYPROCUREMENTPLANTAB')"> 
                <input id="tab2" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab2">Procurement Plan</label>
            </security:authorize>
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_APPROVEDFACILITYPROCUREMENTPLANTAB')"> 
                <input id="tab3" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab3">Approve Facility Procurement Plan</label>
            </security:authorize>
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_COMPOSEFACILITYPROCUREMENTPLANTAB')"> 
                <input id="tab4" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab4">Compose Procurement Plan</label>
            </security:authorize>
            <section class="tabContent" id="content1">
                <div >
                    <div class="row">
                        <div class="col-md-12">
                        </div>
                    </div>
                    <div style="margin: 10px;">
                        <fieldset style="min-height:100px;">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile">
                                        <div class="tile-body">
                                            <%@include file="views/procurementPlanTable.jsp" %>

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
        $('#procurementtable2').DataTable();
    });
    function validateNumber(event) {
        var key = window.event ? event.keyCode : event.which;
        if (event.keyCode === 8 || event.keyCode === 46) {
            return true;
        } else if (key < 48 || key > 57) {
            return false;
        } else {
            return true;
        }
    }


    $('#tab3').click(function () {
        ajaxSubmitData('facilityprocurementplanmanagement/composedfacilityprocurementplan.htm', 'content3', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab2').click(function () {
        ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredprocurementplans.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab4').click(function () {
        ajaxSubmitData('facilityprocurementplanmanagement/topdowncomposeprocurementplan.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    function managefacilityfinancialyear(facilityfinancialyearid, startyear, endyear) {
        $.ajax({
            type: 'POST',
            data: {facilityfinancialyearid: facilityfinancialyearid},
            url: "facilityprocurementplanmanagement/managefacilityfinancialyear.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: '<a href="#!" style="color: red;">UPDATE FINANCIAL YEAR(' + startyear + '-' + endyear + ')</a>',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '60%',
                    useBootstrap: false,
                    closeIcon: true,
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                            ajaxSubmitData('facilityprocurementplanmanagement/facilityprocurementplanhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                        }
                    }
                });
            }
        });
    }
</script>
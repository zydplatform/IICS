<%-- 
    Document   : scheduledServicesHome
    Created on : Jun 14, 2018, 11:29:50 AM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>
    var myVar;
    function chekstatus() {
        myVar = setInterval(function () {
            $('#serviceMsg').fadeIn(2000);
            ajaxSubmitData('schedulerservicesmanagement/scheduledgetupdatedservices.htm', 'getupdatedservices', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }, 10000);
    }

    $(document).ready(function () {
         chekstatus();

    });
</script>
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
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                    <li class="last active"><a href="#">Services Schedule</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <main id="main">
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Service Schedulers</label>

            <input id="tab2" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab2">Activity</label>

            <section class="tabContent" id="content1">
                <div >
                    <div class="row">
                        <div class="col-md-12">
                            <span id="serviceMsg" class="alert alert-info" style="display: none;width: 500px;opacity: .7; margin-left: 30%;">Checking Services Status</span>
                            <button onclick="addnewservice();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Add Service</button>
                        </div>
                        
                    </div>
                    <div style="margin: 10px;">
                        <fieldset style="min-height:100px;">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile">
                                        <div class="tile-body" id="getupdatedservices">
                                            <%@include file="views/registeredServices.jsp" %>
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

        </main>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="addnewservicedialog" class="supplierCatalogDialog addnewservice">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleoralreadyheading">New Service</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="addnewservicediv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Please Wait...........</h3>
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
        <div id="updateservicedialog" class="supplierCatalogDialog updateservicess">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleoralreadyheading">Update Service</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="updateservicediv">
                                        <div class="overlay">
                                            <div class="m-loader mr-4">
                                                <svg class="m-circular" viewBox="25 25 50 50">
                                                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"/>
                                                </svg>
                                            </div>
                                            <h3 class="l-text">Please Wait...........</h3>
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

    $('#tab2').click(function () {
        ajaxSubmitData('schedulerservicesmanagement/schedulerservicesactivities.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    function addnewservice() {
        window.location='#addnewservicedialog';
        ajaxSubmitData('schedulerservicesmanagement/addnewservice.htm', 'addnewservicediv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        initDialog('addnewservice');
    }
</script>
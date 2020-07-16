<%-- 
    Document   : tabs
    Created on : Aug 21, 2018, 5:03:58 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="app-title" id="">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Facility Services</h1>
        <p>Together We Save Lives...!</p>
    </div>
    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li> 
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                    <li class="last active"><a href="#">Facility Services</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="row">
        <div class="col-md-12">
            <main id="main">                
                <input id="tab1" class="tabCheck" type="radio" name="tabs" onClick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'servicePane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <label class="tabLabels" for="tab1">Facility Service</label>

                <input id="tab2" class="tabCheck" type="radio" name="tabs" onClick="ajaxSubmitData('systemActivity/activityManagement.htm', 'servicePane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <label class="tabLabels" for="tab2">System Activity Service</label>
                <input id="tab3" class="tabCheck" type="radio" name="tabs" onClick="ajaxSubmitData('systemActivity/programManagement.htm', 'servicePane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <label class="tabLabels" for="tab3">Facility Programs</label>
            </main>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="servicePane"></div>
        </div>
    </div>
<script src="static/res/js/bootstrap.min.js"></script>

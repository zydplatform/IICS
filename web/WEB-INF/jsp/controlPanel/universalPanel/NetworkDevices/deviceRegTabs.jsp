<%-- 
    Document   : deviceRegTabs
    Created on : Mar 5, 2018, 5:06:01 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="static/mainpane/css/autoCompleteDropList.css">

<div>
    <div class="app-title" id="">
        <div class="col-md-5">
            <div class="box-title">
                <h3>
                    <i class="fa fa-home"></i>
                    System Access & Device Management
                </h3>
            </div>
        </div>

        <div>
            <div class="mmmains">
                <div class="wrapper">
                    <ul class="breadcrumbs">
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li> 
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                        <li class="last active"><a href="#">Network Devices</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <main id="main">                
                <input id="tab1" class="tabCheck" type="radio" name="tabs" onClick="ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <label class="tabLabels" for="tab1">Device Manufacturer</label>

                <input id="tab2" class="tabCheck" type="radio" name="tabs" onClick="ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=a2&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <label class="tabLabels" for="tab2">Granted Device</label>

                <input id="tab3" class="tabCheck" type="radio" name="tabs" onClick="ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=a2&i=0&b=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <label class="tabLabels" for="tab3">Denied Access</label>

                <input id="tab4" class="tabCheck" type="radio" name="tabs" onClick="ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=a4&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <label class="tabLabels" for="tab4">Un Registered Devices</label>

                <input id="tab5" class="tabCheck" type="radio" name="tabs" onClick="ajaxSubmitData('onlineUsers.htm', 'panel_overview', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <label class="tabLabels" for="tab5">Online Users</label>
            </main>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="panel_overview"></div>
        </div>
    </div>
</div>


<script src="static/res/js/bootstrap.min.js"></script>

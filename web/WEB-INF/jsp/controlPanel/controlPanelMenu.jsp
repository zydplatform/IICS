<%-- 
    Document   : controlPanelMenu
    Created on : Mar 20, 2018, 4:16:23 PM
    Author     : Grace-K //configureandmanage.htm
--%>
<%@include file="../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<% int x = 0;%>
<div id="mmmainControlpanel">
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
                        <li class="last active"><a href="#">Control Panel</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_UNIVERSALSETTINGS')">
            <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img  src="static/img/UniSysIcon1.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Universal Settings
                    </h4>
                </div>
            </div> 
            <%x += 1;%>
        </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALSETTINGS')">
            <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img src="static/img/LocalSysIcon3.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Local Settings
                    </h4>
                </div>
            </div>  
            <%x += 1;%>
        </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    </div>
</div>
<script>
    breadCrumb();
</script>

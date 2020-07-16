<%-- 
    Document   : localSettings
    Created on : Mar 26, 2018, 1:17:21 PM
    Author     : IICSRemote
--%>

<%@include file="../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% int x = 0;%>
<div class="container-fluid" id="mmmainLocalSettings">
    <div class="app-title">
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
                        <li class="last active"><a href="#">Local Setting</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">   
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALSETTINGSCONFIGURE')">        
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('localsettigs/configure.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img2/ConfigSysIcon2.png">
                </div>
                <div class="icon-content">
                    <h2>
                        Configure
                    </h2>
                </div>
            </div>  
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALSETTINGSMANAGE')"> 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('localsettigs/manage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img2/ManageSysIcon2.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Manage
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALSETTINGSRESOURCELOCATIONS')">        
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('locationofresources/managebuilding.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/manage_facilities.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Resource Locations
                    </h4>
                </div>
            </div>  
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN')">        
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('facilityinfrastructure/manageinfrastructure.htm', 'workpane', '', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/FacilitySysIcon1.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Facility Infrastructure
                    </h4>
                </div>
            </div>  
            <%x += 1;%>
        </security:authorize>


        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALACTIVITIESANDACCESSRIGHTS')">        
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('localaccessrightsmanagement/localaccessrightsmanagementhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/AccessSysIcon3.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Activities & Access Right
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div>
    <div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALSERVICEALLOCATION')">  
            <div class="col-sm-4 col-md-3" align="center" onclick="ajaxSubmitData('serviceallocation/servicelocationmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/serviceAllocation.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Service Allocations
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize><% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALLABORATORYSETTING')"> 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('locallaboratorysetingmanagement/labTestsClassification.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img src="static/img/LabSysIcon3.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>Laboratory Settings</h4>
                </div>
            </div>
        </security:authorize>
    </div>
    <% if (x % 4 == 0) { %></div>
<div class="row"><%}%>
</div>

<script>
    breadCrumb();
</script>

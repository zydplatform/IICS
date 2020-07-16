<%-- 
    Document   : ManageMenu
    Created on : Mar 26, 2018, 3:03:16 PM
    Author     : IICSRemote
--%>
<%@include file="../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% int x = 0;%>
<div class="container-fluid">
    <div class="app-title" >
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
                        <li class="last active"><a href="#">Manage</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEUNITSTORAGESPACE')"> 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('localsettigs/shelvingtab.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       

                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/storageSpace.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Unit Storage Space
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEPROCUREMENTPLAN')"> 
            <div class="col-sm-4 col-md-3  menu-icon" align="center" onclick="ajaxSubmitData('facilityprocurementplanmanagement/facilityprocurementplanhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/procurement.png" style="width: 78px;">
                </div>
                <div class="icon-content">
                    <h4>
                        Facility Procurement Plan
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_UNITPROCUREMENTPLAN')"> 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('procurementplanmanagement/procurementplanmanagement.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/procurement1.png" style="width: 78px;">
                </div>
                <div class="icon-content">
                    <h4>
                        Unit Procurement Plan
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGESUPPLIERSLOCAL')">
            <div class="col-sm-4 col-md-3  menu-icon" align="center" onclick="ajaxSubmitData('supplierandstoresmanagement/supplierandstoresmanagementhomemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/Supplier2.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Supplier & Stores
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALAPPOINTMENTANDSCHEDULE')">
            <div class="col-sm-4 col-md-3  menu-icon" align="center" onclick="ajaxSubmitData('appointmentandSchedules/appointmentsPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/appointments.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Appointments
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALRESOURCEALLOCATION')">
            <div class="col-sm-4 col-md-3  menu-icon" align="center" onclick="ajaxSubmitData('allocationofresources/resourceAllocationPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/serviceAllocation.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Allocation Of Resources
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div>
    <div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALASSETMANAGEMENT')">
            <div class="col-sm-4 col-md-3  menu-icon" align="center" onclick="ajaxSubmitData('assetsmanagement/assetmanagementPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/assetsMgt.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Assets Management
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div>
    <div class="row"><%}%>
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('extordersmanagement/manageFacilityExternalOrders', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/prosysytemorder.png">
            </div>

            <div class="icon-content">
                <h2>
                    External Order
                </h2>
            </div>
        </div>
    </div>
        
</div>
<script>
    breadCrumb();
</script>
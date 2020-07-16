<%-- 
    Document   : homepageicon
    Created on : Jun 28, 2018, 8:12:22 AM
    Author     : IICS-GRACE
--%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<% int x = 0;%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="app-title">
    <div class="col-md-5">
        <h1>
            <i class="fa fa-dashboard"></i>
            Dashboard
        </h1>
        <p>Together We Save Lives...!</p>
    </div>
    <div>
        <div class="mmmains">
            <div class="wrapper" id="">
                <ul class="breadcrumbs">
                    <li class="last active">
                        <a style="font-size: 18px !important" href="#" class="fa fa-home"></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_CONTROLPANELMANAGEMENT')">  
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img src="static/img/SettingsSysIcon1.png" class="expando" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <h4>
                    Control Panel
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %>
</div>
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PATIENTMANAGEMENT')">  
        <div class="col-sm-4 col-md-3  menu-icon" align="center" onclick="ajaxSubmitData('patient/patientmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content ">
                <img  src="static/img/patientManagemt.png" class="expando" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <!--<h4>Patient Management</h4>-->
                <h4>Patient Registration & Identification</h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %>
</div>
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_INVENTORYMANAGEMENT')">   
        <div class="col-sm-4 col-md-3  menu-icon" align="center" onclick="ajaxSubmitData('store/inventoryAndSupplies.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content ">
                <img src="static/img/StoresSysIcon1.png" class="expando" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <h4>Inventory & Supplies</h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %>
</div>
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_USERMANAGEMENT')">  
        <div class="col-sm-4 col-md-3  menu-icon" align="center" onclick="ajaxSubmitData('usermanagement/internalAndexternal.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content ">
                <img src="static/img/PpleSysIcon1.png" class="expando" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <h4>User management</h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %>
</div>
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_CLINICALCONSULTATION')">   
        <div class="col-sm-4 col-md-3 menu-icon" align="center"  onclick="ajaxSubmitData('doctorconsultation/doctorconsultationhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img src="static/img/PatientSysIcon1.png" class="expando" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <h4>
                    Clinical Consultations
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize><% if (x % 4 == 0) { %>
</div>
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LABORATORY')"> 
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('laboratory/laboratoryhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img src="static/img/LabSysIcon2.png" class="expando" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <h4>Laboratory</h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize><% if (x % 4 == 0) { %>
</div>
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_DISPENSING')">                        
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Controlpanel/dispensingMenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img src="static/img/DispenseDrugs_1.png" class="expando" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <!--<h4>Dispensary</h4>-->
                <h4>Pharmacy</h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize><% if (x % 4 == 0) { %>
</div>
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EMERGENCIES')">
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('emergencies/loadEmergenciesMenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img src="static/img/manage_facilities.png" class="expando" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <h4>Emergencies</h4>
            </div>
        </div>
        <%x += 1 ;%>
    </security:authorize><% if (x % 4 == 0) { %>
</div>
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_DASHBOARDANDREPORTS')">
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('dashboard/loadDashboardMenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img src="static/img/patientStatistics.png" class="expando" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <h4>Dashboard & Reports</h4>
            </div>
        </div>
        <%x += 1;%>  
    </security:authorize>
    <% if (x % 4 == 0) { %>
</div>
    
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_REGISTERSTAFF')">
        <div class="col-sm-3 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('staffmanager/staffmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" 
                     src="static/img/internalStaff.png">
            </div>
            <div class="icon-content">
                <h2>
                    Staff Management
                </h2>
            </div>
        </div>
    </security:authorize>
</div>
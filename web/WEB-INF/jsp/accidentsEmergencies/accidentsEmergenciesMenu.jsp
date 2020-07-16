<%-- 
    Document   : accidentsEmergenciesMenu
    Created on : Oct 30, 2019, 12:46:01 PM
    Author     : Kiganda Ivan
--%>

<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% int x = 0;%>
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
                    <li class="last active"><a href="#">Accidents & Emergencies</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PATIENTREGISTRATION')"> 
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('accidentsandEmergencies/patientRegistration.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/inventoryImg1.png">
            </div>
            <div class="icon-content">
                <h4>
                    Patient Registration
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>  
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EMERGENCYTRIAGE')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('accidentsandEmergencies/emergencyTriage.htm', 'workpane', '&tab=tab1', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/InventoryStockCard.png"/>
            </div>
            <div class="icon-content">
                <h4>
                    EMERGENCY TRIAGE
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>  
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_ASSESSMENT')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('accidentsandEmergencies/assessment.htm', 'workpane', '&tab=tab1', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/InventoryDrugs.png">
            </div>
            <div class="icon-content">
                <h4>
                    ASSESSMENT & EXAMINATION
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>         
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_DISPOSITION')">
        <div class="col-sm-3 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('accidentsandEmergencies/disposition.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/Ordering1.png" style="width: 78px;">
            </div>
            <div class="icon-content">
                <h4>
                    Disposition
                </h4>
            </div>
        </div>    
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div>
<script>
    breadCrumb();
</script>
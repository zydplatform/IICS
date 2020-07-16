<%-- 
    Document   : controlPanelMenu
    Created on : Mar 20, 2018, 4:16:24 PM
    Author     : Grace-K //configureandmanage.htm
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
                    <li class="last active"><a href="#">Dashboard & Reports</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row" style="margin-top: 5%;">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_STAFFACTIVITIES')"> 
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('dashboard/loadStaffActiviiesMenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="150" height="160" src="static/img/PpleSysIcon1.png">
            </div>
            <div class="icon-content">
                <h4>
                    Staff Activities
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>  
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PATIENTSTATISTICS')">
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('dashboard/facilitypatientstatistics.htm', 'workpane', '&tab=tab1', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="150" height="160" src="static/img/patientManagemt.png"/>
            </div>
            <div class="icon-content">
                <h4>
                    Patient Statistics
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div>
    <div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALSERVICEALLOCATION')">  
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('postsandactivities/scheduleOfDutieslocal.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
            <div class="icon-content">
                <img class="expando" border="1" width="150" height="160" src="static/img/PostsSysIcon2.png">
            </div>
            <div class="icon-content">
                <h4>
                    Schedule of Duties Report
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div>
    <div class="row"><%}%>  
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_INVENTORY')">
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('dashboard/itemstatisticshome.htm', 'workpane', '', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="150" height="160" src="static/img/InventoryDrugs.png">
            </div>
            <div class="icon-content">
                <h4>
                    Inventory
                </h4>
            </div>
        </div>
    </security:authorize>
</div>
<script>
    breadCrumb();
</script>
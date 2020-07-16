<%-- 
    Document   : controlPanelMenu
    Created on : Mar 20, 2018, 4:16:23 PM
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
                    <li class="first"><a href="#!" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', '', 'GET');"></a></li>
                    <li><a href="#!" onclick="ajaxSubmitData('dashboard/loadDashboardMenu.htm', 'workpane', '', 'GET');">Dashboard & Reports</a></li>
                    <li class="last active"><a href="#">Staff Activities</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row" style="margin-top: 5%;">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_STAFFACTIVITIES')"> 
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('dashboard/loadStaffAttendancePane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="150" height="160" src="static/img/appointments.png">
            </div>
            <div class="icon-content">
                <h4>
                    Staff Attendance
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <%--<% if (x % 3 == 0) { %></div><div class="row"><%}%>  
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PATIENTATTENDANCE')">
            <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('dashboard/patientattendance.htm', 'workpane', '&tab=tab1', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="150" height="160" src="static/img/resource.png"/>
                </div>
                <div class="icon-content">
                    <h4>
                        Patient Attendance
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>--%>
    <% if (x % 3 == 0) { %></div><div class="row"><%}%>  
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_CLINICPERFORMANCE')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('dashboard/loadStaffPerformancePane.htm', 'workpane', '&tab=tab1', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="150" height="160" src="static/img/resource.png"/>
            </div>
            <div class="icon-content">
                <h4>
                    Clinic Performance
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
</div>
<script>
    breadCrumb();
</script>
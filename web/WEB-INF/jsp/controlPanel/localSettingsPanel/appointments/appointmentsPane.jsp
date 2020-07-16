<%-- 
    Document   : appointmentsPane
    Created on : May 15, 2018, 11:14:59 AM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% int x = 0;%>
<div class="container-fluid">
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
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Setting</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('localsettigs/manage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Manage</a></li>
                        <li class="last active"><a href="#">Appointments Pane</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
      <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_APPOINTMENTRESOURCES')"> 
       <div class="col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Appointmentresources/resourcesPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
            <div class="icon-content">
                <img class="" src="static/img/resource.png">
            </div>
            <div class="icon-content">
                <h4>
                    Resources
                </h4>
            </div>
        </div>
           <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_APPOINTMENTSCHEDULES')"> 
       <div class="col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('appointmentandSchedules/schedulestab.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
            <div class="icon-content">
                <img class="" src="static/img/schedule.png">
            </div>
            <div class="icon-content">
                <h4>
                    Schedules
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
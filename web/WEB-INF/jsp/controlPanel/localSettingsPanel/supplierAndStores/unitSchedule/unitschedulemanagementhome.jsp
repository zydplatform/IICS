<%-- 
    Document   : unitschedulemanagementhome
    Created on : Apr 17, 2018, 10:22:37 AM
    Author     : RESEARCH
--%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                        <li><a href="#" onclick="ajaxSubmitData('supplierandstoresmanagement/supplierandstoresmanagementhomemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Supplier&Stores</a></li>
                        <li class="last active"><a href="#">Schedule</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<main id="main">
 <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_STOREANDSUPPLIESUNITSCHEDULETYPE')"> 
    <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
    <label class="tabLabels" for="tab1">Unit Schedule</label>
</security:authorize>
 
    <section class="tabContent" id="content1">
        <%@include file="forms/unitScheduleTypeHome.jsp" %>
    </section>
    
</main>

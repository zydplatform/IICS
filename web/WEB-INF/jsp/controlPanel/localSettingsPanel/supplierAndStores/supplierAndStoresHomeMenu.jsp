<%-- 
    Document   : supplierAndStoresHomeMenu
    Created on : Jul 2, 2009, 1:17:26 AM
    Author     : RESEARCH
--%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../../include.jsp" %>
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
                        <li class="last active"><a href="#">Supplier&Stores</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALMANAGEEXTERNALSUPPLIER')"> 
            <div class="col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70"  src="static/img/suppliers_ext.png">
                </div>
                <div class="icon-content">
                    <h2>
                        External Supplier
                    </h2>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALMANAGEFACILITYSTORE')"> 
            <div class="col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('nominateinternalfacilitySupplier/nominateinternalfacilitysupplierhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70"  src="static/img/internalstorage.png">
                </div>
                <div class="icon-content">
                    <h2>
                        Facility Stores
                    </h2>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEUNITSCHEDULE')">
            <c:if test="${isstoresunit=='yes'}">
                <div class="col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('unitschedulemanagement/unitschedulemanagementhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                    <div class="icon-content">
                        <img class="expando" border="1" width="90" height="70"  src="static/img/deliverySchedule.png">
                    </div>
                    <div class="icon-content">
                        <h2>
                            Unit Schedule
                        </h2>
                    </div>
                </div>
            </c:if>
            <%x += 1;%> 
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    </div>
</div>
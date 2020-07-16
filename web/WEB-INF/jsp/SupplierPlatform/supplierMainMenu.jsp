<%-- 
    Document   : supplierMainMenu
    Created on : Sep 4, 2018, 12:41:20 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<% int x = 0;%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="app-title">
    <div class="col-md-5">
        <h1>
            <i class="fa fa-hospital-o"></i>
            Customer Order System
        </h1>
        <p>Together We Save Lives...!</p>
    </div>
    <div>
        <div class="mmmains">
            <div class="wrapper" id="">
                <ul class="breadcrumbs">
                    <li class="last active"><a style="font-size: 18px !important" href="#" class="fa fa-home"></a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SUPPLIERCONTROLPANELMANAGEMENT')">   
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Supplier/Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
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
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EXTERNALORDERMANAGEMENT')"> 
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Supplier/Store/orderManagement.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img src="static/img/StoresSysIcon1.png" class="expando" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <h4>Order Processing</h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %>
</div>
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SUPPLIERUSERMANAGEMENT')"> 
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Supplier/Usermanagement/internalAndexternal.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
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

</div>
<%-- 
    Document   : Usermanagementmenu
    Created on : May 31, 2018, 2:47:51 PM
    Author     : user
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
                    <li class="last active"><a href="#">User management</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEINTERNALSYSTEMUSER')">
        <div class="col-sm-3 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('usermanagement/internalSystemuser.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/int_staff2.png">
            </div>
            <div class="icon-content">
                <h2>
                    Internal system user
                </h2>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEEXTERNALSYSTEMUSER')">
<!--        <div class="col-sm-3 col-md-3 menu-icon" align="center" >
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/ext_staff1.png">
            </div>
            <div class="icon-content">
                <h2>
                    External system user
                </h2>
            </div>
        </div>-->
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
</div>
<script>
    breadCrumb();
</script>
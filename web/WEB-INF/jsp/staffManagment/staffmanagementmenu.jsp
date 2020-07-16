<%-- 
    Document   : staffmanagement
    Created on : Aug 7, 2019, 11:25:23 AM
    Author     : Amyner
--%>


<%@include file="../include.jsp" %>
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
                    <li class="last active"><a href="#">Staff management</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEINTERNALSYSTEMUSER')">
        <div class="col-sm-3 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('staffmanager/registerstaff.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/int_staff2.png">
            </div>
            <div class="icon-content">
                <h2>
                    Register staff
                </h2>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEEXTERNALSYSTEMUSER')">
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
     </security:authorize>
</div>
<script>
    breadCrumb();
</script>
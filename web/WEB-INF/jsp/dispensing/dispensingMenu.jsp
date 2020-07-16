<%-- 
    Document   : dispensingMenu
    Created on : Sep 17, 2018, 2:34:53 PM
    Author     : HP
--%>

<%@include file="../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% int x = 0;%>
<div class="container-fluid" id="mmmainLocalSettings">
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
                        <li class="last active"><a href="#">Dispensing</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">   
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PREPACKAGING')"> 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('packaging/packaginghome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/packaging.png">
                </div>
                <div class="icon-content">
                    <h2>
                        Packaging
                    </h2>
                </div>
            </div>  
            <%x += 1;%>
        </security:authorize><% if (x % 4 == 0) { %>
    </div>
    <div class="row"><%}%>   
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_DISPENSE')"> 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/DispensingManual1.png">
                </div>
                <div class="icon-content">
                    <h2>
                        Dispensing
                    </h2>
                </div>
            </div>  
        </security:authorize>
    </div>
</div>
<script>
    breadCrumb();
</script>
<%-- 
    Document   : paediaricsmenu
    Created on : Oct 18, 2018, 8:36:04 AM
    Author     : user
--%>

<%@include file="../../include.jsp" %>
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
                        <li><a href="#" onclick="ajaxSubmitData('patient/patientmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Patient Management</a></li>
                        <li class="last active"><a href="#">Paediatrics</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">   
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PAEDTRIAGE')">    
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('paediatrics/paedtriage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img border="1" width="90" height="70" src="static/img/TreatmentSysIcon1.png">
            </div>
            <div class="icon-content">
                <h2>
                    Triage
                </h2>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) {%>
</div>
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PAEDCONSULTATION')">
        <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('paediatrics/paedconsultation.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img src="static/img/PatientSysIcon1.png" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <h4>
                    Clinical Consultations
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) {%></div>
<div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_NUTRITIONMANAGEMENT')">
        <div class="col-sm-4 col-md-3 menu-icon" align="center">
            <div class="icon-content">
                <img src="static/img/nutrition.png" border="1" width="90" height="70">
            </div>
            <div class="icon-content">
                <h4>
                    Nutrition management
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    
</div>

<script>
    breadCrumb();
</script>


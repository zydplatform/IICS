<%-- 
    Document   : PatientMenu
    Created on : Sep 12, 2018, 5:18:12 PM
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
                        <li class="last active"><a href="#">Patient Management</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">   
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PATIENTVISIT')">    
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('patient/patientvisits.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/patientVisit.png">
                </div>
                <div class="icon-content">
                    <h2>
                        Patient Visit
                    </h2>
                </div>
            </div>  
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %>
    </div>
        <div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PATIENTVISIT')">
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('patient/getUnitPatientReportPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/unityRegister.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Unit Register
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div>
        <div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PATIENTVISIT')">     
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('patient/getFacilityRegisteredPatients.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/facilityRegister.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Facility Register
                    </h4>
                </div>
            </div>  
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_TRIAGE')">        
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('triage/clinictriagehome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/Triage.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Triage
                    </h4>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div> 
        <div class="row"> <%}%>  
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PATIENTVISIT')">  
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('patient/patientRegisterStatistics.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/patientStatistics.png">
                </div>
                <div class="icon-content">
                    <h2>
                        Patient Statistics
                    </h2>
                </div>
            </div>
            <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div>
        <div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PATIENTFILES')">   
            <div class="col-sm-4 col-md-3 menu-icon" align="center"  onclick="ajaxSubmitData('patients/filemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img src="static/img/PatientFiles.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Patient Files
                    </h4>
                </div>
            </div>
             <%x += 1;%>
        </security:authorize>
        <% if (x % 4 == 0) { %></div>
        <div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PAEDIATRICS')">   
            <div class="col-sm-4 col-md-3 menu-icon" align="center"  onclick="ajaxSubmitData('paediatrics/paediaricsmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img src="static/img/pediatricCons.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Paediatrics
                    </h4>
                </div>
            </div>
             <%x += 1;%>
        </security:authorize>

    </div>
    <script>
        breadCrumb();
    </script>

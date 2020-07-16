<%-- 
    Document   : universalPageMenu
    Created on : Mar 20, 2018, 4:33:59 PM
    Author     : Grace-K

--%>
<%@include file="../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="increment" value="1" scope="page"/>
<c:set var="itemCounter" value="0" scope="page"/>
<div id="mmmainUniversalSettings">
    <div class="app-title" >
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
                        <li class="last active"><a href="#">Universal Settings</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEFACILITIES')">
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('facility/facilityhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img src="static/img/FacilitySysIcon1.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Facility
                    </h4>
                </div>
            </div>  
            <c:set var="itemCounter" value="${itemCounter + increment}"/>
        </security:authorize>        
        <c:if test="${itemCounter%4==0}"></div><div class="row"></c:if>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEUNIVERSALPOSTANDACTIVITIES')">
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('postsandactivities/postsandactivitiesPane.htm', 'workpane', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/PostsSysIcon2.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Designation Categories & Posts
                    </h4>
                </div>
            </div>
            <c:set var="itemCounter" value="${itemCounter + increment}"/>
        </security:authorize>
        <c:if test="${itemCounter%4==0}"></div><div class="row"></c:if>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEHEALTHSUPPLIES')"> 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('essentialmedicinesandsupplieslist/essentialmedicinesandsupplieslisthome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/items.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Medicines & Health Supplies
                    </h4>
                </div>
            </div>
            <c:set var="itemCounter" value="${itemCounter + increment}"/>
        </security:authorize>
        <c:if test="${itemCounter%4==0}"></div><div class="row"></c:if>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGELOCATIONS')">
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('locations/manageLocations.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/locations_control_panel.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Locations
                    </h4>
                </div>
            </div>
            <c:set var="itemCounter" value="${itemCounter + increment}"/>
        </security:authorize>
        <c:if test="${itemCounter%4==0}"></div><div class="row"></c:if>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EXTERNALSUPPLIER')"> 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Controlpanel/loadsuppliermenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/item_supplier_control_panel.png">
                </div>
                <div class="icon-content">
                    <h4>
                        External Suppliers
                    </h4>
                </div>
            </div>
            <c:set var="itemCounter" value="${itemCounter + increment}"/>
        </security:authorize>       
        <c:if test="${itemCounter%4==0}"></div><div class="row"></c:if>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGECURRENCIES')"> 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('currencysystemsettings/currencypane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/zone_bay_labels.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Manage Currencies
                    </h4>
                </div>
            </div>
            <c:set var="itemCounter" value="${itemCounter + increment}"/>
        </security:authorize>        
        <c:if test="${itemCounter%4==0}"></div><div class="row"></c:if>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEQUEUES')"> 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('queuingsystemsettings/queuepane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/Queues.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Manage Queues
                    </h4>
                </div>
            </div>
            <c:set var="itemCounter" value="${itemCounter + increment}"/>
        </security:authorize>
        <c:if test="${itemCounter%4==0}"></div><div class="row"></c:if>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEUNIVERSALMODULESANDACTIVITIES')" > 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('activitiesandaccessrights/activitiesandaccessrights_tabs.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/AccessSysIcon3.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Activities & Access Rights
                    </h4>
                </div>
            </div>            
            <c:set var="itemCounter" value="${itemCounter + increment}"/>
        </security:authorize>
        <c:if test="${itemCounter%4==0}"></div><div class="row"></c:if>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGENETWORKANDDEVICES')" >             
            <div class="col-sm-4 col-md-3 menu-icon" align="center"  onclick="ajaxSubmitData('deviceManuSetting.htm', 'workpane', 'act=tab&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/DeviceSysIcon1.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Network & Devices
                    </h4>
                </div>
            </div>
            <c:set var="itemCounter" value="${itemCounter + increment}"/>
        </security:authorize>
        <c:if test="${itemCounter%4==0}"></div><div class="row"></c:if>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGESERVICESSCHEDULER')" > 
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('schedulerservicesmanagement/scheduledservicesmanagementhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/serviceSCheduler.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Services Scheduler
                    </h4>
                </div>
            </div>

            <c:set var="itemCounter" value="${itemCounter + increment}"/>
        </security:authorize>
        <c:if test="${itemCounter%4==0}"></div><div class="row"></c:if>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEFACILITYSERVICES')" >
            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'workpane', 'act=a1&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">

                <div class="icon-content">
                    <img class="expando" border="1" width="90" height="70" src="static/img/ServiceSysIcon1.png">
                </div>
                <div class="icon-content">
                    <h4>
                        Facility Services
                    </h4>
                </div>
            </div>

        </security:authorize>
        <c:set var="itemCounter" value="${itemCounter + increment}"/>
        <%--<c:if test="${itemCounter%4==0}"></div><div class="row"></c:if>
      <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGERERELOCATEDDATA') or hasRole('ROLE_SUPERADMIN')" > </security:authorize>
          <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&m=0&ofst=1&maxR=100&sStr=', 'GET');">
              <div class="icon-content">
                  <img class="expando" border="1" width="90" height="70" src="static\img\recoverySystem.png">
              </div>
              <div class="icon-content">
                  <h4>
                     System Recovery Module
                  </h4>
              </div>
          </div>
      <c:if test="${itemCounter%4==0}">
      </div><div class="row"></c:if>--%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_CLINICALGUIDELINES')">   
            <div class="col-sm-4 col-md-3 menu-icon" align="center"  onclick="ajaxSubmitData('consultation/consultationhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img src="static/img/clinicalGuideline.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Clinical Guidelines
                    </h4>
                </div>
            </div>
        </security:authorize>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_ASSETS')">   
            <div class="col-sm-4 col-md-3 menu-icon" align="center"  onclick="ajaxSubmitData('medicalandnonmedicalequipment/medicalEquipmentPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img src="static/img/fixedAssetsMgt.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Assets
                    </h4>
                </div>
            </div>
        </security:authorize>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_ASSETS')">   
            <div class="col-sm-4 col-md-3 menu-icon" align="center"  onclick="ajaxSubmitData('postsandactivities/scheduleOfDuties.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img src="static/img/PostsSysIcon2.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Set Staffing Levels
                    </h4>
                </div>
            </div>
        </security:authorize>
         <security:authorize access="hasRole('ROLE_ROOTADMIN')">   
            <div class="col-sm-4 col-md-3 menu-icon" align="center"  onclick="ajaxSubmitData('spokenlanguages/managespokenlanguages.htm', 'workpane','', 'GET');">
                <div class="icon-content">
                    <img src="static/img/PpleSysIcon1.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Spoken languages
                    </h4>
                </div>
            </div>
        </security:authorize>
        <!--            <div class="col-sm-4 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Controlpanel/loadItemLists.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                        <div class="icon-content">
                            <img class="expando" border="1" width="90" height="70" src="static/img/roles_and_privilege_settings.png">
                        </div>
                        <div class="icon-content">
                            <h4>
                                EMHSLU
                            </h4>
                        </div>
                    </div>-->

    </div>
    <!--
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('donorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/DonorSysIcon9.png">
            </div>
    
            <div class="icon-content">
                <h2>
                    Donor Program
                </h2>
            </div>
        </div>-->
</div>
<script>
    breadCrumb();
</script>


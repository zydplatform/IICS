<%-- 
    Document   : resourcespane
    Created on : May 15, 2018, 11:26:59 AM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <li><a href="#" onclick="ajaxSubmitData('appointmentandSchedules/appointmentsPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Appointments Pane</a></li>
                        <li class="last active"><a href="#">Resources</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <main  class="col-md-12 col-sm-12">
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_STAFFAPPOINTMENTSTAB')"> 
         <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
        <label class="tabLabels" for="tab1">View Staff</label>
        </security:authorize>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_ACTIVEAPPOINTMENTSERVICETAB')"> 
        <input id="tab2" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab2">Services</label>
        </security:authorize>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_ACTIVEAPPOINTMENTSERVICEACTIVITYTAB')"> 
        <input id="tab4" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab4">Service Activity</label>
        </security:authorize>
        <section class="tabContent" id="content1">
            <div>
                <%@include file="views/viewStaff.jsp" %>
            </div>
        </section>
        <section class="tabContent" id="content2">
           
        </section>
     
        <section class="tabContent" id="content4">
            
        </section>
    </main>
</div>
<script>
    breadCrumb();
    $('#tab1').change(function () {
        ajaxSubmitData('Appointmentresources/viewsstaff.htm', 'content1', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab2').change(function () {//shelvingxxxtab
        ajaxSubmitData('Appointmentresources/service.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab4').change(function () {
        ajaxSubmitData('Appointmentresources/serviceActivities.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
</script>
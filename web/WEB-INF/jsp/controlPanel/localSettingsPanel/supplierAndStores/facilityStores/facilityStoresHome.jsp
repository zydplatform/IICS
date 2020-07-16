<%-- 
    Document   : facilityStoresHome
    Created on : Apr 23, 2018, 2:23:21 PM
    Author     : RESEARCH
--%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                    <li class="last active"><a href="#">Stores</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<main id="main">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_NOMINATEINTERNALFACILITYSUPPLIER')"> 
        <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
        <label class="tabLabels" for="tab1">Nominate Internal Facility Supplier</label>
    </security:authorize>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_APPROVEINTERNALFACILITYSUPPLIER')"> 
        <input id="tab2" class="tabCheck" type="radio" name="tabs">
        <label class="tabLabels" for="tab2">Approve Nominated Internal Facility Supplier</label>
    </security:authorize>
    <section class="tabContent" id="content1">
        <%@include file="forms/nominateInternalFacilitySupplier.jsp" %>
    </section>
    <section class="tabContent" id="content2">

    </section>
</main>
<script>
    $('#tab2').click(function () {
        ajaxSubmitData('nominateinternalfacilitySupplier/approvedorunapprovednominatedinternalsuppliers.htm', 'content2', 'type=unapproved&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab1').click(function () {
        ajaxSubmitData('nominateinternalfacilitySupplier/nominateinternalfacilitysupplierhome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
</script>

<%-- 
    Document   : controlPanelMenu
    Created on : Mar 20, 2018, 4:16:23 PM
    Author     : Grace-K //configureandmanage.htm
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
                    <li class="last active"><a href="#">Inventory & Supplies</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_DOINVENTORYMANAGEMENT')"> 
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('store/inventoryPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/inventoryImg1.png">
            </div>
            <div class="icon-content">
                <h4>
                    Inventory
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>  
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_DOSTOCKMANAGEMENT')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('stock/stockManagementPane.htm', 'workpane', '&tab=tab1', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/InventoryStockCard.png"/>
            </div>
            <div class="icon-content">
                <h4>
                    Stock Taking
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>  
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_DOSTOCKTAKING')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('stock/stockTakingPane.htm', 'workpane', '&tab=tab1', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/InventoryDrugs.png">
            </div>
            <div class="icon-content">
                <h4>
                    Stock Counting
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>         
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_DOFACILITYUNITORDERPROCESSING')">
        <div class="col-sm-3 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('ordersmanagement/ordershomemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/Ordering1.png" style="width: 78px;">
            </div>
            <div class="icon-content">
                <h4>
                    Unit Orders
                </h4>
            </div>
        </div>    
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>  
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EXPIRIESANDDAMAGES')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('expiryAndDamages/expiryAndDamagePane.htm', 'workpane', '', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/expiry.png">
            </div>
            <div class="icon-content">
                <h4>
                    Expiry & Damages
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_FACILITYUNITCATALOGUE')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('catalogue/loadUnitCatalogPane.htm', 'workpane', 'tab=1', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/shelvingImg1.png">
            </div>
            <div class="icon-content">
                <h4>
                    Unit Catalogue
                </h4>
            </div>
        </div>   
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_FACILITYCATALOGUE')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('catalogue/loadFacilityCatalogPane.htm', 'workpane', '', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/shelvingImg2.png">
            </div>
            <div class="icon-content">
                <h4>
                    Facility Catalogue
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_APPROVEFACILITYORDERS')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('approvefacilityorders/approvefacilityinternalorders.htm', 'workpane', '', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/Ordering2.png">
            </div>
            <div class="icon-content">
                <h4>
                    Approve Orders
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PLACESUPPLIESREQUISITION')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('sandriesreq/suppliesRequisitionsHome.htm', 'workpane', '', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/SupplerRequisition.png">
            </div>
            <div class="icon-content">
                <h4>
                    Supplies Requisitions
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PROCESSSUPPLIESREQUISITION')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('store/disposeSupplies.htm', 'workpane', '', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/InventoryDrugs.png">
            </div>
            <div class="icon-content">
                <h4>
                    Inventory Disposals
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PROCESSSUPPLIESREQUISITION')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('internaldonorprogram/donorProgramPane', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/DonorSysIcon9.png">
            </div>
            <div class="icon-content">
                <h4>
                    Donations
                </h4>
            </div>
        </div>
    </security:authorize>
</div>
<script>
    breadCrumb();
</script>
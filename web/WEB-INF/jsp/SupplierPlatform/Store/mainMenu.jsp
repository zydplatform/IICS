<%-- 
    Document   : mainMenu
    Created on : Sep 4, 2018, 10:01:34 AM
    Author     : samuelwam <samuelwam@gmail.com>
--%>

<%@include file="../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<% int x = 0;%>
<div id="mmmainControlpanel">
    <div class="app-title" id="">
        <div class="col-md-5">
            <h1><i class="fa fa-hospital-o"></i>Customer Order Processing</h1>
            <p>Order Processing!</p>
        </div>

        <div>
            <div class="mmmains">
                <div class="wrapper">
                    <ul class="breadcrumbs">
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('Supplier/Menu/mainMenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                        <li class="last active"><a href="#">Order Processing</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SUPPLIERNEWORDERMANAGER')">
            <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Supplier/Store/newOrdersManager.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img  src="static/img/prosysytemorder.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>New Orders <a><button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: purple;" onclick=""><span>${countNewOrders}</span></button></a></h4>
                    
                </div>
            </div> 
            <%x += 1;%>
        </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SUPPLIERUNDERPROCESSINGORDERMANAGER')">
            <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Supplier/Store/processOrdersManager.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img  src="static/img/InventoryStockCard.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Under Processing<a><button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: orange;" onclick=""><span>${countProcessingOrders}</span></button></a>
                    </h4>
                </div>
            </div> 
            <%x += 1;%>
        </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SUPPLIERDISPATCHORDERMANAGER')">
            <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Supplier/Store/orderDispatchManager.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img  src="static/img/ServiceSysIcon1.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Ready To Dispatch<a><button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: green;" onclick=""><span>${countOrdersReady}</span></button></a>
                    </h4>
                </div>
            </div> 
            <%x += 1;%>
        </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SUPPLIERDISPATCHEDORDERMANAGER')">
            <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Supplier/Store/dispatchedOrdersManager.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img  src="static/img/SupplierOutSysIcon1.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Dispatched Orders<a><button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: green;" onclick=""><span>${countDispatchedOrders}</span></button></a>
                    </h4>
                </div>
            </div> 
            <%x += 1;%>
        </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SUPPLIERREJECTEDORDERMANAGER')">
            <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('Supplier/Store/rejectedOrdersManager.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                <div class="icon-content">
                    <img  src="static/img/prosysytemorder.png" class="expando" border="1" width="90" height="70">
                </div>
                <div class="icon-content">
                    <h4>
                        Rejected Orders<a><button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red;" onclick=""><span>${countRejectedOrders}</span></button></a>
                    </h4>
                </div>
            </div> 
            <%x += 1;%>
        </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    </div>
</div>
<script>
    breadCrumb();
</script>

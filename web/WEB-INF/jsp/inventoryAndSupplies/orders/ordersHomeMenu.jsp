<%-- 
    Document   : ordersHomeMenu
    Created on : Apr 16, 2018, 4:26:46 PM
    Author     : RESEARCH
--%>
<%@include file="../../include.jsp" %>
<% int x = 0;%>
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
                    <li><a href="#" onclick="ajaxSubmitData('store/inventoryAndSupplies.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Inventory & Supplies</a></li>
                    <li class="last active"><a href="#">Facility Unit Order</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_UNITORDERSERVICING')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/prosysytemorder.png">
            </div>

            <div class="icon-content">
                <h4>
                    Process Internal Order
                </h4>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_APPROVECONSOLIDATEUNITORDERS')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('ordersmanagement/approveorconsolidateordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">       
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/approve.png">
            </div>
            <div class="icon-content">
                <h4>
                    Approve/Consolidate Orders
                </h4>
            </div>
        </div>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PREPAREFACILITYUNITORDER')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('ordersmanagement/placeordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/placesystemorder.png">
            </div>
            <div class="icon-content">
                <h4>
                    Place Orders
                </h4>
            </div>
        </div>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EXTERNALORDERSERVICING')">
        <div class="col-sm-6 col-md-3 menu-icon" align="center" onclick="ajaxSubmitData('extordersmanagement/extOrderProcessing', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <div class="icon-content">
                <img class="expando" border="1" width="90" height="70" src="static/img/prosysytemorder1.png">
            </div>

            <div class="icon-content">
                <h2>
                    Process External Order
                </h2>
            </div>
        </div>
        <%x += 1;%>
    </security:authorize>
    <% if (x % 4 == 0) { %></div><div class="row"><%}%>
</div>
<script>
    breadCrumb();
</script>
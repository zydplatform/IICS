<%-- 
    Document   : approveOrConsolidateOrdersHome
    Created on : May 18, 2018, 9:12:21 AM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <li><a href="#" onclick="ajaxSubmitData('ordersmanagement/ordershomemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Facility Unit Order</a></li>
                    <li class="last active"><a href="#">Approve Orders</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row" id="">
    <div class="col-md-12" id="contentminex">
        <%@include file="approveOrders/approveOrdersHome.jsp" %>
    </div>
</div>
<script>
    breadCrumb();
</script>


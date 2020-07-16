<%-- 
    Document   : placeOrdersHome
    Created on : Apr 16, 2018, 5:29:58 PM
    Author     : RESEARCH
--%>
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
                    <li class="last active"><a href="#">Place Order</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<main id="main">
    <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
    <label class="tabLabels" for="tab1">Internal Order</label>

    <input id="tab2" class="tabCheck" type="radio" name="tabs">
    <label class="tabLabels" for="tab2">External Order</label>

    <input id="tab3" class="tabCheck" type="radio" name="tabs">
    <label class="tabLabels" for="tab3">View/Manage Order(s)</label>
    
    <section class="tabContent" id="content1">
        <%@include file="internalOrder/forms/newOrder.jsp" %>
    </section>
    <section class="tabContent" id="content2">
       
    </section>
    <section class="tabContent" id="content3">
        
    </section>
</main>
    <script>
         breadCrumb();
        $('#tab3').click(function(){
            ajaxSubmitData('ordersmanagement/viewormanageorder.htm', 'content3', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });
        $('#tab2').click(function(){
            ajaxSubmitData('extordersmanagement/placeexternalordershome.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        });
    </script>
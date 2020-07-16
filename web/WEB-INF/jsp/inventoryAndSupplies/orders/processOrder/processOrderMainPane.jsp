<%--
    Document   : processOrderMainPane
    Created on : May 16, 2018, 1:16:07 AM
    Author     : IICS-GRACE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp"%>
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
                    <li><a href="#" onclick="ajaxSubmitData('store/inventoryAndSupplies.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Inventory & Supplies</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('ordersmanagement/ordershomemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Facility Unit Order</a></li>
                    <li class="last active"><a href="#">Process Orders</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div style="margin-top: 6px">
    <main id="main">
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_TODAYSORDER')">
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked onclick="ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label class="tabLabels" for="tab1">Today's</label>
        </security:authorize>

        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_FUTUREORDER')">
            <input id="tab2" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('ordersmanagement/managefutureorders.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label class="tabLabels" for="tab2">Future <span id="noOfFutureorders" class="badge badge-patientinfo">0</span></label>
        </security:authorize>

        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_EXPIREDORDER')">
            <input id="tab3" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('ordersmanagement/manageexpiredorders.htm', 'content3', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label class="tabLabels" for="tab3">Expired <span id="noOfExpiredorders" class="badge badge-danger">0</span></label>
        </security:authorize>

        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SERVICEDORDERS')">
            <input id="tab4" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('ordersmanagement/managedeliveredorders.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label class="tabLabels" for="tab4">Serviced Orders</label>
        </security:authorize>

        <input id="tab5" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('ordersmanagement/unservicedorders.htm', 'content5', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab5">Unserviced Order Items</label>
            
        <section class="tabContent" id="content1">
            <div id="">
                <%@include file="../processOrder/views/todaysOrders.jsp"%>
            </div>
        </section>

        <section class="tabContent" id="content2">
            <div id="futuredOrders">
                <%-- TAB-2 CONTENT--%>

            </div>
        </section>

        <section class="tabContent" id="content3">
            <div id="expiredOrders">
                <%-- TAB-3 CONTENT--%>

            </div>
        </section>

        <section class="tabContent" id="content4">
            <%-- TAB-4 CONTENT--%>
            <div id="deliveredOrders">
                <%-- TAB-4 CONTENT--%>

            </div>
        </section>
                
        <section class="tabContent" id="content5">
            
        </section>

    </main>
</div>


<script>
    var serverDate = '${serverdate}';
    $(document).ready(function () {
        breadCrumb();
        $.ajax({
            type: 'GET',
            data: '',
            dataType: 'JSON',
            url: 'ordersmanagement/numberoftodayfutureexpireorders.htm',
            success: function (number) {
                var ordernos = number[0];
                var noOfFutureorders = ordernos.noOfFutureorders;
                var noOfExpiredOrders = ordernos.noOfExpiredorders;
                $('#noOfFutureorders').html(noOfFutureorders);
                $('#noOfExpiredorders').html(noOfExpiredOrders);
                
            }
        });
    });
    function getUnservicedOrders(date){        
        if (date === undefined || date === null || date.trim().length === 0) {
            date = new Date(serverDate).toISOString();
        } else {
            var v = date.split('-'); 
            date = new Date((v[2] + '-' + v[1] + '-' + v[0])).toISOString();
        }
        var selectedDate = date.substring(0, date.indexOf('T'));        
        ajaxSubmitData('ordersmanagement/unservicedorders.htm', 'content5', 'targetdate=' + selectedDate, 'GET');
    }
</script>


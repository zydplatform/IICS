<%-- 
    Document   : test
    Created on : May 29, 2018, 2:39:23 PM
    Author     : RESEARCH
--%>

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
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                    <li class="last active"><a href="#">Manage Currencies</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<main id="main">
    <section class="form-group" id="content1">
        <div>
            <%@include file="views/viewcurrencies.jsp" %>
        </div>
    </section>
</main>
<script>
    breadCrumb();
    $(document).ready(function () {
        $('#viewcurrencyrates').click(function () {
            $('#viewrates').modal('show');
        });

        $('#cancel').click(function () {
            $('#viewrates').modal('show');
        });
    });
</script>

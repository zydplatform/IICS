<%-- 
    Document   : resourceallocationpane
    Created on : May 21, 2018, 12:16:28 PM
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
                        <li class="last active"><a href="#">Configure Locations</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <main  class="col-md-12 col-sm-12">
        <div id="content1">
            
        </div>
    </main>
</div>
<script>
    breadCrumb();
    
</script>

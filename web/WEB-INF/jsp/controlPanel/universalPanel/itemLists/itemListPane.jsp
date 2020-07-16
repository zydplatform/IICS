<%-- 
    Document   : itemListPane
    Created on : 04-May-2018, 09:33:10
    Author     : IICS
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
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                    <li class="last active"><a href="#">Item Lists</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row" id="manageItems">
    <div class="col-md-12" id="itemsPane">

    </div>
</div>
<script>
    $(document).ready(function () {
        breadCrumb();
        ajaxSubmitData('store/initItemPane.htm', 'itemsPane', '', 'GET');
    });
</script>

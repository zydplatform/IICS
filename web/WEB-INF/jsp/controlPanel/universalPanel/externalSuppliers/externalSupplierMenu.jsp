<%-- 
    Document   : externalSupplierMenu
    Created on : Mar 21, 2018, 9:48:33 PM
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
                    <li class="last active"><a href="#">External Suppliers</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row" id="manageSuppliers">
    <div class="col-md-12" id="externalSupplierContent">
        
    </div>
</div>
<script>
    $(document).ready(function () {
        breadCrumb();
        ajaxSubmitData('externalsuppliers/initSupplierPane.htm', 'externalSupplierContent', 'tab=tab1', 'GET');
    });
</script>
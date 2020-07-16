<%-- 
    Document   : inventoryPane
    Created on : Apr 10, 2018, 7:24:47 AM
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
                    <li><a href="#" onclick="ajaxSubmitData('store/inventoryAndSupplies.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Inventory & Supplies</a></li>
                    <li class="last active"><a href="#">Stock Taking</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row" id="manageItems">
    <div class="col-md-12" id="externalSupplierContent">
        <main id="main">
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Locations</label>

            <input id="tab2" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab2">Stock Counting</label>

            <input id="tab3" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab3">Item Recounts</label>
            <section class="tabContent" id="content1">
                <div>
                    <div id="stockEntryContent">
                        <%@include file="locations/assignedLocations.jsp" %>
                    </div>
                </div>
            </section>
            <section class="tabContent" id="content2">
                <div>
                    <%@include file="counting/countItems.jsp" %>
                </div>
            </section>
            <section class="tabContent" id="content3">
                <div>
                    <%@include file="recounts/recounts.jsp" %>
                </div>
            </section>
        </main>
    </div>
</div>
<script>
    breadCrumb();
    $('#${tabid}').click();
</script>
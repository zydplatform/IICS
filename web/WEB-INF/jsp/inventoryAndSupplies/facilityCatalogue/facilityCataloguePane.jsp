<%-- 
    Document   : facilityCataloguePane
    Created on : Apr 30, 2018, 1:02:58 PM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<div class="app-title" id="">
    <div class="col-md-5">
        <h1>
            <i class="fa fa-dashboard"></i> Dashboard
        </h1>
        <p>Together We Save Lives...!</p>
    </div>
    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="window.location.reload(true);"></a></li>
                    <li><a href="#" onclick="ajaxSubmitData('store/inventoryAndSupplies.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Inventory & Supplies</a></li>
                    <li class="last active"><a href="#">Facility Catalogue</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <main id="main">
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Approved Items</label>

            <input id="tab2" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab2">Pending Items</label>

            <section class="tabContent" id="content1">
                <div>
                    <%@include file="generalCatalogue/generalCatalogueItems.jsp" %>
                </div>
            </section>
            <section class="tabContent" id="content2">
                <div>
                    <%@include file="approve/approveItems.jsp" %>
                </div>
            </section>
        </main>
    </div>
</div>
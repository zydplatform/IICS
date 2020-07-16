<%-- 
    Document   : inventoryPane
    Created on : Apr 10, 2018, 7:24:47 AM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
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
                    <li class="last active"><a href="#">Inventory</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row" id="manageItems">
    <div class="col-md-12" id="externalSupplierContent">
        <main id="main">
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_STOCKENTRYANDSHELVINGMANAGEMENT')"> 
                <input id="tab1" class="tabCheck" type="radio" name="tabs" checked path="">
                <label class="tabLabels" for="tab1">Stock Entry & Shelving</label>
            </security:authorize>     
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGESHELVES')"> 
                <input id="tab2" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab2">Shelves</label>
            </security:authorize>
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_VIEWSTOCK')">
                <input id="tab3" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab3">Stock</label>
            </security:authorize>
            <section class="tabContent" id="content1">
                <div>
                    <div id="stockEntryContent">
                        <%@include file="entry/unitStock.jsp" %>
                    </div>
                </div>
            </section>
            <section class="tabContent" id="content2">
                <div>
                    <%@include file="shelves/manageShelves.jsp" %>
                </div>
            </section>
            <section class="tabContent" id="content3">
                <div>
                    <div>
                        <%@include file="stock/manageStock.jsp" %>
                    </div>
                </div>
            </section>
        </main>
    </div>
</div>
<script>
    breadCrumb();
</script>
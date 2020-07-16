<%-- 
    Document   : inventoryPane
    Created on : Apr 10, 2018, 7:24:47 AM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
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
                    <li class="last active"><a href="#">Stock Management</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row" id="manageItems">
    <div class="col-md-12" id="externalSupplierContent">
        <main id="main">
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_STOCKTAKINGACTIVITESMANAGEMENT')"> 
                <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                <label class="tabLabels" for="tab1">Stock Taking Activities</label>
            </security:authorize>
            
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGESTOCKLOCATIONS')"> 
                <input id="tab2" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab2">Locations</label>
            </security:authorize> 
            
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGESTOCKCELLCOUNTS')"> 
                <input id="tab3" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab3">Cell Counts</label>
            </security:authorize>
           
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGESTOCKRECOUNTS')">
                <input id="tab4" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab4">Recounts</label>
            </security:authorize>    
            
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGESTOCKFOLLOWUPS')">
                <input id="tab5" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab5">Discrepancies</label>
            </security:authorize>            

            <section class="tabContent" id="content1">
                <div>
                    <div id="stockEntryContent">
                        <%@include file="stockTakingSetup/setupPage.jsp" %>
                    </div>
                </div>
            </section>
            <section class="tabContent" id="content2">
                <div>
                    <%@include file="cellLocations/activityLocations.jsp" %>
                </div>
            </section>
            <section class="tabContent" id="content3">
                <div>
                    <div>
                        <%@include file="stockCount/cellCounts.jsp" %>
                    </div>
                </div>
            </section>
            <section class="tabContent" id="content4">
                <div>
                    <div>
                        <%@include file="recounts/recounts.jsp" %>
                    </div>
                </div>
            </section>
            <section class="tabContent" id="content5">
                <div>
                    <div>
                        <%@include file="follow-up/followPane.jsp" %>
                    </div>
                </div>
            </section>
        </main>
    </div>
</div>
<script>
    breadCrumb();
    $('#${tabid}').click();
</script>
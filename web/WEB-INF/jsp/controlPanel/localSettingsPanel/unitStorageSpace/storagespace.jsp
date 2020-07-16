<%-- 
    Document   : storagespace
    Created on : Mar 26, 2018, 5:11:25 PM
    Author     : IICSRemote
--%>
<%@include file="../../../include.jsp" %>
<div id="mainxxx">
    <div class="app-title" >
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
                        <li><a href="#" onclick="ajaxSubmitData('localsettigs/manage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Manage</a></li>
                        <li class="last active"><a href="#">Unit Storage Space</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="tile">
        <div class="tile-body">  
            <main  class="col-md-12 col-sm-12">
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_CREATESTORAGESPACETAB')">
                    <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                    <label class="tabLabels" for="tab1">Create Storage Space</label>
                </security:authorize>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEUNITSTORAGESPACETAB')">
                    <input id="tab2" class="tabCheck" type="radio" name="tabs">
                    <label class="tabLabels" for="tab2">Manage Storage Space</label>

                </security:authorize>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEUNITSTOREFUNCTIONSTAB')">
                    <input id="tab3" class="tabCheck" type="radio" name="tabs">
                    <label class="tabLabels" for="tab3">Store Functionalities</label>
                </security:authorize>

                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_CREATESTORAGETYPETAB')">
                    <input id="tab4" class="tabCheck" type="radio" name="tabs">
                    <label class="tabLabels" for="tab4">Create Storage Type</label>
                </security:authorize>
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PRINTCELLLABELSTAB')">
                    <input id="tab5" class="tabCheck" type="radio" name="tabs">
                    <label class="tabLabels" for="tab5">Print Cell Labels</label>
                </security:authorize>

                <section class="tabContent" id="content1">
                    <div>
                        <%@include file="views/storagetype.jsp" %>
                    </div>
                </section>
                <section class="tabContent" id="content2">
                    <div>
                        <%@include file="views/managespace.jsp" %>
                    </div>
                </section>
                <section class="tabContent" id="content3">
                    <div>
                        <div>
                            <p>Loading Content.......................</p>
                        </div>
                    </div>
                </section>
                <section class="tabContent" id="content4">
                    <div id="xStoreType">
                        <p>Loading Content.......................</p>
                    </div>
                </section>
                <section class="tabContent" id="content5">
                    <div id="">
                        <p>Under Implementation.......................</p>
                    </div>
                </section>
            </main>
        </div>
    </div>
</div>
<script>
    breadCrumb();
    $('#tab1').change(function () {
        ajaxSubmitData('localsettigs/shelvingtab.htm', 'mainxxx', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab2').change(function () {//shelvingxxxtab
        ajaxSubmitData('localsettigs/manageshelvingtab.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab3').change(function () {
        ajaxSubmitData('localsettigs/Operationalspace.htm', 'content3', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab4').change(function () {
        ajaxSubmitData('localsettigs/storagetypeshow.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
    $('#tab5').change(function () {
        ajaxSubmitData('localsettigs/printingzonecellLabels.htm', 'content5', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
</script>
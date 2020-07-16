<%-- 
    Document   : packaginghome
    Created on : Aug 10, 2018, 1:12:26 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../include.jsp" %>
<!DOCTYPE html>
<div class="app-title" >
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>

    <div class="">
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/dispensingMenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Dispensing</a></li>
                    <li class="last active"><a href="#">Packaging</a></li>
                </ul>
            </div>
        </div>
    </div>
</div
<div style="margin-top: 6px">
    <main id="main">
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PACKAGE_ITEMS')">
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Create Packages</label>
        </security:authorize>

        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PICK_ITEMS')">
            <input id="tab2" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('packaging/picktopackets.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label class="tabLabels" for="tab2">Pick Items</label>
        </security:authorize>

        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PACKAGE_ITEMS')">
            <input id="tab3" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('packaging/pack_to_packets.htm', 'content3', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label class="tabLabels" for="tab3">Package Items<span class="badge badge-patientinfo"></span></label>
        </security:authorize>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PACKAGE_ITEMS')">
            <input id="tab4" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('packaging/packageditems.htm', 'content4', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
            <label class="tabLabels" for="tab4">Packaged Items<span class="badge badge-patientinfo"></span></label>
        </security:authorize>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_VIEW_BOOKED_ITEMS')">
        <input id="tab5" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('packaging/bookeditems.htm', 'booked', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab5">Booked Items<span class="badge badge-patientinfo"></span></label>
        </security:authorize>    

        <section class="tabContent" id="content1">
            <div class="col-md-12">
                <div class="col-md-12">
                    <div style="margin-top: 3em">
                        <div>
                            <div>
                                <%@include file="views/packageitemsearch.jsp" %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="tabContent" id="content2">
            <div id="picktopackage">

            </div>
        </section>

        <section class="tabContent" id="content3">
            <div id="futuredOrders">
                <%-- TAB-2 CONTENT--%>

            </div>
        </section>
        <section class="tabContent" id="content4">
            <div id="futuredOrders">
                <%-- TAB-2 CONTENT--%>

            </div>
        </section>
        <section class="tabContent" id="content5">
            <div id="booked">
                <%-- TAB-5 CONTENT--%>

            </div>
        </section>        
    </main>
</div>

<script>
    
</script>
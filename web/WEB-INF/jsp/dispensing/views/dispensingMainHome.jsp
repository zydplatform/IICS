<%--
    Document   : dispensingMainHome
    Created on : Oct 5, 2018, 9:38:44 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<div class="app-title">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>

    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="clearInterval(interval);ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                    <li><a href="#" onclick="clearInterval(interval);ajaxSubmitData('Controlpanel/dispensingMenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Dispensing Home</a></li>
                    <li class="last active"><a href="#">Drug Dispensing</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div style="">
    <main id="main" style="padding: 1% !important">
        <input id="tab1" class="tabCheck" type="radio" name="tabs" checked onclick="ajaxSubmitData('dispensing/approvePrescriptionView.htm', 'prescribedDrugsDiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab1">Approve Prescriptions</label>

        <input id="tab2" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('dispensing/issuePrescriptionsView.htm', 'readyToIssueView', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab2">Issue Drugs <span id="no-of-ready-orders" class="badge badge-patientinfo">0</span></label>

        <input id="tab3" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('dispensing/dispensedDrugsView.htm', 'dispensedDrugs', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab3">Dispensed Drugs</label>

        <section class="tabContent" id="content1">
            <div id="prescribedDrugsDiv">
                <%@include file="../views/drugDispensingPane.jsp" %>
            </div>
        </section>

        <section class="tabContent" id="content2">
            <div id="readyToIssueView">
                <%-- TAB-2 CONTENT--%>

            </div>
        </section>

        <section class="tabContent" id="content3">
            <div id="dispensedDrugs">
                <%-- TAB-3 CONTENT--%>

            </div>
        </section>
    </main>
</div>

<script>
    breadCrumb();
//    $.ajax({
//        type: 'GET',
//        url: "dispensing/readyItemsCount.htm",
//        success: function (readyItemscount) {
//            $('#no-of-ready-orders').html(readyItemscount);
//        }
//    });

</script>
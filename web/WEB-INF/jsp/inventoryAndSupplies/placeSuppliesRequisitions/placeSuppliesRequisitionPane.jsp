<%-- 
    Document   : suppliesRequisitionMenu
    Created on : Oct 7, 2018, 1:21:49 PM
    Author     : IICS
--%>

<%@include file="../../include.jsp" %>
<% int x = 0;%>
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
                    <li class="last active"><a href="#">Supplies Requisitions</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div style="">
    <main id="main" style="padding: 1% !important">
        <input id="tab1" class="tabCheck" type="radio" name="tabs" checked onclick="ajaxSubmitData('sandriesreq/suppliesRequisitionsHome.htm', 'workpane', '', 'GET');">
        <label class="tabLabels" for="tab1">Place Requisition</label>

        <input id="tab2" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('sandriesreq/approveRequistionTab.htm', 'contentApproveRequisition', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab2">Approve Requisition <span id="" class="badge badge-patientinfo">${noOfApprovedOrders}</span></label>

        <input id="tab3" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('sandriesreq/issueOutRequests.htm', 'contentIssueOutRequisition', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab3">Issue Requisition  <span id="" class="badge badge-patientinfo">${noOfReadyToIssueOrders}</span></label>

        <input id="tab4" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('sandriesreq/servicesdOrderRequisitions.htm', 'contentIssuedPrescription', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab4">Serviced Supplies</label>

        <section class="tabContent" id="content1">
            <div id="prescribedDrugsDiv">
                <%@include file="forms/placeOrders.jsp" %>
            </div>
        </section>

        <section class="tabContent" id="content2">
            <div id="contentApproveRequisition">
                <%-- TAB-2 CONTENT--%>

            </div>
        </section>

        <section class="tabContent" id="content3">
            <div id="contentIssueOutRequisition">
                <%-- TAB-3 CONTENT--%>

            </div>
        </section>

        <section class="tabContent" id="content4">
            <div id="contentIssuedPrescription">
                <%-- TAB-4 CONTENT--%>

            </div>
        </section>
    </main>
</div>
<script>
    breadCrumb();
</script>
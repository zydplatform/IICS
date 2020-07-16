<%-- 
    Document   : staffPerformancePane
    Created on : Oct 17, 2018, 10:35:12 AM
    Author     : IICS
--%>
<%@include file="../../../include.jsp"%>
<div class="app-title">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>
    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#!" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', '', 'GET');"></a></li>
                    <li><a href="#!" onclick="ajaxSubmitData('dashboard/loadDashboardMenu.htm', 'workpane', '', 'GET');">Dashboard & Reports</a></li>
                    <li><a href="#!" onclick="ajaxSubmitData('dashboard/loadStaffActiviiesMenu.htm', 'workpane', '', 'GET');">Staff Activities</a></li>
                    <li class="last active"><a href="#">Performance</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <main id="main">
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Range Summary</label>
            <input id="tab2" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab2">Daily Summary</label>

            <section class="tabContent" id="content1">
                <div>
                    <%@include file="range/range.jsp" %>
                </div>
            </section>
            <section class="tabContent" id="content2">
                <div>
                    <%@include file="daily/performancePane.jsp" %>
                </div>
            </section>
        </main>
    </div>
</div>
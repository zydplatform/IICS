<%-- 
    Document   : prescriptionTabs
    Created on : Apr 12, 2019, 9:54:52 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp"%>
<div class="app-title">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>

    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="clearInterval(interval);ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');cleanUp();"></a></li>
                    <li><a href="#" onclick="clearInterval(interval);ajaxSubmitData('Controlpanel/dispensingMenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');cleanUp();">Dispensing Home</a></li>
                    <li class="last active"><a href="#">Drug Dispensing</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div style="">
    <main id="main" style="padding: 1% !important">
        <input id="tab1" class="tabCheck" type="radio" name="tabs" checked onclick="ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab1">Servicing Queue</label>
        <%--<security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_VIEWPRESCRIPTIONITEMS')">--%>  
            <input id="tab2" class="tabCheck" type="radio" name="tabs" onclick="navigateTo('view-prescription-items', ${(patientvisitid == null) ? 'null' :patientvisitid}, null, ${facilityunitid}, null);cleanUp();">
            <label class="tabLabels" for="tab2">View Prescription</label>
        <%--</security:authorize>--%>
        <%--<security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_APPROVEPRESCRIPTIONS')">--%>  
            <input id="tab3" class="tabCheck" type="radio" name="tabs" onclick="navigateTo('approve-prescriptions', null, null, ${facilityunitid}, null);cleanUp();">
            <label class="tabLabels" for="tab3">Approve Prescription  <span class="badge badge-info" id="reviewed-count">${reviewedCount}</span></label>
        <%--</security:authorize>--%>
        <%--<security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PICKPRESCRIPTIONITEMS')">--%> 
            <input id="tab4" class="tabCheck" type="radio" name="tabs" onclick="navigateTo('pick-lists', null, null, ${facilityunitid}, null);cleanUp();">
            <label class="tabLabels" for="tab4">Pick Items  <span class="badge badge-info" id="pick-lists-count">${pickListCount}</span></label>
        <%--</security:authorize>--%>
        <%--<security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_ISSUEPRESCRIPTIONS')">--%> 
            <input id="tab5" class="tabCheck" type="radio" name="tabs" onclick="navigateTo('issue-prescription', null, null, ${facilityunitid}, null);cleanUp();">
            <label class="tabLabels" for="tab5">Ready To Issue <span class="badge badge-info" id="ready-to-issue-prescription-count">${readyToIssueCount}</span></label>
        <%--</security:authorize>--%>
        <%--<security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_VIEWSERVICEDPRESCRIPTIONS')">--%>
            <input id="tab6" class="tabCheck" type="radio" name="tabs" onclick="navigateTo('serviced-prescriptions', null, null, null, null);cleanUp();">
            <label class="tabLabels" for="tab6">Serviced Prescriptions   <span class="badge badge-info" id="serviced-prescription-count">${servicedPrescriptionCount}</span></label>
        <%--</security:authorize>--%>
            <input id="tab7" class="tabCheck" type="radio" name="tabs" onclick="navigateTo('unresolved-prescriptions', null, null, null, null);cleanUp();">
            <label class="tabLabels" for="tab7">Unresolved Prescriptions   <span class="badge badge-info" id="unresolved-prescription-count">${unresolvedPrescriptionCount}</span></label>
            
            <input id="tab8" class="tabCheck" type="radio" name="tabs" onclick="navigateTo('today-consumption', null, null, null, null);cleanUp();">
            <label class="tabLabels" for="tab8">Daily Consumption   <span class="badge badge-info" id="today-consumption-count">${todayconsumptioncount}</span></label>
            
            <input id="tab9" class="tabCheck" type="radio" name="tabs" onclick="navigateTo('unserviced-prescriptions', null, null, null, null);cleanUp();">
            <label class="tabLabels" for="tab9">Unserviced Prescriptions</label>
            
            <section class="tabContent" id="content1">
                <div id="prescribedDrugsDiv">
                    <%@include file="../views/drugDispensingPane.jsp" %>
                </div>
            </section>
        <%--<security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_VIEWPRESCRIPTIONITEMS')">--%>  
            <section class="tabContent" id="content2">
                <div id="view-prescription-items">
                </div>
            </section>
        <%--</security:authorize>--%>
        <%--<security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_APPROVEPRESCRIPTIONS')">--%>  
            <section class="tabContent" id="content3">
                <div id="approve-prescriptions" class="approve-prescription-items">
                    <%-- TAB-2 CONTENT--%>
                </div>
            </section>
        <%--</security:authorize>--%>
        <%--<security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_PICKPRESCRIPTIONITEMS')">--%>         
            <section class="tabContent" id="content4">
                <div id="pick-lists" class="picklist-items">
                    <%-- TAB-3 CONTENT--%>
                </div>
            </section>  
        <%--</security:authorize>--%>
        <%--<security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_ISSUEPRESCRIPTIONS')">--%>         
            <section class="tabContent" id="content5">
                <div id="issue-prescription" class="dispensing-items">
                    <%-- TAB-4 CONTENT--%>
                </div>
            </section>
        <%--</security:authorize>--%>
        <%--<security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_VIEWSERVICEDPRESCRIPTIONS')">--%>        
            <section class="tabContent" id="content6">
                <div id="serviced-prescriptions">
                    <%-- TAB-5 CONTENT--%>
                </div>
            </section>
        <%--</security:authorize>--%>
        <section class="tabContent" id="content7">
            <div id="unresolved-prescriptions">
                <%-- TAB-5 CONTENT--%>
            </div>
        </section>
        <section class="tabContent" id="content8">
            <div id="today-consumption">
                <%-- TAB-5 CONTENT--%>
            </div>
        </section>
        <section class="tabContent" id="content9">
            <div id="unserviced-prescriptions">
                <%-- TAB-5 CONTENT--%>
            </div>
        </section>
    </main>
</div>
<script>    
    var serverDate = '${serverdate}';
    function navigateTo(destination, patientvisitid, dateServiced, facilityUnitId, prescriptionId) {
        $('#' + destination).html('');
        switch (destination) {
            case 'view-prescription-items':                 
                    $(destination).html('');
                    if (patientvisitid === undefined || patientvisitid === null) {
                        popPrescription('dispensing/popprescription.htm', {facilityunitid: facilityUnitId, queuestage: 'review'}, 'dispensing/viewprescriptionitems.htm', destination);                       
                    } else {
                        ajaxSubmitData('dispensing/viewprescriptionitems.htm', destination, 'patientvisitid=' + patientvisitid, 'GET');
                        $('#tab1').prop('checked', false);
                        $('#content1').attr('display', 'none');
                        $('#tab2').prop('checked', true);
                        $('#content2').attr('display', 'block');
                    }
                break;
            case 'approve-prescriptions':
                popPrescription('dispensing/popprescription.htm', {facilityunitid: facilityUnitId, queuestage: 'approval'}, 'dispensing/approveprescriptionitems.htm', destination);
                break;
            case 'pick-lists':
                popPrescription('dispensing/popprescription.htm', {facilityunitid: facilityUnitId, queuestage: 'picking'}, 'dispensing/pickitems.htm', destination);
                break;
            case 'issue-prescription':
                popPrescription('dispensing/popprescription.htm', {facilityunitid: facilityUnitId, queuestage: 'dispensing'}, 'dispensing/readytoissueitems.htm', destination);
                break;
            case 'serviced-prescriptions':
                var date = new Date(serverDate).toISOString();
                if (dateServiced === undefined || dateServiced === null) {
                    dateServiced = date.substring(0, date.indexOf('T'));
                } else {
                    date = dateServiced.toISOString();
                    dateServiced = date.substring(0, date.indexOf('T'));
                }
                ajaxSubmitData('dispensing/servicedprescriptions.htm', destination, 'dateissued=' + dateServiced, 'GET');
                break;
            case 'unresolved-prescriptions':                
                ajaxSubmitData('dispensing/unresolvedprescriptions.htm', destination, '', 'GET');
                break;
            case 'today-consumption':
                var date = new Date(serverDate).toISOString();
                if (dateServiced === undefined || dateServiced === null) {
                    dateServiced = date.substring(0, date.indexOf('T'));
                } else {
                    date = dateServiced.toISOString();
                    dateServiced = date.substring(0, date.indexOf('T'));
                }
                ajaxSubmitData('dispensing/todayconsumption.htm', destination, 'consumptiondate=' + dateServiced, 'GET');
                break;
            case 'unserviced-prescriptions':                
                var date = new Date(serverDate).toISOString();              
                if (dateServiced === undefined || dateServiced === null) {
                    dateServiced = date.substring(0, date.indexOf('T'));
                } else {
                    date = dateServiced.toISOString();
                    dateServiced = date.substring(0, date.indexOf('T'));
                }
                ajaxSubmitData('dispensing/unservicedprescriptions.htm', destination, 'selecteddate=' + dateServiced, 'GET');
                break;
            default:
                ajaxSubmitData('dispensing/dispensingmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                break;
        }
    }
    function cleanUp() {        
        if (eventSource !== null) {
            eventSource.close();
        }
    }
</script>


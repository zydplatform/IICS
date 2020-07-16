<%-- 
    Document   : RegisterUser
    Created on : Apr 4, 2018, 2:56:00 AM
    Author     : IICS PROJECT
--%>
<%@include file="../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    #legendHead{
        color: white;
        background-color: purple;
        border-radius: 20%;
        margin-left: 40%;
        border: 6px solid purple;
    }
    #size{
        border: 2px solid purple;
    }
</style>
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
                    <li><a href="#" onclick="ajaxSubmitData('usermanagement/internalAndexternal.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">User Management</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('usermanagement/internalSystemuser.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Manage and register</a></li>
                    <li class="last active"><a href="#">Register User</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_REQUESTTOUSESYSTEM')">
            <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
            <label class="tabLabels" for="tab1">Request to use system</label>
        </security:authorize>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_APPROVEUSERREQUESTS')">
            <input id="tab2" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab2">Approve request(s)<span class="badge badge-info">${requisitions}</span></label>
        </security:authorize>
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_CONFIRMUSERREQUESTS')">
            <input id="tab3" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab3">Confirm approved Requests(s)<span class="badge badge-info">${aplist}</span></label>
        </security:authorize>
       
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_VIEWDENIEDORAPPROVEDREQUEST')">
            <input id="tab4" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab4">Confirmed<span class="badge badge-info">${approvedrequestscount}</span> /Denied<span class="badge badge-danger">${deniedrequestscount}</span> Requests</label>
        </security:authorize>
        
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_VIEWSTAFFLIST')">
            <input id="tab5" class="tabCheck" type="radio" name="tabs">
            <label class="tabLabels" for="tab5">Staff List</label>
        </security:authorize>
        
        <section class="tabContent" id="content1">
            <div class="col-md-12">
                <fieldset id="size">
                    <div class="col-md-12">
                        <div style="margin-top: 3em">
                            <div>
                                <div>
                                    <%@include file="SearchStaff.jsp" %>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </section>
        <section class="tabContent" id="content2">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body" id="requisitionlist">

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="tabContent" id="content3">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body" id="people">

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="tabContent" id="content4">
            <div class="tile">
                <div class="tile-body" id="requestprocessing">
                </div>
            </div>
        </section>
        <section class="tabContent" id="content5">
            <div class="tile">
                <div class="tile-body" id="stafflists">
                </div>
            </div>
        </section>
    </div>
</div>
<script>
    breadCrumb();
    $('#tab2').click(function () {
        ajaxSubmitData('retrievesavedrequests.htm', 'requisitionlist', '', 'GET');
    });
    $('#tab3').click(function () {
        ajaxSubmitData('retrievepersons.htm', 'people', '', 'GET');
    });
    $('#tab4').click(function () {
        ajaxSubmitData('requeststatus.htm', 'requestprocessing', '', 'GET');
    });
    $('#tab5').click(function () {
        ajaxSubmitData('stafflist.htm', 'stafflists', '', 'GET');
    });

</script>

<%-- 
    Document   : recoveryCategoryReg
    Created on : Aug 16, 2018, 10:31:22 AM
    Author     : user
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Setting</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('locations/trailcategory.htm','workpane','act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=','GET')">Trail Registration</a></li>
                        <li class="last active">Trail Registration</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<main id="main" >
    <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
    <label class="tabLabels" for="tab1" onClick="ajaxSubmitData('locations/trailcategory.htm','workpane','act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=','GET');"> Recovery Category</label>
   
    
    
    
    <%--TAB-1 CONTENT
      <div style="margin: 10px;" id="workpane">
            <div class="row">
                <div class="col-md-12">
                    <button data-toggle="modal" data-target="#addRecoveryCategory" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus-circle"></i>Add Category</button>
                </div>
            </div>
            <%@include file=""%>
        </div>
      </main>
    
    <!-- ADD NEW  -->
    <div class="modal fade col-md-12" id="addRecoveryCategory" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 153%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Add category</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <button id="saveRecoveryCategory" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseRegion" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!--  UPDATE Region 
    <div class="modal fade col-md-12" id="updateRegion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 153%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Update Region</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <input type="hidden" id="regionid" value=""/>
                                <div class="tile">
                                    <div class="tile-body">
                                        <%@include file="../../location/forms/updateRegion.jsp"%>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <button id="saveUpdateRegion" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Update</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseRegionUpdate" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>-->--%>

<script>
    $(document).ready(function () {
        breadCrumb();
        
</script>
<script src="static/res/js/bootstrap.min.js"></script>

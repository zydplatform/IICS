<%-- 
    Document   : main
    Created on : August 1, 2018, 10:05:07 AM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>

<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="static/mainpane/css/autoCompleteDropList.css">
<style>
 #size{
        border: 2px solid purple;
        
    }
</style>
<div>
    <div class="app-title" id="">
        <div class="col-md-5">
            <div class="box-title">
                <h3>
                    <i class="fa fa-home"></i>
                    Data Trails Management
                </h3>
            </div>
        </div>

        <div>
            <div class="mmmains">
                <div class="wrapper">
                    <ul class="breadcrumbs">
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li> 
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                        <li class="last active"><a href="#">Data Trails</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
<fieldset id="size" style="width:50%; margin:auto;" >
    <div class="row">
        <div class="col-md-12">
            <main id="main">                
                <div class="form-group row">
                    <select class="form-control col-md-5" id="activity" name="activity" onChange="ajaxSubmitData('locations/locationsAuditor.htm', 'activityPane', 'act=b&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr='+this.value+'', 'GET');">
                        <option value="0">-Select Data  Activity-</option>
                        <option value="Location Management">Location Management</option>                    
                    </select>
                </div>
                <div class="form-group row" id="activityPane">
                    <select class="form-control col-md-5" id="audCat" name="audCat" onChange="clearDiv('activityPanel'); if(this.value==0){return false;} ajaxSubmitData('locations/locationsAuditor.htm', 'activityPanel', 'act=c&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr='+this.value+'', 'GET');">
                        <option value="0">--Select Data Category--</option>
                        <c:forEach items="${model.audActivityList}" var="list">                                
                            <option value="${list}">${list}</option>
                        </c:forEach>
                    </select>
                </div>
            </main>
        </div>
    </div>
</fieldset>
    <div class="row">
        <div class="col-md-12">
            <div id="activityPanel"></div>
        </div>
    </div>
</div>


<script src="static/res/js/bootstrap.min.js"></script>
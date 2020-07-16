<%-- 
    Document   : clinicalGuidelineMainPane
    Created on : Aug 6, 2018, 11:36:14 AM
    Author     : IICS-GRACE
--%>
<link rel="stylesheet" type="text/css" href="static/res/css/jquery.treefilter.css"/>
<link rel="stylesheet" type="text/css" href="static/res/css/easyui.css"/>
<%@include file="../../include.jsp"%>
<style>
    .thumbnail {
        margin: 0;
        padding: 0px 5px;
    }
    .thumbnail3 {
        margin: 0;
        padding: 40px 5px;
    }
    h3 {
        margin: 0;
    }

    .ui-resizable-handle {
        position: absolute;
        font-size: 0.1px;
        display: block;
        touch-action: none;
        width: 30px;
        right: -15px;
    }
    .ui-resizable-handle:after {
        content: "";
        display: block;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        margin-top: -10px;
        width: 4px;
        height: 4px;
        border-radius: 50%;
        background: #ddd;
        box-shadow: 0 10px 0 #ddd, 0 20px 0 #ddd;
    }

    .layout-button-left {
        background: url('static/img2/layout_arrows.png') no-repeat 0 0;
    }
    .layout-button-right {
        background: url('static/img2/layout_arrows.png') no-repeat 0 -16px;
    }
    .icon-ok{
        background:url('static/img2/ok.png') no-repeat center center;
    }
    .tf-tree .tf-child-true:before {
        display: block;
        position: absolute;
        top: -1px;
        left: 0;
        content: url("static/img2/menu-arrow-right.png");
        width: 20px;
        height: 20px;
        font-size: 11px;
        line-height: 20px;
        text-align: center;
        transition: .1s linear;
    }
    .tf-tree .tf-child-false:before {
        display: block;
        position: absolute;
        top: -1px;
        left: 0;
        content: url("static/img2/menu-dot.png");
        width: 20px;
        height: 20px;
        font-size: 11px;
        line-height: 20px;
        text-align: center;
    }

</style>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="app-title">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>

    <div class="">
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li> 
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                    <li class="last active"><a href="#">Clinical Guidelines</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="">
    <%@include file="../consultation/clinicalguidelines/views/manageClinicalGuidelines.jsp" %>
</div>
<script>
    breadCrumb();

    $(function () {
        var tree = new treefilter($("#my-trees"), {
            searcher: $("input#my-search"),
            multiselect: false
        });
    });
    
</script>
<script src="static/res/js/jquery.easyui.min.js"></script>
<script src="static/res/js/jquery.treefilter.js"></script>
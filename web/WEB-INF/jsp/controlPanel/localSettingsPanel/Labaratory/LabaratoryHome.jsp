<%-- 
    Document   : LabaratoryHome
    Created on : Aug 31, 2018, 2:01:30 AM
    Author     : HP
--%>
<link rel="stylesheet" type="text/css" href="static/res/css/easyui.css"/>
<link href="static/mainpane/css/hummingbird-treeview.css" rel="stylesheet">
<%@include file="../../../include.jsp" %>
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
    .fontsz{
        font-size: 16px !important;
    }
    .xx{
        margin-left: 1.5em;
    }
</style>
<div class="container-fluid" id="LabTestsmmmainLocalSettings">
    <div class="app-title">
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
                        <li class="last active"><a href="#">Laboratory Setting</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <main id="main">
        <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
        <label class="tabLabels" for="tab1">Laboratory Tests</label>

        <input id="tab2" class="tabCheck" type="radio" name="tabs" onclick=" ajaxSubmitData('locallaboratorysetingmanagement/addmethodTestProcedure.htm', 'addmethodTestProcedurediv', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab2">Method/Test Procedure</label>

        <section class="tabContent" id="content1">
            <div class="tile">
                <div class="tile-body">
                    <fieldset style="min-height:100px;">
                        <div class="row">
                            <div class="col-md-12">
                                <button onclick="addLabTestClassification();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Lab Test Classifications</button>
                            </div>
                        </div>
                        <div style="margin:20px 0;"></div>
                        <div class="easyui-layout" style="width:auto;height:400px;">
                            <div data-options="region:'west',split:true" title="Tests" style="width:300px;"><br>
                                <div class="container" id="searchedTestsClassificationDiv">

                                    <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
                                        <!-- <div id="treeview_container" class="hummingbird-treeview"> -->
                                        <ul id="classificationstreeview" class="hummingbird-base">
                                            <c:forEach items="${labClassificationsList}" var="component">
                                                <li>
                                                    <c:if test="${component.size > 0}"><i class="fa fa-plus"></i></c:if><c:if test="${component.size < 1}"><i class="fa fa-minus"></i></c:if> 
                                                    <label><a href="#!" onclick="viewclassificationlabtests1(${component.labtestclassificationid}, '${component.labtestclassificationname}');">${component.labtestclassificationname}</a></label>
                                                        <c:if test="${component.size > 0}">
                                                        <ul class="xx">
                                                            <c:forEach items="${component.labtestsclassificationsub}" var="component1">
                                                                <li>
                                                                    <i class="fa fa-minus"></i>
                                                                    <label><a href="#!" onclick="viewClassificationLabTests(${component.labtestclassificationid},${component1.labtestclassificationid}, '${component.labtestclassificationname}', '${component1.labtestclassificationname}');">${component1.labtestclassificationname}</a></label>
                                                                </li>  
                                                            </c:forEach>
                                                        </ul> 
                                                    </c:if>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>

                                </div>
                            </div>
                            <div data-options="region:'center',title:'Title',iconCls:'icon-ok'" style="width:985px;"><br>
                                <div id="LabTestsnavigationtab">
                                    <input type="hidden" id="LabTestsclassificationid" class="form-control form-control-sm" style="width: 50%;">
                                    <input type="hidden" id="LabTestsclassificationname" class="form-control form-control-sm" style="width: 50%;">

                                    <input type="hidden" id="LabTestsclassificationSubCategoryid" class="form-control form-control-sm" style="width: 50%;">
                                    <input type="hidden" id="LabTestsclassificationSubCategoryname" class="form-control form-control-sm" style="width: 50%;">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <span style="display: none" id="spanLabTestsClassificationHeading"><b>Classification:&nbsp;<span  title="Edit Of This Classification." onclick="updateLabTestsClassificationDetails();" class="badge badge-secondary icon-custom"><i class="fa fa-edit"></i></span>
                                                    |
                                                    <span onclick="deleteLabTestsClassification();" title="Delete Of This Classification."  class="badge badge-danger icon-custom"><i class="fa fa-remove"></i></span></b></span> <h5 style="display: none" id="displayLabTeststhenavigationspan"><span class="badge badge-secondary"><strong id="theLabTestsnavigationheadfdfgjgdff"></strong></span></h5> 
                                        </div>
                                        <div class="col-md-6">
                                            <span style="display: none" id="spanLabTestsClassificationSubCategoryHeading"><b>Sub Category&nbsp;
                                                </b></span> <h5 style="display: none" id="displayLabTeststCategoryhenavigationspan"><span class="badge badge-secondary"><strong id="theLabTestsnavigationCategoryheadfdfgjgdff"></strong></span></h5> 
                                        </div>
                                    </div>
                                    <hr>
                                </div>
                                <div id="categoryLabTestsDivs"><br><br>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="tile">
                                                <h3 class="tile-title">Classification</h3>
                                                <div class="tile-body">Classifications contain categories then sub categories and finally items.<br>
                                                    Create A classification then categories and finally add items under classification categories.</div>
                                                <div class="tile-footer"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="tile">
                                                <h3 class="tile-title"> Categories</h3>
                                                <div class="tile-body">Categories May contain Sub categories then Items or Items.<br>
                                                    Specialist Medicines under category Items are highlighted with green color.</div>
                                                <div class="tile-footer"></div>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>

        </section>
        <section class="tabContent" id="content2">
            <div class="tile">
                <div class="tile-body">
                    <fieldset style="min-height:100px;">
                        <div class="row">
                            <div class="col-md-12">
                                <button onclick="addmethodTestProcedure();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Add Method/Procedures</button>
                            </div>
                        </div><br><br>
                        <div id="addmethodTestProcedurediv">

                        </div>
                    </fieldset>
                </div>
            </div>
        </section>

    </main>
</div>
<script src="static/res/js/jquery.easyui.min.js"></script>
<script src="static/mainpane/js/hummingbird-treeview.js"></script>
<script>
                                    $("#classificationstreeview").hummingbird();
                                    function addLabTestClassification() {
                                        $.ajax({
                                            type: 'GET',
                                            data: {},
                                            url: "locallaboratorysetingmanagement/addnewlaboratoryclassificationsform.htm",
                                            success: function (data) {
                                                $.confirm({
                                                    title: 'ADD LAB TEST CLASSIFICATION(S).',
                                                    content: '' + data,
                                                    type: 'purple',
                                                    typeAnimated: true,
                                                    boxWidth: '70%',
                                                    useBootstrap: false,
                                                    buttons: {
                                                        tryAgain: {
                                                            text: 'Finish',
                                                            btnClass: 'btn-purple',
                                                            action: function () {
                                                                ajaxSubmitData('locallaboratorysetingmanagement/labTestsClassification.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                            }
                                                        },
                                                        close: function () {
                                                            ajaxSubmitData('locallaboratorysetingmanagement/labTestsClassification.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                        }
                                                    }
                                                });
                                            }
                                        });
                                    }
                                    function viewclassificationlabtests1(labtestclassificationid, labtestclassificationname) {
                                        document.getElementById('LabTestsclassificationid').value = labtestclassificationid;
                                        document.getElementById('LabTestsclassificationname').value = labtestclassificationname;
                                        document.getElementById('spanLabTestsClassificationHeading').style.display = 'block';
                                        document.getElementById('displayLabTeststhenavigationspan').style.display = 'block';
                                        document.getElementById('theLabTestsnavigationheadfdfgjgdff').innerHTML = labtestclassificationname;

                                        document.getElementById('spanLabTestsClassificationSubCategoryHeading').style.display = 'none';
                                        document.getElementById('displayLabTeststCategoryhenavigationspan').style.display = 'none';

                                        ajaxSubmitData('locallaboratorysetingmanagement/laboratoryCategoryTestshome.htm', 'categoryLabTestsDivs', 'labtestclassificationid=' + labtestclassificationid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                    function viewClassificationLabTests(labtestclassificationid, clabtestclassificationid, labtestclassificationname, clabtestclassificationname) {
                                        document.getElementById('LabTestsclassificationid').value = labtestclassificationid;
                                        document.getElementById('LabTestsclassificationname').value = labtestclassificationname;
                                        document.getElementById('spanLabTestsClassificationHeading').style.display = 'block';
                                        document.getElementById('displayLabTeststhenavigationspan').style.display = 'block';
                                        document.getElementById('theLabTestsnavigationheadfdfgjgdff').innerHTML = labtestclassificationname;

                                        document.getElementById('LabTestsclassificationSubCategoryid').value = clabtestclassificationid;
                                        document.getElementById('spanLabTestsClassificationSubCategoryHeading').style.display = 'block';
                                        document.getElementById('displayLabTeststCategoryhenavigationspan').style.display = 'block';
                                        document.getElementById('theLabTestsnavigationCategoryheadfdfgjgdff').innerHTML = clabtestclassificationname;


                                        ajaxSubmitData('locallaboratorysetingmanagement/laboratoryTests.htm', 'categoryLabTestsDivs', 'labtestclassificationid=' + clabtestclassificationid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                                    }
                                    function addmethodTestProcedure() {
                                        $.ajax({
                                            type: 'GET',
                                            data: {},
                                            url: "locallaboratorysetingmanagement/addmethodTestProcedureform.htm",
                                            success: function (data, textStatus, jqXHR) {
                                                $.confirm({
                                                    title: 'ADD TEST METHOD',
                                                    content: '' + data,
                                                    type: 'purple',
                                                    closeIcon: true,
                                                    boxWidth: '70%',
                                                    useBootstrap: false,
                                                    typeAnimated: true,
                                                    buttons: {
                                                        tryAgain: {
                                                            text: 'Save',
                                                            btnClass: 'btn-purple',
                                                            action: function () {
                                                                if (addTestMethods.size > 0) {
                                                                    $.ajax({
                                                                        type: 'POST',
                                                                        data: {methods:JSON.stringify(Array.from(addTestMethods))},
                                                                        url: "locallaboratorysetingmanagement/saveaddmethodTestProcedureform.htm",
                                                                        success: function (data) {
                                                                            ajaxSubmitData('locallaboratorysetingmanagement/addmethodTestProcedure.htm', 'addmethodTestProcedurediv', 'i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                        }
                                                                    });
                                                                }
                                                            }
                                                        },
                                                        close: function () {
                                                        }
                                                    }
                                                });
                                            }
                                        });
                                    }
</script>
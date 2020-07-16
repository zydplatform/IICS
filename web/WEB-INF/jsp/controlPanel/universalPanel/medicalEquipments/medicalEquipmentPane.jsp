<%-- 
    Document   : medicalEquipmentPane
    Created on : Oct 29, 2018, 10:29:46 AM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<div class="container-fluid">
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
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                        <li class="last active"><a href="#">Medical & Non-Medical Equipments</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="row" id="">
        <div class="col-md-12" id="contentminex">
            <main id="main">
                <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                <label class="tabLabels" for="tab1">Medical Equipments</label>
                <input id="tab2" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab2">Non-Medical Equipments</label>
                <section class="tabContent" id="content1">
                    <div>
                        <div class="row user">
                            <div class="col-md-12" id="moreClassificationContent">
                                <div class="row">
                                    <div class="col-md-12" id="BldFac">
                                        <button class="btn btn-primary pull-right" type="button"  id="registerClassification" onclick="registerClassification()" style="float: right"><i class="fa fa-plus-circle"></i>Add Classification</button>
                                    </div>
                                </div>
                                <fieldset>
                                    <%@include file="views/viewClassifications.jsp" %>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                </section>
                <section class="tabContent" id="content2">

                </section>
            </main>
            <!--add classification dialog-->
            <div class="row">
                <div class="col-md-12">
                    <div id="addNewClassification" class="supplierCatalogDialog">
                        <div id="divSection4">
                            <div id="head">
                                <a href="#close" title="Close" class="close2">X</a>
                                <h5 class="modalDialog-title">Add Classification</h5>
                            </div>
                            <div class="row scrollbar" id="addclassificationContent" style="height: 530px;">

                            </div>
                        </div>
                    </div>

                </div>
            </div>
           
        </div>
    </div>
</div>
<script>
    breadCrumb();
    $('#tableviewdonors').DataTable();

    function registerClassification() {
        window.location = '#addNewClassification';
        initDialog('supplierCatalogDialog');
        ajaxSubmitData('medicalandnonmedicalequipment/addNewClassification.htm', 'addclassificationContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }

    $('#tab2').click(function () {
        ajaxSubmitData('medicalandnonmedicalequipment/nonMedicalEquipmentPane.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
</script>
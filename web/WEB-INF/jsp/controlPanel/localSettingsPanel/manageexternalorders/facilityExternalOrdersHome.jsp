<%-- 
    Document   : facilityExternalOrdersHome
    Created on : Aug 16, 2018, 12:42:30 PM
    Author     : RESEARCH
--%>
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
                    <li><a href="#" onclick="ajaxSubmitData('localsettigs/manage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Manage</a></li>
                    <li class="last active"><a href="#">Facility External Order</a></li>

                </ul>
            </div>
        </div>
    </div>
</div>
<div style="margin-top: 6px">
    <main id="main">
        <input id="tab1" class="tabCheck" type="radio" name="tabs" checked onclick="ajaxSubmitData('extordersmanagement/manageFacilityExternalOrders', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab1">External Facility Order</label>

        <input id="tab2" class="tabCheck" type="radio" name="tabs" onclick="ajaxSubmitData('extordersmanagement/approveFacilityExternalOrders', 'approveExtFacOrders', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
        <label class="tabLabels" for="tab2">Approve External Facility Order<span id="noOffacextorders" class="badge badge-patientinfo"></span></label>

        <section class="tabContent" id="content1">
            <div id="">
                <div class="row">
                    <div class="col-md-12">
                        <div >
                            <div class="row">
                                <div class="col-md-12">
                                    <button onclick="addnewfacilityexternalorder();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Add Facility External Order</button>
                                </div>
                            </div>
                            <div style="margin: 10px;">
                                <fieldset style="min-height:100px;">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="tile">
                                                <div class="tile-body">
                                                    <%@include file="views/viewfacilityextorders.jsp" %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </div> 
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div id="addnewfacexternalorder" class="extorderdialog">
                                    <div  style="height: 85% !important; width: 60% !important; ">
                                        <div id="head">
                                            <a href="#close" title="Close" class="close2">X</a>
                                            <h2 class="modalDialog-title">Add New Facility External Order</h2>
                                            <hr>
                                        </div>
                                        <div class="row scrollbar" id="content">
                                            <div class="col-md-12" id="addingExtOrder">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="tabContent" id="content2">
            <div id="">
                <div class="row">
                    <div class="col-md-12">
                        <div >
                            <div id="approveExtFacOrders">
                                <%-- TAB-2 CONTENT--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
</div>

<script>
    jQuery(document).ready(function () {
        breadCrumb();
        $('#procurementtable2').DataTable();
    });

    console.log("fifth");
    function addnewfacilityexternalorder() {
        window.location = '#addnewfacexternalorder';
        initDialog('extorderdialog');
        ajaxSubmitData('extordersmanagement/addnewfacilityexternalorder', 'addingExtOrder', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }

//    function getLastDateOfMonth(Year, Month) {
//        return(new Date((new Date(Year, Month + 1, 1)) - 1));
//    }
</script>
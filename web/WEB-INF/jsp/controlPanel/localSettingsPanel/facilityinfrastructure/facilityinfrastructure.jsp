<%-- 
    Document   : addfacilitybuilding
    Created on : Aug 19, 2019, 10:30:36 AM
    Author     : USER 1
--%>

<%@include file = "../../../include.jsp" %>

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
                        <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Setting</a></li>
                        <li class="last active"><a href="#">Facility Infrastructure</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12" id="contentminex">
            <main id="main">
                <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                <label class="tabLabels" for="tab1">Set-Up infrastructure</label> 
                <section class="tabContent" id="content1">
                    <div>
                        <div class="row user">
                            <div class="col-md-12" id="viewblkrooms">
                                <div class="row">
                                    <div class="col-md-6" id="enterFac">
                                        <div class="form-group">
                                            <input class="form-control" id="facilityid" type="hidden" value="${FacilityLists.facilityid}">
                                            <input class="form-control" id="facilityname" type="hidden" value="${FacilityLists.facilityname}">
                                        </div>
                                    </div>
                                    <div class="col-md-6" id="BldFac">
                                        <button class="btn btn-primary pull-right" type="button"  id="addfacbld"  href="#" style="float: right"><i class="fa fa-plus-circle"></i>Add Building To Facility</button>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="tile">
                                            <div class="tile-body" id="viewblkrooms">
                                                <fieldset id="buildingTableDiv">
                                                    <%@include file="views/facilityinfrastructuretable.jsp" %>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" id="addrmblk">
                                        <div id="addfacilityblds" class="supplierCatalogDialog">
                                            <div>

                                                <div id="divSection1">
                                                    <div id="head">
                                                        <a href="#close" title="Close" class="close2">X</a>
                                                        <h2 class="modalDialog-title">Add Building to Facility</h2>
                                                        <hr>
                                                    </div>
                                                    <div class="row scrollbar" id="content">
                                                        <%@include file="forms/infrastructurebuilding.jsp" %>

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
            </main>
        </div>

    </div>


</div>
<script>
    var facilityid = document.getElementById('facilityid').value;
    if (!(facilityid === 0)) {
        $.ajax({
            type: 'GET',
            url: 'facilityinfrastructure/facilityinfrastructure.htm',
            success: function (res) {
                $('#buildingTableDiv').html(res);
            }
        });

    }
    $(document).ready(function () {
        $('.facilityunitsearch').select2();
        $('.select2').css('width', '100%');

        $('#RoomBlk').hide();

        $('#addfacbld').click(function () {
            window.location = '#addfacilityblds';
            initDialog('supplierCatalogDialog');

        });
    });
</script>                                                 
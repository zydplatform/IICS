<%-- 
    Document   : viewlocationofresources
    Created on : May 15, 2018, 12:16:12 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
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
                        <li class="last active"><a href="#">Resource Locations</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row" id="">
        <div class="col-md-12" id="contentminex">
            <main id="main">
                <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                <label class="tabLabels" for="tab1">Set-Up Locations</label>
                <input id="tab2" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab2">Assign Locations</label>
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
                                                    <%@include file="facilityblocktable.jsp" %>
                                                </fieldset>
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
                                                        <h2 class="modalDialog-title">Add Building(s)</h2>
                                                        <hr>
                                                    </div>
                                                    <div class="row scrollbar" id="content">
                                                        <%@include file="../forms/addfacilitybuilding.jsp" %>

                                                    </div>
                                                </div>
                                                <div id="divSection2" class="hidedisplaycontent">
                                                    <div id="head">
                                                        <a href="#close" title="Close" class="close2">X</a>
                                                        <h2 class="modalDialog-title">Add Block(s) To Building(s)</h2>
                                                        <hr>
                                                    </div>
                                                    <div class="row scrollbar" id="blockcontent">

                                                    </div>                                        
                                                </div>

                                                <div id="divSection5" class="hidedisplaycontent">
                                                    <div id="head">
                                                        <a href="#close" title="Close" class="close2">X</a>
                                                        <h2 class="modalDialog-title">Add Floor(s) To A Block</h2>
                                                        <hr>
                                                    </div>
                                                    <div class="row scrollbar" id="floorblkcontents">

                                                    </div>                                        
                                                </div>

                                                <div id="divSection4" class="hidedisplaycontent">
                                                    <div id="head">
                                                        <a href="#close" title="Close" class="close2">X</a>
                                                        <h2 class="modalDialog-title">Add Room(s) To A Floor</h2>
                                                        <hr>
                                                    </div>
                                                    <div class="row scrollbar" id="roomfloorcontents">

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

                </section>
            </main>
        </div>
    </div>
</div>
<script>

    var facilityid = document.getElementById('facilityid').value;
    if (!(facilityid === 0)) {
        $.ajax({
            type: 'POST',
            url: 'locationofresources/viewbuildingsinfacility.htm',
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
    function editblksz(value) {
        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');

        $('#editfacilityblkid').val(tablerowid);
        $('#editblockname').val(tableData[1]);
        $('#editblkdescription').val(tableData[2]);

        $('#editblk').modal('show');
    }

    $('#tab2').click(function () {
        ajaxSubmitData('allocationoffacilityunits/locationallocationpane.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

    });

</script>

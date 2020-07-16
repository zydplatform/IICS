<%-- 
    Document   : maindesigantionpage
    Created on : Apr 3, 2018, 2:23:27 PM
    Author     : SAMINUNU
--%>

<%@include file="../../../../include.jsp"%>
<style>
    .hide{
        display: none;
    }
    .error
    {
        border:2px solid red;
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
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/configureandmanage.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Local Setting</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('localsettigs/configure.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Configure</a></li>
                    <li class="last active"><a href="#">Designation Categories & Designations</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <main id="main">
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALDESIGNATIONCATEGORYTAB')">
                <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                <label class="tabLabels" for="tab1">Designation Categories</label>
            </security:authorize>
            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_LOCALTRANSFEREDDESIGNATIONTAB')">
                <input id="tab2" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab2">Transferred Designations</label>
            </security:authorize>

            <section class="form-group tabContent" id="content1">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Active Facility:</label>
                            <b>${facilityList.facilityname}</b>
                            <input class="form-control" id="facilityid" type="hidden" value="${facilityList.facilityid}">
                            <input class="form-control" id="facilityname" type="hidden" value="${facilityList.facilityname}">
                        </div>
                    </div>
                </div>
                <div style="margin: 10px;" id="thelocaltable">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-6">
                                <% int s = 1;%>
                                <button class="btn btn-primary" type="button" href="#" onclick="addDesignationCat(this.id);" id="up9<%=s++%>" ><i class="fa fa-fw fa-lg fa-plus-circle"></i>ADD DESIGNATION CATEGORY</button>
                            </div>
                            <div class="col-md-6">
                                <button class="btn btn-primary" type="button" onclick="importDesignation();" id="importdesigna"  href="#" style="float: right"><i class="fa fa-fw fa-lg fa-archive-circle"></i>IMPORT DESIGNATION CATEGORIES</button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12" id="desigCat">
                            <fieldset style="min-height:100px;">
                                <div class="tile">
                                    <div class="tile-body">
                                        <div class="row">
                                            <%@include file="localdesignationtable.jsp" %>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </section>

            <section class="tabContent" id="content2">

            </section>
        </main>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div id="adddesignationscat" class="supplierCatalogDialog">
            <div>
                <div id="divSection1">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h4 class="modalDialog-title">ADD NEW DESIGNATION CATEGORY &nbsp;</h4>
                        <hr>
                    </div>
                    <div class="scrollbar" id="designationcatcontents"> 
                        <div class="col-md-12">

                        </div>
                    </div>
                </div>
                <div id="divSection2" class="hidedisplaycontent">
                    <div id="head">
                        <a href="#close" title="Close" class="close2">X</a>
                        <h2 class="modalDialog-title">ADD DESIGNATIONS &nbsp;</h2>
                        <hr>
                    </div>
                    <div class="row scrollbar" id="designationcontent">
                        <div class="col-md-12">

                        </div>
                    </div>                                        
                </div>
            </div>
        </div>
    </div>
</div>

<div class="col-sm-12">
    <div id="updatedesignations">
        <div class="modal fade col-sm-12" id="updatelocaldesigna" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 150%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;
                        </button>
                    </div>
                    <div class="modal-body">
                        <%@include file="../forms/updatelocaldesignation.jsp" %>
                    </div>
                    <div class="modal-footer">

                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<script>
    breadCrumb();
    $('#samplesTable').DataTable();
    $(document).ready(function () {


    });
    $('#domainimportselect').change(function () {
        var facilitydomainid_domainname = document.getElementById('domainimportselect').value;
        var fields = facilitydomainid_domainname.split('-');
        var facilitydomainid = fields[0];
        ajaxSubmitData('localsettingspostsandactivities/importDesignations.htm', 'importcontents', 'facilitydomainid=' + facilitydomainid + '', 'GET');
    });


    $('#viewpostsearch').click(function () {
        ajaxSubmitData('localsettingspostsandactivities/viewpostdesignationpage.htm', 'localpostsearch', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
    });

    function importDesignation() {
        $.ajax({
            type: "GET",
            cache: false,
            url: "localsettingspostsandactivities/importDesignations.htm",
            success: function (data) {
                $.dialog({
                    title: '<font color="green">' + '<strong class="center">Import Designations' + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
//        window.location = '#importdesignations';
//        initDialog('supplierCatalogDialog');
//
//
//        console.log("---------------------facilitydomainid" + facilitydomainid);
//        ajaxSubmitData('localsettingspostsandactivities/importDesignations.htm', 'importcontents', 'facilitydomainid=' + facilitydomainid + '', 'GET');

    }

    $('#savedesignations').click(function () {
        var validlocaldesignationname = $("#categoryname").val();
        if (validlocaldesignationname === '') {
            $('#categoryname').addClass('error');
            $.alert({
                title: 'Alert!',
                content: ' Please Enter Designation Category Name'
            });
        } else {
            swal({
                title: "Save Designation Category?",
                type: "warning",
                showCancelButton: true,
                confirmButtonText: "Cancel",
                cancelButtonText: "Save",
                closeOnConfirm: true,
                closeOnCancel: false
            },
                    function (isConfirm) {
                        if (isConfirm) {

                            ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                            document.getElementById('categoryname').value = "";
                            document.getElementById('description').value = "";


                        } else {
                            var facilityid = $('#facilitylocalid').val();
                            var categoryname = $('#categoryname').val();
                            var description = $('#description').val();

                            $.ajax({
                                type: "POST",
                                data: {categoryname: categoryname, description: description, facilityid: facilityid},
                                dataType: 'text',
                                url: "localsettingspostsandactivities/savelocaldesignations.htm",
                                success: function (response) {

                                    document.getElementById('categoryname').value = "";
                                    document.getElementById('description').value = "";
                                    $('#adddesigs').modal('hide');
                                    $('.body').removeClass('modal-open');
                                    $('.modal-backdrop').remove();
                                    $('.close').click();
                                    ajaxSubmitData('localsettingspostsandactivities/maindesignationpage.htm', 'workpane', '', 'GET');
                                }
                            });
                            swal("Saved", "Designation Added", "success");
                        }
                    });
        }
    });

    function addDesignationCat(id) {
        var facilityname = $("#facilityname").val();
        var facilityid = $("#facilityid").val();
        console.log("--------------facilityname"+facilityname);
        console.log("--------------facilityid"+facilityid);

        $.ajax({
            type: "GET",
            cache: false,
            url: "localsettingspostsandactivities/addDesignationCategory.htm",
            data: {facilityname: facilityname, facilityid: facilityid},
            success: function (data) {
                $.dialog({
                    title: '<font color="green">' + '<strong class="center">Add Designation Categories' + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '80%',
                    useBootstrap: false,
                    type: 'green',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });

    }

    $('#tab2').click(function () {
        ajaxSubmitData('localsettingspostsandactivities/viewtranferreddesignations.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    });
</script>


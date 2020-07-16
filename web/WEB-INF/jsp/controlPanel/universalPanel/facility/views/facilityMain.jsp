<%--
    Document   : facility_main
    Created on : Mar 22, 2018, 8:09:25 AM
    Author     : Grace-K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div>
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
                        <li class="last active"><a href="#">Facility</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <main id="main">
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_REGISTERFACILITYOWNERSHIP')"> 
                    <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
                    <label class="tabLabels" onclick="ajaxSubmitData('facility/facilityhome', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" for="tab1">Facility Ownership</label>
                </security:authorize>  
                <!--<input id="tab2" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab2">Facility Domain</label>-->

                <!--<input id="tab3" class="tabCheck" type="radio" name="tabs">
                <label class="tabLabels" for="tab3">Register Facility</label>-->

                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SETFACILITYPOLICY')"> 
                    <input id="tab4" class="tabCheck" type="radio" name="tabs">
                    <label class="tabLabels" for="tab4" onClick="ajaxSubmitData('entityPolicySetting.htm', 'descContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Set Facility Policy</label>
                </security:authorize> 
                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_MANAGEFACILITYLEVEL')"> 
                    <input id="tab2" class="tabCheck" type="radio" name="tabs">
                    <label class="tabLabels" for="tab2">Facility Level</label>
                </security:authorize> 


                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_REGISTERFACILITY')">
                    <input id="tab5" class="tabCheck" type="radio" name="tabs" onClick="ajaxSubmitData('domainFacSetting.htm', 'facTabContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    <label class="tabLabels" for="tab5">Register Health Facility</label>
                </security:authorize>



                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasAuthority('PRIVILEGE_SEARCHFACILITIES')">
                    <input id="tab6" class="tabCheck" type="radio" name="tabs" onClick="ajaxSubmitData('domainFacSetting.htm', 'searchTabContent', 'act=a2&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    <label class="tabLabels" for="tab6">Search Facility</label>
                </security:authorize>
                    <section class="tabContent" id="content1">
                    <%-- TAB-1 CONTENT--%>
                    <div class="row">
                        <div class="col-md-12">
                            <button data-toggle="modal" data-target="#addFacilityOwner" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus-circle"></i>Add Facility Owner</button>
                        </div>
                    </div>
                    <div style="margin: 10px;" id="facliltyOwnerContent">
                        <%-- TAB-1 CONTENT--%>
                        <%@include file="../../facility/views/facilityOwnersTabContent.jsp"%>
                    </div>
                </section>

                <section class="tabContent" id="content2">
                    <div class="row">
                        <div class="col-md-12">
                            <button onclick="registerNewFacilityLevel();" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus-circle"></i>Add Facility Level</button>
                        </div>
                    </div>
                    <div style="margin: 10px;" id="facliltyLevelContent">
                        <%-- TAB-2 CONTENT--%>

                    </div>
                </section>

                <section class="tabContent" id="content3">
                    <div style="margin: 10px;" id="registerFacilityContent">
                        <%-- TAB-3 CONTENT--%>

                    </div>
                </section>
                <section class="tabContent" id="content4">
                    <div id="descContent"></div>
                </section>

                <section class="tabContent" id="content5">
                    <div id="facTabContent"></div>
                </section>

                <section class="tabContent" id="content6">
                    <div id="searchTabContent"></div>
                </section>

            </main>
        </div>
    </div>
</div>

<!-- ADD NEW FACILITY OWNER -->
<div class="modal fade col-md-12" id="addFacilityOwner" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Add Facility Owner</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <%@include file="../../facility/forms/addFacilityOwner.jsp"%>
                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="col-md-8 col-md-offset-3">
                                            <button id="saveFacilityOwner" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseFacilityOwner" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
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

<!-- ADD UPDATE FACILITY OWNER -->
<div class="modal fade col-md-12" id="updateFacilityOwner" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Update Facility Owner</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <input type="hidden" id="facilityownerid" value=""/>
                            <div class="tile">
                                <div class="tile-body">
                                    <%@include file="../../facility/forms/updateFacilityOwner.jsp"%>
                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="col-md-8 col-md-offset-3">
                                            <button id="saveUpdateFacilityOwner" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Update</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseFacilityOwnerUpdate" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
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

<!-- ADD NEW FACILITY DOMAIN -->
<div class="modal fade col-md-12" id="addNewFacilityDomain" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Add Facility Domain</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <%@include file="../../facility/forms/addFacilityDomain.jsp"%>
                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="col-md-8 col-md-offset-3">
                                            <button id="saveFacilityDomain" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseFacilityDomain" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
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

<!-- ADD UPDATE FACILITY DOMAIN -->
<div class="modal fade col-md-12" id="updateFacilityDomain" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Update Facility Owner</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <input type="hidden" id="facilitydomainid" value=""/>
                            <div class="tile">
                                <div class="tile-body">
                                    <%@include file="../../facility/forms/updateFacilityDomain.jsp"%>
                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="col-md-8 col-md-offset-3">
                                            <button id="saveUpdateFacilityDomain" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Update</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseFacilityDomainUpdate" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
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

<script>
   
    $(document).ready(function () {
        breadCrumb();
        $('[data-toggle="popover"]').popover();
        $('#saveFacilityOwner').click(function () {
            var ownername = document.getElementById('ownername').value;
            var description = document.getElementById('facilityOwner_description').value;
            if (ownername === null || ownername === '') {
                if (ownername === null || ownername === '') {
                    document.getElementById('ownername').focus();
                }
            } else {
                var ownername = $('#ownername').val();
                var description = $('#facilityOwner_description').val();
                var data = {
                    ownername: ownername,
                    description: description
                };
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "facility/submitfacilityowner.htm",
                    data: data,
                    success: function (response) {
                        if (response != "") {
                            alert(response);
                            document.getElementById('ownername').value = '';
                            document.getElementById('facilityOwner_description').value = '';
                            return false;
                        } else {
                            alert("New Facility Owner Successfully Added!");
                        }
                        document.getElementById('ownername').value = '';
                        document.getElementById('facilityOwner_description').value = '';
                        ajaxSubmitData('facility/facilitywoners.htm', 'facliltyOwnerContent', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                    }
                });
                $('#addFacilityOwner').modal('hide');
            }
        });

        $('#saveUpdateFacilityOwner').click(function () {
            var updateownername = $('#updateownername').val();
            var updatedescription = $('#updatedescription').val();
            var facilityownerid = $('#facilityownerid').val();

            var data = {
                updateownername: updateownername,
                updatedescription: updatedescription,
                facilityownerid: facilityownerid
            };
            $.ajax({
                type: "POST",
                cache: false,
                url: "facility/updatefacilityowner.htm",
                data: data,
                success: function (response) {
                    document.getElementById('updateownername').value = '';
                    document.getElementById('updatedescription').value = '';
                    ajaxSubmitData('facility/facilitywoners.htm', 'facliltyOwnerContent', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                }
            });
            $('#updateFacilityOwner').modal('hide');
        });

        $('#saveFacilityDomain').click(function () {
            var tableRowsNo = document.getElementById("tableFacilityDomain").rows.length;
            var domainname = document.getElementById('domainname').value;
            var description2 = document.getElementById('description2').value;
            if (domainname === null || domainname === '' || description2 === null || description2 === '') {
                if (domainname === null || domainname === '') {
                    document.getElementById('domainname').focus();
                }
                if (description2 === null || description2 === '') {
                    document.getElementById('description2').focus();
                }
            } else {
                var domainname = $('#domainname').val();
                var description2 = $('#description2').val();
                var data = {
                    domainname: domainname,
                    description2: description2
                };
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "facility/submitfacilitydomain.htm",
                    data: data,
                    success: function (newDomainId) {
                        $('#addnew-pane').html(newDomainId);
                        $('#tableFacilityDomain').append(
                                '<tr><td> ' + tableRowsNo + '</td>' +
                                '<td>' + domainname + '</td>' +
                                '<td class="center"><a href="#" onClick=""><font color="blue">Pending</font></a></td>' +
                                '<td class=""><a href="#" onClick=""><font color="blue">Pending</font></a></td>' +
                                '<td class="center">Active</td>' +
                                '<td>' + description2 + '</td>' +
                                '<td>' +
                                '<div>' +
                                '<a href="#"<i class="fa fa-fw fa-lg fa-edit"></i>Update</td>'
                                );
                        document.getElementById('domainname').value = '';
                        document.getElementById('description2').value = '';
                    }
                });
                $('#addNewFacilityDomain').modal('hide');
            }
        });

        $.ajax({
            type: "GET",
            cache: false,
            url: "facility/viewfacilitydomains.htm",
            success: function (page) {
                $('#facliltyDomainContent').html(page);
            }
        });

        $.ajax({
            type: "GET",
            cache: false,
            url: "facility/viewfacilities.htm",
            success: function (page) {
                $('#registerFacilityContent').html(page);
            }
        });

        $('#btnCloseFacilityOwner').click(function () {
            $('#addFacilityOwner').modal('hide');
            $('#saveFacilityOwner').click(null);
        });

        $('#btnCloseFacilityOwnerUpdate').click(function () {
            $('#updateFacilityOwner').modal('hide');
            $('#saveUpdateFacilityOwner').click(null);
        });

        $('#btnCloseFacilityDomain').click(function () {
            $('#addNewFacilityDomain').modal('hide');
            $('#saveFacilityDomain').click(null);
        });
    });

    function updateFacilityOwner(id) {
        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        document.getElementById('facilityownerid').value = tablerowid;
        document.getElementById('updateownername').value = tableData[1];
        document.getElementById('updatedescription').value = tableData[2];
        $('#updateFacilityOwner').modal('show');
    }
    $('#tab2').click(function () {
        ajaxSubmitData('facilitylevelmanagement/facilitylevels.htm', 'facliltyLevelContent', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
    });
    function registerNewFacilityLevel() {
        $.confirm({
            title: 'Register New Facility Level!',
            type: 'purple',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Enter Facility Level Name</label>' +
                    '<input type="text" placeholder="Enter Facility Level name" class="newfacilitylevelname form-control" required />' +
                    '</div>' +
                    '<label>Enter Short Name</label>' +
                    '<input type="text" placeholder="Enter Short name" class="newfacilityLevelshortname form-control" required />' +
                    '</div>' +
                    '<label>Enter More Info</label>' +
                    '<textarea class="newfacilityleveldescription form-control" placeholder="Enter More Info" rows="4"></textarea>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Save',
                    btnClass: 'btn-purple',
                    action: function () {
                        var name = this.$content.find('.newfacilitylevelname').val();
                        var shortname = this.$content.find('.newfacilityLevelshortname').val();
                        var desc = this.$content.find('.newfacilityleveldescription').val();
                        if (!name) {
                            $.alert('provide a valid name');
                            return false;
                        }
                        if (!shortname) {
                            $.alert('provide a valid short name');
                            return false;
                        }
                        if (!desc) {
                            $.alert('provide a valid More Info');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            data: {name: name, shortname: shortname, desc: desc},
                            url: "facilitylevelmanagement/savenewfacilitylevel.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    ajaxSubmitData('facilitylevelmanagement/facilitylevels.htm', 'facliltyLevelContent', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                                } else {
                                    $.confirm({
                                        title: 'Register New Facility Level!',
                                        content: 'Something went Wrong, While Trying To Register Facility Level',
                                        type: 'red',
                                        icon: 'fa fa-warning',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                            }
                                        }
                                    });
                                }
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                },
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });
            }
        });
    }
//    function createshortName(value){
//         var shortname=$('.newfacilityLevelshortname').val();
//      var charact=value.split(' ');  
//      for(i=0;i<charact.length;i++){
//        $('.newfacilityLevelshortname').val(shortname+value.charAt(0));
//      }
//    }
</script>

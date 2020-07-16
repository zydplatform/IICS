<%-- 
    Document   : listLocationTab
    Created on : May 31, 2018, 10:31:28 AM
    Author     : uwera
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
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                    <li class="last active"><a href="#">Manage Location</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<main id="main" >
    <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
    <label class="tabLabels" for="tab1" onClick="ajaxSubmitData('locations/manageLocations.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Region</label>
    <input id="tab2" class="tabCheck" type="radio" name="tabs">
    <label class="tabLabels" for="tab2" onClick="ajaxSubmitData('locations/manageDistrict.htm', 'regionContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">District</label>
    <%--onClick="ajaxSubmitData('locations/manageDistrict.htm', 'regionContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"--%>
   <input id="tab3" class="tabCheck" type="radio" name="tabs">
    <label class="tabLabels" for="tab3" onClick="ajaxSubmitData('locations/manageCounty.htm', 'regionContent', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">County</label>
    
    <input id="tab5" class="tabCheck" type="radio" name="tabs">
    <label class="tabLabels" for="tab5" onClick="ajaxSubmitData('locations/managesubCounty.htm','regionContent','act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Sub County</label>
    
    <input id="tab6" class="tabCheck" type="radio" name="tabs">
    <label class="tabLabels" for="tab6" onClick="ajaxSubmitData('locations/manageParish.htm','regionContent','act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Parish</label>
    
    <input id="tab7" class="tabCheck" type="radio" name="tabs">
    <label class="tabLabels" for="tab7" onClick="ajaxSubmitData('locations/manageVillage.htm','regionContent','act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Village</label>
    
    <input id="tab8" class="tabCheck" type="radio" name="tabs">
    <label class="tabLabels" for="tab8" onclick="ajaxSubmitData('locations/locationsAuditor.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&m=0&ofst=1&maxR=100&sStr=', 'GET');">Location Recovery</label>
    
    
    <%--TAB-1 CONTENT--%>
      <div style="margin: 10px;" id="regionContent">
            <div class="row">
                <div class="col-md-12">
                    <button data-toggle="modal" data-target="#addRegion" class="btn btn-primary pull-right" type="button"><i class="fa fa-fw fa-lg fa-plus-circle"></i>Add Region</button>
                </div>
            </div>
            <%@include file="../../location/view/regionContent.jsp"%>
        </div>
      </main>
    
    <!-- ADD NEW Region -->
    <div class="modal fade col-md-12" id="addRegion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 153%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Add Region</h5>
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
                                        <%@include file="../../location/forms/addRegion.jsp"%>
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <button id="saveRegion" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseRegion" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
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


    <!--  UPDATE Region -->
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
    </div>
  
<script>
    $(document).ready(function () {
        breadCrumb();
        $('[data-toggle="popover"]').popover();
        $('#saveRegion').click(function () {
            var regionname = document.getElementById('regionname').value;
            if (regionname === null || regionname === '') {
                if (regionname === null || regionname === '') {
                    document.getElementById('regionname').focus();
                }
            } else {
                var regionname = $('#regionname').val();
                var data = {
                    regionname,
                };
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "locations/submitregion.htm",
                    data: data,
                    success: function (response) {
                        if(response!=""){
                            alert(response);
                            document.getElementById('regionname').value = '';
                             return false;
                        }else{
                            alert("New Region Successfully Added!");
                        }; 
                        $('#addnew-pane').html(response);
                        $('#tableRegion').append(
                                '<tr><td class="center"><%=y++%></td>' +
                                '<td>' + regionname + '</td>' +
                                //'<td>' + description + '</td>' +
                                '<td class="center">' +
                                '<div>' +
                                '<a href="#"<i class="fa fa-fw fa-lg fa-edit"></i></td>'
                                );
                        document.getElementById('regionname').value = '';
                         ajaxSubmitData('locations/manageLocations.htm', 'workpane', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                    }
                });
                $('#addRegion').modal('hide');
            }
        });

        $('#saveUpdateRegion').click(function () {
            var updateregionname = $('#updateregionname').val();
            //var updatedescription = $('#updatedescription').val();
            var regionid = $('#regionid').val();

            var data = {
                updateregionname,
                //updatedescription: updatedescription,
                regionid,
            };
            $.ajax({
                type: "POST",
                cache: false,
                url: "locations/updateregion.htm",
                data: data,
                success: function (response) {
                    ajaxSubmitData('locations/regions.htm', 'regionContent', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
                }
            });
            $('#updateRegion').modal('hide');
        });

        $('#btnCloseRegion').click(function () {
            $('#addRegion').modal('hide');
            $('#saveRegion').click(null);
        });

        $('#btnCloseRegionUpdate').click(function () {
            $('#updateRegion').modal('hide');
            $('#saveUpdateRegion').click(null);
        });
    });

    function updateRegion(id) {
        var tableData = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        document.getElementById('regionid').value = tablerowid;
        document.getElementById('updateregionname').value = tableData[1];
        //document.getElementById('updatedescription').value = tableData[2];
        $('#updateRegion').modal('show');
    }
</script>
<script src="static/res/js/bootstrap.min.js"></script>
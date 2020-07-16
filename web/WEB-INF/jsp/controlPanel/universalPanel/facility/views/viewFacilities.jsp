<%-- 
    Document   : viewFacilities
    Created on : Mar 29, 2018, 12:03:45 AM
    Author     : Grace-K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<div class="row">
    <div class="col-md-12">
        <p class="pull-right">
            <a class="btn btn-primary icon-btn" href="#registerFacility">
                <i class="fa fa-plus"></i>
                Register Facility
            </a>
        </p>
    </div>
</div>
<fieldset>
    <table class="table table-hover table-bordered" id="facilityTable">
        <thead>
            <tr>
                <th>No</th>
                <th>Facility</th>
                <th>Facility Code</th>
                <th class="center">Status</th>
                <th>Update</th>
            </tr>
        </thead>
        <tbody id="tableFacilities">
            <% int n = 1;%>
            <% int w = 1;%>
            <c:forEach items="${faclilitiesList}" var="facility">
                <tr id="${facility.facilityid}">
                    <td><%=n++%></td>
                    <td>${facility.facilityname}</td>
                    <td>${facility.facilitycode}</td>
                    <td>${facility.status}</td>
                    <td class="center">
                        <a href="#" onclick="updateFacilities(this.id);" id="up90<%=w++%>"><i class="fa fa-fw fa-lg fa-edit"></i></a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</fieldset>

<div class="row">
    <div class="col-md-12">
        <div id="registerFacility" class="modalDialog" style="">
            <div style="height: auto;">
                <a href="#close" title="Close" class="close2">X</a>
                <h4 class="modalDialog-title">Register New Facility</h4>
                <hr>
                <div class="row">
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <h6 class="tile-title">Basic Facility Information</h6>
                                    <div class="tile-body">
                                        <form>
                                            <div class="form-group">
                                                <label class="control-label" for="facilityname">Facility Name</label>
                                                <input class="form-control" id="facilityname" name="facilityname" type="text" placeholder="Facility Name">
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label" for="facilitycode">Facility Code</label>
                                                <input class="form-control" id="facilitycode" type="text" name="facilitycode" placeholder="Facility Code">
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label">Owner</label>
                                                <select class="form-control" id="facilityowner">

                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">Domain</label>
                                                <select class="form-control" id="facility-domains">

                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">Domain Level</label>
                                                <select class="form-control" id="facility-domain-levels">

                                                </select>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <h6 class="tile-title">GPS Information</h6>
                                    <form>

                                        <div class="form-group">
                                            <label class="control-label">District</label>
                                            <select class="form-control" id="district">

                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Village</label>
                                            <input class="form-control" id="village" list="villageList" type="text" placeholder="Village Name">
                                            <datalist id="villageList">

                                            </datalist>
                                        </div>

                                        <div class="form-group">
                                            <label class="control-label">Gps(Northing)</label>
                                            <input class="form-control" id="gpsnorthing" type="text" placeholder="">
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Gps(Easting)</label>
                                            <input class="form-control" id="gpseasting" type="text" placeholder="">
                                        </div>


                                        <div class="float-left" style="margin-top: 7% !important; margin-left: 60%">

                                            <button  style=""class="btn btn-primary" id="saveNewFacility" type="button">
                                                <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                                                Save
                                            </button>
                                            <button class ="btn btn-secondary" type="button" onclick="window.location = '#close'">
                                                <i class="fa fa-fw fa-lg fa-times-circle"></i>
                                                Cancel
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
            
<!-- ADD UPDATE FACILITIES -->           
<div class="modal fade col-md-12" id="updateFacilitiesmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Update Facility</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <input type="hidden" id="facilitiesId" value=""/>
                            <div class="tile">
                                <div class="tile-body">
                                    <%@include file="../../facility/forms/updateFacilities.jsp"%> 
                                </div>
                                <div class="tile-footer">
                                    <div class="row">
                                        <div class="col-md-8 col-md-offset-3">
                                            <button id="saveUpdateFacility" class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Update</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseFacilityUpdate" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
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
function updateFacilities(id) {
        var tableData3 = $('#' + id).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + id).closest('tr').attr('id');
        document.getElementById('facilitiesId').value = tablerowid;
        document.getElementById('updatedfacilityname').value = tableData3[1];
        document.getElementById('updatedshortname').value = tableData3[2];
        document.getElementById('updatedfacilitystatus').value = tableData3[3];
        $('#updateFacilitiesmodal').modal('show');
    }
    
    $('#btnCloseFacilityUpdate').click(function () {
        $('#updateFacilitiesmodal').modal('hide');
        $('#saveUpdateFacility').click(null);
    });
    
    $('#saveUpdateFacility').click(function () {
        var updatedfacilityname = $('#updatedfacilityname').val();
        var updatedshortname = $('#updatedshortname').val();
        var facilitiesId = $('#facilitiesId').val();

        var data = {
            updatedfacilityname: updatedfacilityname,
            updatedshortname: updatedshortname,
            facilitiesId: facilitiesId
        };
        $.ajax({
            type: "POST",
            cache: false,
            url: "facility/updatefacility.htm",
            data: data,
            success: function (response) {
                ajaxSubmitData('facility/viewfacilities.htm', 'registerFacilityContent', 'act=a&sn=&i=0&c=0&a=n&st=&d=&offset=1&maxResults=100&vsearch=', 'GET');
            }
        });
        $('#updateFacilitiesmodal').modal('hide');
    });
    
    $(document).ready(function () {
        $('#facilityTable').DataTable();
        
        
        $.ajax({
            type: 'POST',
            url: 'locations/fetchDistricts.htm',
            success: function (data) {
                var res = JSON.parse(data);
                if (res !== '' && res.length > 0) {
                    for (i in res) {
                        $('#district').append('<option id="dis' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                    }
                    var districtid = parseInt($('#district').val());
                    $.ajax({
                        type: 'POST',
                        url: 'locations/fetchDistrictVillages.htm',
                        data: {districtid: districtid},
                        success: function (data) {
                            var res = JSON.parse(data);
                            if (res !== '' && res.length > 0) {
                                for (i in res) {
                                    $('#villageList').append('<option class="classvillage" data-id="' + res[i].id + '"  value="' + res[i].village + '">' + res[i].subcounty + '</option>');
                                }
                            }
                        }
                    });
                }
            }
        });
        $('#district').change(function () {
            $('#villageList').html('');
            var districtid = parseInt($('#district').val());
            $.ajax({
                type: 'POST',
                url: 'locations/fetchDistrictVillages.htm',
                data: {districtid: districtid},
                success: function (data) {
                    var res = JSON.parse(data);
                    if (res !== '' && res.length > 0) {
                        for (i in res) {
                            $('#villageList').append('<option class="classvillage" data-id="' + res[i].id + '" value="' + res[i].village + '">' + res[i].subcounty + '</option>');
                        }
                    }
                }
            });
        });

        //Facility Owners
        $.ajax({
            type: 'POST',
            url: 'facility/fetchfaclilityowners.htm',
            success: function (data) {
                var res = JSON.parse(data);
                if (res !== '' && res.length > 0) {
                    for (i in res) {
                        $('#facilityowner').append('<option id="own' + res[i].id + '" data-ownername="' + res[i].ownername + '" value="' + res[i].id + '">' + res[i].ownername + '</option>');
                    }
                }
            }
        });

        //Fetch Domains and Levels in selected Domain
        $.ajax({
            type: 'POST',
            url: 'facility/fetchfaclilitydomains.htm',
            success: function (data) {
                var res = JSON.parse(data);
                console.log(res);
                if (res !== '' && res.length > 0) {
                    for (i in res) {
                        $('#facility-domains').append('<option id="dom' + res[i].id + '" data-name="' + res[i].domainname + '" value="' + res[i].id + '">' + res[i].domainname + '</option>');
                    }
                    var domainid1 = parseInt($('#facility-domains').val());
                    $.ajax({
                        type: 'POST',
                        url: 'facility/fetchdomainlevels.htm',
                        data: {domainid: domainid1},
                        success: function (data) {
                            var res = JSON.parse(data);
                            if (res !== '' && res.length > 0) {
                                for (i in res) {
                                    $('#facility-domain-levels').append('<option class="classfacilitylevels" data-id="' + res[i].id + '" value="' + res[i].facilitylevelname + '">' + res[i].shortname + '</option>');
                                }
                            }
                        }
                    });
                }
            }
        });

        $('#facility-domains').change(function () {
            $('#facility-domain-levels').html('');
            var domainid = parseInt($('#facility-domains').val());
            $.ajax({
                type: 'POST',
                url: 'facility/fetchdomainlevels.htm',
                data: {domainid: domainid},
                success: function (data) {
                    var res = JSON.parse(data);
                    if (res !== '' && res.length > 0) {
                        for (i in res) {
                            $('#facility-domain-levels').append('<option class="classfacilitylevels" data-id="' + res[i].id + '" value="' + res[i].facilitylevelname + '">' + res[i].shortname + '</option>');
                        }
                    }
                }
            });
        });

        $('#saveNewFacility').click(function () {
            var facilityname = document.getElementById('facilityname').value;
            var facilitycode = document.getElementById('facilitycode').value;
            if (facilityname === null || facilityname === '' || facilitycode === null || facilitycode === '') {
                if (facilityname === null || facilityname === '') {
                    document.getElementById('facilityname').focus();
                }
                if (facilitycode === null || facilitycode === '') {
                    document.getElementById('facilitycode').focus();
                }
            } else {
                var facilityname = $('#facilityname').val();
                var facilitycode = $('#facilitycode').val();
                var facilityowner = $('#facilityowner').val();
                var facilitydomains = $('#facility-domains').val();
                var facilitydomainlevels = $('.classfacilitylevels').data('id');
                var district = $('#district').val();
                var village = $('.classvillage').data('id');
                var data = {
                    facilityname: facilityname,
                    facilitycode: facilitycode,
                    facilityowner: facilityowner,
                    facilitydomains: facilitydomains,
                    facilitydomainlevels: facilitydomainlevels,
                    district: district,
                    village: village
                };
                console.log(data);
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "facility/submitnewfacility.htm",
                    data: data,
                    success: function (rep) {
                        $('#tableFacilities').append(
                                '<tr><td><%=n++%></td>' +
                                '<td>'+facilityname + '</td>' +
                                '<td>'+ facilitycode + '</td>' +
                                '<td>APPROVED</td>' +
                                '<td class="center"><a href="#">' +
                                '<i class="fa fa-fw fa-lg fa-edit"></i></a></td></tr>'
                                );
                        document.getElementById('facilityname').value = '';
                        document.getElementById('facilitycode').value = '';
                        document.getElementById('village').value = '';
                        document.getElementById('gpsnorthing').value = '';
                        document.getElementById('gpseasting').value = '';
                    }
                });
            }
        });
    });
</script>
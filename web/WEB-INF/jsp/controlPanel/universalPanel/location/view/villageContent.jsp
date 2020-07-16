<%-- 
    Document   : villageContent
    Created on : Jun 24, 2018, 12:19:27 PM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="static/mainpane/css/autoCompleteDropList.css">
<br>
<div class="box-title" align="center">
    <h3>
        <i class="fa fa-home"></i>
       Manage Villages [${model.totalVillages}]
    </h3>
</div>
<br>
    <div class="row">
        <div class="col-md-12">
            <p class="pull-left">
            <div class="row">

                <div class="form-group">
                <select class="form-control" name="region" id="regionidlist" onChange="clearDiv('villagePane'); ajaxSubmitData('locations/manageVillage.htm', 'districtPane', 'act=b&i=' + this.value + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
                    <option value="0">--Select Region--</option>
                    <c:forEach items="${model.regionsList}" var="regions">
                        <option <c:if test="${model.regionid==regions.regionid}">selected</c:if> value="${regions.regionid}">${regions.regionname} </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group" id="districtPane">
                <select class="form-control" name="district" id="districtlist" onChange="clearDiv('villagePane'); ajaxSubmitData('locations/manageVillage.htm', 'countyPane', 'act=b&i=' + this.value + '&b=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
                    <option value="0">--Select District--</option>
                    <c:forEach items="${model.districtList}" var="distr">
                        <option <c:if test="${model.districtid==distr.districtid}">selected</c:if> value="${distr.districtid}">${distr.districtname} </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group" id="countyPane">
                <select class="form-control" name="county" id="countylist" onChange="clearDiv('villagePane'); ajaxSubmitData('locations/manageVillage.htm', 'subcountyPane', 'act=b&i=' + this.value + '&b=c&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
                    <option value="0">--Select County--</option>
                    <c:forEach items="${model.countyList}" var="count">
                        <option <c:if test="${model.countyid==count.countyid}">selected</c:if> value="${count.countyid}">${count.countyname} </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group" id="subcountyPane">
                <select class="form-control" name="subcounty" id="subcountylist" onChange="clearDiv('villagePane'); ajaxSubmitData('locations/manageVillage.htm', 'parishPane', 'act=b&i=' + this.value + '&b=d&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
                    <option value="0">--Select Sub-County--</option>
                    <c:forEach items="${model.subCountyList}" var="count">
                        <option <c:if test="${model.subcountyid==count.subcountyid}">selected</c:if> value="${count.subcountyid}">${count.subcountyname} </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group" id="parishPane">
                <select class="form-control" name="parish" id="parishlist" onChange="clearDiv('villagePane'); ajaxSubmitData('locations/manageVillage.htm', 'villagePane', 'act=b&i=' + this.value + '&b=e&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
                    <option value="0">--Select Parish--</option>
                    <c:forEach items="${model.parishList}" var="count">
                        <option <c:if test="${model.parishid==count.parishid}">selected</c:if> value="${count.parishid}">${count.parishname} </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <form id="search-form_3" action="" method="">
                    <input type="hidden" id="fsearchTerm" value="n"/>
                    <input id="fSearchId" placeholder="Type Village Name" type="text" class="search_3" style="border-radius: 35px !important;" oninput="clearDiv('villagePane'); funSearchLocationByTerm()"/>
                </form>
            </div>
                <div class="searchResults" id="fsearchResults">
                    <div class="loadergif" id="floadergif">
                        <img id="gif" src="static/images/load.gif"/>
                    </div>
                    <div class="panel-body">
                        <ul class="list-group" id="fsearchList"></ul>
                    </div>
                </div>
                <div class="col-md-2" >
                    <a class="btn btn-primary icon-btn" href="#" data-toggle="modal" data-target="#addUpdateVillage" onClick="funSetLocationVals('add',0); showDiv('addVillagePane'); hideDiv('villageResponse');">
                        <i class="fa fa-plus"></i>
                        Add New Village
                    </a>
                </div>
            </div>

        </div>

    </div>

<div class="row" id="villagePane">
    <fieldset style="width: 100%"><legend>Villages Under Parish: ${model.parishObj.parishname} [Villages: ${model.size}]</legend>
        <div id="response-pane"></div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                            <thead>
                                <tr>
                                    <th class="center">No</th>
                                    <th>Village Name</th>
                                    <th>Parish Name</th>
                                    <th>Sub County Name</th>
                                    <th>County Name</th>
                                    <th>District Name </th>
                                    <th>Region Name </th>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEVILLAGE') or hasRole('PRIVILEGE_DELETEVILLAGE')"></security:authorize>
                                        <th class="center">Manage</th>

                                    </tr>
                                </thead>
                                <tbody id="tableDesc">
                                <c:set var="count" value="1"/>
                                <c:set var="No" value="0" />
                                <c:forEach items="${model.villageList}" var="list" varStatus="status">
                                    <c:choose>
                                        <c:when test="${status.count % 2 != 0}">
                                            <tr>
                                            </c:when>
                                            <c:otherwise>
                                            <tr bgcolor="white">
                                            </c:otherwise>
                                        </c:choose>
                                        <td>${status.count}</td>
                                        <td align="left">${list[1]}</td> 
                                        <td align="left">${list[2]}</td>
                                        <td align="left">${list[3]}</td>
                                        <td align="left">${list[4]}</td>
                                        <td align="left">${list[5]}</td>
                                        <td align="left">${list[6]}</td>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEVILLAGE') or hasRole('PRIVILEGE_DELETEVILLAGE')"></security:authorize>
                                            <td class="center">
                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEVILLAGE')"></security:authorize>
                                            <a href="#" title="Update Parish" onclick="ajaxSubmitData('locations/addOrUpdateVillage.htm', 'response-pane', {vID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                            &nbsp;

                                            <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEVILLAGE')"> </security:authorize>
                                                <a href="#" title="View Attachments/Discard Village" onclick="
                                                        ajaxSubmitData('locations/manageSelectedLoc.htm', 'response-pane', {id: '${list[0]}', act: 'v', st: 'a', v2: '0'}, 'GET');"><i class="fa fa-fw fa-lg fa-book"></i></a>
                                             <!--   <a href="#" title="Discard Village" onclick="var resp = confirm('Are you sure you want to delete village:: ${list[1]}!');
                                                   if (resp === false) {
                                                       return false;
                                                   }
                                                   ajaxSubmitData('locations/deleteVillage.htm', 'response-pane', 'act=a&vID=${list[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-times"></i></a>-->

                                        </td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="row" id="addNew"></div>
                    </div>
                </div>
            </div>
        </div>

    </fieldset> 
</div>
</div>
<!-- ADD NEW / UPDATE Village FORM -->
<div class="modal fade col-md-12" id="addUpdateVillage" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 150%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Add/Update Village</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container" id="addVillagePane">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <form class="form-horizontal" id="manageFormField" name="manageFormField">
                                    <div class="tile-body">

                                        <div class="form-group row">
                                            <label class="control-label col-md-4" for="region">Region Name:</label>
                                            <div class="col-md-8">
                                                <input class="form-control col-md-8" type="text" readonly="readonly" id="rname" name="rname" placeholder="Region Name">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-4" for="district">District Name:</label>
                                            <div class="col-md-8">
                                                <input class="form-control col-md-8" type="text" readonly="readonly" id="dname" name="dname" placeholder="District Name">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-4" for="county">County Name:</label>
                                            <div class="col-md-8">
                                                <input class="form-control col-md-8" type="text" readonly="readonly" id="cname" name="cname" placeholder="County Name">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-4" for="subcounty">Sub-County Name:</label>
                                            <div class="col-md-8">
                                              <input class="form-control col-md-8" type="text" readonly="readonly" id="scname" name="scname" placeholder="Sub County Name">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-4" for="parish">Parish Name:</label>
                                            <div class="col-md-8">
                                                <input type="hidden" id="parentId" name="parent" value=""/>
                                                <input class="form-control col-md-8" type="text" readonly="readonly" id="pname" name="pname" placeholder="Parish Name">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-4" for="parish">Village:</label>
                                            <div class="col-md-8">
                                                <input class="form-control col-md-8" type="text" id="vname" name="vname" placeholder="Village Name">
                                            </div>
                                        </div>

                                    </div>
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div>
                                                <input type="hidden" name="cref" id="cref"/>
                                                <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                                <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                            </div>
                                            <div class="col-md-8 col-md-offset-3">
                                                <button id="saveVillage" class="btn btn-primary" type="button" onClick="var vilName=$('#vname').val(); if(vilName===null || vilName===''){$('#vname').focus(); $('#vname').css('border', '2px solid #f50808c4'); return false;} $('#vname').css('border', '2px solid #ced4da'); ajaxSubmitData('locations/saveOrUpdateVillage.htm', 'villageResponse', $('#manageFormField').serialize(), 'POST');"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseFacilityOwner" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
                                            </div>
                                        </div>
                                    </div>
                                </form>        
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container" id="villageResponse"></div>
            </div>
        </div>
    </div>
</div>
</div>
<script>
    $(document).ready(function () {
        $('#discardPane').modal('show');
        $('#sampleTable').DataTable();
    });

    function funSetLocationVals(activity,count){
        if(activity=='add'){
            var region=$("#regionidlist option:selected").text();
            $('#rname').val(region);
            var district=$("#districtlist option:selected").text();
            $('#dname').val(district);
            var county=$("#countylist option:selected").text();
            $('#cname').val(county);
            var subcounty=$("#subcountylist option:selected").text();
            $('#scname').val(subcounty);
            var parish=$("#parishlist option:selected").text();
            $('#pname').val(parish);
            var parishid=$("#parishlist").val();
            $('#parentId').val(parishid);
            $("#saveVillage").html('Save New Village');
            $('#formActivity').val("Save");
        }
        if(activity=='update'){
            var region=$("#regionidlist option:selected").text();
            $('#rname').val(region);
            var district=$("#districtlist option:selected").text();
            $('#dname').val(district);
            var county=$("#countylist option:selected").text();
            $('#cname').val(county);
            var subcounty=$("#subcountylist option:selected").text();
            $('#scname').val(subcounty);
            var parish=$("#parishlist option:selected").text();
            $('#pname').val(parish);
            var parishid=$("#parishlist").val();
            $('#parentId').val(parishid);
           
            var villageName=$("#villageName"+count+"").val();
            $('#vname').val(villageName);
            $("#saveVillage").html('Update Village');
            $('#formActivity').val("Update");
        }
    }

   function trim2(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    function funSearchLocationByTerm() {
        $('#fsearchList').html('');
        var searchTerm = $('#fsearchTerm').val();
        var searchValue = trim2($('#fSearchId').val());
        var size = searchValue.length;
        if (searchTerm === '0') {
            $('#fSearchId').val('');
            //document.getElementById('fsearchList').innerHTML  = "Select Search Term!";
            //$("#fsearchResults").text("Select Search Term!");
        }
        if (size <= 0) {
            document.getElementById('fsearchResults').style.display = 'none';
        } else if (size > 0) {
            document.getElementById('floadergif').style.display = 'block';
            document.getElementById('fsearchResults').style.display = 'block';
            $.ajax({
                type: "POST",
                cache: false,
                url: "locations/quickSearchLocationByTerm.htm",
                data_type: 'JSON',
                data: {sTerm: searchTerm, sVal: searchValue},
                success: function (response) {
                    document.getElementById('floadergif').style.display = 'none';
                    if (!(response === '' || response === '[]')) {
                        document.getElementById('fsearchList').style.display = 'block';
                        var result = JSON.parse(response);
                        var url = 'locations/getSearchedLocation.htm';
                        var div = 'villagePane';
                        var vals = 'act=' + searchTerm + '&b=${model.b}&c=${model.a}&d=0&ofst=1&maxR=100&sStr=';
                        var method = 'GET';
                        if (searchTerm === 'n') {
                            for (index in result) {
                                var id = result[index].id;
                                $('#fsearchList').append(
                                        '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                        '' +
                                        '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                        '<a href="#">' + result[index].name + '</a> [Parish: ' + result[index].parish + ']' +
                                        '<div class="mic-info">' +
                                        'Sub-County: ' + result[index].subcounty + '</div>' +
                                        'County: ' + result[index].county + '</div>' +
                                        'District: ' + result[index].district + '</div>' +
                                        'Region: ' + result[index].region + '</div>' +
                                        '</div></div></div></li>'
                                        );
                            }
                        }
                    } else {
                        if (searchTerm === 'n') {
                            $('#fsearchList').append('No Results Found For Locations With Name Like: <strong>' + searchValue + ' ${model.title}</strong>');
                        }

                    }
                }
            });

        }
    }
    function clearSearchResult2() {
        document.getElementById('fsearchResults').style.display = 'none';
    }

</script>
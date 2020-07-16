<%-- 
    Document   : parishContent
    Created on : Jun 23, 2018, 10:02:23 AM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="static/mainpane/css/autoCompleteDropList.css">
<br>
<div class="box-title" align="center">
    <h3>
        <i class="fa fa-home"></i>
        Manage Parishes [${model.totalParishes}]
    </h3>
</div>
<br>
    <div class="row">
        <div class="col-md-12">
            <p class="pull-left">
            <div class="row">

                <div class="form-group">
                    <select class="form-control" name="region" id="regionidlist" onChange="clearDiv('parishPane'); ajaxSubmitData('locations/manageParish.htm', 'districtPane', 'act=b&i=' + this.value + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
                        <option value="0">--Select Region--</option>
                        <c:forEach items="${model.regionsList}" var="regions">
                            <option <c:if test="${model.regionid==regions.regionid}">selected</c:if> value="${regions.regionid}">${regions.regionname} </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group" id="districtPane">
                    <select class="form-control" name="district" id="districtlist" onChange="clearDiv('parishPane'); ajaxSubmitData('locations/manageParish.htm', 'countyPane', 'act=b&i=' + this.value + '&b=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
                        <option value="0">--Select District--</option>
                        <c:forEach items="${model.districtList}" var="distr">
                            <option <c:if test="${model.districtid==distr.districtid}">selected</c:if> value="${distr.districtid}">${distr.districtname} </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group" id="countyPane">
                    <select class="form-control" name="county" id="countylist" onChange="clearDiv('parishPane'); ajaxSubmitData('locations/manageParish.htm', 'subcountyPane', 'act=b&i=' + this.value + '&b=c&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
                        <option value="0">--Select County--</option>
                        <c:forEach items="${model.countyList}" var="count">
                            <option <c:if test="${model.countyid==count.countyid}">selected</c:if> value="${count.countyid}">${count.countyname} </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group" id="subcountyPane">
                    <select class="form-control" name="subcounty" id="subcountylist" onChange="clearDiv('parishPane'); ajaxSubmitData('locations/manageParish.htm', 'parishPane', 'act=b&i=' + this.value + '&b=d&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
                        <option value="0">--Select Sub-County--</option>
                        <c:forEach items="${model.subCountyList}" var="count">
                            <option <c:if test="${model.subcountyid==count.subcountyid}">selected</c:if> value="${count.subcountyid}">${count.subcountyname} </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <form id="search-form_3" action="" method="">
                        <input type="hidden" id="fsearchTerm" value="g"/>
                        <input id="fSearchId" placeholder="Type Parish Name" type="text" class="search_3" style="border-radius: 35px !important;" oninput="clearDiv('parishPane'); funSearchLocationByTerm()"/>
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
                    <a class="btn btn-primary icon-btn" href="#" data-toggle="modal" data-target="#addUpdateParish" onClick="funSetLocationVals('add',0);showDiv('addParishPane'); hideDiv('parishResponse');">
                        <i class="fa fa-plus"></i>
                        Add New Parish
                    </a>
                </div>
            </div>

        </div>

    </div>

<div class="row" id="parishPane">
    <fieldset style="width: 99%"><legend>Parishes Under Sub-County: ${model.subCountyObj.subcountyname} [Parishes: ${model.size}]</legend>
        <div id="response-pane"></div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                            <thead>
                                <tr>
                                    <th class="center">No</th>
                                    <th>Parish Name</th>
                                    <th>Sub County Name</th>
                                    <th>County Name</th>
                                    <th>District Name </th>
                                    <th>Region Name </th>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEPARISH') or hasRole('PRIVILEGE_DELETEPARISH')">
                                        <th class="center">Manage</th>
                                         </security:authorize>
                                    </tr>
                                </thead>
                                <tbody id="tableDesc">
                                <c:set var="count" value="1"/>
                                <c:set var="No" value="0" />
                                <c:forEach items="${model.parishList}" var="list" varStatus="status">
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
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEPARISH') or hasRole('PRIVILEGE_DELETEPARISH')">
                                            <td class="center">
                                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_UPDATEPARISH')">
                                                   <!-- <a href="#" title="Update Parish" data-toggle="modal" data-target="#addUpdateParish" onclick="funSetLocationVals('update',${status.count});" ><i class="fa fa-fw fa-lg fa-edit"></i></a>-->
                                                    &nbsp;
                                                   <a href="#" title="Update Parish" onclick="ajaxSubmitData('locations/addOrUpdateParish.htm', 'response-pane', {pID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                                </security:authorize>
                                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEPARISH')">
                                                    <a href="#" title="View Attachments/Discard Parish" onclick="
                                                    ajaxSubmitData('locations/manageSelectedLoc.htm', 'response-pane', {id:'${list[0]}',act:'p',st:'a',v2:'0'}, 'GET');"><i class="fa fa-fw fa-lg fa-book"></i></a>
                                                    <!-- ajaxSubmitData('locations/deleteParish.htm', 'response-pane', 'act=a&id=${list[0]}', 'GET'); -->
                                                    </security:authorize>
                                            </td>
                                        </security:authorize>
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
<!-- ADD NEW / UPDATE PARISH FORM -->
<div class="modal fade col-md-12" id="addUpdateParish" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Add/Update Parish</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container" id="addParishPane">
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
                                                <input class="form-control col-md-8" type="text" readonly="readonly" id="scname" name="scname" placeholder="Sub-County Name">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-4" for="parish">Parish:</label>
                                            <div class="col-md-8">
                                              <input type="hidden" id="parentId" name="parent" value=""/>
                                                <input class="form-control col-md-8" type="text" id="pname" name="pname" placeholder="Parish Name">
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
                                                <button id="saveParish" class="btn btn-primary" type="button" onClick="var parName=$('#pname').val(); if(parName===null || parName===''){$('#pname').focus(); $('#pname').css('border', '2px solid #f50808c4'); return false;} $('#pname').css('border', '2px solid #ced4da');ajaxSubmitData('locations/saveOrUpdateParish.htm', 'parishResponse', $('#manageFormField').serialize(), 'POST');"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save</button>&nbsp;&nbsp;&nbsp;<a id="btnCloseFacilityOwner" class="btn btn-secondary" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cancel</a>
                                            </div>
                                        </div>
                                    </div>
                                </form>        
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container" id="parishResponse"></div>
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
            var subcountyid=$("#subcountylist").val();
            $('#parentId').val(subcountyid);
            $("#saveParish").html('Save New Parish');
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
            var subcountyid=$("#subcountylist").val();
            $('#parentId').val(subcountyid); //parishName
            var parishName=$("#parishName"+count+"").val();
            $('#pname').val(parishName);
            $("#saveParish").html('Update Parish');
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
                        var div = 'parishPane';
                        var vals = 'act=' + searchTerm + '&b=${model.b}&c=${model.a}&d=0&ofst=1&maxR=100&sStr=';
                        var method = 'GET';
                        if (searchTerm === 'g') {
                            for (index in result) {
                                var id = result[index].id;
                                $('#fsearchList').append(
                                        '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                        '' +
                                        '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                        '<a href="#">' + result[index].name + '</a> [Sub-County:' + result[index].subcounty + ']' +
                                        '<div class="mic-info">' +
                                        'County: ' + result[index].county + '</div>' +
                                        'District: ' + result[index].district + '</div>' +
                                        'Region: ' + result[index].region + '</div>' +
                                        '</div></div></div></li>'
                                        );
                            }
                        }
                    } else {
                        if (searchTerm === 'g') {
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
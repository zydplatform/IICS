<%-- 
    Document   : countyContet
    Created on : Jun 4, 2018, 11:09:31 AM
    Author     : Uwera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="static/mainpane/css/autoCompleteDropList.css">

<div class="box-title" align="center">
    <h3>
        <i class="fa fa-home"></i>
        Manage Counties [${model.totalCounties}] 
    </h3>
</div>
    <br>
<div class="row">
    <div class="col-md-12">
        <p class="pull-left">
        <div class="row">
            <div class="col-md-2">
                <div class="form-group">
                    <select class="form-control" name="regionid" id="regionidlist" onChange="ajaxSubmitData('locations/loadLocationVals.htm', 'districtPane', {locID: $(this).val(), act: 1}, 'GET');">                                                         
                        <option value="0">--Select Region--</option>
                        <c:forEach items="${model.regionsList}" var="regions">
                            <option <c:if test="${model.regionid==regions.regionid}">selected</c:if> value="${regions.regionid}">${regions.regionname} </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group" id="districtPane">
                    <select class="form-control" name="regionid" id="regionidlist" onChange="ajaxSubmitData('locations/getSearchedLocation.htm', 'countyPane', 'act=a&i='+this.value+'&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">                                                         
                        <option value="0">--Select District--</option>
                        <c:forEach items="${model.districtList}" var="distr">
                            <option <c:if test="${model.districtid==distr.districtid}">selected</c:if> value="${distr.districtid}">${distr.districtname} </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <form id="search-form_3" action="" method="">
                        <input type="hidden" id="fsearchTerm" value="e"/>
                        <input id="fSearchId" placeholder="Type County Name" type="text" class="search_3" style="border-radius: 35px !important;" oninput="funSearchLocationByTerm()"/>
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
            </div>
            <div class="col-md-2">
                <a class="btn btn-primary icon-btn" href="#" onClick="ajaxSubmitData('locations/addOrUpdateCounty.htm', 'response-pane', {cID: '0', act: 'add'}, 'GET');">
                    <i class="fa fa-plus"></i>
                    Add New County
                </a>
            </div>
        </div>
        </p>

    </div>

</div>

<div class="row" id="countyPane">
    <fieldset style="width: 99%"><legend></legend>  <%--${model.title}--%>
        <div id="response-pane"></div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered col-md-12" id="sampleTable">
                            <thead>
                                <tr>
                                    <th class="center">No</th>
                                    <th>County Name</th>
                                    <th>District Name </th>
                                    <th>Region Name </th>
                                        <security:authorize access="hasRole('PRIVILEGE_UPDATECOUNTY') or hasRole('PRIVILEGE_DELETECOUNTY')"> </security:authorize>
                                        <th class="center">Manage</th>
                                    </tr>
                                </thead>
                                <tbody id="tableDesc">
                                <c:set var="count" value="1"/>
                                <c:set var="No" value="0" />
                                <c:forEach items="${model.countyList}" var="list" varStatus="status">
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

                                      <td class="center">
                                            <a href="#" title="Update County" onclick="ajaxSubmitData('locations/addOrUpdateCounty.htm', 'response-pane', {cID: '${list[0]}', act: 'update'}, 'GET');" ><i class="fa fa-fw fa-lg fa-edit"></i></a>
                                            &nbsp;
                                                <a href="#" title="View Attachments/Discard County" onclick="
                                                    ajaxSubmitData('locations/manageSelectedLoc.htm', 'response-pane', {id:'${list[0]}',act:'c',st:'a',v2:'0'}, 'GET');"><i class="fa fa-fw fa-lg fa-book"></i></a>
                                          <!-- <a href="#" title="Discard County" onclick="var resp = confirm('Are you sure you want to delete County:: ${list[1]}!');
                                                    if (resp === false) {
                                                        return false;
                                                    }                                                          
                                                    ajaxSubmitData('locations/deleteCounty.htm', 'response-pane', 'act=a&id=${list[0]}', 'GET');"><i class="fa fa-fw fa-lg fa-times"></i></a>-->
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
<script>
    $(document).ready(function () {
        $('#discardPane').modal('show');
        $('#sampleTable').DataTable();
    });

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
                        var div = 'countyPane';
                        var vals = 'act=' + searchTerm + '&b=${model.b}&c=${model.a}&d=0&ofst=1&maxR=100&sStr=';
                        var method = 'GET';
                        if (searchTerm === 'e') {
                            for (index in result) {
                                var id = result[index].id;
                                $('#fsearchList').append(
                                        '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                        '' +
                                        '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                        '<a href="#">' + result[index].name + '</a> [District:' + result[index].district + ']' +
                                        '<div class="mic-info">' +
                                        'Region: ' + result[index].region + '</div>' +
                                        '</div></div></div></li>'
                                        );
                            }
                        }
                    } else {
                        if (searchTerm === 'b') {
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

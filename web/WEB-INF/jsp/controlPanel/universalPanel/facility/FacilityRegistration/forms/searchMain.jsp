<%-- 
    Document   : searchMain
    Created on : Apr 12, 2018, 15:14:17 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="static/mainpane/css/autoCompleteDropList.css">

<br>
<div class="box box-color box-bordered">    
    <div class="box-title">
        <h3>
            <i class="fa fa-home"></i>
            Facility Settings - Search Facilities Under Domain: ${model.domainRef.domainname}
        </h3>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-12">
                    <fieldset style="width:auto">
                        <div style="float:left; margin-right: 10px;">
                            <label>Search Facility By: </label>
                        </div>
                        <div style="float:left;">
                            <select class="form-control" id="fsearchTerm" style="width:200px" onChange="clearDiv('fsearchList'); $('#fSearchId').val(''); clearDiv('summaryPane');
                                    $('fSearchId').val('');
                                    if (this.value === '0') {
                                        return false;
                                    }
                                    if (this.value === 'a') {
                                        hideDiv('quickSearch');
                                        ajaxSubmitData('domainFacSetting.htm', 'summaryPane', 'act=a2&i=${model.domainRef.facilitydomainid}&b=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    } else {
                                        showDiv('quickSearch');
                                    }">
                                <option value="j">Quick Search (Name,Code,Village,Sub-County)</option>
                                <option value="a">Search By Facility Levels</option>
                                <option value="b">Search By Facility Name</option>
                                <option value="c">Search By Region</option>
                                <option value="d">Search By District</option>
                                <option value="e">Search By County</option>
                                <option value="f">Search By Sub-County</option>
                                <option value="g">Search By Parish</option>
                                <option value="h">Search By Village</option>
                            </select>
                        </div>
                        <div style="float:left; margin-left: 10px;" id="quickSearch">
                            <div class="row"
                                 <form id="search-form_3" action="" method="">
                                    <input id="fSearchId" placeholder="Type Search Value" type="text" class="search_3" style="border-radius: 35px !important;" oninput="funSearchFacilityByTerm()"/>
                                </form>
                            </div>
                            <div class="row">
                                <div class="searchResults" id="fsearchResults">
                                    <div class="loadergif" id="floadergif">
                                        <img id="gif" src="static/images/load.gif"/>
                                    </div>
                                    <div class="panel-body">
                                        <ul class="list-group" id="fsearchList"></ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                    <div class="row">
                        <div class="col-md-12" id="summaryPane"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
jQuery(document).ready(function() {
//hideDiv('quickSearch');
//$('#fsearchTerm').val('a');    
//ajaxSubmitData('domainFacSetting.htm', 'summaryPane', 'act=a2&i=${model.domainRef.facilitydomainid}&b=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
});    
    
function trim2(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    function funSearchFacilityByTerm() {
        clearDiv('summaryPane');
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
                url: "quickSearchFaciliyByTerm.htm",
                data_type: 'JSON',
                data: {sTerm: searchTerm,sVal: searchValue},
                success: function (response) {
                    document.getElementById('floadergif').style.display = 'none';
                    if (!(response === '' || response === '[]')) {
                        document.getElementById('fsearchList').style.display = 'block';
                        var result = JSON.parse(response);
                        var url = 'getSearchedFacility.htm';
                        var div = 'summaryPane';
                        var vals = 'act='+searchTerm+'&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}';
                        var method = 'GET';
                            if(searchTerm==='b'){
                                for (index in result) {
                                    var id = result[index].id;
                                    $('#fsearchList').append(
                                            '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                            '' +
                                            '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                            '<a href="#">' + result[index].name + '</a> [Type:' + result[index].level + ']' +
                                            '<div class="mic-info">' +
                                            'Code: ' + result[index].code + '</div>' +
                                            '</div><div class="comment-text">Ownership: ' + result[index].funder +
                                            '</div></div></div></li>'
                                            );
                                }
                            }
                            if(searchTerm==='c'){
                                for (index in result) {
                                    var id = result[index].id;
                                    $('#fsearchList').append(
                                            '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                            '' +
                                            '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                            '<a href="#">' + result[index].name + '</a></div></li>'
                                            );
                                }
                            }
                            if(searchTerm==='d'){
                                for (index in result) {
                                    var id = result[index].id;
                                    $('#fsearchList').append(
                                            '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                            '' +
                                            '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                            '<a href="#">' + result[index].name + '</a>' +
                                            '<div class="mic-info">' +
                                            'Region: ' + result[index].region + '</div>' +
                                            '</div></div></div></li>'
                                            );
                                }
                            }
                            if(searchTerm==='e'){
                                for (index in result) {
                                    var id = result[index].id;
                                    $('#fsearchList').append(
                                            '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                            '' +
                                            '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                            '<a href="#">' + result[index].name + '</a>' +
                                            '<div class="mic-info">Region: ' + result[index].region + '</div>' +
                                            '<div class="comment-text">District: ' + result[index].district +'</div>'+
                                            '</div></div>'+
                                            '</li>'
                                            );
                                }
                            }
                            if(searchTerm==='f'){
                                for (index in result) {
                                    var id = result[index].id;
                                    $('#fsearchList').append(
                                            '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                            '' +
                                            '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                            '<a href="#">' + result[index].name + '</a>' +
                                            '<div class="mic-info">Region: ' + result[index].region + '</div>' +
                                            '<div class="comment-text">District: ' + result[index].district +'</div>'+
                                            '<div class="comment-text">County: ' + result[index].county +'</div>'+
                                            '</div></div>'+
                                            '</li>'
                                            );
                                }
                            }
                            if(searchTerm==='g'){
                                for (index in result) {
                                    var id = result[index].id;
                                    $('#fsearchList').append(
                                            '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                            '' +
                                            '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                            '<a href="#">' + result[index].name + '</a>' +
                                            '<div class="mic-info">Region: ' + result[index].region + '</div>' +
                                            '<div class="comment-text">District: ' + result[index].district +'</div>'+
                                            '<div class="comment-text">County: ' + result[index].county +'</div>'+
                                            '<div class="comment-text">Sub-County: ' + result[index].subcounty +'</div>'+
                                            '</div></div>'+
                                            '</li>'
                                            );
                                }
                            }
                            if(searchTerm==='h'){
                                for (index in result) {
                                    var id = result[index].id;
                                    $('#fsearchList').append(
                                            '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                            '' +
                                            '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                            '<a href="#">' + result[index].name + '</a>' +
                                            '<div class="mic-info">Region: ' + result[index].region + '</div>' +
                                            '<div class="comment-text">District: ' + result[index].district +'</div>'+
                                            '<div class="comment-text">County: ' + result[index].county +'</div>'+
                                            '<div class="comment-text">Sub-County: ' + result[index].subcounty +'</div>'+
                                            '<div class="comment-text">Parish: ' + result[index].parish +'</div>'+
                                            '</div></div>'+
                                            '</li>'
                                            );
                                }
                            }
                            if(searchTerm==='j'){
                                for (index in result) {
                                    var id = result[index].id;
                                    $('#fsearchList').append(
                                            '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                            '' +
                                            '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                            '<a href="#">' + result[index].name + '</a> [Type:' + result[index].level + ']' +
                                            '<div class="mic-info">' +
                                            'Code: ' + result[index].code + '</div>' +
                                            '</div></div></div></li>'
                                            );
                                }
                            }
                    } else {
                        if(searchTerm==='b'){
                            $('#fsearchList').append('No Results Found For Facility With Name Like: <strong>' + searchValue + ' ${model.title}</strong>');
                        }
                        if(searchTerm==='c'){
                            $('#fsearchList').append('No Results Found For Region With Name Like: <strong>' + searchValue + ' ${model.title}</strong>');
                        }
                        if(searchTerm==='d'){
                            $('#fsearchList').append('No Results Found For District With Name Like: <strong>' + searchValue + ' ${model.title}</strong>');
                        }
                        if(searchTerm==='e'){
                            $('#fsearchList').append('No Results Found For County With Name Like: <strong>' + searchValue + ' ${model.title}</strong>');
                        }
                        if(searchTerm==='f'){
                            $('#fsearchList').append('No Results Found For Sub-County With Name Like: <strong>' + searchValue + ' ${model.title}</strong>');
                        }
                        if(searchTerm==='g'){
                            $('#fsearchList').append('No Results Found For Parish With Name Like: <strong>' + searchValue + ' ${model.title}</strong>');
                        }
                        if(searchTerm==='h'){
                            $('#fsearchList').append('No Results Found For Village With Name Like: <strong>' + searchValue + ' ${model.title}</strong>');
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
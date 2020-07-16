<%-- 
    Document   : searchFacility
    Created on : Apr 12, 2018, 10:48:09 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="static/mainpane/css/autoCompleteDropList.css">

<div class="modal fade" id="panel-searchFacility" tabindex="-1" role="dialog" aria-labelledby="searchFacility" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width:200%; margin-left: -50%;">
            <div class="modal-header">
                <h5 class="modal-title" id="facSearchTitle">Search Facility ${model.title} [Total: ${model.count}]</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="clearDiv('searchTabContent'); ajaxSubmitData('domainFacSetting.htm', 'searchTabContent', 'act=a2&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="page-header">
                        <div style="float:left">
                                <select class="form-control" id="searchTerm" style="width:200px" onChange="clearDiv('searchTerms'); clearDiv('response'); var returnPane='response'; if(this.value!='g'){returnPane='searchTerms'} if(this.value=='0'){return false;} ajaxSubmitData('facilitySearchByTerm.htm', ''+returnPane+'', 'act='+this.value+'&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                    <option value="0">-Select Search Term-</option>
                                    <option value="g">View All In Selected Category</option>
                                    <option value="a">Search By Region</option>
                                    <option value="b">Search By District</option>
                                    <option value="c">Search By County</option>
                                    <option value="d">Search By Sub-County</option>
                                    <option value="e">Search By Parish</option>
                                    <option value="f">Search By Village</option>
                                </select>
                        </div>
                        <div style="float:right">
                            <div class="row"
                                     <form id="search-form_3" action="" method="">
                                        <input id="facility" placeholder="Search Registered Facility" type="text" class="search_3" style="border-radius: 25px !important;" oninput="funSearchFacility()"/>
                                    </form>
                                </div>
                                <div class="row">
                                    <div class="searchResults" id="searchResults">
                                        <div class="loadergif" id="loadergif">
                                            <img id="gif" src="static/images/load.gif"/>
                                        </div>
                                        <div class="panel-body">
                                            <ul class="list-group" id="searchList"></ul>
                                        </div>
                                    </div>
                                </div>
                        </div>
                        <div id="searchTerms"></div>
                    </div>
                </div>
            </div>
            <div id="response"></div>
        </div>
    </div>
</div>

<script>
    jQuery(document).ready(function () {
        //Main.init();
        TableData.init();
    });
    $('#panel-searchFacility').modal('show');

    function trim(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    function funSearchFacility() {
        clearDiv('searchTerms');
        clearDiv('response');
        $('#searchList').html('');
        var facility = trim($('#facility').val());
        var size = facility.length;
        if (size <= 0) {
            document.getElementById('searchResults').style.display = 'none';
        } else if (size > 0) {
            document.getElementById('loadergif').style.display = 'block';
            document.getElementById('searchResults').style.display = 'block';
            $.ajax({
                type: "POST",
                cache: false,
                url: "quickSearchFaciliy.htm",
                data_type: 'JSON',
                data: {sVal: facility},
                success: function (response) {
                    document.getElementById('loadergif').style.display = 'none';
                    if (!(response === '' || response === '[]')) {
                        document.getElementById('searchList').style.display = 'block';
                        var result = JSON.parse(response);
                        var url = 'orgFacilitySettings.htm';
                        var div = 'response';
                        var vals = 'act=h&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}';
                        var method = 'GET';
                        for (index in result) {
                            var id = result[index].id;
                            $('#searchList').append(
                                    '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                    '' +
                                    '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                    '<a href="#">' + result[index].name + '</a> [Type:' + result[index].level + ']' +
                                    '<div class="mic-info">' +
                                    'Code: ' + result[index].code + '</div>' +
                                    '</div><div class="comment-text">Ownership: ' + result[index].funder +
                                    '</div></div></div></li>'
                                    );
                        }
                    } else {
                        $('#searchList').append('No Results Found For <strong>' + facility + ' ${model.title}</strong>');
                    }
                }
            });
        }
    }
    function clearSearchResult() {
        document.getElementById('searchResults').style.display = 'none';
    }
    
    
</script>
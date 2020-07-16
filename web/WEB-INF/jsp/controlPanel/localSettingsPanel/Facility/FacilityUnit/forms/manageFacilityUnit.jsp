<%-- 
    Document   : manageFacilityUnit
    Created on : May 17, 2018, 11:15:56 PM
    Author     : samuelwam
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="static/mainpane/css/autoCompleteDropList.css">

<br>
<fieldset style="width:95%; margin: 0 auto;" >
    <legend> 
        &nbsp;&nbsp;&nbsp; Facility Structure Description For ${model.facObj.facilityname}
    </legend>
    <div id="addnew-pane">
        
        <div style="float:right; margin-left: 10px;" id="quickSearch">
            <div class="row"
                 <form id="search-form_3" action="" method="">
                     <input type="hidden" id="fsearchTerm" value="a"/>
                    <input id="fSearchId" placeholder="Type Unit To Search" type="text" class="search_3" style="border-radius: 35px !important;" oninput="funSearchFacilityUnit()"/>
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
        <c:if test="${model.totalUnStructuredUnitObj!=0}">
            <div style="float:right" align="left">
                <button data-toggle="modal" data-target="#unStructuredUnit" class="btn btn-primary pull-right" type="button" onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=e&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"><i class="fa fa-fw fa-lg fa-adjust"></i>Un Structured Units: ${model.totalUnStructuredUnitObj}</button>
            </div>
        </c:if>
        <c:if test="${not empty  model.structureList}">
            <div class="tree">
                <c:forEach items="${model.structureList}" var="list" varStatus="status" begin="0" end="${model.size}">
                    <ul>
                                            <li>${model.facObj.facilityname}
                    <ul>
                        <li>
                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=d&i=${list.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${list.hierachylabel} [${list.items}]</a>
                            <c:if test="${not empty list.facilitystructureList}">
                                <ul>
                                    <c:forEach items="${list.facilitystructureList}" var="level2">
                                        <li>
                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=d&i=${level2.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level2.hierachylabel} [${level2.items}]</a>
                                            <c:if test="${not empty level2.facilitystructureList}">    
                                                <ul>
                                                    <c:forEach items="${level2.facilitystructureList}" var="level3">
                                                        <li>
                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=d&i=${level3.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level3.hierachylabel} [${level3.items}]</a>
                                                            <c:if test="${not empty level3.facilitystructureList}">    
                                                                <ul>
                                                                    <c:forEach items="${level3.facilitystructureList}" var="level4">
                                                                        <li>
                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=d&i=${level4.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level4.hierachylabel} [${level4.items}]</a>
                                                                            <c:if test="${not empty level4.facilitystructureList}">    
                                                                                <ul>
                                                                                    <c:forEach items="${level4.facilitystructureList}" var="level5">
                                                                                        <li>
                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=d&i=${level5.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level5.hierachylabel} [${level5.items}]</a>
                                                                                            <c:if test="${not empty level5.facilitystructureList}">    
                                                                                                <ul>
                                                                                                    <c:forEach items="${level5.facilitystructureList}" var="level6">
                                                                                                        <li>
                                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=d&i=${level6.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level6.hierachylabel} [${level6.items}]</a>
                                                                                                            <c:if test="${not empty level6.facilitystructureList}">    
                                                                                                                <ul>
                                                                                                                    <c:forEach items="${level6.facilitystructureList}" var="level7">
                                                                                                                        <li>
                                                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=d&i=${level7.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level7.hierachylabel} [${level7.items}]</a>
                                                                                                                            <c:if test="${not empty level7.facilitystructureList}">    
                                                                                                                                <ul>
                                                                                                                                    <c:forEach items="${level7.facilitystructureList}" var="level8">
                                                                                                                                        <li>
                                                                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=d&i=${level8.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level8.hierachylabel} [${level8.items}]</a>
                                                                                                                                            <c:if test="${not empty level8.facilitystructureList}">    
                                                                                                                                                <ul>
                                                                                                                                                    <c:forEach items="${level8.facilitystructureList}" var="level9">
                                                                                                                                                        <li>
                                                                                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=d&i=${level9.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level9.hierachylabel} [${level9.items}]</a>
                                                                                                                                                            <c:if test="${not empty level9.facilitystructureList}">  
                                                                                                                                                                <ul>
                                                                                                                                                                    <c:forEach items="${level9.facilitystructureList}" var="level10">
                                                                                                                                                                        <li>
                                                                                                                                                                            <a href="#"onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=d&i=${level10.structureid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">${level10.hierachylabel} [${level10.items}]</a>
                                                                                                                                                                        </li>
                                                                                                                                                                    </c:forEach>
                                                                                                                                                                </ul>
                                                                                                                                                            </c:if>
                                                                                                                                                        </li>
                                                                                                                                                    </c:forEach>
                                                                                                                                                </ul>
                                                                                                                                            </c:if>
                                                                                                                                        </li>
                                                                                                                                    </c:forEach>
                                                                                                                                </ul>
                                                                                                                            </c:if>
                                                                                                                        </li>
                                                                                                                    </c:forEach>
                                                                                                                </ul>
                                                                                                            </c:if>
                                                                                                        </li>
                                                                                                    </c:forEach>
                                                                                                </ul>
                                                                                            </c:if>
                                                                                        </li>
                                                                                    </c:forEach>
                                                                                </ul>
                                                                            </c:if>
                                                                        </li>
                                                                    </c:forEach>
                                                                </ul>
                                                            </c:if>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </c:if>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </li>
                    </ul>
                            </li>
                    </ul>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty model.structureList}">
            <div align="center"><h3>No Registered Facility Structure! Please Set Up Structure</h3></div>
        </c:if>
    </div>
</fieldset>
    
    <script>
        
        function trim2(x) {
        return x.replace(/^\s+|\s+$/gm, '');
    }
    function funSearchFacilityUnit() {
        $('#fsearchList').html('');
        var searchTerm = $('#fsearchTerm').val();
        var searchValue = trim2($('#fSearchId').val());
        var size = searchValue.length;
        if (searchTerm === '0') {
            $('#fSearchId').val('');
        }
        if (size <= 0) {
            document.getElementById('fsearchResults').style.display = 'none';
        } else if (size > 0) {
            document.getElementById('floadergif').style.display = 'block';
            document.getElementById('fsearchResults').style.display = 'block';
            $.ajax({
                type: "POST",
                cache: false,
                url: "quickSearchFaciliyUnitByTerm.htm",
                data_type: 'JSON',
                data: {sTerm: searchTerm,sVal: searchValue},
                success: function (response) {
                    document.getElementById('floadergif').style.display = 'none';
                    if (!(response === '' || response === '[]')) {
                        document.getElementById('fsearchList').style.display = 'block';
                        var result = JSON.parse(response);
                        var url = 'facilityUnitSetting.htm';
                        var div = 'addnew-pane';
                        var vals = 'act=g&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}';
                        var method = 'GET';
                            if(searchTerm==='a'){
                                for (index in result) {
                                    var id = result[index].id;
                                    $('#fsearchList').append(
                                            '<li onclick="ajaxSubmitData(\'' + url + '\', \'' + div + '\', ' + '\'i=' + id + '&' + vals + '\', \'' + method + '\'); clearSearchResult2();" class="list-group-item" data-pid="' + id + '"> <div class="row"> <div class="col-xs-2 col-md-1">' +
                                            '' +
                                            '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                            '<a href="#">' + result[index].name + '</a>' +
                                            '</div></div></div></li>'
                                            );
                                }
                            }
                    } else {
                        if(searchTerm==='a'){
                            $('#fsearchList').append('No Results Found For Facility Unit With Name Like: <strong>' + searchValue + ' ${model.title}</strong>');
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
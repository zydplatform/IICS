<%-- 
    Document   : facilityRegHome
    Created on : Nov 29, 2017, 7:18:42 AM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="static/mainpane/css/autoCompleteDropList.css">


<div class="col-sm-12">
    <div class="box box-color box-bordered">    
        <div class="box-title">
            <h3>
                <i class="fa fa-home"></i>
                Org. Settings - Manage/Register ${model.orgObj.organisationname} [School/Branch]
            </h3>
        </div>
        <div style="float:right">   
            <span class="text4" class="ui-state-highlight">${model.message}</span>
            <div id="AddNewRg" class="form-actions text5"></div>
        </div>

        <div style="float:left" align="left"><a id="back" href="#"  onClick="ajaxSubmitData('organisationSetting.htm', 'workPane', 'act=g&i=0&b=a&c=${model.c}&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a></div>
        <!--<div style="float:right; padding-right:5px"><a id="close_module" href="#" onClick="ajaxSubmitData('organisationSetting.htm', 'workPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"><i class="fa fa-home"></i></a></div>-->
        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGESCHOOLSBYSEARCH')">
            <div class="page-header" >
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="row"
                             <form id="search-form_3" action="" method="">
                                <input id="school" placeholder="Search Registered School" type="text" class="search_3" style="border-radius: 25px !important;" oninput="funSearchSchool()"/>
                            </form>
                        </div>
                        <div class="row">
                            <div class="searchResults" id="searchResults">
                                <div class="loadergif" id="loadergif">
                                    <img id="gif" src="static/images/load.gif"/>
                                </div>
                                <div class="panel-body">
                                    <ul class="list-group" id="searchList">

                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </security:authorize>
        <div id="response" class="box-content nopadding">
            <div id="addnew-pane"></div>
            <c:if test="${not empty  model.facilityList}">
                <form id="manageFormField" name="manageFormField">

                    <c:if test="${model.paginate==true}">
                        <script>showDiv('pagenateSearch2');</script>
                        <script>showDiv('pagenateSearch3');</script>
                        <div id="searchHeading1">
                            <c:if test="${model.count<=(model.maxResults*model.offset)}"><font color="blue"><font color="blue">${model.offset2}-${model.count}</font> of ${model.count}</font></c:if>
                            <c:if test="${model.count>(model.maxResults*model.offset)}"><font color="blue">${model.offset2}-${model.maxResults*model.offset}</font> of <font color="blue">${model.count}</font></c:if>
                            ${model.facilityType}
                            <input type="hidden" size="5" name="act" id="act" value="${model.act}"/>
                            <input type="hidden" size="5" name="b" id="b" value="${model.b}"/>
                            <input type="hidden" size="5" name="i" id="i" value="${model.i}"/>
                            <input type="hidden" size="5" name="c" id="c" value="${model.c}"/>
                            <input type="hidden" size="5" name="d" id="d" value="${model.d}"/>
                            <input type="hidden" size="5" name="sStr" id="sStr" value="${model.sStr}"/>


                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-md-12">
                            <!-- start: DYNAMIC TABLE PANEL -->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <i class="fa fa-external-link-square"></i>
                                    Manage School/Organisation Branch 
                                    <div class="panel-tools">
                                        <a class="btn btn-xs btn-link panel-collapse collapses" href="#">
                                        </a>
                                        <a class="btn btn-xs btn-link panel-refresh" href="#">
                                            <i class="fa fa-refresh"></i>
                                        </a>
                                        <a class="btn btn-xs btn-link panel-close" href="#">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </div>
                                </div>
                                <div class="panel-body" id="searchResults">
                                    <table class="table table-striped table-bordered table-hover table-full-width" id="sample_1">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>School Name</th>
                                                <th>Code</th>   
                                                <th>Branches</th>
                                                <!--<th>Operational Units</th>-->
                                                <th>Status</th>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGE')">
                                                    <th>Manage</th> 
                                                    </security:authorize>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITY')">
                                                    <th>Discard</th>
                                                    </security:authorize>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:set var="quantity" value="quantity"/>
                                            <c:set var="qtyServiced" value="0" />
                                            <c:forEach items="${model.facilityList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                                <c:choose>
                                                    <c:when test="${status.count % 2 != 0}">
                                                        <tr>
                                                        </c:when>
                                                        <c:otherwise>
                                                        <tr bgcolor="white">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td align="left">${status.count}</td>
                                                    <td align="left">${list.facilityname}</td> 
                                                    <td align="left">${list.facilitycode}</td>
                                                    <td align="left">
                                                        <c:if test="${list.totalunits>0}">
                                                            <a href="#" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'response', 'act=i&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
                                                                ${list.totalunits}
                                                                <c:if test="${list.totalunits>1}">Branches</c:if><c:if test="${list.totalunits==1}">Branch</c:if>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${list.totalunits==0}">N/A</c:if>
                                                    </td> 
                                                    <!--<td align="left"><c:if test="${not empty list.shortname}">${list.shortname}</c:if><c:if test="${empty list.shortname}">--</c:if></td> -->
                                                    <!--<td align="left">
                                                        <div style="float:left">
                                                    ${list.occupiedunits}/${list.totalunits}
                                                    <c:if test="${list.totalunits>0}">[<a href="#" title="View ${list.totalunits} Facility Unit" onClick="if(${list.active==false}){alert('Activate/Approve Facility!'); return false;} ajaxSubmitData('facilityUnitSetting.htm', 'workPane', 'act=a&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.orgObj.organisationid}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">view</a>]</c:if>
                                                </div>
                                                <div style="float:right">
                                                    <a href="#" onClick="if(${list.active==false}){alert('Activate/Approve Facility!'); return false;} ajaxSubmitData('orgFacilitySettings.htm', 'addnew-pane', 'act=e&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.orgObj.organisationid}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Add Unit</a>
                                                </div>
                                            </td>-->
                                                    <td align="right"><c:if test="${list.active==true}">Approved</c:if><c:if test="${list.active==false}"><span class="text4">Pending Approval</span></c:if></td>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGE')">
                                                        <td align="center">
                                                            <div style="float:left"><a href="#" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'addnew-pane', 'act=c1&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');" data-placement="top" data-original-title="View Details For ${list.facilityname}"><i class="fa fa-file-text"></i></a></div>
                                                            <div style="float:right">
                                                                <a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit/Update" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'addnew-pane', 'act=c&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-edit"></i></a>
                                                            </div>
                                                        </td>
                                                    </security:authorize>
                                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITY')">    
                                                        <td align="center">
                                                            <a href="#" class="btn btn-xs btn-bricky tooltips" data-placement="top" data-original-title="Remove" onClick="var resp = confirm('Discard Facility!');
                                                                    if (resp == false) {
                                                                        return false;
                                                                    }
                                                                    ajaxSubmitData('orgFacilitySettings.htm', 'TempDialogDiv', 'act=g&i=${list.facilityid}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-times fa fa-white"></i></a>
                                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="${list.facilityid}" onChange="if (this.checked) {
                                                                        document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) + 1
                                                                    } else {
                                                                        document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) - 1
                                                                    }
                                                                    var ticks = document.getElementById('selectedObjs').value;
                                                                    if (ticks > 0) {
                                                                        showDiv('selectObjBtn');
                                                                    }
                                                                    if (ticks == 0) {
                                                                        hideDiv('selectObjBtn');
                                                                    }"/>
                                                        </td>   
                                                    </security:authorize>
                                                </tr>
                                            </c:forEach>

                                        </tbody>
                                    </table>
                                    <c:if test="${model.size>0}">
                                        <table align="right">
                                            <tr>
                                                <td>
                                                    <input type="hidden" id="forg" name="forg" value="${model.orgObj.organisationid}"/>
                                                    <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                                                    <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                                                    <input type="hidden" name="act" value="${model.act}"/>
                                                    <input type="hidden" name="b" value="${model.b}"/>
                                                    <input type="hidden" name="i" value="${model.i}"/>
                                                    <input type="hidden" name="a" value="${model.a}"/>
                                                </td>
                                                <td align="right">
                                                    Select <a href="javascript:selectToggleCheckBox(true, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value =${model.size};
                                                            showDiv('selectObjBtn');"><font color="blue"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value = 0;
                                                                    hideDiv('selectObjBtn');"><font color="blue">None</font></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="right">
                                                    <div id="selectObjBtn" style="display:none">
                                                        <input type="button" value="Discard Facility" class='btn btn-purple' onClick="var resp = confirm('Delete Facility(s)?');
                                                                if (resp == false) {
                                                                    return false;
                                                                }
                                                                ajaxSubmitData('deleteFacility.htm', 'TempDialogDiv', $('#manageFormField').serialize(), 'POST');"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        </br>
                                    </c:if>
                                </div>
                            </div>
                            <!-- end: DYNAMIC TABLE PANEL -->
                        </div>
                    </div>
                </form>
            </c:if>
            <c:if test="${empty model.facilityList}">
                <div align="center"><h3>No Registered ${model.facilityType}</h3></div>
            </c:if>
        </div>
    </div>
</div>
<div id="TempDialogDiv"></div>
<script type="text/javascript" src="static/mainpane/plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="static/mainpane/plugins/DataTables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="static/mainpane/plugins/DataTables/media/js/DT_bootstrap.js"></script>
<script src="static/mainpane/js/table-data.js"></script>

<script>
                                                            function trim(x) {
                                                                return x.replace(/^\s+|\s+$/gm, '');
                                                            }
                                                            function funSearchSchool() {
                                                                $('#searchList').html('');
                                                                var school = trim($('#school').val());
                                                                var size = school.length;
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
                                                                        data: {sVal: school},
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
                                                                                            '<img src="static/images/noimageplaceholder.png" class="img-circle img-responsive" alt="" />' +
                                                                                            '</div> <div class="col-xs-10 col-md-11"> <div>' +
                                                                                            '<a href="#">' + result[index].name + '</a> [Type:' + result[index].level + ']' +
                                                                                            '<div class="mic-info">' +
                                                                                            'School Mate Code: ' + result[index].code + '</div>' +
                                                                                            '</div><div class="comment-text">Ownership: ' + result[index].funder +
                                                                                            '</div></div></div></li>'
                                                                                            );
                                                                                }
                                                                            } else {
                                                                                $('#searchList').append('No Results found for <strong>' + school + '</strong>');
                                                                            }
                                                                        }
                                                                    });
                                                                }
                                                            }
                                                            function clearSearchResult() {
                                                                document.getElementById('searchResults').style.display = 'none';
                                                            }
                                                            $(document).ready(function () {

                                                            });

                                                            jQuery(document).ready(function () {
                                                                //Main.init();
                                                                TableData.init();
                                                            });
</script>



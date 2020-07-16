<%-- 
    Document   : searchedFacility
    Created on : Feb 08, 2018, 10:50:19 AM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div id="facility-pane">
    <fieldset><legend>Searched Facility</legend>
        <c:if test="${not empty  model.facilityList}">
            <form id="manageFormField" name="manageFormField">

                <c:if test="${model.paginate==true}">
                    <div id="searchHeading1" align="right">
                        <c:if test="${model.count<=(model.maxR*model.ofst)}"><font color="blue"><font color="blue">${model.offset2}-${model.count}</font> of ${model.count}</font></c:if>
                        <c:if test="${model.count>(model.maxR*model.ofst)}"><font color="blue">${model.offset2}-${model.maxR*model.offset}</font> of <font color="blue">${model.count}</font></c:if>
                        ${model.facilityType}
                        <select id="maxResults" name="maxResults" style="width:100px" onChange="ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act=${model.act}&i=${model.i}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=1&maxR=' + this.value);">
                            <option value="10">10</option>
                            <option value="20">20</option>
                            <option value="50">50</option>
                            <option value="100" selected="selected">100</option>
                            <option value="150">150</option>
                            <option value="200">200</option>
                            <option value="250">250</option>
                            <option value="300">300</option>
                            <option value="350">350</option>
                            <option value="400">400</option>
                            <option value="450">450</option>
                            <option value="500">500</option>
                            <option value="0">All Records</option>
                        </select>
                        <span>Max Results Per Search</span>
                        <input type="hidden" size="5" name="act" id="act" value="${model.act}"/>
                        <input type="hidden" size="5" name="b" id="b" value="${model.b}"/>
                        <input type="hidden" size="5" name="i" id="i" value="${model.i}"/>
                        <input type="hidden" size="5" name="c" id="c" value="${model.c}"/>
                        <input type="hidden" size="5" name="d" id="d" value="${model.d}"/>
                        <input type="hidden" size="5" name="sStr" id="sStr" value="${model.sStr}"/>
                        <br><br>
                    </div>
                </c:if>

                <table class="table table-hover table-bordered" id="searchedFacility">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Facility</th>
                            <c:if test="${model.showLevel==true}"><th>Facility Level</th></c:if>
                                <th>Facility Code</th>
                                <th class="center">Status</th>
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGE')"></security:authorize>
                                <th>Manage</th> 
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITY')"></security:authorize>
                                <!--<th>Discard</th>-->
                            </tr>
                        </thead>
                        <tbody id="tableFacilities">
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
                                <c:if test="${model.showLevel==true}"><td align="left">${list.facilitylevelid.shortname}</td> </c:if>
                                <!--<td align="left"><c:if test="${not empty list.shortname}">${list.shortname}</c:if><c:if test="${empty list.shortname}">--</c:if></td> -->
                                <td align="left">${list.facilitycode}</td>

                                <td align="right">
                                    <c:if test="${list.active==false}"><img src="static/images/disabledsmall.png" width="20px" height="20px" title="Pending Approval" alt="Pending Approval"></c:if>
                                    <c:if test="${list.active==true}"><img src="static/images/authorised.png" width="20px" height="20px" title="Active" alt="Active"></c:if>
                                    </td>
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGE')"></security:authorize>
                                    <td align="center">
                                        <!--
                                        <a href="#" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'facility-pane', 'act=c1&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');" data-placement="top" data-original-title="View Details For ${list.facilityname}"><i class="fa fa-file-text"></i></a>
                                    &nbsp;&nbsp;    
                                    <a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit/Update" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'facility-pane', 'act=c&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-edit"></i></a>
                                    &nbsp;&nbsp;   
                                    <a href="#" class="btn btn-xs btn-bricky tooltips" data-placement="top" data-original-title="Remove" onClick="var resp = confirm('Discard Facility!'); if (resp == false) {
                                                return false;
                                            }
                                            ajaxSubmitData('orgFacilitySettings.htm', 'facility-pane', 'act=g&i=${list.facilityid}&b=${model.b}&c=${model.c}&d=0&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-times fa fa-white"></i></a>
                                        -->
                                        <a href="#" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'facility-pane', 'act=c1&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');" data-placement="top" data-original-title="View Details For ${list.facilityname}"><i class="fa fa-fw fa-lg fa-dedent"></i></a>
                                </td>

                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITY')"></security:authorize>   
                                    <!--    
                                    <td align="center">
                                            <a href="#" class="btn btn-xs btn-bricky tooltips" data-placement="top" data-original-title="Remove" onClick="var resp = confirm('Discard Facility!');
                                                        if (resp == false) {
                                                            return false;
                                                        }
                                                        ajaxSubmitData('orgFacilitySettings.htm', 'TempDialogDiv', 'act=g&i=${list.facilityid}&b=${model.b}&c=${model.c}&d=0&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-times fa fa-white"></i></a>
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
                                -->

                            </tr>
                        </c:forEach>
                    </tbody>
                    <c:if test="${model.size>0}">
                        <table align="right">
                            <tr>
                                <td>
                                    <input type="hidden" id="forg" name="forg" value="0"/>
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
                    <c:if test="${model.paginate==true}">
                        <div class="PagerContainer" align="center">
                            <div>
                                <div>
                                    <input type="hidden" id="psearch" value=""/>
                                    <img src="static/images/pager/first.gif" width="16" height="16" alt="First Page" onclick="movePage(1, 'b');
                                            ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act=${model.act}&i=${model.i}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=' + $('#pages').val() + '&maxR=' + $('#maxResults').val() + '', 'GET');" />
                                    <img src="static/images/pager/previous.gif" width="16" height="16" alt="Previous Page" onclick="if (document.getElementById('pages').value == 1) {
                                                return false;
                                            }
                                            movePage(-1, 'a');
                                            ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act=${model.act}&i=${model.i}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=' + $('#pages').val() + '&maxR=' + $('#maxResults').val() + '', 'GET');" />
                                    <img src="static/images/pager/next.gif" width="16" height="16" alt="Next Page" onclick="if (document.getElementById('pages').value ==${model.totalPage}) {
                                                return false;} movePage(1, 'a'); ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act=${model.act}&i=${model.i}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=' + $('#pages').val() + '&maxR=' + $('#maxResults').val() + '', 'GET');" />
                                    <img src="static/images/pager/last.gif" width="16" height="16" alt="Last Page" onclick="movePage(document.getElementById('lastPg').value, 'b');
                                            ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act=${model.act}&i=${model.i}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=' + $('#pages').val() + '&maxR=' + $('#maxResults').val() + '', 'GET');" />
                                </div>
                                <div>
                                    <c:set var="nC" value="1"></c:set>
                                    Batches <input type="text" style="width:40px" id="pages" onKeyPress="return isNumberKey(event)" name="pages" value="${model.ofst}" onChange="if (this.value >${model.totalPage}) {
                                                this.value =${model.totalPage}
                                            }"/>of ${model.totalPage}
                                    <input type="hidden" size="5" value="${model.totalPage}" id="lastPg">
                                    <input type="hidden" size="5" value="1" id="curSelectPg">
                                </div>
                            </div>
                            <script>
                                function movePage(x, act) {
                                    if (act == 'a') {
                                        var curPg = (parseInt(document.getElementById('pages').value) + x);
                                        if (curPg > parseInt(document.getElementById('lastPg').value)) {
                                            return false;
                                        }
                                        document.getElementById('pages').value = curPg;
                                    }
                                    if (act == 'b') {
                                        document.getElementById('pages').value = x;
                                    }
                                }
                            </script>
                        </div>
                    </c:if>    
                </table>
            </form>
        </c:if>
        <c:if test="${empty model.facilityList}">
            <div align="center"><h3>No Registered ${model.facilityType}</h3></div>
        </c:if>
    </fieldset>    
    <script>
        $(document).ready(function () {
            $('#searchedFacility').DataTable();
        })
    </script>
</div>

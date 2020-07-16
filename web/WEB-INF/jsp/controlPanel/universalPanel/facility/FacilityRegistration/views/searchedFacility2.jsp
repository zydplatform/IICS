<%-- 
    Document   : searchedFacility2
    Created on : Apr 23, 2018, 6:36:27 PM
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
                            <th>Code</th>
                            <c:if test="${model.act=='b'}">
                            <th>Region</th>
                            <th>District</th>
                            <th>County</th>
                            <th>Location</th>
                            </c:if>
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
                                <td align="left">${list.facilityname} ${list.facilitylevelid.shortname}</td> 
                                <td align="left">${list.facilitycode}</td>
                                <c:if test="${model.act=='b'}">
                                <td align="center">
                                    <c:if test="${empty list.village}">Pending</c:if>
                                    <c:if test="${not empty list.village}">${list.village.parishid.subcountyid.countyid.districtid.regionid.regionname}</c:if>
                                </td>
                                <td align="center">
                                    <c:if test="${empty list.village}">Pending</c:if>
                                    <c:if test="${not empty list.village}">${list.village.parishid.subcountyid.countyid.districtid.districtname}</c:if>
                                </td>
                                <td align="center">
                                    <c:if test="${empty list.village}">Pending</c:if>
                                    <c:if test="${not empty list.village}">${list.village.parishid.subcountyid.countyid.countyname}</c:if>
                                </td>
                                <td align="center">
                                    <c:if test="${empty list.village}">Pending</c:if>
                                    <c:if test="${not empty list.village}">Sub-County: ${list.village.parishid.subcountyid.subcountyname}, Parish: ${list.village.parishid.parishname}, Village: ${list.village.villagename}</c:if>
                                </td>
                                </c:if>
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGE')"></security:authorize>
                                    <td align="center">
                                        <a href="#" onClick="ajaxSubmitData('orgFacilitySettings.htm', 'summaryPane', 'act=c1&i=${list.facilityid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');" data-placement="top" data-original-title="View Details For ${list.facilityname}"><i class="fa fa-fw fa-lg fa-dedent"></i></a>
                                    </td>

                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEFACILITY')"></security:authorize>   
                            </tr>
                        </c:forEach>
                    </tbody>
                    <c:if test="${model.size>0}">
                        <table align="right">
                            <tr></tr>
                        </table>
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


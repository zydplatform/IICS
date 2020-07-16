<%-- 
    Document   : registeredList
    Created on : Mar 7, 2018, 5:21:12 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset>
    <legend>
        <c:if test="${model.state==true}">Manage Registered Devices Granted Access To IICS Network</c:if>
        <c:if test="${model.state==false}">Manage Registered Devices Denied Access To IICS Network</c:if>
        </legend>
        <div id="response">

            <div id="addnew-pane"></div>
        <c:if test="${not empty  model.deviceList}">
            <form id="manageFormField" name="manageFormField">

                <c:if test="${model.paginate==true}">
                    <div id="searchHeading1">
                        <c:if test="${model.count<=(model.maxR*model.ofst)}"><font color="blue"><font color="blue">${model.offset2}-${model.count}</font> of ${model.count}</font></c:if>
                        <c:if test="${model.count>(model.maxR*model.ofst)}"><font color="blue">${model.offset2}-${model.maxR*model.offset}</font> of <font color="blue">${model.count}</font></c:if>
                        ${model.facilityType}
                        <select id="maxResults" name="maxResults" style="width:100px" class="form-control" onChange="ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=${model.act}&i=${model.i}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=1&maxR=' + this.value);">
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
                    </div>
                </c:if>

                <div class="row">
                    <div class="col-md-12">
                        <!-- start: DYNAMIC TABLE PANEL -->
                        <table class="table table-hover table-bordered" id="dataGrid">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th class="hidden-xs">Device Type</th> 
                                    <th class="hidden-xs">Device Name</th> 
                                    <th class="hidden-xs">Location</th> 
                                    <th>Operating System</th>
                                    <th>Mac Address</th>
                                    <th>Serial No.</th>
                                    <th>Date Added</th>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEREGISTEREDNETWORKDEVICE')">
                                        <th>Manage</th> 
                                        </security:authorize>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEREGISTEREDNETWORKDEVICE')">
                                        <th>Discard</th>
                                        </security:authorize>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="count" value="1"/>
                                <c:set var="No" value="0" />
                                <c:forEach items="${model.deviceList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                    <c:choose>
                                        <c:when test="${status.count % 2 != 0}">
                                            <tr>
                                            </c:when>
                                            <c:otherwise>
                                            <tr bgcolor="white">
                                            </c:otherwise>
                                        </c:choose>
                                        <td>${status.count}</td>
                                        <td>${list.devicetype}</td>
                                        <td>${list.devicename}</td>
                                        <td>${list.physicalcondition}</td>
                                        <td>${list.operatingsystem}</td>
                                        <td>${list.macaddress}</td>
                                        <td>${list.serialnumber}</td>
                                        <td><fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${list.dateadded}"/></td>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_MANAGEREGISTEREDNETWORKDEVICE')">
                                            <td align="center">
                                                <a href="#" class="btn btn-xs btn-teal tooltips" data-placement="top" class="close" data-dismiss="modal" aria-hidden="true" data-original-title="Edit/Update" onClick="ajaxSubmitData('deviceManuSetting.htm', 'addnew-pane', 'act=c3&i=${list.registereddeviceid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"><i class="fa fa-edit"></i></a>
                                            </td>
                                        </security:authorize>
                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEREGISTEREDNETWORKDEVICE')">
                                            <td align="center">
                                                <a href="#" data-dismiss="modal" aria-hidden="true" class="btn btn-xs btn-bricky tooltips" data-dismiss="modal" aria-hidden="true" data-placement="top" data-original-title="Remove" onClick="var resp = confirm('Delete Device From Network?');
                                                            if (resp === true) {
                                                                ajaxSubmitData('deviceManuSetting.htm', 'addnew-pane', 'act=e2&i=${list.registereddeviceid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');
                                                            }"><i class="fa fa-times fa fa-white"></i></a>
                                                
                                            </td>   
                                        </security:authorize>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                        <c:if test="${model.paginate==true}">
                            <div class="PagerContainer" align="center">
                                <div>
                                    <div>
                                        <input type="hidden" id="psearch" value=""/>
                                        <img src="static/images/pager/first.gif" width="16" height="16" alt="First Page" onclick="movePage(1, 'b'); ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=${model.act}&i=${model.i}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=' + $('#pages').val() + '&maxR=' + $('#maxResults').val() + '', 'GET');" />
                                        <img src="static/images/pager/previous.gif" width="16" height="16" alt="Previous Page" onclick="if (document.getElementById('pages').value == 1) {
                                                        return false;
                                                    }
                                                    movePage(-1, 'a');
                                                    ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=${model.act}&i=${model.i}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=' + $('#pages').val() + '&maxR=' + $('#maxResults').val() + '', 'GET');" />
                                        <img src="static/images/pager/next.gif" width="16" height="16" alt="Next Page" onclick="if (document.getElementById('pages').value ==${model.totalPage}) {
                                                        return false;} movePage(1, 'a'); ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=${model.act}&i=${model.i}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=' + $('#pages').val() + '&maxR=' + $('#maxResults').val() + '', 'GET');" />
                                        <img src="static/images/pager/last.gif" width="16" height="16" alt="Last Page" onclick="movePage(document.getElementById('lastPg').value, 'b');
                                                    ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=${model.act}&i=${model.i}&b=${model.b}&c=${model.c}&d=${model.d}&ofst=' + $('#pages').val() + '&maxR=' + $('#maxResults').val() + '', 'GET');" />
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
                    </div>
                </div>
            </form>
        </div>
    </c:if>
    <c:if test="${empty model.deviceList}">
        <div align="center"><h3>
                <c:if test="${model.state==true}">No Devices With Granted Access Found!</c:if>
                <c:if test="${model.state==false}">No Devices With Denied Access Found!</c:if>
                </h3></div>
        </c:if>
</fieldset>
<script>
    $(document).ready(function () {
        $('#dataGrid').DataTable();
    })
</script>
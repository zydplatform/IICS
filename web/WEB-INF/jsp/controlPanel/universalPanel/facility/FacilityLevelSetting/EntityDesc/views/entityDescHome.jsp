<%-- 
    Document   : entityDescHome
    Created on : Jan 22, 2018, 12:00:41 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<br>
<div class="box-title">
    <h3>
        <i class="fa fa-home"></i>
        Facility Settings - Manage/Register Descriptions [Domain: ${model.domainRef.domainname}] 
    </h3>
</div>

<div class="row" >
    <div class="col-md-12"> 
        <div class="pull-right">
            <a class="btn btn-primary icon-btn" href="#" onClick="
                    if ($('#levelid').val() == 0) {
                        alert('Select Facility Level!');
                        return false;
                    }
                    ajaxSubmitData('entityDescSetting.htm', 'addNew', 'act=c&i=${model.i}&b=${model.b}&c=${model.a}&d=${model.levelRef.facilitylevelid}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
                <i class="fa fa-plus"></i>
                Add New Description
            </a>
        </div>
        <div class="pull-left">
            <select class="form-control" id="levelid" name="levelid" onChange="clearDiv('addNew'); if (this.value == '0') {
                        return false;
                    } else {
                        ajaxSubmitData('entityDescSetting.htm', 'descContent', 'act=b&i='+this.value+'&b=a&c=a&d=${model.domainRef.facilitydomainid}&ofst=1&maxR=100&sStr=', 'GET')
                    }">
                <option value="0">--Select Facility Level--</option>
                <c:forEach items="${model.levels}" var="level">                                
                    <option value="${level[0]}" <c:if test="${level[0]==model.levelRef.facilitylevelid}">selected="selected"</c:if>>${level[1]}</option>
                </c:forEach>
            </select>
                    <br><br>
        </div> 
    </div>
                    
</div>    
<div class="row" id="addNew">
    <div id="addnew-pane"></div>
    
    <fieldset style="width: 99%"><legend>Manage Descriptions Under ${model.levelRef.facilitylevelname}</legend>               
        <div id="response" class="bs-component">
            <div>
                <c:if test="${not empty  model.descList}">
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
                                    
                                    <div class="panel-body">
                                        <br>
                                        <table class="table table-hover table-bordered" id="descTable">
                                            <thead>
                                                <tr>
                                                    <th>No</th>
                                                    <th>Description</th>
                                                    <th>Options</th>
                                                    <th>Discard</th>
                                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEENTITYDESCRIPTION')">
                                                        </security:authorize>
                                                </tr>
                                            </thead>
                                            <tbody id="tableDesc">
                                                <c:set var="count" value="1"/>
                                                <c:set var="No" value="0" />
                                                <c:forEach items="${model.descList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                                    <c:choose>
                                                        <c:when test="${status.count % 2 != 0}">
                                                            <tr>
                                                            </c:when>
                                                            <c:otherwise>
                                                            <tr bgcolor="white">
                                                            </c:otherwise>
                                                        </c:choose>
                                                            <td>${status.count}</td>
                                                            <td class="hidden-xs">
                                                                <c:if test="${list.description=='addFunder'}">Facility is funded by:</c:if>
                                                                <c:if test="${list.description=='addSupervisor'}">Facility is supervised by:</c:if>
                                                                <c:if test="${list.description=='addGender'}">Facility gender is:</c:if>
                                                                <c:if test="${list.description=='addPaymentMode'}">Nature of patient payment mode:</c:if>
                                                                <c:if test="${list.description=='addCatchmentArea'}">Facility catchment area:</c:if>
                                                                <c:if test="${list.description=='receiveAdverts'}">Receive Adverts:</c:if>
                                                            </td>
                                                            <td class="hidden-xs">
                                                                <c:if test="${list.description=='addFunder'}">Central Government, &nbsp;&nbsp; Local Government </c:if>
                                                                <c:if test="${list.description=='addSupervisor'}">Central Government, &nbsp;&nbsp; Private, &nbsp;&nbsp; Local Government  </c:if>
                                                                <c:if test="${list.description=='addGender'}">Single, &nbsp;&nbsp; Mixed</c:if>
                                                                <c:if test="${list.description=='addPaymentMode'}">Paying, &nbsp;&nbsp; Non Paying</c:if>
                                                                <c:if test="${list.description=='addCatchmentArea'}">
                                                                    <input type="hidden" id="options" value="${list.options}"/>
                                                                    <c:set var="opts" value="${fn:split(list.options, ',')}" />
                                                                    <c:forEach items="${opts}" var="option">
                                                                        <c:if test="${option=='National'}">National, &nbsp;&nbsp; </c:if>
                                                                        <c:if test="${option=='Regional'}">Regional, &nbsp;&nbsp; </c:if>
                                                                        <c:if test="${option=='District'}">District, &nbsp;&nbsp; </c:if>
                                                                        <c:if test="${option=='County'}">County, &nbsp;&nbsp; </c:if>
                                                                        <c:if test="${option=='Sub-County'}">Sub-County, &nbsp;&nbsp; </c:if>
                                                                        <c:if test="${option=='Parish'}">Parish, &nbsp;&nbsp; </c:if>
                                                                    </c:forEach>
                                                                </c:if>
                                                                <c:if test="${list.description=='receiveAdverts'}">Yes, &nbsp;&nbsp; No</c:if>
                                                            </td>
                                                            <td align="center">
                                                                <div id="${list.description}-resp">
                                                                <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="${list.description}" onChange="if (this.checked) {
                                                                            var delChk = confirm('Remove Selected Description!');
                                                                            if (delChk == false) {
                                                                                this.checked = false;
                                                                                return false;
                                                                            }
                                                                            ajaxSubmitData('regEntityDesc.htm', '${list.description}-resp', 'act=c&i=${model.levelRef.facilitylevelid}&b=' + this.value + '', 'GET');
                                                                        }"/>
                                                                </div>
                                                            </td>   
                                                        <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_DELETEENTITYDESCRIPTION')">
                                                        </security:authorize>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <!--<c:if test="${model.size>0}">
                                            <table align="right">
                                                <tr>
                                                    <td>
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
                                                            <input type="button" id="saveButton" name="button" class="btn btn-primary" value="Delete Category" onClick="var resp = confirm('Delete Description?');
                                                                    if (resp == false) {
                                                                        return false;
                                                                    }
                                                                    ajaxSubmitData('deleteEntityDesc.htm', 'TempDialogDiv', $('#manageFormField').serialize(), 'POST');"/> 
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                            </br>
                                        </c:if>
                                        -->

                                    </div>
                                </div>
                                <!-- end: DYNAMIC TABLE PANEL -->
                            </div>
                        </div>
                    </form>
                </c:if>
                <c:if test="${empty model.descList}">
                    <div align="center"><h3>No Registered ${model.facilityType} Under ${model.levelRef.facilitylevelname}</h3></div>
                </c:if>
            </div>
        </div>
    </fieldset> 
</div>
<div id="TempDialogDiv"></div>

<script>
    $(document).ready(function () {
        $('#descTable').DataTable();
    })
</script>     

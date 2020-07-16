<%-- 
    Document   : formDesc
    Created on : Jan 22, 2018, 2:15:28 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="titleAct" value="Add New"></c:set>    
<c:if test="${not empty model.descObjArr}"><c:set var="titleAct" value="Update"></c:set></c:if>

        <!--<div class="modal fade col-md-12" id="panel-addEntityDesc" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width: 170%; margin-left: -50%;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">${titleAct} Setup Descriptions Under ${model.levelRef.facilitylevelname}</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('entityDescSetting.htm', 'descContent', 'act=a&i=0&b=${model.b}&c=${model.c}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
        -->
            <div class="modal-body">
                <form name="submitData" id="submitData" class="form-horizontal">
                    <table class="table table-striped table-bordered table-hover table-full-width" id="sample_1">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th class="hidden-xs">Category/Description</th> 
                                <th>Values</th>

                                <th>Add/Remove</th> 
                                    <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_ADDENTITYDESCRIPTION')"></security:authorize>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1.</td>
                                    <td class="hidden-xs">
                                        Facility is funded by:
                                    </td>
                                    <td>
                                        Central Government: <input type="radio" name="addFunder" id="govt" value="Central Government" disabled="disabled"/>
                                        Local Government:  <input type="radio" name="addFunder" id="ngo" value="Local Government" disabled="disabled"/>
                                    </td>

                                    <td align="center">
                                        <div id="funderDiv-resp">
                                        <c:set var="addFunder" value="0" />
                                        <c:forEach items="${model.descListArr}" var="list">
                                            <c:if test="${list=='addFunder'}">
                                                <c:set var="addFunder" value="1" /> 
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${addFunder==0}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="addFunder" onChange="if (this.checked) {
                                                                                ajaxSubmitData('regEntityDesc.htm', 'funderDiv-resp', 'act=a&i=${model.levelRef.facilitylevelid}&b=' + this.value + '', 'GET');
                                                                            } else {
                                                                                ajaxSubmitData('regEntityDesc.htm', 'funderDiv-resp', 'act=b&i=${model.levelRef.facilitylevelid}&b=' + this.value + '', 'GET');
                                                                            }"/>
                                        </c:if>
                                        <c:if test="${addFunder==1}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="addFunder" checked="checked" disabled="disabled"/>
                                        </c:if>

                                    </div>
                                </td>   
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_ADDENTITYDESCRIPTION')"></security:authorize>
                                </tr>
                                <tr>
                                    <td>2.</td>
                                    <td class="hidden-xs">
                                        Facility is supervised by:
                                    </td>
                                    <td>
                                        Central Government: <input type="checkbox" name="addSupervisor" id="sgovt" value="Central Government" disabled="disabled"/>
                                        Private: <input type="checkbox" name="addSupervisor" id="sprivate" value="Private" disabled="disabled"/>
                                        Local Government: <input type="checkbox" name="addSupervisor" id="localGovt" value="Local Government" disabled="disabled"/>          
                                    </td>
                                    <td align="center">
                                        <div id="supervisorDiv-resp">
                                        <c:set var="addSupervisor" value="0" />
                                        <c:forEach items="${model.descListArr}" var="list">
                                            <c:if test="${list=='addSupervisor'}">
                                                <c:set var="addSupervisor" value="1" /> 
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${addSupervisor==0}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="addSupervisor" onChange="if (this.checked) {
                                                                                ajaxSubmitData('regEntityDesc.htm', 'supervisorDiv-resp', 'act=a&i=${model.levelRef.facilitylevelid}&b=' + this.value + '', 'GET');
                                                                            } else {
                                                                                ajaxSubmitData('regEntityDesc.htm', 'supervisorDiv-resp', 'act=b&i=${model.levelRef.facilitylevelid}&b=' + this.value + '', 'GET');
                                                                            }"/>
                                        </c:if>
                                        <c:if test="${addSupervisor==1}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="addSupervisor" checked="checked" disabled="disabled"/>
                                        </c:if>
                                    </div>
                                </td>   
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_ADDENTITYDESCRIPTION')">
                                </security:authorize>
                            </tr>
                            <tr>
                                <td>3.</td>
                                <td class="hidden-xs">
                                    Facility gender is:
                                </td>
                                <td>
                                    Yes: <input type="radio" name="addGender" id="single" value="Single" disabled="disabled"/> 
                                    <select class="form-control" id="singleType" name="singleType" style="width:100px">
                                        <option value="0">--Select Gender--</option>
                                        <option value="Male Patients">Male Patients</option>
                                        <option value="Female Patients">Female Patients</option>
                                    </select>
                                    No:  <input type="radio" name="addGender" id="mixed" value="Mixed" disabled="disabled"/>
                                </td>
                                <td align="center">
                                    <div id="genderDiv-resp">
                                        <c:set var="addGender" value="0" />
                                        <c:forEach items="${model.descListArr}" var="list">
                                            <c:if test="${list=='addGender'}">
                                                <c:set var="addGender" value="1" /> 
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${addGender==0}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="addGender" onChange="if (this.checked) {
                                                                                ajaxSubmitData('regEntityDesc.htm', 'genderDiv-resp', 'act=a&i=${model.levelRef.facilitylevelid}&b=' + this.value + '', 'GET');
                                                                            } else {
                                                                                ajaxSubmitData('regEntityDesc.htm', 'genderDiv-resp', 'act=b&i=${model.levelRef.facilitylevelid}&b=' + this.value + '', 'GET');
                                                                            }"/>
                                        </c:if>
                                        <c:if test="${addGender==1}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="addGender" checked="checked" disabled="disabled"/>
                                        </c:if>
                                    </div>
                                </td>   
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_ADDENTITYDESCRIPTION')">
                                </security:authorize>
                            </tr>
                            <tr>
                                <td>4.</td>
                                <td class="hidden-xs">
                                    Nature of patient payment mode:
                                </td>
                                <td>
                                    <!--Cash: <input type="checkbox" name="cash" id="cash" value="Cash" disabled="disabled"/>
                                    Insurance: <input type="checkbox" name="insurance" id="insurance" value="Insurance" disabled="disabled"/>
                                    -->
                                    Paying: <input type="radio" name="paying" id="paying" value="Paying" disabled="disabled"/>
                                    Non paying: <input type="radio" name="paying" id="free" value="Non paying" disabled="disabled"/>
                                    <!--Both: <input type="checkbox" name="addPaymentMode" id="both" value="Both Cash and Free" disabled="disabled"/>-->
                                </td>
                                <td align="center">
                                    <div id="paymentModeDiv-resp">
                                        <c:set var="addPaymentMode" value="0" />
                                        <c:forEach items="${model.descListArr}" var="list">
                                            <c:if test="${list=='addPaymentMode'}">
                                                <c:set var="addPaymentMode" value="1" /> 
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${addPaymentMode==0}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="addPaymentMode" onChange="if (this.checked) {
                                                                                ajaxSubmitData('regEntityDesc.htm', 'paymentModeDiv-resp', 'act=a&i=${model.levelRef.facilitylevelid}&b=' + this.value + '', 'GET');
                                                                            } else {
                                                                                ajaxSubmitData('regEntityDesc.htm', 'paymentModeDiv-resp', 'act=b&i=${model.levelRef.facilitylevelid}&b=' + this.value + '', 'GET');
                                                                            }"/>
                                        </c:if>
                                        <c:if test="${addPaymentMode==1}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="addPaymentMode" checked="checked" disabled="disabled"/>
                                        </c:if>
                                    </div>
                                </td>   
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_ADDENTITYDESCRIPTION')">
                                </security:authorize>
                            </tr>
                            <tr>
                                <td>5.</td>
                                <td class="hidden-xs">
                                    Facility catchment area:
                                </td>
                                <td>
                                    National: <input type="checkbox" name="National" id="national" value="National" onClick="if(this.checked){$('#checkC_Count').val(parseInt($('#checkC_Count').val())+1);}else{$('#checkC_Count').val(parseInt($('#checkC_Count').val())-1);}"/> 
                                    Regional: <input type="checkbox" name="Regional" id="regional" value="Regional" onClick="if(this.checked){$('#checkC_Count').val(parseInt($('#checkC_Count').val())+1);}else{$('#checkC_Count').val(parseInt($('#checkC_Count').val())-1);}"/>
                                    District: <input type="checkbox" name="District" id="districtx" value="District" onClick="if(this.checked){$('#checkC_Count').val(parseInt($('#checkC_Count').val())+1);}else{$('#checkC_Count').val(parseInt($('#checkC_Count').val())-1);}"/>
                                    County: <input type="checkbox" name="County" id="county" value="County" onClick="if(this.checked){$('#checkC_Count').val(parseInt($('#checkC_Count').val())+1);}else{$('#checkC_Count').val(parseInt($('#checkC_Count').val())-1);}"/>
                                    Sub-County: <input type="checkbox" name="Sub-County" id="sub-county" value="Sub-County" checked="checked" onClick="if(this.checked){$('#checkC_Count').val(parseInt($('#checkC_Count').val())+1);}else{$('#checkC_Count').val(parseInt($('#checkC_Count').val())-1);}"/>
                                    Parish: <input type="checkbox" name="Parish" id="parish" value="Parish" checked="checked" onClick="if(this.checked){$('#checkC_Count').val(parseInt($('#checkC_Count').val())+1);}else{$('#checkC_Count').val(parseInt($('#checkC_Count').val())-1);}"/>
                                    <input type="hidden" id="checkC_Count" value="2"/>
                                </td>
                                <td align="center">
                                    <div id="catchmentAreaDiv-resp"> 
                                        <c:set var="addCatchmentArea" value="0" />
                                        <c:forEach items="${model.descListArr}" var="list">
                                            <c:if test="${list=='addCatchmentArea'}">
                                                <c:set var="addCatchmentArea" value="1" /> 
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${addCatchmentArea==0}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="addCatchmentArea" onChange="if (this.checked) {
                                var check=$('#checkC_Count').val(); if(check==0){alert('Select Atleast 1 Value For Catchment Area'); this.checked=false; return false;}
                                                                                ajaxSubmitData('regEntityDesc_Catchment.htm', 'catchmentAreaDiv-resp', 'act=a&i=${model.levelRef.facilitylevelid}&b='+this.value+'&n='+$('#national').is(':checked')+'&r='+$('#regional').is(':checked')+'&d='+$('#districtx').is(':checked')+'&c='+$('#county').is(':checked')+'&sc='+$('#sub-county').is(':checked')+'&p='+$('#parish').is(':checked')+'', 'GET');
                                                                            } else {
                                                                                ajaxSubmitData('regEntityDesc_Catchment.htm', 'catchmentAreaDiv-resp', 'act=b&i=${model.levelRef.facilitylevelid}&b=' + this.value + '&n='+$('#national').is(':checked')+'&r='+$('#regional').is(':checked')+'&d='+$('#districtx').is(':checked')+'&c='+$('#county').is(':checked')+'&sc='+$('#sub-county').is(':checked')+'&p='+$('#parish').is(':checked')+'', 'GET');
                                                                            }"/>
                                        </c:if>
                                        <c:if test="${addCatchmentArea==1}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="addCatchmentArea" checked="checked" disabled="disabled"/>
                                        </c:if>
                                    </div>
                                </td>   
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_ADDENTITYDESCRIPTION')">
                                </security:authorize>
                            </tr>
                            <tr>
                                <td>6.</td>
                                <td class="hidden-xs">
                                    Receive Adverts:
                                </td>
                                <td>
                                    Yes: <input type="radio" name="receiveAdverts" id="rYes" value="Yes" disabled="disabled"/>
                                    No: <input type="radio" name="receiveAdverts" id="rNo" value="No" disabled="disabled"/>
                                </td>
                                <td align="center">
                                    <div id="receiveAdvertsDiv-resp">
                                        <c:set var="receiveAdverts" value="0" />
                                        <c:forEach items="${model.descListArr}" var="list">
                                            <c:if test="${list=='receiveAdverts'}">
                                                <c:set var="receiveAdverts" value="1" /> 
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${receiveAdverts==0}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="receiveAdverts" onChange="if (this.checked) {
                                                                                ajaxSubmitData('regEntityDesc.htm', 'receiveAdvertsDiv-resp', 'act=a&i=${model.levelRef.facilitylevelid}&b=' + this.value + '', 'GET');
                                                                            } else {
                                                                                ajaxSubmitData('regEntityDesc.htm', 'receiveAdvertsDiv-resp', 'act=b&i=${model.levelRef.facilitylevelid}&b=' + this.value + '', 'GET');
                                                                            }"/>
                                        </c:if>
                                        <c:if test="${receiveAdverts==1}">
                                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="receiveAdverts" checked="checked" disabled="disabled"/>
                                        </c:if>
                                    </div>
                                </td>   
                                <security:authorize access="hasRole('ROLE_ROOTADMIN') or hasRole('PRIVILEGE_ADDENTITYDESCRIPTION')">
                                </security:authorize>
                            </tr>
                        </tbody>
                    </table>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-actions" align="center">
                                <input type="hidden" name="cref" id="cref" value="${model.descObjArr[0]}"/>
                                <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                <div align="left" style="alignment-adjust: central;">
                                    <div id="btnSaveHide">
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
                                                <td align="right"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="right">
                                                    <div id="selectObjBtn" style="display:none">
                                                        <input type="button" id="saveButton" name="button"class='btn btn-purple' value="Add Description" onClick="var resp = confirm('Add Description?');
                                                                                    if (resp == false) {
                                                                                        return false;
                                                                                    }
                                                                                    ajaxSubmitData('addEntityDesc.htm', 'TempDialogDiv', $('#manageFormField').serialize(), 'POST');"/> 
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
           <!-- </div>
        </div>
    </div>
</div>    
-->

<script>
    $('#panel-addEntityDesc').modal('show');
    function validateB4Submit() {
        var description = document.getElementById('description').value;
        if (description === '' || description === null) {
            if (description === null || description === '') {
                alert('Description Missing!');
            }
            return false;
        }
        return true;
    }
</script>
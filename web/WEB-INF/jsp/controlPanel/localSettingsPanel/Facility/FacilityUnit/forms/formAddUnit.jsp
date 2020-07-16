<%-- 
    Document   : formAddUnit
    Created on : May 18, 2018, 1:06:30 PM
    Author     : samuelwam
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<style>
    .transfer-unit:hover{
        text-decoration: underline !important;
        cursor: pointer; 
    }
</style>
<legend> 
    <div style="float:left" align="left">
        <c:if test="${empty model.viewForm}">
            <a id="back" href="#"  onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=d&i=${model.i}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a>
            </c:if>
            <c:if test="${not empty model.viewForm}">
            <a id="back" href="#"  onClick="${model.returnURL}"> <i class="fa fa-backward"></i></a>
            </c:if>
    </div>
    &nbsp;&nbsp;&nbsp;
    <c:if test="${empty model.unitObj}"> Add New ${model.hyrchObj.hierachylabel}</c:if>
    <c:if test="${not empty model.unitObj}"> Update ${model.unitObj.facilityunitname}</c:if>
    <!--<a href="#" onClick="ajaxSubmitData('facilityUnitSetUp.htm', 'addUnitResponse-pane', 'act=c&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">xx</a>-->
    </legend>
    <div class="row">
        <div class="col-md-12">
            <div id="addUnitResponse-pane">
                <form name="submitData" id="submitData">

                    <div class="row" id="addUpdate" <c:if test="${not empty model.viewForm}">style="display:none"</c:if>>
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <div class="row" id="facUnitInfoDiv">
                                        <div class="col-md-4">
                                        <c:if test="${model.formActivity=='Add' && not empty model.hyrchList}">
                                            <div class="form-group">
                                                <c:if test="${model.serviceLevelObj==false}">
                                                    <label class="control-label">
                                                        Select ${model.levelHyrchObj.hierachylabel}
                                                    </label>
                                                    <div id="structureSelect${i}">
                                                        <select class="form-control" id="sselect" name="sselect" onChange="if (this.value === 0) {$('#parentId').val(0); return false;} $('#parentId').val(this.value);">
                                                            <option value=0>-Select Level-</option>
                                                            <c:forEach items="${model.hyrchList}" var="list" varStatus="status">
                                                                <option value="${list.facilityunitid}">${list.facilityunitname}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>    
                                                    <c:set var="i" value="${i+1}"></c:set>
                                                </c:if>
                                                <c:if test="${model.serviceLevelObj==true}">
                                                    <div id="selectHrchyYes" style="display:none">
                                                        <label class="control-label">
                                                            Select Structure
                                                        </label>

                                                        <select class="form-control" id="sselect" name="sselect" onChange="if (this.value === 0) {
                                                            $('#parentId').val(0); return false;}
                                                                <c:if test="${model.serviceLevelObj==true}">
                                                                ajaxSubmitData('facStructureLoader.htm', 'structureSelect1', 'act=c&i='+this.value+'&b=${model.b}&c=a&d=1&e=<c:if test="${not empty model.hyrchObj.structureid}">${model.hyrchObj.structureid}</c:if><c:if test="${empty model.hyrchObj.structureid}">0</c:if>', 'GET');
                                                                </c:if>">
                                                            <option value=0>-Select ${model.levelHyrchObj.hierachylabel}-</option>
                                                            <c:forEach items="${model.hyrchList}" var="list" varStatus="status">
                                                                <option value="${list.facilityunitid}">${list.facilityunitname}</option>
                                                            </c:forEach>
                                                        </select>
                                                        <div id="structureSelect1"></div> 
                                                    </div>
                                                    <div id="selectHrchyNo">
                                                        <label class="control-label">
                                                            Set Structure
                                                        </label>
                                                        Yes: <input type="radio" name="setStructure" id="tsetStructure" value="true" onChange="showDiv('selectHrchyYes'); hideDiv('selectHrchyNo');"/>
                                                        &nbsp;&nbsp;
                                                        No: <input type="radio" name="setStructure" id="fsetStructure" value="false" onChange="hideDiv('selectHrchyYes'); showDiv('selectHrchyNo');"/>
                                                    </div>
                                                </c:if>
                                                
                                                </div>
                                        </c:if>     
                                        <!--<c:if test="${model.formActivity=='Update'}">    
                                            <c:if test="${not empty model.hyrchList}">
                                                <c:set var="i" value="0"></c:set>
                                                <c:forEach items="${model.hyrchList}" var="list" varStatus="status">
                                                    <div class="form-group">
                                                        <label class="control-label">
                                                            ${list.facilitystructure.hierachylabel}
                                                        </label>
                                                        <div id="structureSelect${i}">
                                                            <select class="form-control" id="sselect${i}" name="sselect${i}" <c:if test="${empty model.unitLevelsArr}">disabled="disabled"</c:if> onChange="clearDiv('structureSelect${i}');
                                                                    if (this.value == 0) {
                                                                        return false;
                                                                    }
                                                                    $('#parentId').val(this.value);
                                                                    ajaxSubmitData('facStructureLoader.htm', 'structureSelect${i}', 'act=a&i=' + this.value + '&b=${model.b}&c=a&d=1&e=<c:if test="${not empty model.hyrchObj.structureid}">${model.hyrchObj.structureid}</c:if><c:if test="${empty model.hyrchObj.structureid}">0</c:if>', 'GET');">
                                                                <c:if test="${i==0}">
                                                                    <c:forEach items="${model.unitLevelsArr}" var="level" varStatus="status">
                                                                        <option value="${level[0]}" <c:if test="${list.facilityunitid==level[0]}">selected="selected"</c:if>>${level[1]}</option>
                                                                    </c:forEach>
                                                                </c:if>
                                                                <c:if test="${i>0}">           
                                                                    <option value="${list.facilityunitid}">${list.facilityunitname}</option>      
                                                                </c:if>
                                                            </select>
                                                        </div>    
                                                        <c:set var="i" value="${i+1}"></c:set>
                                                        </div>
                                                </c:forEach>
                                            </c:if>
                                        </c:if>-->   
                                        <div class="form-group required">
                                            <label class="control-label">
                                                ${model.hyrchObj.hierachylabel} Name 
                                            </label>
                                            <input id="facilityunitval" class="form-control" value="${model.unitObj.facilityunitname}" placeholder="${model.hyrchObj.hierachylabel} Name" name="facilityunitname" onChange="ajaxSubmitData('facilityUnitRegCheck.htm', 'nameChkResp', 'act=b&i=${model.unitObj.facilityunitid}&b=' + this.value + '&c=b&d=0', 'GET');"/> 
                                            <div id="nameChkResp"></div>
                                            <input type="hidden" id="parentId" name="parentId" value="0"/>
                                            <input type="hidden" id="nameChk" value="true"/>
                                             <input type="hidden" id="hasParentObjs" value="<c:if test="${not empty model.hyrchList}">true</c:if><c:if test="${empty model.hyrchList}">false</c:if>"/>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Short Name
                                            </label>
                                            <input id="shortname" class="form-control" value="${model.unitObj.shortname}" placeholder="Short Name" name="shortname"/> 
                                        </div>

                                    </div>
                                    <div class="col-md-1"></div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="control-label">
                                                Description
                                            </label>
                                            <textarea name="description" id="descriptionval" placeholder="About ${model.hyrchObj.hierachylabel}" class='form-control'>${model.unitObj.description}</textarea>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label" for="telContact">
                                                Telephone Contact:<span class="symbol required">
                                            </label>
                                            <textarea name="telContact" id="telContact" placeholder="${model.hyrchObj.hierachylabel} Active Telephone/Mobile Phone Contacts" onKeyPress="return isNumberKey(event);" onKeyUp="this.value = commafyPhone(this.value);" class='form-control'>${model.unitObj.telephone}</textarea>
                                            <input type="hidden" id="phoneChk" value="true"/>
                                            <div id="phoneChkResp"></div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Location: 
                                            </label>
                                            <div class="row">
                                                <textarea name="location" id="locationval" placeholder="Direction to unit" class='form-control'>${model.unitObj.location}</textarea>
                                            </div> 
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Status: <span class="symbol required"></span>
                                            </label>
                                            Active: <input type="radio" name="status" id="fstatus" <c:if test="${model.unitObj.active==true || empty model.unitObj}">checked="checked"</c:if> value="true"/>
                                                &nbsp;&nbsp;
                                                Inactive: <input type="radio" name="status" id="tstatus" <c:if test="${model.unitObj.active==false}">checked="checked"</c:if> value="false"/>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">
                                                    Is Service Level: <span class="symbol required"></span>
                                                </label>
                                                Yes: <input type="radio" name="service" id="fservice" <c:if test="${model.hyrchObj.service==true}">checked="checked"</c:if> <c:if test="${model.hyrchObj.service==false}">disabled="disabled"</c:if> value="true"/>
                                                &nbsp;&nbsp;
                                                    No: <input type="radio" name="service" id="tservice" <c:if test="${model.hyrchObj.service==false || empty model.hyrchObj.service}">checked="checked"</c:if> value="false" <c:if test="${model.hyrchObj.service==true}">disabled="disabled"</c:if>/>
                                            </div>
                                        </div>
                                    </div>
                                            <div id="errorCheck1"></div>
                                </div>
                                <div class="tile-footer">
                                    <div class="row" id="submitBtns" >
                                        <div class="col-sm-12">
                                            <div class="form-actions" >
                                            <input type="hidden" name="serviceState" id="serviceState" value="${model.hyrchObj.service}"/>
                                            <input type="hidden" name="hyrchId" id="hyrchId" value="${model.hyrchObj.structureid}"/>
                                            <input type="hidden" name="cref" id="cref" value="${model.unitObj.facilityunitid}"/>
                                            <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                            <input type="hidden" name="formActivity" id="formActivity" value="update"/>
                                            <div align="left" style="alignment-adjust: central;">
                                                <div id="btnSaveHide">
                                                    <c:if test="${model.hyrchObj.service==true}">
                                                        <input type="button" name="button" class='btn btn-primary' value="<c:if test="${empty model.unitObj}">Save</c:if><c:if test="${not empty model.unitObj}">Update</c:if> ${model.hyrchObj.hierachylabel}" onClick="var resp = validateB4SubmitUnit();
                                                                if (resp === false) {
                                                                    return false;
                                                                }
                                                                ajaxSubmitForm('registerFacilityUnit.htm', 'addUnitResponse-pane', 'submitData');"/>
                                                    </c:if>
                                                    <c:if test="${model.hyrchObj.service==false}">
                                                        <input type="button" name="button" class='btn btn-primary' value="<c:if test="${empty model.unitObj}">Save</c:if><c:if test="${not empty model.unitObj}">Update</c:if> Hierarchy" onClick="var resp = validateB4SubmitUnit();
                                                                if (resp === false) {
                                                                    return false;
                                                                }
                                                                ajaxSubmitForm('registerFacUnitHierachy.htm', 'addUnitResponse-pane', 'submitData');"/>
                                                    </c:if>    
                                                    &nbsp;&nbsp;
                                                    <input name="" type="reset" value="Reset" class="btn" onClick="$(this.form)[0].reset()">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row" id="viewDetails" <c:if test="${empty model.viewForm}">style="display:none"</c:if>>
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <div class="row" id="facUnitInfoDiv">
                                        <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="control-label">
                                                <c:if test="${not empty model.unitObj.facilitystructure}">${model.unitObj.facilitystructure.hierachylabel} Name </c:if>
                                                <c:if test="${empty model.unitObj.facilitystructure}">Unit Name </c:if>
                                                </label>
                                            ${model.unitObj.facilityunitname}
                                            <div id="nameChkResp"></div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Short Name <span class="symbol required"></span>
                                            </label>
                                            ${model.unitObj.shortname}
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Description
                                            </label>
                                            ${model.unitObj.description}
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label" for="telContact">
                                                Telephone Contact:
                                            </label>
                                            ${model.unitObj.telephone}
                                            <div id="phoneChkResp"></div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Location: 
                                            </label>
                                            <div class="row">
                                                ${model.unitObj.location}
                                            </div> 
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Status: <span class="symbol required"></span>
                                            </label>
                                            <c:if test="${model.unitObj.active==true}">Active</c:if>
                                            <c:if test="${model.unitObj.active==false}">De-Activated</c:if>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">
                                                    Is Service Level: <span class="symbol required"></span>
                                                </label>
                                            <c:if test="${model.unitObj.service==true}">Yes</c:if>
                                            <c:if test="${model.unitObj.service==false}">No</c:if>
                                            </div>
                                        </div>

                                        <div class="col-md-1"></div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label class="control-label" for="status">Added By:</label>
                                            <c:if test="${not empty model.unitObj.person}">${model.unitObj.person.firstname} ${model.unitObj.person.lastname}</c:if>
                                            <c:if test="${empty model.unitObj.person}"><span class="text2">Pending</span></c:if> <br>
                                            <fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${model.unitObj.dateadded}"/>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Last Update By:</label>
                                            <c:if test="${not empty model.unitObj.person1}">${model.unitObj.person1.firstname} ${model.unitObj.person1.lastname}</c:if>
                                            <c:if test="${empty model.unitObj.person1}"><span class="text2">Pending</span></c:if> <br>
                                            <fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${model.unitObj.dateupdated}"/>
                                        </div>  
                                        <div class="form-group">
                                            <label class="control-label">Attached Units:</label>
                                            <c:if test="${model.unitObj.subunits>0}">${model.unitObj.subunits} [<a href="#" onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=h&i=${model.unitObj.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.unitObj.facilityunitid}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.isAttachedUnit}', 'GET');">Transfer</a>]</c:if>
                                            <c:if test="${model.unitObj.subunits==0}"><span class="text2">No Attachments</span></c:if> <br>
                                            </div>                                            
                                            <c:if test="${not empty model.hyrchList}">
                                                <fieldset>
                                                    <c:forEach items="${model.hyrchList}" var="list" varStatus="status">
                                                        <div class="form-group">
                                                            <label class="control-label">
                                                                ${list.facilitystructure.hierachylabel}
                                                            </label>
                                                            ${list.facilityunitname}    
                                                        </div>
                                                    </c:forEach>
                                                    <div class="form-group">
                                                        <span style="color:red; font-weight:strong">
                                                            <label class="control-label">
                                                                <a href="#" onClick="transferUnit(${model.unitObj.facilityunitid},'a')">Transfer Unit</a>
                                                            </label>
                                                        </span>
                                                    </div>
                                                </fieldset>
                                            </c:if>
                                            <c:if test="${empty model.hyrchList && model.isUnitObj==true}">
                                                <fieldset>
                                                    <span style="color:red; font-weight:strong">
                                                        <label class="control-label">
                                                            Unit Not Structured! <a href="#" onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addUnitResponse-pane', 'act=m&i=${model.unitObj.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Update</a>
                                                        </label>
                                                    </span>
                                                </fieldset>    
                                            </c:if>
                                            
                                        </div>    
                                    </div>
                                    <div class="tile-footer">
                                        <input type="button" name="button" class='btn btn-primary' value="Update" onClick="showDiv('addUpdate');
                                                hideDiv('viewDetails');"/>
                                        &nbsp;&nbsp;
                                        <input type="button" name="button" class='btn btn-primary' value="Unit Organogram" onClick="ajaxSubmitData('facilityUnitSetting.htm', 'viewDetails', 'act=j&i=${model.unitObj.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');"/>
                                </div>
                            </div>
                        </div>
                    </div>                                            
            </form>
        </div>
    </div>
        </div>
                                
</fieldset>


<script>
    $(document).ready(function () {
        breadCrumb();
        $('[data-toggle="popover"]').popover();
        $('#panel-addUnit').modal('show');
    });

    function validateB4SubmitUnit() {
        var unitname = document.getElementById('facilityunitval').value;
        var service = document.getElementById('serviceState').value;
        var parentId = document.getElementById('parentId').value;
        var hasParentObjs = document.getElementById('hasParentObjs').value;
        //alert('hasParentObjs:'+hasParentObjs);
        if (unitname === null || unitname === '' || ('${model.formActivity}'==='Add' && service==='false' && parentId === '0' && hasParentObjs==='true')) {//owner==null || owner=='' || 
        if ('${model.formActivity}'==='Add' && service==='false' && parentId === '0' && hasParentObjs==='true') {
                showWarningSuccess('${model.levelHyrchObj.hierachylabel} Field', 'Facility Level Structure Not Selected!', 'warning', 'errorCheck1');
            }
            if (unitname === null || unitname === '') {
                //alert('Facility Unit Name Missing!');
                showWarningSuccess('${model.hyrchObj.hierachylabel} Field', 'Facility Unit Name Missing!', 'warning', 'errorCheck1');
            }
            return false;
        }
        return true;
    }

    function commafyPhone(str) {
        var newStr = '';
        if (str.length > 10) {
            var str_array = str.split(",");
            for (var i = 0; i < str_array.length; i++) {
                newStr += str_array[i].replace(/(\d{10})/g, '$1,');
            }
            return newStr;
        }
        return str;
    }
    function commafyEmail(str) {
        var resp = true;
        if (str.length > 1) {
            var str_array = str.split(",");
            for (var i = 0; i < str_array.length; i++) {
                //newStr+=str_array[i].replace(/(\d{10})/g,'$1,');
                var checkEmail = validateEmail(str_array[i]);
                if (checkEmail === false) {
                    resp = false;
                    showWarningSuccess('INVALID EMAIL', 'Invalid Email Address:' + str_array[i] + '!', 'warning', 'emailChkResp');
                }
            }
        }
        $('#emailChk').val(resp);
        return resp;
    }

    function showWarningSuccess(title, message, type, div) {
        $.toast({
            heading: title,
            text: message,
            icon: type,
            hideAfter: 3000,
            //position: 'mid-center'
            element: '#' + div,
            position: 'mid-center',
        });

    }    
    
    function transferUnit(id,act) {
        $.confirm({
            title: 'Transfer ${model.unitObj.facilitystructure.hierachylabel}!',
            content: '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label for="itemUnitSelect">Select Destination</label>' +
                    '<select class="form-control" id="unit">' +
                    '<option value="0">All Units</option>' +
                    '<c:forEach items="${units}" var="unit">' +
                    '<option id="class${unit.id}" data-name="${unit.name}" value="${unit.id}">${unit.name}</option>' +
                    '</c:forEach></select></div>' +
                    '</form>',
            boxWidth: '40%',
            useBootstrap: false,
            type: 'purple',
            typeAnimated: true,
            buttons: {
                formSubmit: {
                    text: 'Transfer ${model.unitObj.facilitystructure.hierachylabel}',
                    btnClass: 'btn-purple',
                    action: function () {}
                },
                close: {
                    text: 'Close',
                    btnClass: 'btn-blue',
                    action: function () {

                    }
                }
            },
            onContentReady: function () {}
        });
    }
    
    var itemList = new Set();
    var itemObjectList = [];

    function funRemoveUnit(trId) {
        $('#unitname').val('');
        $('#shortname').val('');
        $('#unitDesc').val('');

        $('#' + trId + '').remove();
        var addedRecs2 = (parseInt($('#addedRecs2').val()) - 1);
        if (addedRecs2 === 0) {
            hideDiv('showSaveBtn');
            showDiv('hideSaveBtn');
            $('#addedRecs').val(0);
            $('#addedOptions').val('false')
        }
    }


    
</script>

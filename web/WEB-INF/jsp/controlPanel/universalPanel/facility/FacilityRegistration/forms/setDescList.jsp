<%-- 
    Document   : setDescList
    Created on : Jan 30, 2018, 1:01:09 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>


<div class="modal fade col-md-12" id="facSetUpByDesc" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 200%; margin-left: -50%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Set Up New ${model.levelObjArr[1]} Facility</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="$('#flevelid').val('0'); clearDiv('setUpPane');">
                    <span aria-hidden="true">&times;</span>
                </button>
                <!--<a href="#" onClick="showDiv('facDescDiv');">Show 1</a> <a href="#" onClick="hideDiv('facDescDiv');">Hide 1</a> 
                <a href="#" onClick="showDiv('facInfoDiv');">Show 2</a><a href="#" onClick="hideDiv('facInfoDiv');">Hide 2</a>-->
            </div>
            <div class="modal-body" id="orgResponse-pane">
                    <form name="submitData" id="submitData">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <div id="facDescDiv" style="display:none; margin: 10px;">
                                            <c:forEach items="${model.descList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                                <c:if test="${list.description=='addFunder'}">
                                                    <div class="form-group row">
                                                        <label class="control-label col-md-4" for="addFunder">Facility is funded by:</label>
                                                        <div class="col-md-8">
                                                            Central Government: <input type="radio" name="addFunder" id="govt2" value="Central Government"/>
                                                            &nbsp;&nbsp;
                                                           Local Government: <input type="radio" name="addFunder" id="private2" value="Local Government"/>
                                                        </div>
                                                    </div>    
                                                </c:if>
                                                <c:if test="${list.description=='addSupervisor'}">
                                                    <div class="form-group row">
                                                        <label class="control-label col-md-4" for="addSupervisor">Facility is supervised by:</label>
                                                        <div class="col-md-8">
                                                            <input type="hidden" name="addSupervisor" id="addSupervisor" value="false"/>
                                                            Central Government: <input type="checkbox" name="addSupervisorGovt" id="addSupervisorGovt" value="Central Government" onChange="if(this.checked){$('#addSupervisor').val('true');}else{if(!document.getElementById('addSupervisorPrivate').checked && !document.getElementById('addSupervisorLocalGovt').checked){$('#addSupervisor').val('false');}}"/>
                                                            &nbsp;
                                                            Private: <input type="checkbox" name="addSupervisorPrivate" id="addSupervisorPrivate" value="Private" onChange="if(this.checked){$('#addSupervisor').val('true');}else{if(!document.getElementById('addSupervisorGovt').checked &&  !document.getElementById('addSupervisorLocalGovt').checked){$('#addSupervisor').val('false');}}"/>
                                                            &nbsp;
                                                            Local Government: <input type="checkbox" name="addSupervisorLocalGovt" id="addSupervisorLocalGovt" value="Local Government" onChange="if(this.checked){$('#addSupervisor').val('true');}else{if(!document.getElementById('addSupervisorGovt').checked && !document.getElementById('addSupervisorPrivate').checked){$('#addSupervisor').val('false');}}"/>
                                                        </div>
                                                    </div>    
                                                </c:if>
                                                <c:if test="${list.description=='addGender'}">
                                                    <div class="form-group row">
                                                        <label class="control-label col-md-4" for="addGender">Facility gender is:</label>
                                                        <div class="col-md-8">
                                                            Single: <input type="radio" name="addGender" id="singleG" value="Single" onChange="showDiv('singleSelect'); $('#singleType').attr('selectedIndex', 0);"/> 
                                                            <div id="singleSelect" style="display:none">
                                                                <select class="form-control" id="singleType" name="singleType" style="width:auto">
                                                                    <option value="0">--Select Gender--</option>
                                                                    <option value="Male Patients">Male Patients</option>
                                                                    <option value="Female Patients">Female Patients</option>
                                                                </select>
                                                            </div>   
                                                            &nbsp;&nbsp;
                                                            Mixed:  <input type="radio" name="addGender" id="mixedG" value="Mixed" onChange="hideDiv('singleSelect'); $('#singleType').attr('selectedIndex', 0);"/>
                                                        </div>
                                                    </div>    
                                                </c:if>
                                                <c:if test="${list.description=='addPaymentMode'}">
                                                    <div class="form-group row">
                                                        <label class="control-label col-md-4" for="addPaymentMode">Nature of patient payment mode:</label>
                                                        <div class="col-md-8">
                                                            <input type="hidden" name="addPaymentMode" id="addPaymentMode" value="false"/>
                                                            Paying: <input type="checkbox" name="cashP" id="cashP" value="Paying" onChange="if(this.checked){$('#addPaymentMode').val('true');}else{if(!document.getElementById('insurance').checked && !document.getElementById('freeP').checked){$('#addPaymentMode').val('false');}}"/>
                                                            &nbsp;
                                                            <!--Insurance: <input type="checkbox" name="insurance" id="insurance" value="Insurance" onChange="if(this.checked){$('#addPaymentMode').val('true');}else{if(!document.getElementById('cashP').checked &&  !document.getElementById('freeP').checked){$('#addPaymentMode').val('false');}}"/>
                                                            &nbsp;-->
                                                            Non Paying: <input type="checkbox" name="free" id="freeP" value="Non Paying" onChange="if(this.checked){$('#addPaymentMode').val('true');}else{if(!document.getElementById('cashP').checked && !document.getElementById('insurance').checked){$('#addPaymentMode').val('false');}}"/>
                                                            <!--Both: <input type="checkbox" name="addPaymentMode" id="both2P" value="Both Cash and Free"/>-->
                                                        </div>
                                                    </div>    
                                                </c:if>
                                                <c:if test="${list.description=='addCatchmentArea'}">
                                                    <div class="form-group row">
                                                        <label class="control-label col-md-4" for="addPaymentMode">Facility catchment area:</label>
                                                        <div class="col-md-8">
                                                            <c:set var="opts" value="${fn:split(list.options, ',')}" />
                                                            <c:forEach items="${opts}" var="option">
                                                                <c:if test="${option=='National'}">National: <input type="radio" name="addCatchmentArea" id="nationalC" value="National" onChange="if(this.checked){$('#checkCatchment').val('true');}else{if(!document.getElementById('regionalC').checked && !document.getElementById('districtC').checked && !document.getElementById('countyC').checked && !document.getElementById('sub-countyC').checked && !document.getElementById('parishC').checked){$('#checkCatchment').val('false');}}"/></c:if>
                                                                &nbsp;&nbsp;
                                                                <c:if test="${option=='Regional'}">Regional: <input type="radio" name="addCatchmentArea" id="regionalC" value="Regional" onChange="if(this.checked){$('#checkCatchment').val('true');}else{if(!document.getElementById('nationalC').checked && !document.getElementById('districtC').checked && !document.getElementById('countyC').checked && !document.getElementById('sub-countyC').checked && !document.getElementById('parishC').checked){$('#checkCatchment').val('false');}}"/></c:if>
                                                                &nbsp;&nbsp;
                                                                <c:if test="${option=='District'}">District: <input type="radio" name="addCatchmentArea" id="districtC" value="District" onChange="if(this.checked){$('#checkCatchment').val('true');}else{if(!document.getElementById('nationalC').checked && !document.getElementById('regionalC').checked && !document.getElementById('countyC').checked && !document.getElementById('sub-countyC').checked && !document.getElementById('parishC').checked){$('#checkCatchment').val('false');}}"/></c:if>
                                                                &nbsp;&nbsp;
                                                                <c:if test="${option=='County'}">County: <input type="radio" name="addCatchmentArea" id="countyC" value="County" onChange="if(this.checked){$('#checkCatchment').val('true');}else{if(!document.getElementById('nationalC').checked && !document.getElementById('regionalC').checked && !document.getElementById('districtC').checked && !document.getElementById('sub-countyC').checked && !document.getElementById('parishC').checked){$('#checkCatchment').val('false');}}"/></c:if>
                                                                &nbsp;&nbsp;
                                                                <c:if test="${option=='Sub-County'}">Sub-County: <input type="radio" name="addCatchmentArea" id="sub-countyC" value="Sub-County" onChange="if(this.checked){$('#checkCatchment').val('true');}else{if(!document.getElementById('nationalC').checked && !document.getElementById('regionalC').checked && !document.getElementById('districtC').checked && !document.getElementById('countyC').checked && !document.getElementById('parishC').checked){$('#checkCatchment').val('false');}}"/></c:if>
                                                                &nbsp;&nbsp;
                                                                <c:if test="${option=='Parish'}">Parish: <input type="radio" name="addCatchmentArea" id="parishC" value="Parish" onChange="if(this.checked){$('#checkCatchment').val('true');}else{if(!document.getElementById('nationalC').checked && !document.getElementById('regionalC').checked && !document.getElementById('districtC').checked && !document.getElementById('countyC').checked && !document.getElementById('sub-countyC').checked){$('#checkCatchment').val('false');}}"/></c:if>
                                                            </c:forEach>
                                                            <input type="hidden" name="checkCatchment" id="checkCatchment" value="false"/>
                                                                                                                     </div>
                                                    </div>    
                                                </c:if>
                                                <c:if test="${list.description=='receiveAdverts'}">
                                                    <div class="form-group row">
                                                        <label class="control-label col-md-4" for="addPaymentMode">Receive Adverts:</label>
                                                        <div class="col-md-8">
                                                            Yes: <input type="radio" name="receiveAdverts" id="rYes2" value="Yes"/>
                                                            &nbsp;
                                                            No: <input type="radio" name="receiveAdverts" id="rNo2" value="No"/>
                                                        </div>
                                                    </div>    
                                                </c:if>
                                            </c:forEach>
                                            <input type="hidden" id="level" name="level" value="${model.levelObjArr[0]}"/>
                                        </div>
                                        <div class="row" id="facInfoDiv">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Code <span class="symbol required"></span>
                                                    </label>
                                                    <input id="facilitycode" class="form-control" value="${model.facObj.facilitycode}" placeholder="${model.facilitycode} [Code]" name="facilitycode" onChange="ajaxSubmitData('facilityRegCheck.htm', 'codeChkResp', 'act=a&i=0&b='+this.value+'&c=a&d=0', 'GET');"/>
                                                    <div id="codeChkResp"></div>
                                                    <input type="hidden" id="codeChk" value="true"/>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Facility Name <span class="symbol required">*</span>
                                                    </label>
                                                    <input id="facilityval" class="form-control" value="${model.facObj.facilityname}" placeholder="Facility Name" name="facilityname" onChange="ajaxSubmitData('facilityRegCheck.htm', 'nameChkResp', 'act=b&i=0&b='+this.value+'&c=a&d=0', 'GET');"/> 
                                                    <div id="nameChkResp"></div>
                                                    <input type="hidden" id="nameChk" value="true"/>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Short Name <span class="symbol required"></span>
                                                    </label>
                                                    <input id="shortname" class="form-control" value="${model.facObj.shortname}" placeholder="Short Name" name="shortname"/> 
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Facility Owner: <span class="symbol required">*</span>
                                                    </label>
                                                    <select class="form-control" id="fowner" name="owner" onChange="if (this.value == 0) {return false;}">
                                                        <option value="0" <c:if test="${empty model.facObj.facilityownerid}">selected="selected"</c:if>>--Select Ownership--</option>
                                                        <option value="${model.facObj.facilityownerid.facilityownerid}" <c:if test="${not empty model.facObj.facilityownerid}">selected="selected"</c:if>>${model.facObj.facilityownerid.ownername}</option>
                                                        <c:forEach items="${model.ownerListArr}" var="owners">                                
                                                            <option value="${owners[0]}" <c:if test="${model.facObj.facilityownerid.facilityownerid==owners[0]}">selected="selected"</c:if>>${owners[1]}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <div id="ownerChkResp"></div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Description: <span class="required symbol"></span>
                                                    </label>
                                                    <textarea name="description" id="descriptionval" placeholder="About Facility" class='form-control'>${model.facObj.description}</textarea>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label" for="telContact">
                                                        Telephone Contact:<span class="symbol required">
                                                    </label>
                                                    <textarea name="telContact" id="telContact" placeholder="Facility Active Telephone/Mobile Phone Contacts" onKeyPress="return isNumberKey(event);" onKeyUp="this.value=commafyPhone(this.value);" class='form-control'>${model.facObj.phonecontact}</textarea>
                                                    <input type="hidden" id="phoneChk" value="true"/>
                                                    <div id="phoneChkResp"></div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label" for="emailContact">
                                                        Email Contact:<span class="symbol required">
                                                    </label>
                                                    <textarea name="emailContact" id="emailContact" placeholder="Separate Facility Email Addresses With Comma" class='form-control' onChange="commafyEmail(this.value);">${model.facObj.emailaddress}</textarea>
                                                    <input type="hidden" id="emailChk" value="true"/>
                                                    <div id="emailChkResp"></div>
                                                </div> 
                                                <div class="form-group">
                                                    <label class="control-label" for="website">
                                                        Website:<span class="symbol required">
                                                    </label>
                                                    <textarea name="website" id="website" class='form-control' placeholder="e.g. https://www.ss.com [Separate With Comma]" onChange="commafyWebsite(this.value);">${model.facObj.website}</textarea>
                                                    <input type="hidden" id="websiteChk" value="true"/>
                                                    <div id="websiteChkResp"></div>
                                                </div>
                                            </div>
                                            <div class="col-md-1"></div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Location: <span class="symbol required">*</span>
                                                    </label>
                                                    <div class="row">
                                                        <div class="col-md-10">
                                                            <select class="form-control" id="region" name="region" onChange="if (this.value == 0) {return false;
                                                                    }ajaxSubmitData('locationsLoader.htm', 'district-pane', 'act=a&i='+this.value+'&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                                                                <option value="0">--Select Region--</option>
                                                                <c:forEach items="${model.regions}" var="regions">                                
                                                                    <option value="${regions[0]}" <c:if test="${model.facObj.village.parish.subcounty.county.district.region.regionid==regions[0]}">selected="selected"</c:if>>${regions[1]}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-10">
                                                            <div id="district-pane">
                                                                <select class="form-control" id="district" name="district" onChange="if (this.value == 0) {return false;}">
                                                                    <option value="0" <c:if test="${empty model.facObj.village}">selected="selected"</c:if>>--Select District--</option>
                                                                    <option value="${model.facObj.village.parish.subcounty.county.district.districtid}" <c:if test="${not empty model.facObj.village}">selected="selected"</c:if>>${model.facObj.village.parish.subcounty.county.district.districtname}</option>
                                                                    <c:forEach items="${model.districts}" var="districts">                                
                                                                        <option value="${districts[0]}" <c:if test="${model.facObj.village.parish.subcounty.county.district.districtid==districts[0]}">selected="selected"</c:if>>${districts[1]}</option>
                                                                    </c:forEach>
                                                                </select>  
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                    <div class="col-md-10">
                                                        <div id="county-pane">
                                                            <select class="form-control" id="county" name="county" onChange="if (this.value == 0){return false; }">
                                                                <option value="0" <c:if test="${empty model.facObj.village}">selected="selected"</c:if>>--Select County--</option>
                                                                <option value="${model.facObj.village.parishid.subcountyid.countyid.countyid}" <c:if test="${not empty model.facObj.village}">selected="selected"</c:if>>${model.facObj.village.parishid.subcountyid.countyid.countyname}</option>
                                                                <c:forEach items="${model.countys}" var="countys">                                
                                                                    <option value="${countys[0]}" <c:if test="${model.facObj.village.parishid.subcountyid.countyid.countyid==countys[0]}">selected="selected"</c:if>>${countys[1]}</option>
                                                                </c:forEach>
                                                            </select>  
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-10">
                                                        <div id="subcounty-pane">
                                                            <select class="form-control" id="subcounty" name="subcounty" onChange="if (this.value == 0){return false; }">
                                                                <option value="0" <c:if test="${empty model.facObj.village}">selected="selected"</c:if>>--Select Sub-County--</option>
                                                                <option value="${model.facObj.village.parishid.subcountyid.subcountyid}" <c:if test="${not empty model.facObj.village}">selected="selected"</c:if>>${model.facObj.village.parishid.subcountyid.subcountyname}</option>
                                                                <c:forEach items="${model.subcountys}" var="subcountys">                                
                                                                    <option value="${subcountys[0]}" <c:if test="${model.facObj.village.parishid.subcountyid.subcountyid==subcountys[0]}">selected="selected"</c:if>>${subcountys[1]}</option>
                                                                </c:forEach>
                                                            </select>  
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-10">
                                                        <div id="parish-pane">
                                                            <select class="form-control" id="parish" name="parish" onChange="if (this.value == 0){return false; }">
                                                                <option value="0" <c:if test="${empty model.facObj.village}">selected="selected"</c:if>>--Select Parish--</option>
                                                                <option value="${model.facObj.village.parishid.parishid}" <c:if test="${not empty model.facObj.village}">selected="selected"</c:if>>${model.facObj.village.parishid.parishname}</option>
                                                                <c:forEach items="${model.parish}" var="parish">                                
                                                                    <option value="${parish[0]}" <c:if test="${model.facObj.village.parishid.parishid==parish[0]}">selected="selected"</c:if>>${parish[1]}</option>
                                                                </c:forEach>
                                                            </select>  
                                                        </div>
                                                    </div>
                                                </div>                 
                                                    <div class="row">
                                                        <div class="col-md-10">
                                                            <div id="village-pane">
                                                                <select class="form-control" id="fvillage" name="village" onChange="if (this.value == 0) {return false;}">
                                                                    <option value="0" <c:if test="${empty model.facObj.village}">selected="selected"</c:if>>--Select Village--</option>
                                                                    <option value="${model.facObj.village.villageid}" <c:if test="${not empty model.facObj.village}">selected="selected"</c:if>>${model.facObj.village.villagename}</option>
                                                                    <c:forEach items="${model.villages}" var="villages">                                
                                                                        <option value="${villages[0]}" <c:if test="${model.facObj.village.villageid==villages[0]}">selected="selected"</c:if>>${villages[1]}</option>
                                                                    </c:forEach>
                                                                </select>  
                                                                    <div id="vilChkResp"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-10">
                                                            <textarea name="location" id="locationval" placeholder="Street, LC" class='form-control'>${model.facObj.location}</textarea>
                                                        <div id="locChkResp"></div>
                                                        </div>
                                                    </div> 
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Status: <span class="symbol required"></span>
                                                    </label>
                                                    Active: <input type="radio" name="status" id="fstatus" <c:if test="${model.facObj.active==true}">checked="checked"</c:if> value="true"/>
                                                        &nbsp;&nbsp;
                                                        Inactive: <input type="radio" name="status" id="tstatus" <c:if test="${model.facObj.active==false || empty model.facObj}">checked="checked"</c:if> value="false"/>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label">
                                                            Has Departments: <span class="symbol required"></span>
                                                        </label>
                                                        Yes: <input type="radio" name="hasDept" id="hasDeptY" <c:if test="${model.facObj.hasdepartments==true}">checked="checked"</c:if>  value="true" onChange="showDiv('selectBranch');
                                                                $('#school').val('');"/>
                                                        &nbsp;&nbsp;
                                                        No: <input type="radio" name="hasDept" id="hasDeptN" <c:if test="${model.facObj.hasdepartments==false || empty model.facObj}">checked="checked"</c:if>  value="false" onChange="hideDiv('selectBranch');
                                                                $('#school').val('');"/> 
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label" for="postaddress">
                                                            Postal Address:
                                                        </label>
                                                        <textarea name="postaddress" id="postaddress" placeholder="i.e. P.O. Box 000 Kla-Uganda" class='form-control'>${model.facObj.postaddress}</textarea>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label" for="facilitylogo">
                                                        Facility Logo Upload
                                                    </label>
                                                    <div class="fileupload fileupload-new" data-provides="fileupload">
                                                        <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;"><img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA?text=no+image" alt=""/>
                                                        </div>
                                                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
                                                        <div>
                                                            <span class="btn btn-light-grey btn-file"><span class="fileupload-new"><i class="fa fa-picture-o"></i> Select image</span><span class="fileupload-exists"><i class="fa fa-picture-o"></i> Change</span>
                                                                <input type="file" id="browsed" accept=".jpg, .jpeg, .png">
                                                                <input type="hidden" id="urlPathSet">
                                                            </span>
                                                            <a href="#" class="btn fileupload-exists btn-light-grey" data-dismiss="fileupload">
                                                                <i class="fa fa-times"></i> Remove
                                                            </a>
                                                            <a href="#" class="btn fileupload-exists btn-light-grey" onClick="uploadAttachment('uploadUserPhoto.htm', 'FacilityLogo', 'urlPathSet', 'browsed');">
                                                                <i class="fa fa-picture"></i> Upload
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>    
                                    </div>
                                    <div class="tile-footer">
                                        <div class="row" id="navBtns" style="display:none">
                                            <div class="col-md-8 col-md-offset-3">
                                                <input class="btn btn-primary" type="button" value="Next >>" onClick="var resp = true;//validateB4SubmitDesc();
                                                        if (resp === false) {return false;}
                                                        hideDiv('facDescDiv'); showDiv('facInfoDiv'); hideDiv('navBtns'); showDiv('submitBtns');"/>

                                                <input type="reset" class="btn btn-white" onClick="$(this.form)[0].reset();
                                                        clearDiv('descList');" value="Refresh">
                                            </div>
                                        </div>
                                        <div class="row" id="submitBtns">
                                            <div class="col-sm-12">
                                                <div class="form-actions" >
                                                    <input type="hidden" name="cref" id="cref" value="${model.facObj.facilityid}"/>
                                                    <input type="hidden" name="saveActivity" id="saveActivity" value="true"/>
                                                    <input type="hidden" name="formActivity" id="formActivity" value="save"/>
                                                    <div align="left" style="alignment-adjust: central;">
                                                        <div id="btnSaveHide">
                                                            <!--<input class="btn btn-blue" type="button" onClick="showDiv('facDescDiv'); hideDiv('facInfoDiv'); showDiv('navBtns'); hideDiv('submitBtns');" value="<< Back">-->
                                                            <input type="button" name="button" class='btn btn-primary' value="<c:if test="${empty model.facObj}">Save</c:if><c:if test="${not empty model.facObj}">Update</c:if> Facility" onClick="var resp = validateB4SubmitFacility();
                                                                    if (resp === false) {return false;} ajaxSubmitForm('registerFacility.htm', 'orgResponse-pane', 'submitData');"/>
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

                </form>
                   
            </div>
        </div>
    </div>
</div>
<script>
function commafyPhone(str){
    var newStr='';
    if(str.length>10){
        var str_array=str.split(",");
        for(var i = 0; i < str_array.length; i++) {
            newStr+=str_array[i].replace(/(\d{10})/g,'$1,');
        }
        return newStr;
    }
    return str;
}
function commafyEmail(str){
    var resp=true;
    if(str.length>1){
        var str_array=str.split(",");
        for(var i = 0; i < str_array.length; i++) {
            //newStr+=str_array[i].replace(/(\d{10})/g,'$1,');
            var checkEmail=validateEmail(str_array[i]); 
            if(checkEmail===false){
                resp=false;
                showWarningSuccess('INVALID EMAIL', 'Invalid Email Address:'+str_array[i]+'!', 'warning', 'emailChkResp');
            }
        }
    }
    $('#emailChk').val(resp);
    return resp;
}
function commafyWebsite(str){
    var resp=true;
    if(str.length>1){
        var str_array=str.split(",");
        for(var i = 0; i < str_array.length; i++) {
            var regex = /(http|https):\/\/(\w+:{0,1}\w*)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%!\-\/]))?/;
            if(!regex.test(str_array[i])) {
                showWarningSuccess('INVALID WEBSITE', 'Invalid Website Address:'+str_array[i]+'!', 'warning', 'websiteChkResp');
                resp=false;
            }
        }
    }
    $('#websiteChk').val(resp);
    return resp;
}

    $('#facSetUpByDesc').modal('show');

function validateB4SubmitFacility() {
        var facilityname = document.getElementById('facilityval').value;
        var owner=document.getElementById('fowner').value;
        var village = document.getElementById('fvillage').value;
        var location = document.getElementById('locationval').value;
        var description = document.getElementById('descriptionval').value;
        var codeChk = document.getElementById('codeChk').value;
        var nameChk = document.getElementById('nameChk').value;
        var phone = document.getElementById('phoneChk').value;
        var email = document.getElementById('emailChk').value;
        var website = document.getElementById('websiteChk').value;
        //alert('facilityname:'+facilityname);
        var email = document.getElementById('emailContact').value;
        
        if (facilityname === null || facilityname === '' || nameChk === false  || owner===null || owner==='0'  || owner==='' ||
                village === null || village ==='0' || village ==='' || location === '' || location === null 
                || phone === false || email === false || website === false || codeChk===false) {//owner==null || owner=='' || 
            if(owner===null || owner==='' || owner ==='0'){
                //alert('Facility Owner Missing!');
                showWarningSuccess('MISSING DETAILS', 'Facility Owner Missing!', 'warning', 'ownerChkResp');
            }
            if (facilityname === null || facilityname === '') {
                //alert('Facility Name Missing!');
                showWarningSuccess('MISSING DETAILS', 'Facility Name Missing!', 'warning', 'nameChkResp');
            }
            if (village === null || village === '' || village ==='0') {
                //alert('Facility Village Missing!');
                showWarningSuccess('MISSING DETAILS', 'Facility Village Location Missing!', 'warning', 'vilChkResp');
            }
            if (location === null || location === '') {
                //alert('Facility Location Description Missing!');
                showWarningSuccess('MISSING DETAILS', 'Facility Location Description/LC Missing!', 'warning', 'locChkResp');
            }
            if (nameChk === false) {
                showWarningSuccess('Name Verification', 'Name Supplied Is Already In Use!', 'warning', 'nameChkResp');
            }
            if (codeChk === false) {
                showWarningSuccess('Code Verification', 'Code Supplied Is Already In Use!', 'warning', 'codeChkResp');
            }
            if (phone === false) {
                showWarningSuccess('INVALID DETAILS', 'Wrong Facility Phone Contact!', 'warning', 'phoneChkResp');
            }
            if (email === false) {
                showWarningSuccess('INVALID DETAILS', 'Wrong Facility Email Address!', 'warning', 'emailChkResp');
            }
            if (website === false) {
                showWarningSuccess('INVALID DETAILS', 'Wrong Facility Website Address!', 'warning', 'websiteChkResp');
            }
            return false;
        }
        if (email!==null && email!==''){
            if(commafyEmail(email)!==true){
                //alert('Invalid Email Address!');
                showWarningSuccess('MISSING DETAILS', 'Invalid Email Address!', 'warning', 'emailChkResp');
                return false;
            }
        } 
        return true;
    }
    
    function validateEmail(email) {
        var atpos = email.indexOf("@");
        var dotpos = email.lastIndexOf(".");
        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
            return false;
        }
        return true;
    }
    
    function validateB4SubmitDesc() {
        var submitResp = true;
        var levelid = document.getElementById('flevelid').value;
        if (levelid === null || levelid === '0') {
            alert('Level Not Selected!');
            submitResp = false;
        }

    <c:forEach items="${model.descList}" var="list">
        <c:if test="${list.description=='addFunder'}">
        if (!document.getElementById('govt2').checked && !document.getElementById('private2').checked && !document.getElementById('both2').checked) {
            submitResp = false;
            alert('Type of Funder Not Selected!');
        }
        </c:if>
        <c:if test="${list.description=='addSupervisor'}">
            if (document.getElementById('checkPaymentMode').value==='false'){
                submitResp = false;
                alert('Facility Supervisor Not Selected!');
        //if (!document.getElementById('sgovt').checked && !document.getElementById('sprivate').checked && !document.getElementById('sboth').checked) {
        }
        </c:if>
        <c:if test="${list.description=='addGender'}">
        if (!document.getElementById('singleG').checked && !document.getElementById('mixedG').checked) {
            submitResp = false;
            alert('Nature of Gender Not Selected!');
        }
        if (document.getElementById('singleG').checked && document.getElementById('singleType').value == '0') {
            submitResp = false;
            alert('Type of Gender Not Selected For Single Sex Facility!');
        }
        </c:if>
        <c:if test="${list.description=='addPaymentMode'}">
        if (document.getElementById('addPaymentMode').value==='false'){
        //if (!document.getElementById('cashP').checked && !document.getElementById('freeP').checked && !document.getElementById('both2P').checked) {
            submitResp = false;
            alert('Nature of Payement Mode Not Selected!');
        }
        </c:if>
        <c:if test="${list.description=='addCatchmentArea'}">
        if (document.getElementById('checkCatchment').value==='false'){
        //if (!document.getElementById('nationalC').checked && !document.getElementById('regionalC').checked && !document.getElementById('districtC').checked && !document.getElementById('countyC').checked && !document.getElementById('sub-countyC').checked) {
            submitResp = false;
            alert('Catchment Area Not Selected!');
        }
        </c:if>
        <c:if test="${list.description=='receiveAdverts'}">
        if (!document.getElementById('rYes2').checked && !document.getElementById('rNo2').checked) {
            submitResp = false;
            alert('State If Facility Should Receive Adverts!');
        }
        </c:if>
    </c:forEach>

        return submitResp;
    }
    
    
    function showWarningSuccess(title, message, type, div){
        $.toast({
                                        heading: title,
                                        text: message,
                                        icon: type,
                                        hideAfter: 6000,
                                        //position: 'mid-center'
                                        element: '#' + div,
                                        position: 'mid-center',
                                    });
        
    }

</script>

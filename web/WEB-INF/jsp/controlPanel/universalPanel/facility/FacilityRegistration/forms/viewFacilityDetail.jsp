<%-- 
    Document   : viewFacilityDetail
    Created on : Nov 29, 2017, 8:40:27 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="titleAct" value="Add New"></c:set>    
<c:if test="${not empty model.facObj}"><c:set var="titleAct" value="Update"></c:set></c:if>


        <div class="modal-content">
            <!--<div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onClick="clearDiv('workPane'); ajaxSubmitData('organisationSetting.htm', 'workPane', 'act=g&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    &times;
                </button>
                <h4><i class="fa fa-pencil-square teal"></i>FACILITY DETAILS</h4>
            </div>
            -->
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <!-- start: FORM VALIDATION 1 PANEL -->
                        <div class="panel panel-default">
                            <div class="panel-heading"></div>
                            <div class="panel-body" id="formResponse-pane">
                            <c:if test="${model.resp==true}">
                                <form name="submitData" id="submitData">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div>
                                                <h1>${model.successMessage}</h1>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row tile" id="facInfoDiv">
                                        <div class="col-md-4">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="tile">
                                                        <div class="tile-body">
                                                            <div id="horizontalwithwords"><span class="pat-form-heading">FACILITY DETAILS</span></div>
                                                            <div class="form-group">
                                                                <label class="control-label" for="fLevel">Level Of Facility:</label>
                                                                <c:if test="${not empty model.facObj.facilitylevelid.facilitylevelname}">${model.facObj.facilitylevelid.facilitylevelname}</c:if>
                                                                <c:if test="${empty model.facObj.facilitylevelid.facilitylevelname}"><span class="text2">Pending</span></c:if>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="control-label">Code</label>
                                                                <c:if test="${not empty model.facObj.facilitycode}">${model.facObj.facilitycode}</c:if>
                                                                <c:if test="${empty model.facObj.facilitycode}"><span class="text2">Pending</span></c:if>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="control-label">
                                                                        Facility Name
                                                                    </label>
                                                                <c:if test="${not empty model.facObj.facilityname}">${model.facObj.facilityname}</c:if>
                                                                <c:if test="${empty model.facObj.facilityname}"><span class="text2">Pending</span></c:if>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="control-label">
                                                                        Short Name
                                                                    </label>
                                                                <c:if test="${not empty model.facObj.shortname}">${model.facObj.shortname}</c:if>
                                                                <c:if test="${empty model.facObj.shortname}"><span class="text2">Pending</span></c:if>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="control-label">
                                                                        Facility Owner:
                                                                    </label>
                                                                <c:if test="${not empty model.facObj.facilityownerid.ownername}">${model.facObj.facilityownerid.ownername}</c:if>
                                                                <c:if test="${empty model.facObj.facilityownerid.ownername}"><span class="text2">Pending</span></c:if>
                                                                    <div id="ownerChkResp"></div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="control-label">
                                                                        Description: <span class="required symbol"></span>
                                                                    </label>
                                                                <c:if test="${not empty model.facObj.description}">${model.facObj.description}</c:if>
                                                                <c:if test="${empty model.facObj.description}"><span class="text2">Pending</span></c:if>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="tile">

                                                            <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">LOCATION</span></div>
                                                            <div class="form-group">
                                                                <label class="control-label">Region:</label>
                                                            <c:if test="${not empty model.facObj.village.parishid.subcountyid.countyid.districtid.regionid}">${model.facObj.village.parishid.subcountyid.countyid.districtid.regionid.regionname}</c:if>
                                                            <c:if test="${empty model.facObj.village.parishid.subcountyid.countyid.districtid.regionid}"><span class="text2">Pending</span></c:if>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">
                                                                    District:
                                                                </label>
                                                            <c:if test="${not empty model.facObj.village.parishid.subcountyid.countyid.districtid}">${model.facObj.village.parishid.subcountyid.countyid.districtid.districtname}</c:if>
                                                            <c:if test="${empty model.facObj.village.parishid.subcountyid.countyid.districtid}"><span class="text2">Pending</span></c:if> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">
                                                                    County:
                                                                </label>
                                                            <c:if test="${not empty model.facObj.village.parishid.subcountyid.countyid.countyname}">${model.facObj.village.parishid.subcountyid.countyid.countyname}</c:if>
                                                            <c:if test="${empty model.facObj.village}"><span class="text2">Pending</span></c:if> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">
                                                                    Village:
                                                                </label>
                                                            <c:if test="${not empty model.facObj.village}">${model.facObj.village.villagename}</c:if>
                                                            <c:if test="${empty model.facObj.village}"><span class="text2">Pending</span></c:if> 
                                                            </div>  
                                                            <div class="form-group">
                                                                <label class="control-label">
                                                                    Street/LC:
                                                                </label>
                                                            <c:if test="${not empty model.facObj.location}">${model.facObj.location}</c:if>
                                                            <c:if test="${empty model.facObj.location}"><span class="text2">Pending</span></c:if>   
                                                            </div> 
                                                            <div style="margin-top: 1px" id="horizontalwithwords"><span class="pat-form-heading">CONTACT DETAILS</span></div>

                                                            <div class="form-group">
                                                                <label class="control-label">Phone Contact:</label>
                                                            <c:if test="${not empty model.facObj.phonecontact}">${model.facObj.phonecontact}</c:if>
                                                            <c:if test="${empty model.facObj.phonecontact}"><span class="text2">Pending</span></c:if>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="control-label">Email Address:</label>
                                                            <c:if test="${not empty model.facObj.emailaddress}">${model.facObj.emailaddress}</c:if>
                                                            <c:if test="${empty model.facObj.emailaddress}"><span class="text2">Pending</span></c:if>
                                                            </div> 
                                                            <div class="form-group">
                                                                <label class="control-label">Web Site:</label>
                                                            <c:if test="${not empty model.facObj.website}">${model.facObj.website}</c:if>
                                                            <c:if test="${empty model.facObj.website}"><span class="text2">Pending</span></c:if>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="tile">

                                                            <div id="horizontalwithwords"><span class="pat-form-heading">OTHER DETAILS</span></div>
                                                            <div class="form-group">
                                                                <label class="control-label" for="status">Status:</label>
                                                                <c:if test="${not empty model.facObj.active}">
                                                                    <c:if test="${model.facObj.active==true}">Active</c:if>
                                                                    <c:if test="${model.facObj.active==false}"><span style="color:red">Inactive</span></c:if>
                                                                </c:if>
                                                                <c:if test="${empty model.facObj.active}"><span class="text2">Pending</span></c:if>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label" for="status">Has Departments:</label>
                                                            <c:if test="${not empty model.facObj.hasdepartments}">
                                                                <c:if test="${model.facObj.hasdepartments==true}">Yes</c:if>
                                                                <c:if test="${model.facObj.hasdepartments==false}">No</c:if>
                                                            </c:if>
                                                            <c:if test="${empty model.facObj.hasdepartments}"><span class="text2">Pending</span></c:if>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label" for="status">Added By:</label>
                                                            <c:if test="${not empty model.facObj.person2.firstname}">${model.facObj.person2.firstname} ${model.facObj.person2.lastname}</c:if>
                                                            <c:if test="${empty model.facObj.person2.firstname}"><span class="text2">Pending</span></c:if> <br>
                                                            <fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${model.facObj.dateadded}"/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label" for="status">Approved By:</label>
                                                            <c:if test="${not empty model.facObj.person1.firstname}">${model.facObj.person1.firstname} ${model.facObj.person1.lastname}</c:if>
                                                            <c:if test="${empty model.facObj.person1.firstname}"><span class="text2">Pending</span></c:if> <br>
                                                            <fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${model.facObj.dateapproved}"/>
                                                        </div>
                                                        <div id="horizontalwithwords"><span class="pat-form-heading">POLICIES</span></div>
                                                        <div class="form-group">
                                                            <c:if test="${not empty model.policyList}">
                                                                <c:forEach items="${model.policyList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                                                    <div class="form-group">
                                                                        <label class="control-label">${list.policyname}</label>
                                                                        <ul>
                                                                            <c:forEach items="${list.facilitypolicyoptionsList}" var="list2">
                                                                                <li><i>${list2.name}</i></li>
                                                                                    </c:forEach>
                                                                        </ul>
                                                                    </div>
                                                                </c:forEach>
                                                            </c:if>
                                                            <c:if test="${empty model.policyList}">
                                                                <label class="control-label">No Polcies Attached To This Facility</label>
                                                            </c:if>
                                                        </div>

                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </form>
                        </c:if>
                        <c:if test="${model.resp==false}">
                            <div class="row">
                                <div class="col-md-12">
                                    <div>
                                        <h1>${model.successMessage}</h1>
                                    </div>
                                </div>
                            </div> 
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <c:if test="${model.addPolicy==true}">
                <button class="btn btn-primary" id="saveuser" onClick="ajaxSubmitData('entityPolicySetting.htm', 'orgResponse-pane', 'act=d&i=${model.facObj.facilityid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    <i class="fa fa-fw fa-lg fa-plus-circle">
                        </i>Add Facility Policy
                    </button>
                
                    <div class="pull-right" style="display:none">
                        <button data-toggle="modal" data-target="#getFacilityPolicyForm"  id="formFacilityPolicy" class="btn btn-primary pull-right" type="button">
                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>Set Facility Policy
                        </button>
                    </div>
            </c:if>
        </div>
                <div id="policySetting-pane"></div>
    </div>
    <!-- /.modal-content -->
</div>
<div id="addFacilityPolicy" class="supplierCatalogDialog">
    <div>
        <div id="head">
            <a href="#close" title="Close" class="close2">X</a>
            <h2 class="modalDialog-title" id="policyTitle">Add Facility Policy</h2>
            <hr>
        </div>
        <div class="row scrollbar" id="content">
            <div class="form-group row" style="width:100%">
                <div class="col-md-8">
                    <form id="submitFacPolicy" name="submitFacPolicy" style="width:100%">
                    <div class="form-group row" style="width:100%">
                                    <div class="tile" style="width:100%">
                                        <h4 class="tile-title">Enter Policy Details</h4>
                                        <div class="tile-body" style="width:100%">
                                            <c:forEach items="${model.policyList}" var="list" varStatus="status">
                                                <div class="form-group">
                                                    <label class="control-label">${status.count}. ${list.category} - ${list.policyname}: </label>&nbsp;&nbsp;
                                                    <c:forEach items="${list.facilitypolicyoptionsList}" var="opt" varStatus="status2">
                                                        <c:if test="${list.datatype=='Single Option'}">
                                                            ${opt.name}: <input type="radio" name="hasDept" id="hasDeptY" value="true"/> &nbsp;&nbsp;
                                                        </c:if>
                                                        <c:if test="${list.datatype=='Multiple Option'}">
                                                            ${opt.name}: <input type="checkbox" name="hasDept" id="hasDeptY" value="true"/> &nbsp;&nbsp;
                                                        </c:if>
                                                        <c:if test="${list.datatype=='Text'}">
                                                            <input class="form-control col-md-10" id="policyOpt${status.count}${status2.count}" name="policyOpt${status.count}${status2.count}" type="text" placeholder="Enter Value"><br>
                                                        </c:if>
                                                    </c:forEach>

                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                    </div>
                        <div class="form-group row">
                            <div id="btnSaveHide">
                                <input type="button" name="button" class='btn btn-primary icon-btn' value="Save Facility Policy" onClick="ajaxSubmitForm('registerFacilityPolicy.htm', 'content', 'submitFacPolicy');"/>
                        &nbsp;&nbsp;
                        <input name="" type="reset" value="Reset" class="btn" onClick="$(this.form)[0].reset()">
                    </div>
                        </div>
                </form>
                </div>
            </div>
        </div>
    </div>
</div>
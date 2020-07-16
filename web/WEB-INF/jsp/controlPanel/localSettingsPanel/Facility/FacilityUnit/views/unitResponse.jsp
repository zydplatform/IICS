<%-- 
    Document   : unitResponse
    Created on : May 18, 2018, 2:56:35 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<br><br>
<div class="panel-body">
    <div class="table-responsive">
        <c:if test="${model.resp==true}">
            <h2>${model.successMessage}</h2>
        </c:if>
        <c:if test="${model.resp==false}">
            <c:if test="${model.mainActivity!='Discard Units' || model.mainActivity!='Discard Unit' || model.mainActivity!='Transfer Unit'}">
                <h2>Sorry, Save Failed  <br/> 
                </c:if>
                <c:if test="${model.mainActivity=='Discard Units' || model.mainActivity=='Discard Unit'}">
                    <h2>Sorry, Delete Failed  <br/> 
                    </c:if>
                    <c:if test="${model.mainActivity=='Transfer Unit'}">
                        <h2>Sorry, Transfer Failed  <br/> 
                        </c:if>        
                        ${model.errorMessage}
                    </h2>
                </c:if>
                <c:if test="${model.mainActivity=='Facility Unit'}">
                    <c:if test="${not empty model.orgList}">   
                        <table class="table table-bordered table-hover" id="sample-table-1">
                            <thead>
                                <tr>
                                    <th class="center"></th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${model.facilityUnitList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                    <tr>
                                        <td align="left">&nbsp;</td>
                                        <td align="left">${list.facilityunitname}</td>
                                        <td align="left">${list.description}</td>                                            
                                        <td align="center"><c:if test="${list.active==true}">Active</c:if><c:if test="${list.active==false}">Disabled</c:if></td>
                                        </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${model.addMoreUnits==true}">
                            <input type="button" name="button" class='btn btn-primary' id="formAddMoreFacilityUnit" value="Add More Units" onClick="ajaxSubmitData('facilityUnitSetUp.htm', 'addUnitResponse-pane', 'act=c&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"/>
                    </c:if>
                </c:if>
                <c:if test="${model.mainActivity=='Facility Unit-2'}">
                    <c:if test="${not empty model.orgList}">   
                        <table class="table table-bordered table-hover" id="sample-table-1">
                            <thead>
                                <tr>
                                    <th class="center"></th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${model.facilityUnitList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                    <tr>
                                        <td align="left">&nbsp;</td>
                                        <td align="left">${list.facilityunitname}</td>
                                        <td align="left">${list.description}</td>                                            
                                        <td align="center"><c:if test="${list.active==true}">Active</c:if><c:if test="${list.active==false}">Disabled</c:if></td>
                                        </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </c:if>            
                <c:if test="${model.mainActivity=='Discard Unit'}">
                    <fieldset style="width:95%; margin: 0 auto;" >
                        <legend> 
                            <div style="float:left" align="left"><a id="back" href="#"  onClick="ajaxSubmitData('facilityUnitSetUp.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"> <i class="fa fa-backward"></i></a></div>
                            &nbsp;&nbsp;&nbsp;
                            Details For Hierarchy Node Under: ${model.facObj.facilityname}
                        </legend>
                        <c:if test="${not empty model.facilityUnitList}">   
                            <table class="table table-bordered table-hover" id="sample-table-1">
                                <thead>
                                    <tr>
                                        <th class="center"></th>
                                        <th>Name</th>
                                        <th>Description</th>
                                            <c:if test="${model.deletedObjState==false}">
                                            <th>Attached Nodes</th>
                                            </c:if>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${model.facilityUnitList}" var="list" varStatus="status" begin="0" end="${model.size}">
                                        <tr>
                                            <td align="left">&nbsp;</td>
                                            <td align="left">${list.facilityunitname}</td>
                                            <td align="left">${list.description}</td>
                                            <c:if test="${model.deletedObjState==false}">
                                                <td align="left">${list.subunits}</td>
                                            </c:if>
                                            <td align="center"><c:if test="${list.active==true}">Active</c:if><c:if test="${list.active==false}">Disabled</c:if></td>
                                            </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </fieldset>
                </c:if>  
                <c:if test="${model.mainActivity=='Discard Units'}">
                    <c:if test="${not empty model.unitObj}">   
                        <table class="table table-bordered table-hover" id="sample-table-1">
                            <thead>
                                <tr>
                                    <th class="center"></th>
                                    <th>Facility Unit Name</th>
                                    <th>Description</th>
                                        <c:if test="${model.resp==false}">
                                        <th>Attached Units</th>
                                        </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td align="left">&nbsp;</td>
                                    <td align="left">${model.unitObj.facilityunitname}</td>
                                    <td align="center"><c:if test="${model.unitObj.active==true}">Deleted Failed!!</c:if><c:if test="${model.unitObj.active==false || empty model.unitObj.active}">Deleted Unit!</c:if></td>
                                    <c:if test="${model.resp==false}">
                                        <td align="center">${model.unitObj.subunits} [<a href="#" onClick="ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act=h&i=${model.unitObj.facilityunitid}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Transfer</a>]</td>
                                    </c:if>
                                </tr>
                            </tbody>
                        </table>
                    </c:if>
                </c:if>
                </div>
                </div>
                <div id="addMoreFacilityUnit" class="supplierCatalogDialog">
                    <div>
                        <div id="head">
                            <a href="#close" title="Close" class="close2">X</a>
                            <h2 class="modalDialog-title" id="policyTitle"><c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Register Facility Unit</c:if></h2>
                                <hr>
                            </div>
                            <div class="row scrollbar" id="unitcontent">

                                <div class="form-group row" style="width:100%">
                                    <div class="col-md-4">
                                        <div class="row">
                                            <div class="col-md-10">
                                                <div class="tile">
                                                        <h4 class="tile-title"><c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if> Details</h4>
                                                    <div class="tile-body">
                                                        <form id="entryform">
                                                            <div class="form-group required">
                                                                    <label class="control-label"><c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if> Name</label>
                                                            <input class="form-control col-md-10" id="unitname" name="unitname" type="text" placeholder="<c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if> Name">
                                                            </div>
                                                            <div class="form-group required">
                                                                <label class="control-label">Short Name</label>
                                                                <input class="form-control col-md-10" id="shortname" name="shortname" type="text" placeholder="Short Name">
                                                            </div>
                                                            <div class="form-group required">
                                                                <label class="control-label">Description</label>
                                                                    <textarea class="form-control col-md-10" rows="2" id="unitDesc" name="description" placeholder="About <c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if>"></textarea>
                                                            </div>                                                
                                                        </form>
                                                    </div>
                                                    <div class="tile-footer">
                                                        <button class="btn btn-primary" id="addMoreUnits" type="button">
                                                            <i class="fa fa-fw fa-lg fa-plus-circle"></i>
                                                                Add <c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <form id="submitUnit" name="submitUnit">
                                            <div class="row">
                                                <div class="col-md-12" id="unitResponse">
                                                    <div class="tile">
                                                        <h4 class="tile-title">Verify Entered Items.</h4>
                                                        <table class="table table-sm" id="verifyItems">
                                                            <thead>
                                                                <tr>
                                                                    <th>Unit Name</th>
                                                                    <th>Short Name</th>
                                                                    <th>Description</th>
                                                                    <th>Remove</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="enteredItemsBody">

                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-sm-12 text-right">
                                                            <input type="hidden" id="addedOptions" value="false"/>
                                                            <input type="hidden" id="addedRecs" value="0" name="itemSize"/>
                                                            <input type="hidden" id="addedRecs2" value="0"/>
                                                            <div id="hideSaveBtn">
                                                                    <button type="button" disabled="disabled" class="btn btn-primary" id="saveUnit">Save New <c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if></button>
                                                            </div>
                                                            <div id="showSaveBtn" style="display:none">
                                                                    <button type="button" class="btn btn-primary" id="saveUnit2" onClick="ajaxSubmitForm('registerFacUnits.htm', 'unitResponse', 'submitPolicy');">Save New <c:if test="${not empty model.hyrchObj}">Register ${model.hyrchObj.hierachylabel}</c:if><c:if test="${empty model.hyrchObj}">Facility Unit</c:if></button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group"></div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                                        
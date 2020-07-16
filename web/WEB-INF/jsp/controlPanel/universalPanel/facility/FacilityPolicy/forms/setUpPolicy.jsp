<%-- 
    Document   : setUpPolicy
    Created on : Jun 28, 2018, 10:28:57 AM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<form id="submitData2" name="submitData2" style="width:100%">
    <div class="form-group row" style="width:100%">
        <div class="col-md-6">
            <div class="row">
                <div class="col-md-10">
                    <div class="tile">
                        <h4 class="tile-title">Enter Policy Details</h4>
                        <div class="tile-body">
                            <div class="form-group required">
                                <label class="control-label">Policy Category</label>
                                <select class="form-control col-md-10" id="pcategory2" name="pcategory" onChange="">
                                    <option id="1" value="Patient Policy" <c:if test="${model.policyObj.category=='Patient Policy'}">selected="selected"</c:if>>Patient Policy</option>
                                    <option id="2" value="Supplier Policy" <c:if test="${model.policyObj.category=='Supplier Policy'}">selected="selected"</c:if>>Supplier Policy</option>
                                    <option id="3" value="Procurement Policy" <c:if test="${model.policyObj.category=='Procurement Policy'}">selected="selected"</c:if>>Procurement Policy</option>
                                </select>
                            </div>
                            <div class="form-group required">
                                <label class="control-label">Policy Name</label>
                                <input class="form-control col-md-10" id="policyname2" name="policyname" type="text" placeholder="Policy Name" value="${model.policyObj.policyname}">
                            </div>
                            <div class="form-group required">
                                <label class="control-label">Description</label>
                                <textarea class="form-control col-md-10" rows="2" id="policyDesc2" name="description" placeholder="About Policy">${model.policyObj.description}</textarea>
                            </div>
                            <div class="form-group required">
                                <label class="control-label">Data Type</label>
                                <select class="form-control col-md-10" id="pdatatype2" name="pdatatype" onChange="">
                                    <option id="0" value="0">-Select Data type-</option>
                                    <option id="1" value="Single Option" <c:if test="${model.policyObj.datatype=='Single Option'}">selected="selected"</c:if>>Single Option</option>
                                    <option id="2" value="Multiple Option" <c:if test="${model.policyObj.datatype=='Multiple Option'}">selected="selected"</c:if>>Multiple Option</option>
                                    <option id="3" value="Text" <c:if test="${model.policyObj.datatype=='Text'}">selected="selected"</c:if>>Text</option>
                                </select>
                            </div>
                            <div class="form-group required">
                                <button type="button" class="btn btn-dark-grey" id="updatePolicyOption" onClick="updateAddPolicy(0);">Add Option</button>
                            </div>
                        </div>
                                <div class="form-group row">
        <div  style="margin:auto;">
            <button type="button" class="btn btn-primary" id="updatePolicyBtn" onClick="ajaxSubmitForm('updateFacPolicy.htm', 'updateContentResp', 'submitData2');">Update Policy</button>
        </div>
    </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="row">
                <div class="tile">
                    <h4 class="tile-title">Update Policy Options/Attributes</h4>
                    <div class="tile-body">
                        <div class="col-md-10" id="policy2Response">
                        <c:set var="c" value="0"></c:set>    
                        <c:forEach items="${model.policyObj.facilitypolicyoptionsList}" var="list">
                            <c:set var="c" value="${c+1}"></c:set>    
                            <div class="form-group">
                                <label>Attribute/Option ${c}</label>
                                <input type="hidden" id="pOptionId${c}" name="pOptionId${c}" value="${list.optionsid}"/>
                                <input type="text" id="pOption${c}" name="pOption${c}" value="${list.name}" placeholder="Enter Option ${c}" class="form-control col-md-8"/>
                                <small><font color="red" id="codeError"></font></small>
                            </div>
                        </c:forEach>
                            <div class="form-group" id="y${c+1}"></div>
                        </div>
                        <input type="hidden" id="policyid" name="policy" value="${model.policyObj.policyid}"/>
                        <input type="hidden" id="optionSize" name="optionSize" value="${c}"/>
                        <input type="hidden" id="selectedCount" name="selectedCount" value="${c}"/>
                    </div>
                </div>
            </div>
        </div>
                    
    </div>
    
</form>
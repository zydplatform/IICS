<%-- 
    Document   : addFacilityPolicy
    Created on : Jul 12, 2018, 7:58:12 AM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>

    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 200%; margin-left: -50%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Set Facility Policy For ${model.facObjArr[1]} ${model.facObjArr[2]} </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="orgPolicy-pane">
                <form id="submitFacPolicy" name="submitFacPolicy" style="width:100%">
                    <div class="form-group row" style="width:100%">
                                    <div class="tile" style="width:100%">
                                        <h4 class="tile-title">Set Up Policies</h4>
                                        <div class="tile-body" style="width:100%">
                                            <c:forEach items="${model.policyList}" var="list" varStatus="status">
                                                <div class="form-group">
                                                    <label class="control-label">${status.count}. ${list.category}-${list.policyname}: </label>&nbsp;&nbsp;
                                                    <input type="hidden" name="policyId${status.count}" id="policyId${status.count}" value="${list.policyid}"/>
                                                    <input type="hidden" name="policyIdChk${status.count}" id="policyIdChk${status.count}"/>
                                                    <c:forEach items="${list.facilitypolicyoptionsList}" var="opt" varStatus="status2">
                                                        <c:if test="${list.datatype=='Single Option'}">
                                                            ${opt.name}: <input type="radio" name="policyOpt${status.count}" id="policyOpt${status.count}${status2.count}" value="${opt.optionsid}" onChange="$('#policyIdChk${status.count}').val('true');"/> &nbsp;&nbsp;
                                                        </c:if>
                                                        <c:if test="${list.datatype=='Multiple Option'}">
                                                            ${opt.name}: <input type="checkbox" name="policyOpt${status.count}${status2.count}" id="policyOpt${status.count}${status2.count}" value="${opt.optionsid}" onChange="$('#policyIdChk${status.count}').val('true');"/> &nbsp;&nbsp;
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
                                <input type="hidden" name="activity" id="activity" value="Add"/>
                                <input type="hidden" name="dfac" id="dfac" value="${model.facObjArr[0]}"/>
                                <input type="hidden" name="itemSize" id="itemSize" value="${model.size}"/>
                                <input type="button" name="button" class='btn btn-primary icon-btn' value="Save Facility Policy" onClick="ajaxSubmitForm('registerFacilityPolicy.htm', 'orgResponse-pane', 'submitFacPolicy');"/>
                        &nbsp;&nbsp;
                        <input name="" type="reset" value="Reset" class="btn" onClick="$(this.form)[0].reset()">
                    </div>
                        </div>
                </form>
            </div>
        </div>
    </div>

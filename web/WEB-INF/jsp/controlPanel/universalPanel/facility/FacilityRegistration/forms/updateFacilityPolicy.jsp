<%-- 
    Document   : updateFacilityPolicy
    Created on : Jul 13, 2018, 12:01:34 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<div class="modal-dialog" role="document">
    <div class="modal-content" style="width: 200%; margin-left: -50%;">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle">Update Facility Policy For ${model.facObjArr[1]} ${model.facObjArr[2]} </h5>
            <div style="float:right" align="left"><a id="back" href="#"  onClick="${model.returnURL}"> <i class="fa fa-backward"></i></a></div>
        </div>
        <div class="modal-body" id="orgPolicy-pane">
            <form id="submitFacPolicy" name="submitFacPolicy" style="width:100%">
                <div class="form-group row" style="width:100%">
                    <div class="tile" style="width:100%">
                        <h4 class="tile-title">Update/Assign Policies</h4>
                        <div class="tile-body" style="width:100%">
                            <c:forEach items="${model.policyList}" var="list" varStatus="status">
                                <div class="form-group">
                                    <label class="control-label">${status.count}. ${list.policyname}: </label>&nbsp;&nbsp;<c:if test="${list.status==true}"><i class="fa fa-trash" onClick="discardPolicy('${list.policyid}','${list.policyname}','${model.facObjArr[0]}');"></i></c:if><c:if test="${list.status==false}"><i class="fa fa-thumbs-down"></i></c:if>&nbsp;&nbsp;
                                    <input type="hidden" name="policyId${status.count}" id="policyId${status.count}" value="${list.policyid}"/>
                                    <input type="hidden" name="policyIdChk${status.count}" id="policyIdChk${status.count}"/>
                                    <c:forEach items="${list.facilitypolicyoptionsList}" var="opt" varStatus="status2">
                                        <c:if test="${list.datatype=='Single Option'}">
                                            ${opt.name}: <input type="radio" name="policyOpt${status.count}" id="policyOpt${status.count}${status2.count}" value="${opt.optionsid}" <c:if test="${opt.active==true}">checked="checked"</c:if> onChange="$('#policyIdChk${status.count}').val('true');"/> &nbsp;&nbsp;
                                        </c:if>
                                        <c:if test="${list.datatype=='Multiple Option'}">
                                            ${opt.name}: <input type="checkbox" name="policyOpt${status.count}${status2.count}" id="policyOpt${status.count}${status2.count}" value="${opt.optionsid}" <c:if test="${opt.active==true}">checked="checked"</c:if> onChange="$('#policyIdChk${status.count}').val('true');"/> &nbsp;&nbsp;
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
                        <input type="hidden" name="activity" id="activity" value="Update"/>
                        <input type="hidden" name="dfac" id="dfac" value="${model.facObjArr[0]}"/>
                        <input type="hidden" name="itemSize" id="itemSize" value="${model.size}"/>
                        <input type="button" name="button" class='btn btn-primary icon-btn' value="Save Facility Policy" onClick="ajaxSubmitForm('registerFacilityPolicy.htm', 'orgPolicy-pane', 'submitFacPolicy');"/>
                        &nbsp;&nbsp;
                        <input name="" type="reset" value="Reset" class="btn" onClick="$(this.form)[0].reset()">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    function discardPolicy(id, name, fid) {
        $.confirm({
            title: 'Are You Sure You Want Discard: '+name+'?',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {Id:id,fId:fid},
                            url: "deleteAssignedFacPolicy.htm",
                            success: function (data, textStatus, jqXHR) {
                                //console.log("faciliyid:::::::::::::" + fid);
                                if (data === 'success') {
                                    $.confirm({
                                        title: 'Deleted/Discarded ' + name + 'Successfully',
                                        type: 'orange',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {
                                                ${model.returnURL}
                                            }
                                        }
                                    });
                                } else {
                                    $.confirm({
                                        title: 'Delete/Discard ' + name,
                                        content: 'Can Not Delete This Policy Confirm If Not In Use',
                                        type: 'red',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'OK',
                                                btnClass: 'btn-red',
                                                action: function () {
                                                    ${model.returnURL}
                                                }
                                            },
                                            NO: function () {
                                            }
                                        }
                                    });
                                }
                            }
                        });

                    }
                },
                NO: function () {
                   
                }
            }
        });
    }
</script>
<%-- 
    Document   : program
    Created on : Nov 6, 2018, 5:37:06 PM
    Author     : Uwera
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="modal fade col-md-12" id="updateFacilityProg" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Program Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="ajaxSubmitData('systemActivity/programManagement.htm', 'program-content', 'act=a2&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="ResponsePaneProgram">
                <form id="updateProgram" name="updateProgram">
                <div class="container">
                    <div class="row">
                        
                            <div class="col-md-12">
                                <div class="tile">
                                    <div class="tile-body">
                                        <div class="form-group">
                                            <label class="control-label">Program Name</label>
                                            <input type="hidden" name="programId" value="${model.programObj[0]}"/>
                                            <input class="form-control col-md-10" id="programname2" name="programname" type="text" readonly="readonly" value="${model.programObj[1]}" placeholder="Program Name">
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Program Key</label>
                                            <input class="form-control col-md-10" id="programkey2" name="programkey" type="text" readonly="readonly" value="${model.programObj[3]}" placeholder="Program Key">
                                        </div>
                                        </div>
                                        <div class="tile-footer">
                                            <div class="row">
                                                <div class="col-md-8 col-md-offset-3">
                                                    <button type="button" class="btn btn-primary" id="btnUpdate" onClick="ajaxSubmitForm('systemActivity/updateFacilityProgram.htm', 'ResponsePaneProgram', 'updateProgram');">Update Program</button>
                                                    &nbsp;&nbsp;
                                                    <button type="button" class="btn btn-primary" id="btnDelete" onClick="ajaxSubmitData('systemActivity/programManagement.htm', 'ResponsePaneProgram', 'act=c&i=${model.programObj[0]}&b=${model.b}&c=${model.a}&d=${model.d}&ofst=${model.ofst}&maxR=${model.maxR}&sStr=${model.sStr}', 'GET');">Delete Program</button>
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
</div>
<script>
    $('#updateFacilityProg').modal('show');
</script>
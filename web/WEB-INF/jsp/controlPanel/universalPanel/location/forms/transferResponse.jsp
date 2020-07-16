<%-- 
    Document   : transferResponse
    Created on : Jun 4, 2018, 10:34:38 PM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>

<fieldset><legend>Locations Transfer</legend>
    <div class="row">
        <div class="col-md-12">
            <div>
                <div class="tile-body">
                    <h3>
                        <c:if test="${model.activity=='a'}">Discarding Region: ${model.regionArrObj[1]}</c:if>
                        <c:if test="${model.activity=='c'}">Discarding County: ${model.countyArrObj[1]}</c:if>
                        </h3>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div>
                    <div class="tile-body">
                        <h3>${model.successmessage}</h3>
                        Remaining Attachments: ${model.countAttachments}
                </div>
            </div>
        </div>
    </div>
    <div class="tile-footer">
        <div class="row">
            <div class="col-md-8 col-md-offset-3">
                <div id="selectObjBtn">
                    <br><br>
                    <input type="button" id="saveButton" class="close" data-dismiss="modal" aria-label="Close" name="button" <c:if test="${model.countAttachments>0}">disabled="disabled"</c:if> class='btn btn-primary' value="Discard ${model.activeLocation}" onClick="var resp = confirm('Are You Sure You Want To Delete Selected ${model.activeLocation}!');
                            if (resp === false) {
                                return false;
                            }
                            if(${model.activity}==='a'){ajaxSubmitData('locations/deleteRegion.htm', 'response-pane', 'act=a&id=${model.discardIdRef}', 'GET');}
                            if(${model.activity}==='c'){}
                                "/> 
                </div>
            </div>
        </div>
    </div>            
</fieldset>

                            <%--
<fieldset><legend>Locations Transfer</legend>
    <div class="row">
        <div class="col-md-12">
            <div>
                <div class="tile-body">
                    <h3>${model.successmessage}</h3>
                </div>
            </div>
        </div>
    </div>
</fieldset>--%>
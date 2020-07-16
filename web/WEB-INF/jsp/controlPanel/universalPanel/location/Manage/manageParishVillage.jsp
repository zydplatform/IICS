<%-- 
    Document   : manageParishVillage
    Created on : Jul 3, 2018, 8:29:49 AM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>

<fieldset style="min-height:150px;">
    <legend>
        <div style="float:left" align="left"><a id="back" href="#"  onClick="ajaxSubmitData('locations/manageSelectedLoc.htm', 'Response-pane', {id: '${model.location[0]}', act: 'p', st: 'b', v2: '0'}, 'GET');"> <i class="fa fa-backward"></i></a></div>
        &nbsp;
        Villages Under Selected Parish: ${model.location[1]}
    </legend>

    <div class="form-group row">
        <div class="col-md-8"><label class="control-label col-md-4">Region Name:</label> ${model.location[5]}</div>
        <div class="col-md-8"><label class="control-label col-md-4">District Name:</label> ${model.location[4]}</div>
        <div class="col-md-8"><label class="control-label col-md-4">County Name:</label> ${model.location[3]}</div>
        <div class="col-md-8"><label class="control-label col-md-4">Sub-County Name:</label> ${model.location[2]}</div>
    </div>

        <div class="tile">
            <form id="submitForm" name="submitForm">
                <div id="formDiv"></div>
                <div id="recordsBody">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered" id="villagesInParish">
                            <thead>
                                <tr>
                                    <th class="center">No</th>
                                    <th>Village Name</th>
                                    <th class="center">Transfer</th>
                                </tr>
                            </thead>
                            <tbody class="col-md-12" id="tableFacilityOwner">
                                <% int y = 1;%>
                                <% int j = 1;%>
                                <c:forEach items="${model.villageList}" var="v" varStatus="status" begin="0" end="${model.size}">
                                    <tr id="${status.count}">
                                        <td class="center">${status.count}</td>
                                        <td>${v[1]}</td>
                                        <td class="center">
                                            <input type="checkbox" name="checkObj${status.count}" id="checkObj${status.count}" value="${v[0]}" onChange="if (this.checked) {
                                            document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) + 1
                                        } else {
                                            document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) - 1
                                        }
                                        var ticks = document.getElementById('selectedObjs').value;
                                        if (ticks > 0) {
                                            showDiv('checkObjBtn');
                                        }
                                        if (ticks == 0) {
                                            hideDiv('checkObjBtn');
                                        }"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div id="addnew-pane"></div>
                    </div>
                    <c:if test="${model.size>0}">
                        <table align="right">
                            <tr>
                                <td>
                                    <input type="hidden" id="locId" name="locId" value="${model.location[0]}"/>
                                    <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                                    <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                                    <input type="hidden" size="5" id="activity" name="activity" value="${model.activity}"/>
                                    <input type="hidden" size="5" id="term" name="term" value="${model.term}"/>
                                    <input type="hidden" size="5" id="id" name="id" value="${model.location[0]}"/>
                                    <input type="hidden" size="5" id="locActivity" name="locActivity" value="facilityTransfer"/>
                                </td>
                                <td align="right">
                                    Select <a href="javascript:selectToggleCheckBox(true, 'checkObj', ${model.size});" onClick="document.getElementById('selectedObjs').value =${model.size};
                                            showDiv('checkObjBtn');"><font color="blue"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'checkObj', ${model.size});" onClick="document.getElementById('selectedObjs').value = 0; hideDiv('checkObjBtn');"><font color="blue">None</font></a>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right">
                                    <div id="checkObjBtn" style="display:none">
                                        <input type="button" value="Transfer Village" class="btn btn-primary" onClick="hideDiv('recordsBody'); document.getElementById('locActivity').value = 'villageTransfer';  ajaxSubmitForm('locations/searchTransferLoc.htm', 'formDiv', 'submitForm');"/>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        </br>
                    </c:if>
                </div>
            </form>
        </div>
                                
</fieldset>
<script>
    $(document).ready(function () {
        $('#villagesInParish').DataTable();
    });
</script>
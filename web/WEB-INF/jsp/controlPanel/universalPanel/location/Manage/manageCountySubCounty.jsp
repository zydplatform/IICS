<%-- 
    Document   : manageCountySubCounty
    Created on : Jul 4, 2018, 6:10:22 PM
    Author     : user
--%>



<%@include file="../../../../include.jsp" %>

<fieldset style="min-height:130px;">
    <legend>
        <div style="float:left" align="left"><a id="back" href="#"  onClick="ajaxSubmitData('locations/manageSelectedLoc.htm', 'Response-pane', {id: '${model.location[0]}', act: 'c', st: 'b', v2: '0'}, 'GET');"> <i class="fa fa-backward"></i></a></div>
        &nbsp;
        Sub county Under Selected County: ${model.location[1]}
    </legend>

    <div class="form-group row">
        <div class="col-md-8"><label class="control-label col-md-4">Region Name:</label> ${model.location[3]}</div>
        <div class="col-md-8"><label class="control-label col-md-4">District Name:</label> ${model.location[2]}</div>
        <div class="col-md-8"><label class="control-label col-md-4">County Name:</label> ${model.location[1]}</div>
        
    </div>

        <div class="tile">
            <form id="submitForm" name="submitForm">
                <div id="formDiv"></div>
                <div id="recordsBody">
                    <div class="tile-body">
                        <table class="table table-hover table-bordered" id="subcountiesInCounties">
                            <thead>
                                <tr>
                                    <th class="center">No</th>
                                    <th>Sub County Name</th>
                                    <th class="center">Transfer</th>
                                </tr>
                            </thead>
                            <tbody class="col-md-12" id="tableFacilityOwner">
                                <% int y = 1;%>
                                <% int j = 1;%>
                                <c:forEach items="${model.subcountyList}" var="v" varStatus="status" begin="0" end="${model.size}">
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
                                    <input type="hidden" size="5" id="locActivity" name="locActivity" value="subcountyTransfer"/>
                                </td>
                                <td align="right">
                                    Select <a href="javascript:selectToggleCheckBox(true, 'checkObj', ${model.size});" onClick="document.getElementById('selectedObjs').value =${model.size};
                                            showDiv('checkObjBtn');"><font color="blue"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'checkObj', ${model.size});" onClick="document.getElementById('selectedObjs').value = 0; hideDiv('checkObjBtn');"><font color="blue">None</font></a>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right">
                                    <div id="checkObjBtn" style="display:none">
                                        <input type="button" value="Transfer Sub County" class="btn btn-primary" onClick="hideDiv('recordsBody'); document.getElementById('locActivity').value = 'subcountyTransfer';  ajaxSubmitForm('locations/searchCountyTransfer.htm', 'formDiv', 'submitForm');"/>
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
        $('#subcountiesInCounties').DataTable();
    });
</script>



<%--
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <fieldset>
                    <legend>Transfer Attached Parish</legend>
                    <form name="submitData" id="submitData">
                        <div class="form-group row">
                            <label class="control-label">
                                Select Destination Sub county <span class="symbol required">*</span>
                            </label>
                            <select class="form-control" id="countyid" name="countyid">
                                <option value="0">--Select Destination Sub county--</option>
                                <c:forEach items="${model.subcountyArrList}" var="r">                                
                                    <option value="${r[0]}">${r[1]}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <table class="table table-hover table-bordered" id="transferList">
                            <c:if test="${model.act=='a'}">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Parish</th>
                                        <th>Transfer</th>
                                    </tr>
                                </thead>
                                <tbody id="tableFacilities">
                                    <% int n = 1;%>
                                    <% int w = 1;%>
                                    <c:forEach items="${model.parishes}" var="parishes" varStatus="status" begin="0" end="${model.size}">
                                        <tr id="${parishes[0]}">
                                            <td>${status.count}</td>
                                            <td>${parishes[1]}</td>
                                            <td class="center">
                                                <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="${parishes[0]}" onChange="if (this.checked) {
                                                            document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) + 1
                                                        } else {
                                                            document.getElementById('selectedObjs').value = parseInt(document.getElementById('selectedObjs').value) - 1
                                                        }
                                                        var ticks = document.getElementById('selectedObjs').value;
                                                        if (ticks > 0) {
                                                            showDiv('selectObjBtn');
                                                        }
                                                        if (ticks == 0) {
                                                            hideDiv('selectObjBtn');
                                                        }"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </c:if>
                        </table>
                        <c:if test="${model.size>0}">
                            <table align="right">
                                <tr>
                                    <td>
                                        <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                                        <input type="hidden" name="parishid" value="${model.parishid.parishid}"/>
                                        <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                                        <input type="hidden" name="act" value="${model.act}"/>
                                        <input type="hidden" name="b" value="${model.b}"/>
                                        <input type="hidden" name="i" value="${model.i}"/>
                                        <input type="hidden" name="a" value="${model.a}"/>
                                    </td>
                                    <td align="right">
                                        Select <a href="javascript:selectToggleCheckBox(true, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value =${model.size};
                                                showDiv('selectObjBtn');"><font color="blue"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value = 0;
                                                        hideDiv('selectObjBtn');"><font color="blue">None</font></a>
                                    </td>
                                </tr>
                            </table>
                            </br>
                        </c:if>
                    </form>
                </fieldset>
            </div>
            <div class="tile-footer">
                <div class="row">
                    <div class="col-md-8 col-md-offset-3">
                        <div id="selectObjBtn" style="display:none; float:right">
                            <input type="button" id="saveButton" name="button"class='btn btn-primary' value="Transfer Location" onClick="var resp = confirm('Transfer Selected Location?');
                                    if (resp == false) {return false;}
                                    var r=$('#subcountyid').val();
                                    if(r==='0'){alert('Select Destination Sub County!'); return false;}
                                    ajaxSubmitData('locations/transferSubCounty.htm', 'transfer-pane', $('#submitData').serialize(), 'POST');"/> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#transferList').DataTable();
    });
</script>--%>
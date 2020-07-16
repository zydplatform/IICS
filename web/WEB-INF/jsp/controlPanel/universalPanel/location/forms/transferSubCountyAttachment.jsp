<%-- 
    Document   : transferSubCountyAttachment
    Created on : Jun 22, 2018, 3:44:56 PM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>

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
</script>
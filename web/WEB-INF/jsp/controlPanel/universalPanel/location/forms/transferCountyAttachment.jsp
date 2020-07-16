<%-- 
    Document   : transferCountyAttachment
    Created on : Jun 13, 2018, 10:53:49 AM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>

<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <fieldset>
                    <legend>Transfer Attached Sub-County</legend>
                    <form name="submitData" id="submitData">
                        <div class="form-group row">
                            <label class="control-label">
                                Select Destination County <span class="symbol required">*</span>
                            </label>
                            <select class="form-control" id="countyid" name="countyid">
                                <option value="0">--Select Destination county--</option>
                                <c:forEach items="${model.countyArrList}" var="r">                                
                                    <option value="${r[0]}">${r[1]}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <table class="table table-hover table-bordered" id="transferList">
                            <c:if test="${model.act=='a'}">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Sub-County</th>
                                        <th>Transfer</th>
                                    </tr>
                                </thead>
                                <tbody id="tableFacilities">
                                    <% int n = 1;%>
                                    <% int w = 1;%>
                                    <c:forEach items="${model.subcounties}" var="subcounties" varStatus="status" begin="0" end="${model.size}">
                                        <tr id="${subcounties[0]}">
                                            <td>${status.count}</td>
                                            <td>${subcounties[1]}</td>
                                            <td class="center">
                                                <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="${subcounties[0]}" onChange="if (this.checked) {
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
                                        <input type="hidden" name="countyid" value="${model.countyid.countyid}"/>
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
                                    var r=$('#countyid').val();
                                    if(r==='0'){alert('Select Destination County!'); return false;}
                                    ajaxSubmitData('locations/transferCounty.htm', 'transfer-pane', $('#submitData').serialize(), 'POST');"/> 
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
<%-- 
    Document   : transferAttachmentForm
    Created on : Jun 21, 2018, 10:03:58 AM
    Author     : user
--%>
<%@include file="../../../../include.jsp" %>
<c:if test="${model.activity=='sc'}">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <fieldset>
                        <legend>Transfer/Divorce Attached Location</legend>
                        <form name="submitData" id="submitData">
                            <c:if test="${model.term=='parish'}">
                                <div class="form-group row">
                                    <label class="control-label">
                                        Select Destination Region: <span class="symbol required">*</span>
                                    </label>
                                    <select class="form-control" id="regionid" name="regionid">
                                        <option value="0">--Select Destination Region--</option>
                                        <c:forEach items="${model.regionArrList}" var="r">                                
                                            <option value="${r[0]}">${r[1]}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="form-group">
                                        <label class="control-label">Previous Region:</label>
                                        <input class="form-control" value="${model.r[1]}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div id="districtDivx">
                                        <label class="control-label">Select a District:</label>
                                        <div id="districtPane">
                                            <select class="form-control" id="districtlist" name="districtid"  onClick="clearFormSelect('district'); ajaxSubmitData('loadDistricts.htm', 'districtDivx', {rID: $('#regionidlist').val(), loc: 22}, 'GET');">
                                                <c:if test="${not empty model.parish}">
                                                    <option value="${model.subcounty.county.district.districtid}" selected="selected">${model.subcounty.county.district.districtname}</option>
                                                </c:if>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Previous District:</label>
                                            <input class="form-control" value="${model.r[2]}"/>
                                        </div>
                                    </div>
                                    <div></div>
                                </div>
                                <div class="form-group">
                                    <div id="countyDivx">
                                        <label class="control-label">Select a County:</label>
                                        <div id="districtPane">
                                            <select class="form-control" id="countylist" name="countylist"  onClick=" ajaxSubmitData('loadCounties.htm', 'countyDivx', {dID: $('#districtlist').val(), loc: 33}, 'GET');">
                                                <c:if test="${not empty model.parish}">
                                                <option value="${model.subcounty.county.countyid}" selected="selected">${model.subcounty.county.countyname}</option>
                                            </c:if>
                                                </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Previous County:</label>
                                        <input class="form-control" value="${model.r[3]}"/>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <div id="countyDivx">
                                        <label class="control-label">SelectSub County:</label>
                                        <div id="districtPane">
                                            <select class="form-control" id="subcountylist" name="subcountylist"  onClick="clearFormSelect('district'); ajaxSubmitData('loadCounties.htm', 'countyDivx', {dID: $('#districtlist').val(), loc: 33}, 'GET');">
                                                <c:if test="${not empty model.parish}">
                                                <option value="${model.subcounty.subcountyid}" selected="selected">${model.subcounty.subcountyname}</option>
                                            </c:if>
                                                </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Previous Sub County:</label>
                                        <input class="form-control" value="${model.r[3]}"/>
                                    </div>
                                  
                                </div>
                            </c:if>
                        </form>
                                    </div>
                            </div>
                                    
                                
                                <c:if test="${model.size>0}">
                                    <table align="right">
                                        <tr>
                                            <td>
                                                <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
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
                                    <input type="button" id="saveButton" name="button"class='btn btn-primary' value="Transfer Location" onClick=" 
                                        if(${model.term!='village' && model.term!='parish'} && document.getElementById('villagelist').value==0){alert('Select ${model.title} Transfer Destination!'); return false;}
                                if(${model.term=='parish'} && document.getElementById('subcountylist').value==0){alert('Select ${model.title} Transfer Destination!'); return false;}
                                if(${model.term=='village'} && document.getElementById('parishlist').value==0){alert('Select Parish For ${model.title} Transfer Destination!'); return false;} 
                                if(document.getElementById('subcountylist').value==${model.location[0]}){alert('Change Sub-County!'); return false;}
                                var resp=confirm('Transfer Selected ${model.title}?'); if(resp==false){return false;}
                                       
                                            ajaxSubmitData('locations/transferLocation.htm', 'transfer-pane', $('#submitData').serialize(), 'POST');"/> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
      
        <script>
            $(document).ready(function () {
                $('#transferList').DataTable();
            });
            function clearLocSelect(act) {
            
                if (act == 'subcounty') {
                    document.getElementById('parishlist').value = 0;
                    document.getElementById('villagelist').value = 0;
                }
                if (act == 'parish') {
                    document.getElementById('villagelist').value = 0;
                }
            }
        </script>

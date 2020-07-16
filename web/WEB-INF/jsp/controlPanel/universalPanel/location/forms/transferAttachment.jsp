<%-- 
    Document   : transferAttachment
    Created on : Jun 4, 2018, 8:50:10 PM
    Author     : Uwera
--%>
<%@include file="../../../../include.jsp" %>
<fieldset>
    <legend>Transfer/Divorce Attached Location</legend>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <form name="submitRegion" id="submitRegion">
                    <div class="tile-body">                    
                        <div class="form-group row required">
                            <label class="control-label">
                                Select Destination Region:
                            </label>
                            <select class="form-control" id="regionid" name="regionid">
                                <option value="0">--Select Destination Region--</option>
                                <c:forEach items="${model.regionArrList}" var="r">                                
                                    <option value="${r[0]}">${r[1]}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <table class="table table-hover table-bordered" id="transferList">
                            <c:if test="${model.act=='a'}">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>District</th>
                                        <th>Transfer</th>
                                    </tr>
                                </thead>
                                <tbody id="tableFacilities">
                                    <% int n = 1;%>
                                    <% int w = 1;%>
                                    <c:forEach items="${model.districts}" var="districts" varStatus="status" begin="0" end="${model.size}">
                                        <tr id="${districts[0]}">
                                            <td>${status.count}</td>
                                            <td>${districts[1]}</td>
                                            <td class="center">
                                                <input type="checkbox" id="selectObj${status.count}" name="selectObj${status.count}"  value="${districts[0]}" onChange="if (this.checked) {
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
                                        <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                                        <input type="hidden" name="act" id="act" value="${model.act}"/>
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
                    </div>
                    <div class="tile-footer">
                        <div class="row">
                            <div class="col-md-8 col-md-offset-3">
                                <div id="selectObjBtn" style="display:none; float:right">
                                    <input type="button" id="saveButton" name="button"class='btn btn-primary' value="Transfer Location" onClick="var resp = confirm('Transfer Selected Location?');
                                            if (resp == false) {
                                                return false;
                                            }
                                            var r = $('#regionid').val();
                                            if (r === '0') {
                                                alert('Select Destination Region!');
                                                return false;
                                            }
                                            $('#act').val('a');
                                            ajaxSubmitData('locations/transferLocation.htm', 'transfer-pane', $('#submitRegion').serialize(), 'POST');"/> 
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</fieldset>

<script>
    $(document).ready(function () {
        $('#transferList').DataTable();
    });


    function showWarningSuccess(title, message, type, div) {
        $.toast({
            heading: title,
            text: message,
            icon: type,
            hideAfter: 6000,
            //position: 'mid-center'
            element: '#' + div,
            position: 'mid-center',
        });
    }
</script>

<!--<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <fieldset>
                    <legend>Transfer/Divorce Attached Location</legend>
                    <form name="submitData" id="submitData">
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
                        </div>
                        <table class="table table-hover table-bordered" id="transferList">
                            <c:if test="${model.act=='a'}">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>District</th>
                                        <th>Transfer</th>
                                    </tr>
                                </thead>
                                <tbody id="tableFacilities">
                                    <% int n = 1;%>
                                    <% int w = 1;%>
                                    <c:forEach items="${model.districts}" var="districts" varStatus="status" begin="0" end="${model.size}">
                                        <tr id="${districts[0]}">
                                            <td>${status.count}</td>
                                            <td>${districts[1]}</td>
                                            <td class="center">
                                                <input type="checkbox" class="case" name="case" id="selectObj${status.count}" value="${districts[0]}" onChange="if (this.checked) {
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
                                    var r=$('#regionid').val();
                                    if(r==='0'){alert('Select Destination Region!'); return false;}
                                    ajaxSubmitData('locations/transferLocation.htm', 'transfer-pane', $('#submitData').serialize(), 'POST');"/> 
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
</script>--!>
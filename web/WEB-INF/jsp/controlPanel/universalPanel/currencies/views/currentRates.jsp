<%-- 
    Document   : currentRates
    Created on : Jul 2, 2009, 12:53:32 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>

<style>
    #loadupdatedrates {
        background: rgba(255,255,255,0.5);
        color: #000000;
        position: fixed;
        height: 100%;
        width: 100%;
        z-index: 5000;
        top: 0;
        left: 0;
        float: left;
        text-align: center;
        padding-top: 25%;
    }
</style>

Current Currency Rate. Base: ${model.base}, Date: <fmt:formatDate  type="both" dateStyle="medium" timeStyle="medium" value="${model.date}"/>
<c:if test="${not empty  model.currencyList}">
    <form id="manageFormField" name="manageFormField">
        <c:if test="${model.size>0}">
            <table align="right">
                <tr id="">
                    <td>
                        <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                        <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                        <input type="hidden" name="act" value="${model.act}"/>
                        <input type="hidden" name="b" value="${model.b}"/>
                        <input type="hidden" name="i" value="${model.i}"/>
                        <input type="hidden" name="a" value="${model.a}"/>
                    </td>
                    <td align="right" id="selectoption">
                        Select <a href="javascript:selectToggleCheckBox(true, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value =${model.size};hideDiv('selectObjBtn');showDiv('selectedObjBtn');"><font color="blue"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value = 0; hideDiv('selectObjBtn');"><font color="blue">None</font></a>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <div id="selectObjBtn" style="display:none">
                            <input type="button" value="Update Rates" class='btn btn-purple' onClick="updatecurrencies();"/>
                        </div>
                        <div id="selectedObjBtn" style="display:none">
                            <input type="button" value="Update All Rates" class='btn btn-purple' id="updatecurrenciesALL">
                            <!-- <input type="button" value="Update All Rates" class='btn btn-purple' id="testthis" onClick="ajaxSubmitData('currencysystemsettings/updateallcurrencyrates.htm','', '&currencyvalues=0&a=0', 'POST')"/>-->
                        </div>
                    </td>
                </tr>
            </table>
            </br>
        </c:if>
        <div id="loadupdatedrates" style="display: none;">
            <img src="static/img2/loader.gif" alt="Loading"/><br/>
            Updating Currency Rates Please Wait...
        </div>
        <table class="table table-hover table-bordered col-md-12" id="currentCurrencyRate">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Country</th>
                    <th>Currency Name</th>
                    <th>Abbrv.</th>
                    <th class="center" contenteditable="true">Current Rate Vs ${model.base}</th>
                    <th>Add</th> 
                </tr>
            </thead>
            <tbody id="tableFacilities">
                <c:forEach items="${model.currencyList}" var="list" varStatus="status" begin="0" end="${model.size}">
                    <tr id="${list.currencyid}">
                        <td align="left">${status.count}</td>
                        <td align="left">${list.country}</td> 
                        <td align="left">${list.currencyname}</td>
                        <td align="left">${list.abbreviation}</td>
                        <td align="left" id="updatedrates" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;" oninput="updatetocurrentrates(this.id);">${list.currencyrate}</td>
                        <td align="center">
                            <input type="checkbox" name="selectObj${status.count}" id="selectObj${status.count}" value="${list.currencyid}" onChange="if (this.checked) {
                                        checkedoruncheckedcurrentrates(this.value, 'checked');
                                    } else {
                                        checkedoruncheckedcurrentrates(this.value, 'unchecked');
                                    }"/>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
            <c:if test="${model.size>0}">
                <table align="right">
                    <tr id="">
                        <td>
                            <input type="hidden" id="selectedObjs" name="selectedObjs" value="0"/>
                            <input type="hidden" id="itemSize" name="itemSize" value="${model.size}"/>
                            <input type="hidden" name="act" value="${model.act}"/>
                            <input type="hidden" name="b" value="${model.b}"/>
                            <input type="hidden" name="i" value="${model.i}"/>
                            <input type="hidden" name="a" value="${model.a}"/>
                        </td>
                        <td align="right" id="selectoption">
                            Select <a href="javascript:selectToggleCheckBox(true, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value =${model.size};"><font color="blue"> All</font></a> | <a href="javascript:selectToggleCheckBox(false, 'selectObj', ${model.size});" onClick="document.getElementById('selectedObjs').value = 0; hideDiv('selectObjBtn');"><font color="blue">None</font></a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <div id="selectObjBtn" style="display:none">
                                <input type="button" value="Update Rates" class='btn btn-purple' onClick="updatecurrencies();"/>
                            </div>
                        </td>
                    </tr>
                </table>
                </br>
            </c:if>

        </table>
    </form>
</c:if>

<c:if test="${empty model.currencyList}">
    <div align="center"><h3>No Registered Currency With Abbreviation</h3></div>
</c:if>
<script>
    
    $(document).ready(function () {
        $('#updatecurrenciesALL').click(function () {
            var jsonupdateAll = ${model.jsoncurrencies};
            document.getElementById('loadupdatedrates').style.display = 'block';
            $.ajax({
                type: 'POST',
                cache: false,
                dataType: 'text',
                data: {currencyvalues: JSON.stringify(jsonupdateAll)},
                url: "currencysystemsettings/updateallcurrencyrates.htm",
                success: function (data) {
                    document.getElementById('loadupdatedrates').style.display = 'none';
                    $.alert({
                        title: 'Alert!',
                        content: 'Currency Rates ' + data + 'Updated',
                    });
                    $('.close').click();
                    ajaxSubmitData('currencysystemsettings/currencypane.htm', 'workpane', '', 'GET');
                }
            });
        });
    });


</script>

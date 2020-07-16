<%-- 
    Document   : itemQuantityStatistics
    Created on : Jun 27, 2018, 11:35:36 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<input type="hidden" value="${itemid}" id="financialyrsSeletcteditemid">
<table class="table table-hover table-bordered" id="procureditemsstatisticsTable" style="width: 100% !important;">
    <thead>
        <tr>
            <c:forEach items="${ItemsFound}" var="a">
                <th colspan="2">${a.financialyear}</th>
                </c:forEach>
        </tr>
        <tr>
            <c:forEach items="${ItemsFound}" var="c">
                <th>${c.type}</th>
                <th>Consumed</th>  
                </c:forEach>
        </tr>
    </thead>
    <tbody>
        <tr>
            <c:forEach items="${ItemsFound}" var="b">
                <td>${b.averageconsumption}</td> 
                <td>${b.stockissuedout}</td> 
            </c:forEach>
        </tr>
    </tbody>
</table> 
<div class="row">
    <div class="col-md-12">
        <div class="tile" >
            <h4 class="tile-title">Units Consumption.</h4>
            <div id="UnitConsumptionprocmentItem4">
                <table class="table table-hover table-bordered" id="unitTables" style="width: 100%;">
                    <thead>
                        <tr>
                            <th></th>
                                <c:forEach items="${ItemsFound}" var="d">
                                <th colspan="2">${d.financialyear}</th>
                                </c:forEach>
                        </tr>
                        <tr>
                            <th >Unit</th>
                                <c:forEach items="${ItemsFound}" var="e">
                                <th >P</th>
                                <th >C</th>
                                </c:forEach>
                            <th >Monthly Need</th>
                            <th >${ordertype} Need</th>
                            <th>Add</th>
                        </tr>
                    </thead>
                    <tbody id="UnitConsumptionprocmentItems">

                    </tbody>
                    <tr>
                        <td colspan="${size+1}"><h3>Total</h3></td>
                        <td align="center"><input type="hidden" value="0" id="monthprocurementSuggId" class="monthprocurementSuggCont form-control" ><h3><span class="badge badge-secondary"><strong id="addedMonthValueText">0</strong></span></h3></td>
                        <td align="center"><input type="hidden" value="0" id="averagetotalSuggprocurementId"  class="averagetotalSuggprocurementCont form-control"><h3><span class="badge badge-secondary"><strong id="addedAnnualValueText">0</strong></span></h3></td>
                    </tr>
                </table> 

            </div>

        </div>
    </div>
</div>
<script>

    ajaxSubmitData('facilityprocurementplanmanagement/facilityunits.htm', 'UnitConsumptionprocmentItems', 'size=' +${size} + '&ofst=1&maxR=100&sStr=', 'GET');
    function getTheProcurementPlanItems(type, value, ordertype) {
        if (type === 'month') {
            if (value !== 0 || value !== '') {
                if (ordertype === 'Quarterly') {
                    document.getElementById('averagetotalSuggprocurementId').value = value * 3;
                } else {
                    document.getElementById('averagetotalSuggprocurementId').value = value * 12;
                }

            }
        } else {
            if (value !== 0 || value !== '') {
                if (ordertype === 'Quarterly') {
                    document.getElementById('monthprocurementSuggId').value = Math.round(value / 3);
                } else {
                    document.getElementById('monthprocurementSuggId').value = Math.round(value / 12);
                }

            }
        }
    }
    function getTehunitspastconsunptions(facilityunitid, value, type, id, cnt) {
        var itemid = $('#financialyrsSeletcteditemid').val();
        if (value.length < 1) {
            $.ajax({
                type: 'POST',
                data: {financialyrs: '${financialyearset}', itemid: itemid, facilityunitid: facilityunitid},
                url: "facilityprocurementplanmanagement/getunitsitemconsumptionaverage.htm",
                success: function (data, textStatus, jqXHR) {
                    var response = JSON.parse(data);
                    var counts = 0;
                    var average = 0;
                    for (index in response) {
                        var results = response[index];
                        counts = counts + 1;
                        document.getElementById(facilityunitid + 'td' + counts).innerHTML = addCommas(results["procured"]);
                        average = average + parseInt(results["procured"]);
                        console.log(parseInt(results["procured"]));
                        counts = counts + 1;
                        document.getElementById(facilityunitid + 'td' + counts).innerHTML = addCommas(results["consumed"]);
                    }

                    if (type === 'month') {
                        var amnt =${size};
                        var motnlyneed = Math.round(average / ((amnt/2) * 12));
                        document.getElementById(id).value = motnlyneed;
                        if ('${ordertype}' === 'Annually') {
                            document.getElementById('annuallgetTehunits' + cnt).value = motnlyneed * 12;
                        } else {
                            document.getElementById('annuallgetTehunits' + cnt).value = motnlyneed * 3;
                        }
                    } else {
                        var amnt =${size};
                        var annualneed = Math.round(average / ((amnt/2) * 12));
                        
                        if ('${ordertype}' === 'Annually') {
                            document.getElementById(id).value = annualneed * 12;
                            document.getElementById('monthgetTehunits' + cnt).value =annualneed;
                        } else {
                            document.getElementById(id).value = annualneed* 3;
                            document.getElementById('monthgetTehunits' + cnt).value = annualneed;
                        }
                    }

                }
            });
        }
    }
    function addCommas(nStr) {
        nStr += '';
        var x = nStr.split('.');
        var x1 = x[0];
        var x2 = x.length > 1 ? '.' + x[1] : '';
        var rgx = /(\d+)(\d{3})/;
        while (rgx.test(x1)) {
            x1 = x1.replace(rgx, '$1' + ',' + '$2');
        }
        return x1 + x2;
    }
</script>
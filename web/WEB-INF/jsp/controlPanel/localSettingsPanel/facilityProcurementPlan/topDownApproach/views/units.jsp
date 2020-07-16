<%-- 
    Document   : units
    Created on : Jun 28, 2018, 11:14:18 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% int k = 1;%>
<% int mn = 1;%>
<% int yr = 1;%>
<% int tm = 1;%>
<% int m = 1;%>
<% int tr = 1;%>
<% int p1 = 1;%>
<% int p2 = 1;%>
<c:forEach items="${UnitsFound}" var="a">
    <tr id="tfrrrrer${a.facilityunitid}">
        <td>${a.facilityunitname}</td> 
        <% int j = 1;%>
        <c:forEach items="${keysFound}" var="f">
            <td id="${a.facilityunitid}td<%=j++%>"></td>   
        </c:forEach>
        <td align="center"><input type="number" min="0" oninput="incrementordecrementmonthannuall(this.value,'month',<%=mn++%>,this.id);" max="1000000" id="monthgetTehunits<%=p1++%>" onfocus="getTehunitspastconsunptions(${a.facilityunitid}, this.value, 'month', this.id,<%=tr++%>);" class="form-control" style="width: 70%;"></td> 
        <td align="center"><input type="number" min="0" oninput="incrementordecrementmonthannuall(this.value,'annual',<%=yr++%>,this.id);" max="1000000" id="annuallgetTehunits<%=p2++%>" onfocus="getTehunitspastconsunptions(${a.facilityunitid}, this.value, 'annual', this.id,<%=k++%>);" class="form-control" style="width: 70%;"></td>  
        <td><input type="checkbox" id="chckV<%=tm++%>" value="<%=m++%>" onchange="if (this.checked) {
                    addvalueofselectedUnits(${a.facilityunitid}, this.value, 'checked', this.id);
                } else {
                    addvalueofselectedUnits(${a.facilityunitid}, this.value, 'unchecked', this.id);
                }"></td>
    </tr>
</c:forEach>
<script>
    var addedUnits = new Set();
    function addvalueofselectedUnits(facilityunitid, count, type, id) {
        var orderperiodid = $('#orderperiodidquarterorannuallid').val();
        var orderperiodtype = $('#ordertypequarterorannuall').val();
        var itemid = $('#financialyrsSeletcteditemid').val();
        if (type === 'checked') {
            var monthvalue = $('#monthgetTehunits' + count).val();
            var annualvalue = $('#annuallgetTehunits' + count).val();
            if (monthvalue === '' || monthvalue===0) {
                $.confirm({
                    title: 'Error!',
                    content: 'Enter Item Quantity First',
                    type: 'red',
                    icon: 'fa fa-warning',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                            $('#' + id).prop('checked', false);
                        }
                    }
                });
            } else {
                var addedmonthtotal = $('#monthprocurementSuggId').val();
                var addedannualtotal = $('#averagetotalSuggprocurementId').val();
                var addedmonthtotal2 = parseInt(addedmonthtotal) + parseInt(monthvalue);
                var addedannualtotal2 = parseInt(addedannualtotal) + parseInt(annualvalue);

                $.ajax({
                    type: 'POST',
                    data: {facilityunitid: facilityunitid, orderperiodid: orderperiodid, monthlyneed: addedmonthtotal, annualorquarter: addedannualtotal, orderperiodtype: orderperiodtype, itemid: itemid},
                    url: "facilityprocurementplanmanagement/savefacilityunititemaddedprocurementtopdown.htm",
                    success: function (data, textStatus, jqXHR) {
                        addedUnits.add(facilityunitid);
                        document.getElementById('addedMonthValueText').innerHTML = addedmonthtotal2;
                        document.getElementById('addedAnnualValueText').innerHTML = addedannualtotal2;

                        document.getElementById('monthprocurementSuggId').value = addedmonthtotal2;
                        document.getElementById('averagetotalSuggprocurementId').value = addedannualtotal2;

                        document.getElementById('monthgetTehunits' + count).disabled = true;
                        document.getElementById('annuallgetTehunits' + count).disabled = true;

                    }
                });
            }
        } else {

        }
    }
    function incrementordecrementmonthannuall(value, type, count, id) {
        var orderperiodtype = $('#ordertypequarterorannuall').val();
        if (value > 0) {

            if (type === 'month') {
                if (orderperiodtype === "Quarterly") {
                    document.getElementById('annuallgetTehunits' + count).value = value * 3;
                } else {
                    document.getElementById('annuallgetTehunits' + count).value = value * 12;
                }
            } else {
                if (orderperiodtype === "Quarterly") {
                    document.getElementById('monthgetTehunits' + count).value = Math.round(value / 3);
                } else {
                    document.getElementById('monthgetTehunits' + count).value = Math.round(value / 12);
                }
            }
        }
    }
</script>

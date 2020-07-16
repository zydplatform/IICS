<%-- 
    Document   : facilityunitsitemvalues
    Created on : May 9, 2018, 7:26:43 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    #genericnametrim {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: available;
    }
</style>
<div class="row">
    <div class="col-md-12">
        <h3 id="genericnametrim"><span class="badge badge-secondary"><strong>${genericname}</strong></span></h3>
    </div>
</div>
<input id="orderperiodtypefacilityunits" value="${orderperiodtype}" type="hidden">
<table class="table table-hover table-bordered" id="facilityunitsitemsviewtable">
    <thead>
        <tr>
            <th>No</th>
            <th>Facility Unit Name</th>
            <th>Short Name</th>
            <th>Monthly Need</th>
            <th>${orderperiodtype}</th>
                <c:if test="${act=='a'}">
                <th>Reject Item</th>
                </c:if>
        </tr>
    </thead>
    <tbody id="facilityunitsitemstablerows">
        <% int j = 1;%>
        <% int i = 1;%>
        <% int a = 1;%>
        <c:forEach items="${facilityunts}" var="a">
            <tr id="${a.facilityunitprocurementplanid}">
                <td><%=j++%></td>
                <td>${a.facilityunitname}</td>
                <td>${a.shortname}</td>
                <td id="facuinteditmonth-<%=i++%>"  <c:if test="${act=='a'}">contenteditable="true" oninput="facilityunitupdatesvalues('${orderperiodtype}',this.id,${a.facilityunitprocurementplanid})" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;"</c:if> >${a.averagemonthlyconsumption}</td>
                <td id="facuinteditannual-<%=a++%>" <c:if test="${act=='a'}">contenteditable="true" oninput="facilityunitupdatesvalues('${orderperiodtype}',this.id,${a.facilityunitprocurementplanid})" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;"</c:if> ><c:if test="${orderperiodtype=='Quarterly'}">${a.averagequarterconsumption}</c:if><c:if test="${orderperiodtype=='Monthly'}">${a.averageannualcomsumption} </c:if><c:if test="${orderperiodtype=='Annually'}">${a.averageannualcomsumption}</c:if></td>
                <c:if test="${act=='a'}">
                    <td align="center">
                        <button onclick="rejectfacilityunititem(${a.facilityunitprocurementplanid},${itemid},${facilityfinancialyearid}, '${orderperiodtype}', '${genericname}',${orderperiodid});"  title="Reject Item For This Unit." class="btn btn-secondary btn-sm add-to-shelf">
                            <i class="fa fa-lg fa-remove"></i>
                        </button>
                    </td>
                </c:if> 
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    var unitsupdatedprocurementitems = new Set();
    function facilityunitupdatesvalues(orderperiodtype, id, facilityunitprocurementplanid) {
        unitsupdatedprocurementitems.add(facilityunitprocurementplanid);
        var fields = id.split('-');
        var tdid = fields[0];
        var number = fields[1];
        var value = $('#' + id).text();
        if (value !== '' || value.length !== 0) {
            if (tdid === 'facuinteditmonth') {
                if (orderperiodtype === 'Quarterly') {
                    document.getElementById('facuinteditannual-' + number).innerHTML = parseInt(value) * 3;
                } else {
                    document.getElementById('facuinteditannual-' + number).innerHTML = parseInt(value) * 12;
                }
            } else {
                if (orderperiodtype === 'Quarterly') {
                    document.getElementById('facuinteditmonth-' + number).innerHTML = Math.round(parseInt(value) / 3);
                } else {
                    document.getElementById('facuinteditmonth-' + number).innerHTML = Math.round(parseInt(value) / 12);
                }
            }
        }
    }
    function savefacilityunititemsmodification() {
        var procurementitms = [];
        var orderperiodtype = $('#orderperiodtypefacilityunits').val();
        if (unitsupdatedprocurementitems.size !== 0) {
            var table = document.getElementById("facilityunitsitemstablerows");
            var x = document.getElementById("facilityunitsitemstablerows").rows.length;
            for (var i = 0; i < x; i++) {
                var row = table.rows[i];
                var ids = row.id;
                var tableData = $('#' + ids).closest('tr')
                        .find('td')
                        .map(function () {
                            return $(this).text();
                        }).get();
                if (unitsupdatedprocurementitems.has(parseInt(ids))) {
                    if (orderperiodtype === 'Quarterly') {
                        procurementitms.push({
                            facilityunitprocurementplanid: ids,
                            monthly: tableData[3],
                            quarter: tableData[4]
                        });
                    } else {
                        procurementitms.push({
                            facilityunitprocurementplanid: ids,
                            monthly: tableData[3],
                            annual: tableData[4]
                        });
                    }
                }
            }
            if (procurementitms.length !== 0) {
                $.ajax({
                    type: 'POST',
                    data: {type: 'updateunit', values: JSON.stringify(procurementitms), orderperiodtype: orderperiodtype},
                    url: "facilityprocurementplanmanagement/rejectfacilityorunitprocurementplanitems.htm",
                    success: function (data, textStatus, jqXHR) {
                        $('#facilityunititemvaluesview').modal('hide');
                        ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredprocuredprocurementplansitemsview.htm', 'facilityprocuredprocuredprocurementplansitemsdiv', 'act=a&facilityfinancialyearid=' + '${facilityfinancialyearid}' + '&orderperiodtype=' + '${orderperiodtype}' + '&orderperiodid=' + '${orderperiodid}' + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                });
            } else {
                $('#facilityunititemvaluesview').modal('hide');
                ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredprocuredprocurementplansitemsview.htm', 'facilityprocuredprocuredprocurementplansitemsdiv', 'act=a&facilityfinancialyearid=' + '${facilityfinancialyearid}' + '&orderperiodtype=' + '${orderperiodtype}' + '&orderperiodid=' + '${orderperiodid}' + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
            }
        } else {
            $('#facilityunititemvaluesview').modal('hide');
            ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredprocuredprocurementplansitemsview.htm', 'facilityprocuredprocuredprocurementplansitemsdiv', 'act=a&facilityfinancialyearid=' + '${facilityfinancialyearid}' + '&orderperiodtype=' + '${orderperiodtype}' + '&orderperiodid=' + '${orderperiodid}' + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
        }
    }
    function rejectfacilityunititem(facilityunitprocurementplanid, itemid, facilityfinancialyearid, orderperiodtype, genericname, orderperiodid) {
        $.confirm({
            title: 'Reject Facility Unit Item!',
            icon: 'fa fa-warning',
            content: 'You Reject This Item For This Unit',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Reject',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {type: 'unit', facilityunitprocurementplanid: facilityunitprocurementplanid},
                            url: "facilityprocurementplanmanagement/rejectfacilityorunitprocurementplanitems.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    ajaxSubmitData('facilityprocurementplanmanagement/facilityunitsitemvaluesview.htm', 'facilityunititemvaluesviewdiv', 'act=a&facilityfinancialyearid=' + facilityfinancialyearid + '&itemid=' + itemid + '&orderperiodid=' + orderperiodid + '&orderperiodtype=' + orderperiodtype + '&genericname=' + genericname + '&maxR=100&sStr=', 'GET');
                                }
                            }
                        });
                    }
                },
                close: function () {
                }
            }
        });
    }
</script>
<%-- 
    Document   : editFinancialYearItemToImport
    Created on : Apr 11, 2018, 11:29:39 AM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-6">

    </div>
    <div class="col-md-6">
        <input type="text" id="searchtable2" class="form-control" onkeyup="searchtable2()" placeholder="Search for items..">
    </div>
</div><br>
<input value="${importtofacilityunitfnyid}" id="procurementidtoimportto" type="hidden">
<input value="${importtoOrderperiod}" id="orderperiodtyp" type="hidden">
<table class="table table-hover table-bordered" id="financialyrsitmstable">
    <c:if test="${importtoOrderperiod=='Quarterly'}">
        <thead>
            <tr>
                <th>No</th>
                <th>Generic Name</th>
                <th>Pack Size</th>
                <th>Monthly Needed</th>
                <th>Quarterly Needed</th>
                <th>Remove</th>
            </tr>
        </thead>
        <tbody id="finanacialsitems">
            <% int j = 1;%>
            <% int i = 1;%>
            <% int p = 1;%>
            <% int k = 1;%>
            <c:forEach items="${items}" var="a">
                <tr id="up<%=i++%>-${a.itemid}">
                    <td><%=j++%></td>
                    <td>${a.genericname}</td>
                    <td>${a.packsize}</td>
                    <td id="months-<%=p++%>" onkeyup="updateitemmonthlyorannualvalue(this.id, 'quarter');" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;" >${a.averagemonthlyconsumption}</td>
                    <td id="annuals-<%=k++%>" onkeyup="updateitemmonthlyorannualvalue(this.id, 'quarter');" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;">${a.averagequarterconsumption}</td>
                    <td align="center">
                        <button onclick="removeitemfromlist(this.id);" id="${a.itemid}" title="Remove Item From Items To Be Imported." class="btn btn-primary btn-sm">
                            <i class="fa fa-remove"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </c:if>
    <c:if test="${importtoOrderperiod=='Annually'}">
        <thead>
            <tr>
                <th>No</th>
                <th>Generic Name</th>
                <th>Pack Size</th>
                <th>Monthly Needed</th>
                <th>Annual Needed</th>
                <th>Remove</th>
            </tr>
        </thead>
        <tbody id="finanacialsitems">
            <% int s = 1;%>
            <% int o = 1;%>
            <% int t = 1;%>
            <% int u = 1;%>
            <c:forEach items="${items}" var="a">
                <tr id="up<%=s++%>-${a.itemid}">
                    <td><%=o++%></td>
                    <td>${a.genericname}</td>
                    <td>${a.packsize}</td>
                    <td id="months-<%=t++%>" onkeyup="updateitemmonthlyorannualvalue(this.id, 'annual');" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;" >${a.averagemonthlyconsumption}</td>
                    <td id="annuals-<%=u++%>" onkeyup="updateitemmonthlyorannualvalue(this.id, 'annual');" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;">${a.averageannualcomsumption}</td>
                    <td align="center">
                        <button onclick="removeitemfromlist(this.id);" id="${a.itemid}" title="Remove Item From Items To Be Imported." class="btn btn-primary btn-sm">
                            <i class="fa fa-remove"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody> 
    </c:if>
    <c:if test="${importtoOrderperiod=='Monthly'}">
        <thead>
            <tr>
                <th>No</th>
                <th>Generic Name</th>
                <th>Pack Size</th>
                <th>Monthly Needed</th>
                <th>Annual Needed</th>
                <th>Remove</th>
            </tr>
        </thead>
        <tbody id="finanacialsitems">
            <% int v = 1;%>
            <% int w = 1;%>
            <% int x = 1;%>
            <% int y = 1;%>
            <c:forEach items="${items}" var="a">
                <tr id="up<%=v++%>-${a.itemid}">
                    <td><%=w++%></td>
                    <td>${a.genericname}</td>
                    <td>${a.packsize}</td>
                    <td id="months-<%=x++%>" onkeyup="updateitemmonthlyorannualvalue(this.id, 'monthly');" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;" >${a.averagemonthlyconsumption}</td>
                    <td id="annuals-<%=y++%>" onkeyup="updateitemmonthlyorannualvalue(this.id, 'monthly');" contenteditable="true" style="border-width: 2px; padding: 8px;border-style: inset; border-color: gray;background-color: white;">${a.averageannualcomsumption}</td>
                    <td align="center">
                        <button onclick="removeitemfromlist(this.id);" id="${a.itemid}" title="Remove Item From Items To Be Imported." class="btn btn-primary btn-sm">
                            <i class="fa fa-remove"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </c:if>
</table><br>
<div class="form-group">
    <div class="row">
        <div class="col-sm-4">
            <hr style="border:1px dashed #dddddd;">
            <button type="button"  onclick="saveandpauseitemsaddedtoproc();"class="btn btn-primary btn-block">Add & Pause</button>
        </div>   
        <div class="col-sm-4">
            <hr style="border:1px dashed #dddddd;">
            <button type="button" onclick="addandsubmitproc();" class="btn btn-primary btn-block">Add & Submit</button>
        </div> 
        <div class="col-sm-4">
            <hr style="border:1px dashed #dddddd;">
            <button type="button" onclick="cancelimportitemstoProc();" class="btn btn-secondary btn-block">Cancel</button>
        </div> 
    </div>
</div>
<script>
    var removeitems = new Set();
    function removeitemfromlist(id) {
        removeitems.add(id);
        var tablerowid = $('#' + id).closest('tr').attr('id');
        $('#' + tablerowid).remove();
    }
    function updateitemmonthlyorannualvalue(id, period) {
        var fields = id.split('-');
        var type = fields[0];
        var posid = fields[1];
        var value = $('#' + id).text();
        if (value !== '' || value.length !== 0) {
            if (period === 'quarter') {
                if (type === 'months') {
                    document.getElementById('annuals-' + posid).innerHTML = parseInt(value) * 3;
                } else {
                    document.getElementById('months-' + posid).innerHTML = Math.round(parseInt(value) / 3);
                }
            } else {
                if (type === 'months') {
                    document.getElementById('annuals-' + posid).innerHTML = parseInt(value) * 12;
                } else {
                    document.getElementById('months-' + posid).innerHTML = Math.round(parseInt(value) / 12);
                }
            }
        }
    }
    function searchtable2() {
        var input, value;
        input = document.getElementById("searchtable2");
        value = input.value.toLowerCase().trim();
        $("#financialyrsitmstable tr").each(function (index) {
            if (!index)
                return;
            $(this).find("td").each(function () {
                var id = $(this).text().toLowerCase().trim();
                var not_found = (id.indexOf(value) === -1);
                $(this).closest('tr').toggle(!not_found);
                return not_found;
            });
        });
    }
    var itemsproc = [];

    function saveandpauseitemsaddedtoproc() {
        var orderperiodtype = $('#orderperiodtyp').val();
        var tablebody = document.getElementById("finanacialsitems");
        var x = document.getElementById("finanacialsitems").rows.length;
        for (var i = 0; i < x; i++) {
            var row = tablebody.rows[i];
            var ids = row.id;
            var tableData = $('#' + ids).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();

            var fields = ids.split('-');
            var iditem = fields[1];
            if (orderperiodtype === 'Quarterly') {
                itemsproc.push({
                    itemid: iditem,
                    monthly: tableData[3],
                    quarter: tableData[4]
                });
            } else {
                itemsproc.push({
                    itemid: iditem,
                    monthly: tableData[3],
                    annual: tableData[4]
                });
            }

        }
        var procurementid = $('#procurementidtoimportto').val();
        if (itemsproc.length !== 0) {
            $.ajax({
                type: 'POST',
                data: {values: JSON.stringify(itemsproc), procurementid: procurementid, type: 'paused', orderperiodtype: orderperiodtype},
                url: "procurementplanmanagement/saveandorsubmitprocurementplan.htm",
                success: function (data, textStatus, jqXHR) {
                    var facilityfinancialyearidselct = $('#facilityfinancialyearidselct').val();
                    window.location = '#close';
                    $.toast({
                        heading: 'Success',
                        text: 'Successfully Saved !!!!!',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    ajaxSubmitData('procurementplanmanagement/unprocuredfinancialyearperiodstable.htm', 'unprocuredfinancialyearperiodstable', 'act=a&selectprocurementfacilityyr=' + facilityfinancialyearidselct + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        } else {
            $.toast({
                heading: 'Error',
                text: 'First Add Items Before Saving !!!!',
                icon: 'error',
                hideAfter: 2000,
                position: 'bottom-center'
            });
        }
    }
    function addandsubmitproc() {
        var orderperiodtype = $('#orderperiodtyp').val();
        var tablebody = document.getElementById("finanacialsitems");
        var x = document.getElementById("finanacialsitems").rows.length;
        for (var i = 0; i < x; i++) {
            var row = tablebody.rows[i];
            var ids = row.id;
            var tableData = $('#' + ids).closest('tr')
                    .find('td')
                    .map(function () {
                        return $(this).text();
                    }).get();

            var fields = ids.split('-');
            var iditem = fields[1];
            if (orderperiodtype === 'Quarterly') {
                itemsproc.push({
                    itemid: iditem,
                    monthly: tableData[3],
                    quarter: tableData[4]
                });
            } else {
                itemsproc.push({
                    itemid: iditem,
                    monthly: tableData[3],
                    annual: tableData[4]
                });
            }
        }
        var procurementid = $('#procurementidtoimportto').val();
        if (itemsproc.length !== 0) {
            $.ajax({
                type: 'POST',
                data: {values: JSON.stringify(itemsproc), procurementid: procurementid, type: 'submit', orderperiodtype: orderperiodtype},
                url: "procurementplanmanagement/saveandorsubmitprocurementplan.htm",
                success: function (data, textStatus, jqXHR) {
                    var facilityfinancialyearidselct = $('#facilityfinancialyearidselct').val();
                    window.location = '#close';
                    $.toast({
                        heading: 'Success',
                        text: 'Successfully Saved !!!!!',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    ajaxSubmitData('procurementplanmanagement/unprocuredfinancialyearperiodstable.htm', 'unprocuredfinancialyearperiodstable', 'act=a&selectprocurementfacilityyr=' + facilityfinancialyearidselct + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        } else {
            $.toast({
                heading: 'Error',
                text: 'First Add Items Before Saving !!!!',
                icon: 'error',
                hideAfter: 2000,
                position: 'bottom-center'
            });
        }
    }
    function cancelimportitemstoProc() {
        var facilityfinancialyearidselct = $('#facilityfinancialyearidselct').val();
        window.location = '#close';
        ajaxSubmitData('procurementplanmanagement/unprocuredfinancialyearperiodstable.htm', 'unprocuredfinancialyearperiodstable', 'act=a&selectprocurementfacilityyr=' + facilityfinancialyearidselct + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
</script>

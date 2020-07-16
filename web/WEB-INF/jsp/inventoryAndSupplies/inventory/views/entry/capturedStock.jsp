<%-- 
    Document   : capturedStock
    Created on : Apr 10, 2018, 9:59:58 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div class="col-sm-12 col-md-12">
    <table class="table table-hover table-bordered" id="captured">
        <thead>
            <tr>
                <th>No</th>
                <th>Item</th>
                <th>Batch</th>
                <th class="center">Expiry</th>
                <th class="right">UnShelved</th>
                <th class="center">Shelve</th>              
            </tr>
        </thead>
        <tbody id="bodyItems">
            <% int k = 1;%>
            <c:forEach items="${stockItems}" var="item">
                <tr>
                    <td><%=k++%></td>
                    <td>${item.name}</td>
                    <td>${item.batch}</td>
                    <td class="center" title="${item.expirydate}">
                        <c:if test="${item.expiry > 0}">
                            <c:if test="${item.expiry >= 365}">
                                <fmt:parseNumber var="years" integerOnly="true" type="number" value="${item.expiry/365}"/>
                                ${years} Years
                            </c:if>
                            <c:if test="${item.expiry < 365}">
                                <c:if test="${item.expiry >= 30}">
                                    <fmt:parseNumber var="months" integerOnly="true" type="number" value="${item.expiry/30}"/>
                                    ${months} Months
                                </c:if>
                                <c:if test="${item.expiry < 30}">
                                    <c:if test="${item.expiry >= 1}">
                                        ${item.expiry} Days
                                    </c:if>
                                    <c:if test="${item.expiry < 1}">
                                        No Expiry Date
                                    </c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                        <c:if test="${item.expiry <= 0}">
                            Expired
                        </c:if>
                    </td>
                    <td class="right">${item.unshelved}</td>
                    <td class="center">
                        <button onclick="shelveItems(${item.id}, '${item.name}', '${item.unshelved}', '${item.expirydate}', '${item.batch}', ${item.expiry})" title="Add to Shelve." class="btn btn-primary btn-sm add-to-shelf">
                            <i class="fa fa-share"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script>
    $(document).ready(function () {
        $('#captured').DataTable();
    });

    function computeExpiry(days) {
        if (days > 364) {
            if (days === 365)
                return '1 Year to Expiry';
            return parseInt(days / 365) + ' Years to Expiry';
        } else {
            if (days > 29) {
                if (days === 30)
                    return '1 Month to Expiry';
                return parseInt(days / 30) + ' Months to Expiry';
            } else {
                if (days > 0) {
                    if (days < 1)
                        return 'No Expiry Date';
                    if (days === 1)
                        return '1 Day to Expiry';
                    return days + ' Days to Expiry';
                } else {
                    return '<strong>Already Expired</strong>';
                }
            }
        }
    }

    function shelveItems(itemid, itemName, qtyString, expiryDate, batchNo, expiry) {
        var qtyValue = parseInt(qtyString.toString().replace(/,/g, ''));
        if (qtyValue > 1) {
            $('#detailsQty').html('<strong >' + qtyString + '</strong> Items');
        } else {
            $('#detailsQty').html('<strong >' + qtyString + '</strong> Item');
        }
        if (expiry < 1 && expiry !== 0.5) {
            $("#isolated").val('true');
        } else {
            $("#isolated").val('false');
        }
        $("#qtyts").val(qtyValue);
        $('#allocationsBody').html('');
        $("#quantityStocked").val(qtyValue);
        $("#qtyts").attr('max', qtyValue);
        $('#stockItem').html(itemName);
        $('#detailsBatch').html(batchNo);
        $('#detailsExpiry').html(expiryDate);
        $('#selectedStock').val(itemid);
        $('#expiryDetails').html(computeExpiry(expiry));
        window.location = '#shelveItems';
        initDialog('shelveItemDialog');
        shelfList = [];
        shelfCells = new Set();
        var isolated = $("#isolated").val();
        $('#storageZone').html('');
        if (isolated === 'true') {
            $.ajax({
                type: 'POST',
                data: {isolated: true},
                url: 'store/fetchStoreZones.htm',
                success: function (response) {
                    if (response === 'refresh' || response === '' || response === '[]') {
                        if (response === 'refresh') {
                            document.location.reload(true);
                        } else {
                            $('#storageZone').html('<option value="0">No Isolated Storages Set</option>');
                        }
                    } else {
                        var res = JSON.parse(response);
                        for (i in res) {
                            $('#storageZone').append('<option id="zon' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                        }
                        var zoneid = parseInt($('#storageZone').val());
                        $('#zoneBay').html('');
                        if (zoneid > 0) {
                            $.ajax({
                                type: 'POST',
                                data: {zoneid: zoneid, isolated: true},
                                url: 'store/fetchStoreBays.htm',
                                success: function (response) {
                                    if (response === 'refresh' || response === '' || response === '[]') {
                                        if (response === 'refresh') {
                                            document.location.reload(true);
                                        } else {
                                            $('#zoneBay').html('<option value="0">No Isolated Bays Set</option>');
                                        }
                                    } else {
                                        var res = JSON.parse(response);
                                        for (i in res) {
                                            $('#zoneBay').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                        }
                                        var bayid = parseInt($('#zoneBay').val());
                                        $('#bayRow').html('');
                                        if (bayid > 0) {
                                            $.ajax({
                                                type: 'POST',
                                                data: {bayid: bayid, isolated: true},
                                                url: 'store/fetchBayrows.htm',
                                                success: function (response) {
                                                    if (response === 'refresh' || response === '' || response === '[]') {
                                                        if (response === 'refresh') {
                                                            document.location.reload(true);
                                                        } else {
                                                            $('#bayRow').html('<option value="0">No Isolated Rows Added</option>');
                                                        }
                                                    } else {
                                                        var res = JSON.parse(response);
                                                        for (i in res) {
                                                            $('#bayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                        }
                                                        var rowid = parseInt($('#bayRow').val());
                                                        $('#rowCell').html('');
                                                        if (rowid > 0) {
                                                            $.ajax({
                                                                type: 'POST',
                                                                data: {rowid: rowid, isolated: true},
                                                                url: 'store/fetchRowCells.htm',
                                                                success: function (response) {
                                                                    if (response === 'refresh' || response === '' || response === '[]') {
                                                                        if (response === 'refresh') {
                                                                            document.location.reload(true);
                                                                        } else {
                                                                            $('#rowCell').html('<option value="0">No Isolated Cells Found</option>');
                                                                        }
                                                                    } else {
                                                                        $('#rowCell').css('border', '2px solid #6D0A70');
                                                                        var res = JSON.parse(response);
                                                                        for (i in res) {
                                                                            $('#rowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                                        }
                                                                    }
                                                                }
                                                            });
                                                        }
                                                    }
                                                }
                                            });
                                        }
                                    }
                                }
                            });
                        }
                    }
                }
            });
        } else {
            $.ajax({
                type: 'POST',
                data: {isolated: false},
                url: 'store/fetchStoreZones.htm',
                success: function (response) {
                    if (response === 'refresh' || response === '' || response === '[]') {
                        if (response === 'refresh') {
                            document.location.reload(true);
                        } else {
                            $('#storageZone').html('<option value="0">No Storage Zones Set</option>');
                        }
                    } else {
                        var res = JSON.parse(response);
                        for (i in res) {
                            $('#storageZone').append('<option id="zon' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                        }
                        var zoneid = parseInt($('#storageZone').val());
                        $('#zoneBay').html('');
                        if (zoneid > 0) {
                            $.ajax({
                                type: 'POST',
                                data: {zoneid: zoneid, isolated: false},
                                url: 'store/fetchStoreBays.htm',
                                success: function (response) {
                                    if (response === 'refresh' || response === '' || response === '[]') {
                                        if (response === 'refresh') {
                                            document.location.reload(true);
                                        } else {
                                            $('#zoneBay').html('<option value="0">No Bays Set</option>');
                                        }
                                    } else {
                                        var res = JSON.parse(response);
                                        for (i in res) {
                                            $('#zoneBay').append('<option id="bay' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                        }
                                        var bayid = parseInt($('#zoneBay').val());
                                        $('#bayRow').html('');
                                        if (bayid > 0) {
                                            $.ajax({
                                                type: 'POST',
                                                data: {bayid: bayid, isolated: false},
                                                url: 'store/fetchBayrows.htm',
                                                success: function (response) {
                                                    if (response === 'refresh' || response === '' || response === '[]') {
                                                        if (response === 'refresh') {
                                                            document.location.reload(true);
                                                        } else {
                                                            $('#bayRow').html('<option value="0">No Rows Added</option>');
                                                        }
                                                    } else {
                                                        var res = JSON.parse(response);
                                                        for (i in res) {
                                                            $('#bayRow').append('<option id="row' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                        }
                                                        var rowid = parseInt($('#bayRow').val());
                                                        $('#rowCell').html('');
                                                        if (rowid > 0) {
                                                            $.ajax({
                                                                type: 'POST',
                                                                data: {rowid: rowid, isolated: false},
                                                                url: 'store/fetchRowCells.htm',
                                                                success: function (response) {
                                                                    if (response === 'refresh' || response === '' || response === '[]') {
                                                                        if (response === 'refresh') {
                                                                            document.location.reload(true);
                                                                        } else {
                                                                            $('#rowCell').html('<option value="0">No Cells Found</option>');
                                                                        }
                                                                    } else {
                                                                        $('#rowCell').css('border', '2px solid #6D0A70');
                                                                        var res = JSON.parse(response);
                                                                        for (i in res) {
                                                                            $('#rowCell').append('<option id="cell' + res[i].id + '" data-name="' + res[i].name + '" value="' + res[i].id + '">' + res[i].name + '</option>');
                                                                        }
                                                                    }
                                                                }
                                                            });
                                                        }
                                                    }
                                                }
                                            });
                                        }
                                    }
                                }
                            });
                        }
                    }
                }
            });
        }
    }
</script>

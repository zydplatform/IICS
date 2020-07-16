<%-- 
    Document   : approveExternalOrderItems
    Created on : Aug 23, 2018, 9:07:58 AM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp" %>
<div class="col-md-12">
    <div class="row">
        <div class="col-md-12">
            <h3><span style="color: #000; font-size: 16px"><b>Facility Order Number:</b></span><span style="color: green; font-size: 16px"><b><font>${neworderno}</font></b></span></h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <table class="table table-hover table-bordered" id="approveFacilityexternalorderstable">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Order Item</th>
                            <th>Origin Facility Unit(s)</th>
                            <th>Quantity Ordered</th>
                            <th>Quantity Approved</th>
                            <th>Approve Item</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int s = 1;%>
                        <% int a = 1;%>
                        <% int i = 1;%>
                        <c:forEach items="${externalOrderItems}" var="a">
                            <tr id="${a.facilityorderid}">
                                <td><%=s++%></td>
                                <td>${a.genericname} ${a.itemstrength}</td>
                                <td class="center"><button title=" The Items To Be Order For." class="btn btn-secondary btn-sm add-to-shelf" style="background-color: green; important" onclick="externalfacorderfacilityunits(${a.facilityorderitemsid})">
                                        ${a.externalOrdersFacUnitcount} Unit(s)
                                    </button></td>
                                <td>${a.qtyapproved}</td>
                                <td class="center"><input class="form-control"  id="facilityqtyapproved<%=i++%>" oninput="approvedorderedqty(this.id)" type="text"></td>
                                <td align="center">
                                    <div class="toggle-flip">
                                        <label>
                                            <input  <c:if test="${a.approved ==true}">checked="checked"</c:if>  value="${a.facilityorderitemsid}" id="vorapp<%=a++%>p" type="checkbox" onchange="if (this.checked) {
                                                            approveorunapproveFacExtErderItems(this.value, 'checked', ${a.facilityorderid},${a.externalfacilityordersid},${a.qtyordered});
                                                        } else {
                                                            approveorunapproveFacExtErderItems(${a.facilityorderitemsid}, 'unchecked', ${a.facilityorderid},${a.externalfacilityordersid},${a.qtyordered});
                                                        }"><span class="flip-indecator"  style="height: 10px !important;width:  32px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                                        </label>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </fieldset>
        </div>
    </div>
</div>
<script>
    $('#approveFacilityexternalorderstable').DataTable();
    var orderItemsSet = new Set();
    //externalOrderItemsSizes
    function externalfacorderfacilityunits(facilityorderitemsid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "extordersmanagement/viewFacExternalUnits.htm",
            data: {facilityorderitemsid: facilityorderitemsid},
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Ordering Facility Units' + '</strong>',
                    content: '' + data,
                    boxWidth: '45%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
    }

    function approvedorderedqty(id) {

    }

    function approveorunapproveFacExtErderItems(facilityorderitemsid, type, facilityorderid, externalfacilityordersid, qtyordered) {
//        if (!orderItemsSet.has(facilityorderitemsid)) {
//            orderItemsSet.add(facilityorderitemsid);
//            console.log(orderItemsSet);
//        } else {
//            orderItemsSet.delete(facilityorderitemsid);
//            if (orderItemsSet.size < 1) {
//            }
//            console.log(orderItemsSet);
//        }
        var jsonOrderitemNo = ${externalOrderItemsSizes};
        var orderInteger = parseInt(jsonOrderitemNo);
        var facilityorderitemno = orderItemsSet.add(facilityorderitemsid);
        var facsetsize = facilityorderitemno.size;
        var facilityqtyapproved = $('#facilityqtyapproved').val();
        console.log("----------------------------facsetsize" + facsetsize);
        console.log("----------------------------qtyordered" + qtyordered);

        if (facsetsize !== orderInteger) {
            if (facilityqtyapproved === '') {
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "extordersmanagement/saveNewOrderValue.htm",
                    data: {facilityqtyapproved: qtyordered, facilityorderitemsid: facilityorderitemsid},
                    success: function (data) {
                        console.log("---------------my data" + data)
                        if (data === 'success') {
                            ajaxSubmitData('extordersmanagement/approveFacilityExternalOrders', 'approveExtFacOrders', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        } else {
                        }
                    }
                });
            } else {
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "extordersmanagement/saveNewOrderValue.htm",
                    data: {facilityqtyapproved: facilityqtyapproved, facilityorderitemsid: facilityorderitemsid},
                    success: function (data) {
                        console.log("---------------my data" + data)
                        if (data === 'success') {
                            ajaxSubmitData('extordersmanagement/approveFacilityExternalOrders', 'approveExtFacOrders', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                        } else {
                        }
                    }
                });
            }
        } else {

            if (facilityqtyapproved === '') {
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "extordersmanagement/saveNewOrderValue.htm",
                    data: {facilityqtyapproved: qtyordered, facilityorderitemsid: facilityorderitemsid},
                    success: function (data) {
                        ajaxSubmitData('extordersmanagement/approveFacilityExternalOrders', 'approveExtFacOrders', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                });
                if (type === 'checked') {
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, facilityorderid: facilityorderid, externalfacilityordersid: externalfacilityordersid, type: 'approve'},
                        url: "extordersmanagement/approveorunapproveextfacilityorderitems.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                ajaxSubmitData('extordersmanagement/approveFacilityExternalOrders', 'approveExtFacOrders', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            } else {
                            }
                        }
                    });
                } else {
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, facilityorderid: facilityorderid, externalfacilityordersid: externalfacilityordersid, type: 'unapprove'},
                        url: "extordersmanagement/approveorunapproveextfacilityorderitems.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                ajaxSubmitData('extordersmanagement/approveFacilityExternalOrders', 'approveExtFacOrders', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            } else {
                            }
                        }
                    });
                }
            } else {
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "extordersmanagement/saveNewOrderValue.htm",
                    data: {facilityqtyapproved: facilityqtyapproved, facilityorderitemsid: facilityorderitemsid},
                    success: function (data) {
                        ajaxSubmitData('extordersmanagement/approveFacilityExternalOrders', 'approveExtFacOrders', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                });
                if (type === 'checked') {
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, facilityorderid: facilityorderid, externalfacilityordersid: externalfacilityordersid, type: 'approve'},
                        url: "extordersmanagement/approveorunapproveextfacilityorderitems.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                ajaxSubmitData('extordersmanagement/approveFacilityExternalOrders', 'approveExtFacOrders', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            } else {
                            }
                        }
                    });
                } else {
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, facilityorderid: facilityorderid, externalfacilityordersid: externalfacilityordersid, type: 'unapprove'},
                        url: "extordersmanagement/approveorunapproveextfacilityorderitems.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                ajaxSubmitData('extordersmanagement/approveFacilityExternalOrders', 'approveExtFacOrders', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            } else {
                            }
                        }
                    });
                }
            }

        }
    }

</script>

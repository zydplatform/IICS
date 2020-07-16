<%-- 
    Document   : approveexternalorderitems
    Created on : Aug 8, 2018, 10:48:18 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../../../../include.jsp" %>
<div class="col-md-12">
    <input value="${facilityorderid}" id="facilityorderid" class="form-group" type="hidden">
    <fieldset>
        <div class="tile">
            <table class="table table-hover table-striped" id="externalOrdersTabled">
                <thead>
                    <tr>
                        <th class="center">#</th>
                        <th>Item</th>
                        <th class="center">Quantity Ordered</th>
                        <th class="center">New Item Value</th>
                        <th class="center">Approve Item</th>
                    </tr>
                </thead>
                <tbody id="approvingOrders">
                    <% int m = 1;%>
                    <% int t = 1;%>
                    <% int r = 1;%>
                    <c:forEach items="${externalOrderItems}" var="i">
                        <tr id="${i.itemid}">
                            <td class="center"><%=m++%></td>
                            <td class="">${i.genericname} ${i.itemstrength}</td>
                            <td class="center" id="qtyordered">${i.qtyordered}</td>
                            <td class="center" id="qtyapproved"><input class="form-control"  id="newordervalues<%=r++%>" oninput="approvedvalue(this.id)" type="text"></td>
                            <td align="center">
                                <div class="toggle-flip">
                                    <label>
                                        <input  <c:if test="${a.approved ==true}">checked="checked"</c:if>  value="${i.facilityorderitemsid}" data-id="${i.qtyordered}" id="vorapp<%=t++%>p" type="checkbox" onchange="if (this.checked) {
                                                    approveorunapproveextorderitems(this.value, 'checked', ${i.facilityorderid}, '${i.qtyorderednocommas}');
                                                } else {
                                                    approveorunapproveextorderitems(${i.facilityorderitemsid}, 'unchecked', ${i.facilityorderid}, '${i.qtyorderednocommas}');
                                                }"><span class="flip-indecator"  style="height: 10px !important;width:  32px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                                    </label>
                                </div>

                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div id="extoverlayapprv" style="display: none;">
            <img src="static/img2/loader.gif" alt="Loading" /><br/>
            Please Wait...
        </div>
        <input class="form-control"  id="neworder" type="hidden">
    </fieldset>
</div>
<script>
    var selectedItems = new Set();
    $('#externalOrdersTabled').DataTable();
    function compareApprovedToOrderedStock(facilityorderid, orderqty, valueinput, dispID) {
        var disp = parseInt(valueinput) - parseInt(orderqty);
        $('#' + dispID).val(disp);
    }

    function approvedvalue(id) {
        console.log("-------------------------my id" + id);
        var x = $('#' + id).val();
        console.log("-------------------------my idx" + x);
        document.getElementById("neworder").value = x;
    }

    function approveorunapproveextorderitems(facilityorderitemsid, type, facilityorderid, qtyordered) {

        var jsonOrderitemNo = ${externalOrderItemsSizes};
        var orderInteger = parseInt(jsonOrderitemNo);
        var facilityorderitemno = selectedItems.add(facilityorderitemsid);
        var facsetsize = facilityorderitemno.size;
        var newordervalue = $('#neworder').val();
        var facilityorderno = $('#facilityorderno').val();

        if (facsetsize !== orderInteger) {
            if (newordervalue === '') {
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "externalordersapproval/saveNewOrderValue.htm",
                    data: {newordervalue: qtyordered, facilityorderitemsid: facilityorderitemsid},
                    success: function (data) {
                        ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');

                    }
                });

                if (type === 'checked') {
                    document.getElementById('extoverlayapprv').style.display = 'block';
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, type: 'approve'},
                        url: "externalordersapproval/approveorunapproveextfacilityunitorderitems.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                                ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');

                            } else {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                            }
                        }
                    });
                } else {
                    document.getElementById('extoverlayapprv').style.display = 'block';
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, type: 'unapprove'},
                        url: "externalordersapproval/approveorunapproveextfacilityunitorderitems.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                                ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');

                            } else {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                            }
                        }
                    });
                }
            } else {
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "externalordersapproval/saveNewOrderValue.htm",
                    data: {newordervalue: newordervalue, facilityorderitemsid: facilityorderitemsid},
                    success: function (data) {
                        ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');

                    }
                });
                if (type === 'checked') {
                    document.getElementById('extoverlayapprv').style.display = 'block';
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, type: 'approve'},
                        url: "externalordersapproval/approveorunapproveextfacilityunitorderitems.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                                ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');

                            } else {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                            }
                        }
                    });
                } else {
                    document.getElementById('extoverlayapprv').style.display = 'block';
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, type: 'unapprove'},
                        url: "externalordersapproval/approveorunapproveextfacilityunitorderitems.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                                ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');
                            } else {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                            }
                        }
                    });
                }
            }
        } else {
            if (newordervalue === '') {
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "externalordersapproval/saveNewOrderValue.htm",
                    data: {newordervalue: qtyordered, facilityorderitemsid: facilityorderitemsid},
                    success: function (data) {
                        ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');

                    }
                });

                if (type === 'checked') {
                    document.getElementById('extoverlayapprv').style.display = 'block';
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, type: 'approve', facilityorderid: facilityorderid},
                        url: "externalordersapproval/approveorunapproveextfacilityunitorderitem.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                                ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');

                            } else {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                            }
                        }
                    });
                } else {
                    document.getElementById('extoverlayapprv').style.display = 'block';
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, type: 'unapprove', facilityorderid: facilityorderid},
                        url: "externalordersapproval/approveorunapproveextfacilityunitorderitem.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                                ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');

                            } else {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                            }
                        }
                    });
                }
            } else {
                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "externalordersapproval/saveNewOrderValue.htm",
                    data: {newordervalue: newordervalue, facilityorderitemsid: facilityorderitemsid, facilityorderid: facilityorderid},
                    success: function (data) {
                        ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');

                    }
                });
                if (type === 'checked') {
                    document.getElementById('extoverlayapprv').style.display = 'block';
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, type: 'approve', facilityorderid: facilityorderid},
                        url: "externalordersapproval/approveorunapproveextfacilityunitorderitem.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                                ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');

                            } else {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                            }
                        }
                    });
                } else {
                    document.getElementById('extoverlayapprv').style.display = 'block';
                    $.ajax({
                        type: 'POST',
                        data: {facilityorderitemsid: facilityorderitemsid, type: 'unapprove', facilityorderid: facilityorderid},
                        url: "externalordersapproval/approveorunapproveextfacilityunitorderitem.htm",
                        success: function (data, textStatus, jqXHR) {
                            if (data === 'success') {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                                ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');

                            } else {
                                document.getElementById('extoverlayapprv').style.display = 'none';
                            }
                        }
                    });
                }
            }
        }

    }

    var selectedItem = [];
    function approveSelectedItems() {
        var facilityorderid = $('#facilityorderid').val();
        var facilityorderno = $('#facilityorderno').val();

        $.ajax({
            type: "POST",
            cache: false,
            url: "externalordersapproval/approveExtFacilityOrder.htm",
            data: {facilityorderid: facilityorderid, facilityorderitemsid: JSON.stringify(Array.from(selectedItem))},
            success: function (data) {
                if (data === 'updated') {
                    $('#enteredTheFloorsBody').html('');
                    $.toast({
                        heading: 'Success',
                        text: 'Order Successfully Approved.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&nvb=0', 'GET');
                    window.location = '#close';
                } else {
                    $.toast({
                        heading: 'Error',
                        text: 'An unexpected error occured while trying to approve order.',
                        icon: 'error'
                    });
                    window.location = '#close';
                }
            }
        });

    }
</script>

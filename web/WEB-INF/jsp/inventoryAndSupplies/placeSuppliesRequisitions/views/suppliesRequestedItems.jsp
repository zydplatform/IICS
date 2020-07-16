<%--
    Document   : viewSentOrderItems
    Created on : May 21, 2018, 4:59:37 AM
    Author     : IICS-GRACE
--%>
<%@include file="../../../include.jsp"%>
<input type="hidden" value="${suppliesorderid}" id="suppliesorderid"/>

<div class="col-md-12">
    <h5 class="center">Order Items</h5>  
    <table class="table table-hover table-bordered col-md-12" id="table-suppliy-view-orders-items">
        <thead class="col-md-12">
            <tr>
                <th class="center">No</th>
                <th>Item</th>
                <th class="center">Qty Ordered</th>
                <th class="center">Unshelved Stock</th>
                <th class="center">Shelved Stock</th>
                <th class="center">Qty Approved</th>
            </tr>
        </thead>
        <tbody class="col-md-12" id="">
            <% int h = 1;%>
            <c:forEach items="${orderItemsList}" var="a">
                <tr id="${a.itemid}" data-transactionalstock="${a.transactionalStock}">
                    <td class="center"><%=h++%></td>
                    <td>${a.genericname}</td>
                    <td class=""><input type="hidden" id="itmordered${a.itemid}" value="${a.qtyordered}"/><span style="font-size: 16px; background-color: #9a4691 !important; color: whitesmoke" class="badge pull-right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${a.qtyordered}"/></span></td>
                    <td>
                        <c:if test="${a.unshelvedstock != null && a.unshelvedstock != '0'}">
                            <strong class="pull-right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${a.unshelvedstock / a.packsize}" /></strong>
                        </c:if>
                        <c:if test="${a.unshelvedstock == null || a.unshelvedstock == '0'}">
                            <strong>
                                <font class="pull-right" color="red">0</font>
                            </strong>
                        </c:if>
                    </td>

                    <td class="">
                        <c:if test="${a.transactionalStocknocommas != null && a.transactionalStocknocommas != '0'}">
                            <strong class="pull-right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${a.transactionalStock / a.packsize}"/></strong>
                        </c:if>
                        <c:if test="${a.transactionalStocknocommas == null || a.transactionalStock == '0'}">
                            <strong>
                                <font class="pull-right" color="red">0</font>
                            </strong>
                        </c:if>
                    </td>

                    <td class="">
                        <input data-transactionalstock="${a.transactionalStock}" oninput="compareTansactionalToApprovedStock(${a.itemid}, ${a.transactionalStocknocommas / a.packsize})" id="itmqtyapprvdsup${a.itemid}" value="" name="${a.suppliesorderitemsid}" class="form-control form-control-sm orderqquantities approvedorders class-validate-orderitemqtys" min="0" max="" type="number"/>
            <medium id="itmerrormsg${a.itemid}" class="form-text hidedisplaycontent">
                <strong style="margin-left: 3px; color: red;">Ordered stock is more than what is shelved [<fmt:formatNumber type="number" maxFractionDigits="0" value="${a.transactionalStock / a.packsize}"/>].</strong>
            </medium>
            <medium id="itmerrormsgqtyordered${a.itemid}" class="form-text hidedisplaycontent">
                <strong style="color: red;">Sorry! Can not approve more than Qty ordered [<fmt:formatNumber type="number" maxFractionDigits="0" value="${a.qtyordered}"/>].</strong>
            </medium>
            </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="col-md-12 right"><hr/>
        <button id="btnSaveApprovedSupplyItems" class="btn btn-primary pull-right" type="button" disabled="true">
            <i class="fa fa-fw fa-lg fa-check-circle"></i>Approve Item Quantities
        </button>
    </div>
</div>

<script>
    var checkemptyinputssetsup = new Set();
    var orderItemsListsizesup = parseInt(${orderItemsListsize});

    var errorItemstwosup = new Set();
    $('#table-suppliy-view-orders-items tr').click(function () {
        var itemid = $(this).attr('id');
        itemid = parseInt(itemid);
        var orderinput = document.getElementById('itmqtyapprvdsup' + itemid).value;
        if (orderinput === null || orderinput === '' || typeof orderinput === 'undefined') {
            orderinput = parseInt(orderinput);
            var qutityoerderfor = $('#itmordered' + itemid).val();
            qutityoerderfor = qutityoerderfor.split(',').join('');
            $("#itmqtyapprvdsup" + itemid).val(parseInt(qutityoerderfor));

            var orderinputnew = document.getElementById('itmqtyapprvdsup' + itemid).value;

            var transstock = $(this).data('transactionalstock');
            transstock = transstock.valueOf().toString().split(',').join('');
            if (parseInt(orderinputnew) > parseInt(qutityoerderfor) || parseInt(orderinputnew) > parseInt(transstock)) {
                if ((parseInt(orderinputnew) > parseInt(qutityoerderfor))) {
                    $("#itmerrormsgqtyordered" + itemid).show();
                    $("#itmerrormsg" + itemid).hide();
                    if (!errorItemstwosup.has(itemid)) {
                        errorItemstwosup.add(itemid);
                        document.getElementById("btnSaveApprovedSupplyItems").disabled = true;
                    }
                }

                if (parseInt(orderinputnew) > parseInt(transstock)) {
                    $("#itmerrormsg" + itemid).show();
                    $("#itmerrormsgqtyordered" + itemid).hide();
                    if (!errorItemstwosup.has(itemid)) {
                        errorItemstwosup.add(itemid);
                        document.getElementById("btnSaveApprovedSupplyItems").disabled = true;
                    }
                }
            } else {
                $("#itmerrormsg" + itemid).hide();
                $("#itmerrormsgqtyordered" + itemid).hide();
                if (errorItemstwosup.has(itemid)) {
                    errorItemstwosup.delete(itemid);
                }
                if (errorItemstwosup.size < 1) {
                    document.getElementById("btnSaveApprovedSupplyItems").disabled = false;
                }
            }

            if (!checkemptyinputssetsup.has(itemid)) {
                checkemptyinputssetsup.add(itemid);
            }
        }
    });

    $('#btnSaveApprovedSupplyItems').click(function () {
        var qtyorderedvalues = [];
        $('.approvedorders').each(function () {
            qtyorderedvalues.push({name: this.name, value: this.value});
        });
        if (orderItemsListsizesup > checkemptyinputssetsup.size && checkemptyinputssetsup.size !== 0) {
            $.confirm({
                icon: 'fa fa-warning',
                title: '<strong><font color="red">Warning!</font></strong>',
                content: '' + '<strong style="font-size: 18px;"><font color="">Some Order Quantities were not entered.<br> <span style="color:red; font-size: 22px"> Are you sure you want to Continue?</span></font></strong>',
                boxWidth: '30%',
                useBootstrap: false,
                type: 'red',
                typeAnimated: true,
                closeIcon: true,
                buttons: {
                    somethingElse: {
                        text: 'Yes',
                        btnClass: 'btn-purple',
                        action: function () {
                            var suppliesorderid = $('#suppliesorderid').val();
                            document.getElementById("btnSaveApprovedSupplyItems").disabled = true;
                            $.ajax({
                                type: 'GET',
                                url: 'sandriesreq/savesuppliyApprovedOrders.htm',
                                data: {suppliesorderid: suppliesorderid, qtyorderedvalues: JSON.stringify(qtyorderedvalues)},
                                success: function (items) {
                                    window.location = '#close';
                                    ajaxSubmitData('sandriesreq/suppliesRequisitionsHome.htm', 'workpane', '', 'GET');
                                }
                            });
                        }
                    },
                    No: {
                        text: 'NO',
                        btnClass: 'btn-red',
                        action: function () {

                        }
                    }
                }
            });
        }
        if (orderItemsListsizesup === checkemptyinputssetsup.size) {
            var suppliesorderid = $('#suppliesorderid').val();
            document.getElementById("btnSaveApprovedSupplyItems").disabled = true;
            $.ajax({
                type: 'GET',
                url: 'sandriesreq/savesuppliyApprovedOrders.htm',
                data: {suppliesorderid: suppliesorderid, qtyorderedvalues: JSON.stringify(qtyorderedvalues)},
                success: function (items) {
                    window.location = '#close';
                    ajaxSubmitData('sandriesreq/suppliesRequisitionsHome.htm', 'workpane', '', 'GET');
                }
            });
        }
        if (checkemptyinputssetsup.size === 0) {
            $.confirm({
                icon: 'fa fa-warning',
                title: '<strong>Alert: <font color="red">Can not proceed!</font></strong>',
                content: '' + '<strong style="font-size: 18px;"><font color="red">Please Fill in Picked Item Order Quantities.</font></strong>',
                boxWidth: '30%',
                useBootstrap: false,
                type: 'red',
                typeAnimated: true,
                closeIcon: true,
                buttons: {
                    somethingElse: {
                        text: 'OK',
                        btnClass: 'btn-purple',
                        action: function () {

                        }
                    }
                }
            });
        }
    });

    var errorItems2 = new Set();
    function compareTansactionalToApprovedStock(itemid, transactionstock) {
        transactionstock = parseInt(transactionstock);
        var approvedstock = $('#itmqtyapprvdsup' + itemid).val();
        var qutityoerderfor = $('#itmordered' + itemid).val();
        qutityoerderfor = qutityoerderfor.split(',').join('');

        if ((parseInt(approvedstock) > parseInt(qutityoerderfor)) || (parseInt(approvedstock) > parseInt(transactionstock))) {

            if (parseInt(approvedstock) > parseInt(qutityoerderfor)) {
                $("#itmerrormsgqtyordered" + itemid).show();
                $("#itmerrormsg" + itemid).hide();
                if (!errorItems2.has(itemid)) {
                    errorItems2.add(itemid);
                    document.getElementById("btnSaveApprovedSupplyItems").disabled = true;
                }
            }

            if (parseInt(approvedstock) > parseInt(transactionstock)) {
                $("#itmerrormsg" + itemid).show();
                $("#itmerrormsgqtyordered" + itemid).hide();
                if (!errorItems2.has(itemid)) {
                    errorItems2.add(itemid);
                    document.getElementById("btnSaveApprovedSupplyItems").disabled = true;
                }
            }
        } else {
            $("#itmerrormsg" + itemid).hide();
            if (errorItems2.has(itemid)) {
                errorItems2.delete(itemid);
            }
            if (errorItems2.size < 1) {
                document.getElementById("btnSaveApprovedSupplyItems").disabled = false;
            }
        }

        if (approvedstock === null || approvedstock === '' || typeof approvedstock === 'undefined') {
            if (checkemptyinputssetsup.has(itemid)) {
                checkemptyinputssetsup.delete(itemid);
            }
        } else {
            if (!checkemptyinputssetsup.has(itemid)) {
                checkemptyinputssetsup.add(itemid);
            }
        }
    }
</script>


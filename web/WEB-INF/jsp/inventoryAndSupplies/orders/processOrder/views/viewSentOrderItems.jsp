<%--
    Document   : viewSentOrderItems
    Created on : May 21, 2018, 4:59:37 AM
    Author     : IICS-GRACE
--%>
<%@include file="../../../../include.jsp"%>
<input type="hidden" value="${facilityorderid}" id="facilityunitorderid"/>

<div class="col-md-12">
    <h5 class="center">Order Items</h5>  
    <table class="table table-hover table-bordered col-md-12" id="table-today-new-orders">
        <thead class="col-md-12">
            <tr>
                <th class="center">No</th>
                <th>Item</th>
                <th class="center">Qty Approved</th> 
                <th> Ordering Unit Stock</th>
                <th class="right">Sanctioned Qty</th>
                <th class="center">Unshelved Stock</th>
                <th class="center">Transaction Stock</th>
                <th class="center">Qty Sanctioned</th>
            </tr>
        </thead>
        <tbody class="col-md-12" id="">
            <% int h = 1;%>
            <c:forEach items="${orderItemsList}" var="a">
                <tr id="${a.itemid}" data-transactionalstock="${a.transactionalStock}">
                    <td class="center"><%=h++%></td>
                    <td>${a.genericname}</td>
                    <td class=""><input type="hidden" id="itmordered${a.itemid}" value="${a.qtyapproved / a.packsize}"/><span style="font-size: 16px; background-color: #9a4691 !important; color: whitesmoke" class="badge pull-right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${a.qtyapproved / a.packsize}"/></span></td>
                    <td>${a.stockbalance}</td>
                    <td class="right">
                        <c:if test="${a.picklistqty != null && a.picklistqty != '0'}">
                            <font color="blue"><fmt:formatNumber type="number" maxFractionDigits="0" value="${a.picklistqty / a.packsize}" /></font>
                        </c:if>
                        <c:if test="${a.picklistqty == null || a.picklistqty == '0'}">
                            <strong>
                                <font class="pull-right" color="red">0</font>
                            </strong>
                        </c:if>
                    </td>
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
                        <!--<input data-item-id="${a.itemid}" data-transactionalstock="${a.transactionalStock}" oninput="compareTansactionalToApprovedStock(${a.itemid}, ${a.transactionalStocknocommas / a.packsize})" id="itmqtyapprvd${a.itemid}" value="" name="${a.facilityorderitemsid}" class="form-control form-control-sm orderqquantities approvedorders class-validate-orderitemqtys" min="0" max="" type="number"/>-->
                        <input data-item-id="${a.itemid}" data-transactionalstock="${a.transactionalStock}" 
                               oninput="compareTansactionalToApprovedStock(${a.itemid}, ${a.transactionalStocknocommas / a.packsize})" 
                               id="itmqtyapprvd${a.itemid}" value="" name="${a.facilityorderitemsid}" 
                               class="form-control form-control-sm orderqquantities approvedorders class-validate-orderitemqtys" 
                               min="0" max="" type="number" <c:if test="${a.transactionalStocknocommas == null || a.transactionalStock == '0'}">disabled="disabled"</c:if>/>
                        
            <medium id="itmerrormsg${a.itemid}" class="form-text hidedisplaycontent">
                <strong style="margin-left: 3px; color: red;">Ordered stock is more than what we can Transact [<fmt:formatNumber type="number" maxFractionDigits="0" value="${a.transactionalStock / a.packsize}"/>].</strong>
            </medium>
            <medium id="itmerrormsgqtyordered${a.itemid}" class="form-text hidedisplaycontent">
                <strong style="color: red;">Sorry! Can not approve more than Qty Approved [<fmt:formatNumber type="number" maxFractionDigits="0" value="${a.qtyapproved / a.packsize}"/>].</strong>
            </medium>
            </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="col-md-12 right"><hr/>
        <button id="btnSaveApprovedOrders" class="btn btn-primary pull-right" type="button" disabled="true"  data-ordering-unit-id="${orderingunitid}">
            <i class="fa fa-fw fa-lg fa-check-circle"></i>Approve Item Quantities
        </button>
    </div>
</div>

<script>
    breadCrumb();
//
//    $('#table-today-new-orders').DataTable();
    var table = $('#table-today-new-orders').DataTable({
        drawCallback: function(){
          $('.paginate_button:not(.disabled)', this.api().table().container())          
             .on('click', function(e){
                $('#table-today-new-orders').parent().parent().parent().parent().parent().scrollTop(0);
             });       
       }
    });
    var checkemptyinputsset = new Set();
    var orderItemsListsize = parseInt(${orderItemsListsize});

    var errorItemstwo2 = new Set();
//    $('#table-today-new-orders tr').click(function () {
    $('#table-today-new-orders').on('click', 'tr', function(){
//        var itemid = $(this).attr('id');
//        itemid = parseInt(itemid);
//        var orderinput = document.getElementById('itmqtyapprvd' + itemid).value;
//        if (orderinput === null || orderinput === '' || typeof orderinput === 'undefined') {
//            orderinput = parseInt(orderinput);
//            var qutityoerderfor = $('#itmordered' + itemid).val();
//            qutityoerderfor = qutityoerderfor.split(',').join('');
//            $("#itmqtyapprvd" + itemid).val(parseInt(qutityoerderfor));
//
//            var orderinputnew = document.getElementById('itmqtyapprvd' + itemid).value;
//
//            var transstock = $(this).data('transactionalstock');
//            transstock = transstock.valueOf().toString().split(',').join('');
//            if (parseInt(orderinputnew) > parseInt(qutityoerderfor) || parseInt(orderinputnew) > parseInt(transstock)) {
//                if ((parseInt(orderinputnew) > parseInt(qutityoerderfor))) {
//                    $("#itmerrormsgqtyordered" + itemid).show();
//                    $("#itmerrormsg" + itemid).hide();
//                    if (!errorItemstwo2.has(itemid)) {
//                        errorItemstwo2.add(itemid);
//                        document.getElementById("btnSaveApprovedOrders").disabled = true;
//                    }
//                }
//
//                if (parseInt(orderinputnew) > parseInt(transstock)) {
//                    $("#itmerrormsg" + itemid).show();
//                    $("#itmerrormsgqtyordered" + itemid).hide();
//                    if (!errorItemstwo2.has(itemid)) {
//                        errorItemstwo2.add(itemid);
//                        document.getElementById("btnSaveApprovedOrders").disabled = true;
//                    }
//                }
//            } else {
//                $("#itmerrormsg" + itemid).hide();
//                $("#itmerrormsgqtyordered" + itemid).hide();
//                if (errorItemstwo2.has(itemid)) {
//                    errorItemstwo2.delete(itemid);
//                }
//                if (errorItemstwo2.size < 1) {
//                    document.getElementById("btnSaveApprovedOrders").disabled = false;
//                }
//            }
//
//            if (!checkemptyinputsset.has(itemid)) {
//                checkemptyinputsset.add(itemid);
//            }
//        }
        
        //
        var transstock = $(this).data('transactionalstock');
        //
        var itemid = $(this).attr('id');
        itemid = parseInt(itemid);
        var orderinput = document.getElementById('itmqtyapprvd' + itemid).value;
        if(transstock > 0){
            if (orderinput === null || orderinput === '' || typeof orderinput === 'undefined') {
                orderinput = parseInt(orderinput);
                var qutityoerderfor = $('#itmordered' + itemid).val();
                qutityoerderfor = qutityoerderfor.split(',').join('');
                $("#itmqtyapprvd" + itemid).val(parseInt(qutityoerderfor));

                var orderinputnew = document.getElementById('itmqtyapprvd' + itemid).value;

    //            var transstock = $(this).data('transactionalstock');
                transstock = transstock.valueOf().toString().split(',').join('');
                if (parseInt(orderinputnew) > parseInt(qutityoerderfor) || parseInt(orderinputnew) > parseInt(transstock)) {
                    if ((parseInt(orderinputnew) > parseInt(qutityoerderfor))) {
                        $("#itmerrormsgqtyordered" + itemid).show();
                        $("#itmerrormsg" + itemid).hide();
                        if (!errorItemstwo2.has(itemid)) {
                            errorItemstwo2.add(itemid);
                            document.getElementById("btnSaveApprovedOrders").disabled = true;
                        }
                    }

                    if (parseInt(orderinputnew) > parseInt(transstock)) {
                        $("#itmerrormsg" + itemid).show();
                        $("#itmerrormsgqtyordered" + itemid).hide();
                        if (!errorItemstwo2.has(itemid)) {
                            errorItemstwo2.add(itemid);
                            document.getElementById("btnSaveApprovedOrders").disabled = true;
                        }
                    }
                } else {
                    $("#itmerrormsg" + itemid).hide();
                    $("#itmerrormsgqtyordered" + itemid).hide();
                    if (errorItemstwo2.has(itemid)) {
                        errorItemstwo2.delete(itemid);
                    }
                    if (errorItemstwo2.size < 1) {
                        document.getElementById("btnSaveApprovedOrders").disabled = false;
                    }
                }

                if (!checkemptyinputsset.has(itemid)) {
                    checkemptyinputsset.add(itemid);
                }
            }
        }
        
        // 
        var current = $(this).parent().parent().parent().parent().parent().parent().parent().scrollTop();
        $(this).parent().parent().parent().parent().parent().parent().parent()
                .animate({ scrollTop: ((current + $(this).height())) }, 50);
        //
    });

    $('#btnSaveApprovedOrders').click(function () {
        var qtyorderedvalues = [];
        var orderingUnitId = $(this).data('ordering-unit-id');
        // 
//        $('.approvedorders').each(function () {
//            qtyorderedvalues.push({name: this.name, value: this.value});
//        });
        table.rows().iterator('row', function(context, index){ //
            var node = $(this.row(index).node());
            node.each(function (e) {
                var i = $(this).children('td').children('.approvedorders')[0];
                var itemId = $(i).data('item-id');
                qtyorderedvalues.push({name: i.name, value: i.value, itemid: itemId});
            });
        });
//        if (orderItemsListsize > checkemptyinputsset.size && checkemptyinputsset.size !== 0) {
//            $.confirm({
//                icon: 'fa fa-warning',
//                title: '<strong><font color="red">Warning!</font></strong>',
//                content: '' + '<strong style="font-size: 18px;"><font color="">Some Order Quantities were not entered.<br> <span style="color:red; font-size: 22px"> Are you sure you want to Continue?</span></font></strong>',
//                boxWidth: '30%',
//                useBootstrap: false,
//                type: 'red',
//                typeAnimated: true,
//                closeIcon: true,
//                buttons: {
//                    somethingElse: {
//                        text: 'Yes',
//                        btnClass: 'btn-purple',
//                        action: function () {
//                            var facilityunitorderid = $('#facilityunitorderid').val();
//                            document.getElementById("btnSaveApprovedOrders").disabled = true;
//                            $.ajax({
//                                type: 'GET',
//                                url: 'ordersmanagement/savesentApprovedOrders.htm',
//                                data: {facilityorderid: facilityunitorderid, qtyorderedvalues: JSON.stringify(qtyorderedvalues)},
//                                success: function (items) {
//                                    window.location = '#close';
//                                    ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                                }
//                            });
//                        }
//                    },
//                    No: {
//                        text: 'NO',
//                        btnClass: 'btn-red',
//                        action: function () {
//
//                        }
//                    }
//                }
//            });
//        }
//        if (orderItemsListsize === checkemptyinputsset.size) {
//            var facilityunitorderid = $('#facilityunitorderid').val();
//            document.getElementById("btnSaveApprovedOrders").disabled = true;
//            $.ajax({
//                type: 'GET',
//                url: 'ordersmanagement/savesentApprovedOrders.htm',
//                data: {facilityorderid: facilityunitorderid, qtyorderedvalues: JSON.stringify(qtyorderedvalues)},
//                success: function (items) {
//                    window.location = '#close';
//                    ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
//                }
//            });
//        }
        if (orderItemsListsize > checkemptyinputsset.size && checkemptyinputsset.size !== 0) {
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
                            var facilityunitorderid = $('#facilityunitorderid').val();
                            document.getElementById("btnSaveApprovedOrders").disabled = true;
                            $.ajax({
                                type: 'GET',
                                url: 'ordersmanagement/savesentApprovedOrders.htm',
                                data: { facilityorderid: facilityunitorderid, qtyorderedvalues: JSON.stringify(qtyorderedvalues), initialrequest: true, orderingunitid: orderingUnitId },
                                success: function (result) {
                                    if(result.toString().toLowerCase() !== 'success'.toLowerCase()){
                                        showOrderItems(facilityunitorderid);
                                        $.confirm({
                                            title: '',
                                            type: 'purple',
                                            typeAnimated: true,
                                            boxWidth: '30%',
                                            closeIcon: false,
                                            useBootstrap: false,
                                            content: '<h5>' + result + '</h5>',
                                            buttons: {
                                                ok: {
                                                    text: 'Proceed',
                                                    btnClass: 'btn btn-warning',
                                                    action: function () {
                                                        $.ajax({
                                                            type: 'GET',
                                                            url: 'ordersmanagement/savesentApprovedOrders.htm',
                                                            data: { facilityorderid: facilityunitorderid, qtyorderedvalues: JSON.stringify(qtyorderedvalues), initialrequest: false, orderingunitid: orderingUnitId },
                                                            success: function (data, textStatus, jqXHR) {                                                
                                                                window.location = '#close';
                                                                ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                            }
                                                        });
                                                    }
                                                },
                                                cancel: {
                                                    text: 'Cancel',
                                                    btnClass: 'btn btn-warning',
                                                    action: function(){
                                                        window.location = '#close';
                                                        ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                    }
                                                }
                                            }
                                        });                     

                                    } else{
                                        window.location = '#close';
                                        ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
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
        if (orderItemsListsize === checkemptyinputsset.size) {
            var facilityunitorderid = $('#facilityunitorderid').val();
//            var orderingUnitId = $(this).data('ordering-unit-id');
            document.getElementById("btnSaveApprovedOrders").disabled = true;
            $.ajax({
                type: 'GET',
                url: 'ordersmanagement/savesentApprovedOrders.htm',
                data: { facilityorderid: facilityunitorderid, qtyorderedvalues: JSON.stringify(qtyorderedvalues), initialrequest: true, orderingunitid: orderingUnitId },
                success: function (result) {
                    if(result.toString().toLowerCase() !== 'success'.toLowerCase()){
                        showOrderItems(facilityunitorderid);
                        $.confirm({
                            title: '',
                            type: 'purple',
                            typeAnimated: true,
                            boxWidth: '30%',
                            closeIcon: false,
                            useBootstrap: false,
                            content: '<h5>' + result + '</h5>',
                            buttons: {
                                ok: {
                                    text: 'Proceed',
                                    btnClass: 'btn btn-warning',
                                    action: function () {
                                        $.ajax({
                                            type: 'GET',
                                            url: 'ordersmanagement/savesentApprovedOrders.htm',
                                            data: { facilityorderid: facilityunitorderid, qtyorderedvalues: JSON.stringify(qtyorderedvalues), initialrequest: false, orderingunitid: orderingUnitId },
                                            success: function (data, textStatus, jqXHR) {                                                
                                                window.location = '#close';
                                                ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            }
                                        });
                                    }
                                },
                                cancel: {
                                    text: 'Cancel',
                                    btnClass: 'btn btn-warning',
                                    action: function(){
                                        window.location = '#close';
                                        ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }
                                }
                            }
                        });                     
                        
                    } else{
                        window.location = '#close';
                        ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        }
    
        if (checkemptyinputsset.size === 0) {
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
        var approvedstock = $('#itmqtyapprvd' + itemid).val();
        var qutityoerderfor = $('#itmordered' + itemid).val();
        qutityoerderfor = qutityoerderfor.split(',').join('');

        if ((parseInt(approvedstock) > parseInt(qutityoerderfor)) || (parseInt(approvedstock) > parseInt(transactionstock))) {

            if (parseInt(approvedstock) > parseInt(qutityoerderfor)) {
                $("#itmerrormsgqtyordered" + itemid).show();
                $("#itmerrormsg" + itemid).hide();
                if (!errorItems2.has(itemid)) {
                    errorItems2.add(itemid);
                    document.getElementById("btnSaveApprovedOrders").disabled = true;
                }
            }

            if (parseInt(approvedstock) > parseInt(transactionstock)) {
                $("#itmerrormsg" + itemid).show();
                $("#itmerrormsgqtyordered" + itemid).hide();
                if (!errorItems2.has(itemid)) {
                    errorItems2.add(itemid);
                    document.getElementById("btnSaveApprovedOrders").disabled = true;
                }
            }
        } else {
            $("#itmerrormsg" + itemid).hide();
            if (errorItems2.has(itemid)) {
                errorItems2.delete(itemid);
            }
            if (errorItems2.size < 1) {
                document.getElementById("btnSaveApprovedOrders").disabled = false;
            }
        }

        if (approvedstock === null || approvedstock === '' || typeof approvedstock === 'undefined') {
            if (checkemptyinputsset.has(itemid)) {
                checkemptyinputsset.delete(itemid);
            }
        } else {
            if (!checkemptyinputsset.has(itemid)) {
                checkemptyinputsset.add(itemid);
            }
        }
    }
</script>
<%-- 
    Document   : verifyReceivedOrderItems
    Created on : Sep 28, 2018, 2:02:15 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<input type="hidden" value="${deliveredto}" id="delivered-to-id"/>
<input type="hidden" value="${ordernumber}" id="order-number"/>
<div class="col-md-12">
    <c:forEach items="${items}" var="item">
        <h2 class="heading" id="colouredborders">${item.genericname}</h2>
        <div class="itemBatches">
            <table class="table table-hover table-striped table-sm picklistheadertable" id="handover-table-data">
                <thead>
                    <tr>
                        <th class="">#</th>
                        <th class="">Batch</th>
                        <th class="">Expiry Date</th>
                        <th class="left">Quantity Picked</th>
                        <th class="center">Quantity Taken</th>
                        <th class="right">Discrepancy</th>
                    </tr>
                </thead>
                <tbody>
                    <% int pt = 1;%>
                    <c:forEach items="${item.pickedListItemValues}" var="batch">
                        <tr class="" id="${batch.orderissuanceid}">
                            <td><%=pt++%></td>
                            <td>${batch.batchno}</td>
                            <td>${batch.expirydate}</td>
                            <td class="left"><input type="hidden" id="itmpicked2${batch.orderissuanceid}" value="${batch.quantitydelivered}"/><font color="blue" class=""><b>${batch.quantitydelivered}</b></font></td>
                            <td class="center"><input  oninput="comparePickedToDeliveredStock233(${batch.orderissuanceid}, ${batch.quantitydeliverednocommas})" id="itmqtydelivered233${batch.orderissuanceid}" data-id="${batch.facilityorderitemsid}" data-orderissuanceid11="${batch.orderissuanceid}" name="${batch.stockid}" class="form-control form-control-sm orderreceivequantities" value="" type="number" min="0" max="${batch.quantitydeliverednocommas}"/><medium id="itmerrordelivermsg233${batch.orderissuanceid}" class="form-text hidedisplaycontent"><font color="red"><b>Can't take more than what you picked [${batch.quantitydelivered}].</b></medium></td>
                    <td class="right">
                        <input type="number" class="form-control-sm" id="discrepancy233${batch.orderissuanceid}" value="0" disabled=""/>
                    </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:forEach>
</div>
<div class="col-md-12 right"><hr/>
    <button id="btnhandoverorderreadyorder" class="btn btn-primary pull-right" type="button" disabled="true">
        <i class="fa fa-fw fa-lg fa-handshake-o"></i>Receive Items
    </button>
</div>

<script>
    //CHECK/VALIDATE ENTERED QUANTITIES
    $(document).ready(function () {
        var destinationstore = ${destinationstore};
        var deliveredtoid = $('#delivered-to-id').val();
        var deliveredto = deliveredtoid;
        var handovertablesize2 = ${handovertablesize};
        var ordernumber = $('#order-number').val();

        $('#btnhandoverorderreadyorder').click(function () {
            var qtydeliveredvalues = [];
            var facilityunitorderitemsid;
            var orderissuanceid11;
            $('.orderreceivequantities').each(function () {
                facilityunitorderitemsid = $(this).data('id');
                orderissuanceid11 = $(this).data('orderissuanceid11');
                qtydeliveredvalues.push({name: this.name, value: this.value, facilityunitorderitemsid: facilityunitorderitemsid, orderissuanceid: orderissuanceid11});
            });

            var facilityorderidhandover = ${facilityorderid};

            if (handovertablesize2 > checkemptyhandoverinputsset2.size && checkemptyhandoverinputsset2.size !== 0) {
                $.confirm({
                    icon: 'fa fa-warning',
                    title: '<strong><font color="red">Warning!</font></strong>',
                    content: '' + '<strong style="font-size: 18px;"><font color="">Some Order Items to hand over have no values.<br> <span style="color:red; font-size: 22px"> Are you sure you want to Continue?</span></font></strong>',
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
                                document.getElementById("btnhandoverorderreadyorder").disabled = false;
                                $.confirm({
                                    icon: 'fa fa-warning',
                                    title: '<strong>Please Verify Order Collector!</strong>',
                                    content: '' +
                                            '<form action="" class="formName">' +
                                            '<div class="form-group required">' +
                                            '<label>USERNAME:</label>' +
                                            '<input type="text" class="form-control" id="courierusername" placeholder="username"/>' +
                                            '</div>' +
                                            '<div class="form-group required">' +
                                            '<label>PASSWORD:</label>' +
                                            '<input type="password" class="form-control" id="courierpassword" placeholder="password"/>' +
                                            '</div>' +
                                            '</form>',
                                    boxWidth: '30%',
                                    useBootstrap: false,
                                    type: 'red',
                                    typeAnimated: true,
                                    buttons: {
                                        formSubmit: {
                                            text: 'Hand Over Items',
                                            btnClass: 'btn-purple',
                                            action: function () {
                                                var courierusername = this.$content.find('#courierusername').val();
                                                var courierpassword = this.$content.find('#courierpassword').val();
                                                if (!courierusername || !courierpassword) {
                                                    if (!courierusername) {
                                                        $.alert('Please Enter User Name!');
                                                        return false;
                                                    }
                                                    if (!courierpassword) {
                                                        $.alert('Please Enter the Password!');
                                                        return false;
                                                    }
                                                } else {
                                                    courierpassword = md5(courierpassword);
                                                    var data = {
                                                        destinationstore: destinationstore,
                                                        username: courierusername,
                                                        password: courierpassword,
                                                        facilityorderidhandover: facilityorderidhandover,
                                                        qtydeliveredvalues: JSON.stringify(qtydeliveredvalues),
                                                        deliveredto: deliveredto,
                                                        ordernumber: ordernumber
                                                    };
                                                    $.ajax({
                                                        type: "GET",
                                                        cache: false,
                                                        url: "ordersmanagement/saveDeliveredUnitStock.htm",
                                                        data: data,
                                                        success: function (result) {
                                                            if (result === 'success') {
                                                                window.location = '#close2';
                                                                $.confirm({
                                                                    boxWidth: '30%',
                                                                    useBootstrap: false,
                                                                    title: '<strong><font color="green">Success!</font></strong>',
                                                                    content: '' + '<div class="card-recieve-items-success">' +
                                                                            '<b><i class="fa fa-check" style="font-size:25px;green;"></i><span style="color: black; font-weight: bolder">  ORDER ITEMS SUCCESSFULLY RECEIVED!</span></b></div>',
                                                                    type: 'green',
                                                                    typeAnimated: true,
                                                                    icon: 'fa fa-check-circle',
                                                                    closeIcon: true,
                                                                    buttons: {
                                                                        formSubmit: {
                                                                            text: 'OK',
                                                                            action: function () {
                                                                                $('.close-dialog').click();
                                                                                ajaxSubmitData('store/inventoryPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                                            }
                                                                        }
                                                                    }
                                                                });
                                                            } else if (result === 'notgiventothisuser') {
                                                                document.getElementById("btnhandoverorderreadyorder").disabled = false;
                                                                $.confirm({
                                                                    boxWidth: '50%',
                                                                    useBootstrap: false,
                                                                    title: '<strong><font color="red">Warning!</font></strong>',
                                                                    content: '' + '<div class="card-recieve-items-error">' +
                                                                            '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder"> ORDER ITEMS WERE NOT  GIVEN TO THIS USER!</span></b></div>',
                                                                    type: 'red',
                                                                    typeAnimated: true,
                                                                    icon: 'fa fa-warning',
                                                                    closeIcon: true,
                                                                    buttons: {
                                                                        OK: function () {

                                                                        }
                                                                    }
                                                                });
                                                            } else {
                                                                document.getElementById("btnhandoverorderreadyorder").disabled = false;
                                                                $.confirm({
                                                                    boxWidth: '50%',
                                                                    useBootstrap: false,
                                                                    title: '<strong><font color="red">Alert!</font></strong>',
                                                                    content: '' + '<div class="card-recieve-items-error">' +
                                                                            '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  PLEASE PROVIDE VALID USERNAME AND PASSWORD!</span></b></div>',
                                                                    type: 'red',
                                                                    typeAnimated: true,
                                                                    icon: 'fa fa-warning',
                                                                    closeIcon: true,
                                                                    buttons: {
                                                                        OK: function () {

                                                                        }
                                                                    }
                                                                });
                                                            }
                                                        }
                                                    });
                                                }
                                            }
                                        },
                                        cancel: {
                                            text: 'Cancel',
                                            btnClass: 'btn-red',
                                            action: function () {
                                                document.getElementById("btnhandoverorderreadyorder").disabled = false;
                                            }
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
            if (handovertablesize2 === checkemptyhandoverinputsset2.size) {
                document.getElementById("btnhandoverorderreadyorder").disabled = true;
                $.confirm({
                    icon: 'fa fa-warning',
                    title: '<strong>Please Verify Order Collector!</strong>',
                    content: '' +
                            '<form action="" class="formName">' +
                            '<div class="form-group required">' +
                            '<label>USERNAME:</label>' +
                            '<input type="text" class="form-control" id="courierusername" placeholder="username"/>' +
                            '</div>' +
                            '<div class="form-group required">' +
                            '<label>PASSWORD:</label>' +
                            '<input type="password" class="form-control" id="courierpassword" placeholder="password"/>' +
                            '</div>' +
                            '</form>',
                    boxWidth: '30%',
                    useBootstrap: false,
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        formSubmit: {
                            text: 'Hand Over Items',
                            btnClass: 'btn-purple',
                            action: function () {
                                var courierusername = this.$content.find('#courierusername').val();
                                var courierpassword = this.$content.find('#courierpassword').val();
                                if (!courierusername || !courierpassword) {
                                    if (!courierusername) {
                                        $.alert('Please Enter User Name!');
                                        return false;
                                    }
                                    if (!courierpassword) {
                                        $.alert('Please Enter the Password!');
                                        return false;
                                    }
                                } else {
                                    courierpassword = md5(courierpassword);
                                    var data = {
                                        destinationstore: destinationstore,
                                        username: courierusername,
                                        password: courierpassword,
                                        facilityorderidhandover: facilityorderidhandover,
                                        qtydeliveredvalues: JSON.stringify(qtydeliveredvalues),
                                        deliveredto: deliveredto,
                                        ordernumber: ordernumber
                                    };
                                    $.ajax({
                                        type: "GET",
                                        cache: false,
                                        url: "ordersmanagement/saveDeliveredUnitStock.htm",
                                        data: data,
                                        success: function (result) {
                                            if (result === 'success') {
                                                window.location = '#close2';
                                                $.confirm({
                                                    boxWidth: '30%',
                                                    useBootstrap: false,
                                                    title: '<strong><font color="green">Success!</font></strong>',
                                                    content: '' + '<div class="card-recieve-items-success">' +
                                                            '<b><i class="fa fa-check" style="font-size:25px;green;"></i><span style="color: black; font-weight: bolder">  ORDER ITEMS SUCCESSFULLY RECEIVED!</span></b></div>',
                                                    type: 'green',
                                                    typeAnimated: true,
                                                    icon: 'fa fa-check-circle',
                                                    closeIcon: true,
                                                    buttons: {
                                                        formSubmit: {
                                                            text: 'OK',
                                                            action: function () {
                                                                $('.close-dialog').click();
                                                                ajaxSubmitData('store/inventoryPane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                            }
                                                        }
                                                    }
                                                });
                                            } else if (result === 'notgiventothisuser') {
                                                document.getElementById("btnhandoverorderreadyorder").disabled = false;
                                                $.confirm({
                                                    boxWidth: '50%',
                                                    useBootstrap: false,
                                                    title: '<strong><font color="red">Warning!</font></strong>',
                                                    content: '' + '<div class="card-recieve-items-error">' +
                                                            '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder"> ORDER ITEMS WERE NOT  GIVEN TO THIS USER!</span></b></div>',
                                                    type: 'red',
                                                    typeAnimated: true,
                                                    icon: 'fa fa-warning',
                                                    closeIcon: true,
                                                    buttons: {
                                                        OK: function () {

                                                        }
                                                    }
                                                });
                                            } else {
                                                document.getElementById("btnhandoverorderreadyorder").disabled = false;
                                                $.confirm({
                                                    boxWidth: '50%',
                                                    useBootstrap: false,
                                                    title: '<strong><font color="red">Alert!</font></strong>',
                                                    content: '' + '<div class="card-recieve-items-error">' +
                                                            '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  PLEASE PROVIDE VALID USERNAME AND PASSWORD!</span></b></div>',
                                                    type: 'red',
                                                    typeAnimated: true,
                                                    icon: 'fa fa-warning',
                                                    closeIcon: true,
                                                    buttons: {
                                                        OK: function () {

                                                        }
                                                    }
                                                });
                                            }
                                        }
                                    });
                                }
                            }
                        },
                        cancel: {
                            text: 'Cancel',
                            btnClass: 'btn-red',
                            action: function () {
                                document.getElementById("btnhandoverorderreadyorder").disabled = false;
                            }
                        }
                    }
                });
            }

            if (checkemptyhandoverinputsset2.size === 0) {
                $.confirm({
                    icon: 'fa fa-warning',
                    title: '<strong>Alert: <font color="red">Can not proceed!</font></strong>',
                    content: '' + '<strong style="font-size: 18px;"><font color="red">Please Fill in Item Order Quantities To Deliver.</font></strong>',
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
    });

    var checkemptyhandoverinputsset2 = new Set();

    var errorItems = new Set();
    function comparePickedToDeliveredStock233(orderissuanceid, pickedstockquantity) {
        var takenstock = $('#itmqtydelivered233' + orderissuanceid).val();
        if (parseInt(takenstock) > parseInt(pickedstockquantity)) {
            $('#discrepancy233' + orderissuanceid).val(parseInt(pickedstockquantity) - parseInt(takenstock));
            $('#discrepancy233' + orderissuanceid).css("color", "red");
            $("#itmerrordelivermsg233" + orderissuanceid).show();

            if (!errorItems.has(orderissuanceid)) {
                errorItems.add(orderissuanceid);
                document.getElementById("btnhandoverorderreadyorder").disabled = true;
            }
        } else {
            $('#discrepancy233' + orderissuanceid).val(parseInt(pickedstockquantity) - parseInt(takenstock));
            $('#discrepancy233' + orderissuanceid).css("color", "blue");
            $("#itmerrordelivermsg233" + orderissuanceid).hide();

            if (errorItems.has(orderissuanceid)) {
                errorItems.delete(orderissuanceid);
            }
            if (errorItems.size < 1) {
                document.getElementById("btnhandoverorderreadyorder").disabled = false;
            }
        }

        if (takenstock === null || takenstock === '' || typeof takenstock === 'undefined') {
            if (checkemptyhandoverinputsset2.has(orderissuanceid)) {
                checkemptyhandoverinputsset2.delete(orderissuanceid);
            }
        } else {
            if (!checkemptyhandoverinputsset2.has(orderissuanceid)) {
                checkemptyhandoverinputsset2.add(orderissuanceid);
            }
        }
    }



</script>
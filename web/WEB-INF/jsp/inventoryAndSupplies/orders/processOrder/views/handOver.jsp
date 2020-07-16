<%--
    Document   : handOver
    Created on : Jul 4, 2018, 9:04:40 AM
    Author     : IICS-GRACE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<input type="hidden" id="facility-order-numberrrr" value="${orderno}"/>
<input type="hidden" id="hand-over-table-size" value="${handovertablesize}"/>
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
                            <td class="left"><input type="hidden" id="itmpicked2${batch.orderissuanceid}" value="${batch.qtypicked}"/><font color="blue" class=""><b>${batch.qtypicked}</b></font></td>
                            <td class="center"><input  oninput="comparePickedToDeliveredStock(${batch.orderissuanceid}, ${batch.qtypickednocommas})" id="itmqtydelivered2${batch.orderissuanceid}" data-id="${batch.facilityorderitemsid}" data-orderissuanceid10="${batch.orderissuanceid}" name="${batch.stockid}" class="form-control form-control-sm orderdeliverdquantities" value="" type="number" min="0" max="${batch.qtypickednocommas}"/><medium id="itmerrordelivermsg${batch.orderissuanceid}" class="form-text hidedisplaycontent"><font color="red"><b>Can't take more than what you picked [${batch.qtypicked}].</b></medium></td>
                    <td class="right"><input type="number" class="form-control-sm" id="discrepancy${batch.orderissuanceid}" value="0" disabled=""/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:forEach>
</div>
<div class="col-md-12 right"><hr/>
    <button id="btnhandoverorder" class="btn btn-primary pull-right" type="button" disabled="true">
        <i class="fa fa-fw fa-lg fa-handshake-o"></i>Hand Over
    </button>
</div>
<script>
    //CHECK/VALIDATE ENTERED QUANTITIES
    var handovertablesize = parseInt($('#hand-over-table-size').val());
    var checkemptyhandoverinputsset = new Set();
    var ordernumber = $('#facility-order-numberrrr').val();

    var errorItems = new Set();
    function comparePickedToDeliveredStock(orderissuanceid, pickedstockquantity) {
        var takenstock = $('#itmqtydelivered2' + orderissuanceid).val();
        if (parseInt(takenstock) > parseInt(pickedstockquantity)) {
            $('#discrepancy' + orderissuanceid).val(parseInt(pickedstockquantity) - parseInt(takenstock));
            $('#discrepancy' + orderissuanceid).css("color", "red");
            $("#itmerrordelivermsg" + orderissuanceid).show();

            if (!errorItems.has(orderissuanceid)) {
                errorItems.add(orderissuanceid);
                document.getElementById("btnhandoverorder").disabled = true;
            }
        } else {
            $('#discrepancy' + orderissuanceid).val(parseInt(pickedstockquantity) - parseInt(takenstock));
            $('#discrepancy' + orderissuanceid).css("color", "blue");
            $("#itmerrordelivermsg" + orderissuanceid).hide();

            if (errorItems.has(orderissuanceid)) {
                errorItems.delete(orderissuanceid);
            }
            if (errorItems.size < 1) {
                document.getElementById("btnhandoverorder").disabled = false;
            }
        }

        if (takenstock === null || takenstock === '' || typeof takenstock === 'undefined') {
            if (checkemptyhandoverinputsset.has(orderissuanceid)) {
                checkemptyhandoverinputsset.delete(orderissuanceid);
            }
        } else {
            if (!checkemptyhandoverinputsset.has(orderissuanceid)) {
                checkemptyhandoverinputsset.add(orderissuanceid);
            }
        }
    }


    $('#btnhandoverorder').click(function () {
        var qtydeliveredvalues = [];
        var facilityunitorderitemsid;
        var orderissuanceiid10;
        $('.orderdeliverdquantities').each(function () {
            facilityunitorderitemsid = $(this).data('id');
            orderissuanceiid10 = $(this).data('orderissuanceid10');
            qtydeliveredvalues.push({name: this.name, value: this.value, facilityunitorderitemsid: facilityunitorderitemsid, orderissuanceid: orderissuanceiid10});
        });

        var originstore = ${originstore};
        var facilityorderidhandover = ${facilityorderid};


        if (handovertablesize > checkemptyhandoverinputsset.size && checkemptyhandoverinputsset.size !== 0) {
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
                            document.getElementById("btnhandoverorder").disabled = true;
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
                                closeIcon: true,
                                buttons: {
                                    formSubmit: {
                                        text: 'Hand Over Items',
                                        btnClass: 'btn-purple',
                                        action: function () {
                                            var handoverbtn3 = this.$content.find('.btnHandOver');
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
                                                handoverbtn3.prop('disabled', true);
                                                courierpassword = md5(courierpassword);
                                                var data = {
                                                    username: courierusername,
                                                    password: courierpassword,
                                                    originstore: originstore,
                                                    facilityorderidhandover: facilityorderidhandover,
                                                    qtydeliveredvalues: JSON.stringify(qtydeliveredvalues),
                                                    ordernumber: ordernumber
                                                };
                                                $.ajax({
                                                    type: "GET",
                                                    cache: false,
                                                    url: "ordersmanagement/deliverOutProcessedOrder.htm",
                                                    data: data,
                                                    success: function (result) {
                                                        if (result === 'success') {
                                                            $.confirm({
                                                                boxWidth: '30%',
                                                                useBootstrap: false,
                                                                title: '<strong><font color="green">Success!</font></strong>',
                                                                content: '' + '<div class="card-recieve-items-success">' +
                                                                        '<b><i class="fa fa-check" style="font-size:25px;green;"></i><span style="color: black; font-weight: bolder">  ORDER SUCCESSFULLY DELIVERED!</span></b></div>',
                                                                type: 'green',
                                                                typeAnimated: true,
                                                                icon: 'fa fa-check-circle',
                                                                closeIcon: true,
                                                                buttons: {
                                                                    OK: function () {

                                                                    }
                                                                }
                                                            });
                                                            ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                                        } else if (result === 'sameuser') {
                                                            document.getElementById("btnhandoverorder").disabled = false;
                                                            $.confirm({
                                                                boxWidth: '30%',
                                                                useBootstrap: false,
                                                                title: '<strong><font color="red">Warning!</font></strong>',
                                                                content: '' + '<div class="card-recieve-items-error">' +
                                                                        '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  CAN NOT HANDOVER TO YOUR SELF!</span></b></div>',
                                                                type: 'red',
                                                                typeAnimated: true,
                                                                icon: 'fa fa-warning',
                                                                closeIcon: true,
                                                                buttons: {
                                                                    OK: function () {

                                                                    }
                                                                }
                                                            });
                                                        } else if (result === 'error') {
                                                            document.getElementById("btnhandoverorder").disabled = false;
                                                            $.confirm({
                                                                boxWidth: '30%',
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
                                                        } else if (result === 'doesnotbelongtoanyunit') {
                                                            document.getElementById("btnhandoverorder").disabled = false;
                                                            $.confirm({
                                                                boxWidth: '30%',
                                                                useBootstrap: false,
                                                                title: '<strong><font color="#BEF">Alert!</font></strong>',
                                                                content: '' + '<div class="card-recieve-items-error">' +
                                                                        '<b><i class="fa fa-info-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  USER IS NOT ATTACHED TO ANY UNIT!</span></b></div>',
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
                                                            document.getElementById("btnhandoverorder").disabled = false;
                                                            $.confirm({
                                                                boxWidth: '50%',
                                                                useBootstrap: false,
                                                                title: '<strong><font color="red">Alert!</font></strong>',
                                                                content: '' + '<div class="card-recieve-items-error">' +
                                                                        '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  USER DOES NOT BELOG TO UNIT THAT SENT AN ORDER!</span></b></div>',
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
                                            document.getElementById("btnhandoverorder").disabled = false;
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
        if (handovertablesize === checkemptyhandoverinputsset.size) {
            document.getElementById("btnhandoverorder").disabled = true;
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
                closeIcon: true,
                buttons: {
                    formSubmit: {
                        text: 'Hand Over Items',
                        btnClass: 'btn-purple btnHandOver',
                        action: function () {
                            var handoverbtn2 = this.$content.find('.btnHandOver');
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
                                handoverbtn2.prop('disabled', true);
                                courierpassword = md5(courierpassword);
                                var data = {
                                    username: courierusername,
                                    password: courierpassword,
                                    originstore: originstore,
                                    facilityorderidhandover: facilityorderidhandover,
                                    qtydeliveredvalues: JSON.stringify(qtydeliveredvalues),
                                    ordernumber: ordernumber
                                };
                                $.ajax({
                                    type: "GET",
                                    cache: false,
                                    url: "ordersmanagement/deliverOutProcessedOrder.htm",
                                    data: data,
                                    success: function (result) {
                                        if (result === 'success') {
                                            $.confirm({
                                                boxWidth: '30%',
                                                useBootstrap: false,
                                                title: '<strong><font color="green">Success!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-success">' +
                                                        '<b><i class="fa fa-check" style="font-size:25px;green;"></i><span style="color: black; font-weight: bolder">  ORDER SUCCESSFULLY DELIVERED!</span></b></div>',
                                                type: 'green',
                                                typeAnimated: true,
                                                icon: 'fa fa-check-circle',
                                                closeIcon: true,
                                                buttons: {
                                                    OK: function () {

                                                    }
                                                }
                                            });
                                            ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                        } else if (result === 'sameuser') {
                                            document.getElementById("btnhandoverorder").disabled = false;
                                            $.confirm({
                                                boxWidth: '30%',
                                                useBootstrap: false,
                                                title: '<strong><font color="red">Warning!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-error">' +
                                                        '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  CAN NOT HANDOVER TO YOUR SELF!</span></b></div>',
                                                type: 'red',
                                                typeAnimated: true,
                                                icon: 'fa fa-warning',
                                                closeIcon: true,
                                                buttons: {
                                                    OK: function () {

                                                    }
                                                }
                                            });
                                        } else if (result === 'error') {
                                            document.getElementById("btnhandoverorder").disabled = false;
                                            $.confirm({
                                                boxWidth: '37%',
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
                                        } else if (result === 'doesnotbelongtoanyunit') {
                                            document.getElementById("btnhandoverorder").disabled = false;
                                            $.confirm({
                                                boxWidth: '30%',
                                                useBootstrap: false,
                                                title: '<strong><font color="#BEF">Alert!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-error">' +
                                                        '<b><i class="fa fa-info-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  USER IS NOT ATTACHED TO ANY UNIT!</span></b></div>',
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
                                            document.getElementById("btnhandoverorder").disabled = false;
                                            $.confirm({
                                                boxWidth: '50%',
                                                useBootstrap: false,
                                                title: '<strong><font color="red">Alert!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-error">' +
                                                        '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  USER DOES NOT BELOG TO UNIT THAT SENT AN ORDER!</span></b></div>',
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
                            document.getElementById("btnhandoverorder").disabled = false;
                        }
                    }
                }
            });
        }

        if (checkemptyhandoverinputsset.size === 0) {

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
</script>
<%-- 
    Document   : receiveSentDonationsPane
    Created on : Nov 12, 2018, 9:44:53 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    .order-delivered-items-view:hover{
        text-decoration: underline !important;
        cursor: pointer; 
    }
</style>
<div class="tile">
    <div class="tile-body">
        <h2 class="heading">Items Picked By ${deliveredby} On ${handoverdate}</h2>
        <table class="table table-hover table-bordered col-md-12" id="table-receive-unit-donations">
            <thead class="col-md-12">
                <tr>
                    <th class="center">No</th>
                    <th class="">Item Name</th>
                    <th class="">Batch No</th>
                    <th class="center">Expiry Date</th>
                    <th class="right">Quantity</th>
                    <th class="">Quantity Received</th>
                    <th class="">Discrepancy</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="">
                <% int e = 1;%>
                <c:forEach items="${readyDonationsList}" var="a">
                    <tr id="">
                        <td class="center"><%=e++%></td>
                        <td>${a.packagename}</td>
                        <td>${a.batchno}</td>
                        <td class="center">${a.expirydate}</td>
                        <td class="right"><input type="hidden" id="itmpicked2${a.donationconsumptionid}" value="${a.qtyhandedover}"/><font color="blue" class=""><b>${a.qtyhandedover}</b></font></td>
                        <td class=""><input  oninput="comparePickedToDeliveredDonorStock(${a.donationconsumptionid}, ${a.qtyhandedovernocommas})" id="itmqtydelivery${a.donationconsumptionid}" data-id="${a.donationsitemsid}" data-donationconsumptionid="${a.donationconsumptionid}" data-staffid="${a.staffid}" name="${a.itemid}" data-batchno="${a.batchno}" data-expirydate="${a.expirydate}" data-qtyreceivednocommas="${a.qtyhandedovernocommas}" data-donorrefno="${a.donorrefno}"data-donorprogramid="${a.donorprogramid}"  class="form-control form-control-sm itemdonatedqty" value="" type="number" min="0" max="${a.qtyhandedovernocommas}"/><medium id="itmerrormsg1${a.donationconsumptionid}" class="form-text hidedisplaycontent"><font color="red"><b>Can't take more than what you picked [${a.qtyhandedover}].</b></medium></td>
                <td class="center">
                    <input type="number" class="form-control-sm" id="itmdeliverydiscrepancy${a.donationconsumptionid}" value="0" disabled=""/>
                </td>                    
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="col-md-12 right"><hr/>
    <button id="btnhandoverorderreadydonation" class="btn btn-primary pull-right" type="button" disabled="true">
        <i class="fa fa-fw fa-lg fa-handshake-o"></i>Receive Items
    </button>
</div>
<script>
    $('#table-receive-unit-donations').DataTable();

    //CHECKING THE QTY ENTERED VIAS QTY DONATED 
    var errorItems = new Set();
    var checkemptyhandoverinputsset555 = new Set();
    function comparePickedToDeliveredDonorStock(donationconsumptionid, qtyhandedovernocommas) {

        var takenitem = $('#itmqtydelivery' + donationconsumptionid).val();
        if (parseInt(takenitem) > parseInt(qtyhandedovernocommas)) {
            $('#itmdeliverydiscrepancy' + donationconsumptionid).val(parseInt(qtyhandedovernocommas) - parseInt(takenitem));
            $('#itmdeliverydiscrepancy' + donationconsumptionid).css("color", "red");
            $("#itmerrormsg1" + donationconsumptionid).show();

            if (!errorItems.has(donationconsumptionid)) {
                errorItems.add(donationconsumptionid);
                document.getElementById("btnhandoverorderreadydonation").disabled = true;
            }
        } else {
            $('#itmdeliverydiscrepancy' + donationconsumptionid).val(parseInt(qtyhandedovernocommas) - parseInt(takenitem));
            $('#itmdeliverydiscrepancy' + donationconsumptionid).css("color", "blue");
            $("#itmerrormsg1" + donationconsumptionid).hide();

            if (errorItems.has(donationconsumptionid)) {
                errorItems.delete(donationconsumptionid);
            }
            if (errorItems.size < 1) {
                document.getElementById("btnhandoverorderreadydonation").disabled = false;
            }
        }

        if (takenitem === null || takenitem === '' || typeof takenitem === 'undefined') {
            if (checkemptyhandoverinputsset555.has(donationconsumptionid)) {
                checkemptyhandoverinputsset555.delete(donationconsumptionid);
            }
        } else {
            if (!checkemptyhandoverinputsset555.has(donationconsumptionid)) {
                checkemptyhandoverinputsset555.add(donationconsumptionid);
            }
        }
    }

//    ADDING DONATED ITEMS INTO FACILITYUNIT STOCK
    $(document).ready(function () {
        var handovertablesizes2 = ${handovertablesizes};
        $('#btnhandoverorderreadydonation').click(function () {
            var qtyreceivedvalues = [];
            var donationsitemsid;
            var donationconsumptionid;
            var expirydate;
            var qtydonatednocommas;
            var batchno;
            var staffid;
            var donorrefno;
            var donorprogramid;

            $('.itemdonatedqty').each(function () {
                donationsitemsid = $(this).data('id');
                donationconsumptionid = $(this).data('donationconsumptionid');
                expirydate = $(this).data('expirydate');
                qtydonatednocommas = $(this).data('qtyreceivednocommas');
                batchno = $(this).data('batchno'); 
                staffid = $(this).data('staffid');
                donorrefno = $(this).data('donorrefno');
                donorprogramid = $(this).data('donorprogramid');
                console.log(this.value);
                qtyreceivedvalues.push({name: this.name, value: this.value, expirydate: expirydate, qtydonatednocommas: qtydonatednocommas, batchno: batchno, donationconsumptionid: donationconsumptionid, donorprogramid: donorprogramid, donorrefno: donorrefno});
            });

            if (handovertablesizes2 > checkemptyhandoverinputsset555.size && checkemptyhandoverinputsset555.size !== 0) {
                $.confirm({
                    icon: 'fa fa-warning',
                    title: '<strong><font color="red">Warning!</font></strong>',
                    content: '' + '<strong style="font-size: 18px;"><font color="">Some Donated Items to hand over have no values.<br> <span style="color:red; font-size: 22px"> Are you sure you want to Continue?</span></font></strong>',
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
                                $.confirm({
                                    icon: 'fa fa-warning',
                                    title: '<strong>Please Verify Items Receiver!</strong>',
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
                                                document.getElementById("btnhandoverorderreadydonation").disabled = true;
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
                                                        staffid:staffid,
                                                        username: courierusername,
                                                        password: courierpassword,
                                                        qtyreceivedvalues: JSON.stringify(qtyreceivedvalues)
                                                    };
                                                    $.ajax({
                                                        type: "GET",
                                                        cache: false,
                                                        url: "internaldonorprogram/saveDeliveredUnitDonorStock.htm",
                                                        data: data,
                                                        success: function (result) {
                                                            if (result === 'success') {
                                                                window.location = '#close2';
                                                                $.confirm({
                                                                    boxWidth: '30%',
                                                                    useBootstrap: false,
                                                                    title: '<strong><font color="green">Success!</font></strong>',
                                                                    content: '' + '<div class="card-recieve-items-success">' +
                                                                            '<b><i class="fa fa-check" style="font-size:25px;green;"></i><span style="color: black; font-weight: bolder">  DONATED ITEMS SUCCESSFULLY RECEIVED!</span></b></div>',
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
                                                                $.confirm({
                                                                    boxWidth: '50%',
                                                                    useBootstrap: false,
                                                                    title: '<strong><font color="red">Warning!</font></strong>',
                                                                    content: '' + '<div class="card-recieve-items-error">' +
                                                                            '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder"> DONATED ITEMS WERE NOT  GIVEN TO THIS USER!</span></b></div>',
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
                                        cancel: function () {
                                            //close
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
            if (handovertablesizes2 === checkemptyhandoverinputsset555.size) {
                $.confirm({
                    icon: 'fa fa-warning',
                    title: '<strong>Please Verify Items Receiver!</strong>',
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
                                document.getElementById("btnhandoverorderreadydonation").disabled = true;
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
                                        staffid:staffid,
                                        username: courierusername,
                                        password: courierpassword,
                                        qtyreceivedvalues: JSON.stringify(qtyreceivedvalues)
                                    };
                                    $.ajax({
                                        type: "GET",
                                        cache: false,
                                        url: "internaldonorprogram/saveDeliveredUnitDonorStock.htm",
                                        data: data,
                                        success: function (result) {
                                            if (result === 'success') {
                                                window.location = '#close2';
                                                $.confirm({
                                                    boxWidth: '30%',
                                                    useBootstrap: false,
                                                    title: '<strong><font color="green">Success!</font></strong>',
                                                    content: '' + '<div class="card-recieve-items-success">' +
                                                            '<b><i class="fa fa-check" style="font-size:25px;green;"></i><span style="color: black; font-weight: bolder">  DONATED ITEMS SUCCESSFULLY RECEIVED!</span></b></div>',
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
                                                $.confirm({
                                                    boxWidth: '50%',
                                                    useBootstrap: false,
                                                    title: '<strong><font color="red">Warning!</font></strong>',
                                                    content: '' + '<div class="card-recieve-items-error">' +
                                                            '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder"> DONATED ITEMS WERE NOT  GIVEN TO THIS USER!</span></b></div>',
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
                        cancel: function () {
                            //close
                        }
                    }
                });
            }

            if (checkemptyhandoverinputsset555.size === 0) {
                $.confirm({
                    icon: 'fa fa-warning',
                    title: '<strong>Alert: <font color="red">Can not proceed!</font></strong>',
                    content: '' + '<strong style="font-size: 18px;"><font color="red">Please Fill in Item Donated Quantities To Deliver.</font></strong>',
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


</script>


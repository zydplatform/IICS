<%-- 
    Document   : handOverSupplies
    Created on : Nov 7, 2018, 5:08:32 AM
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../include.jsp" %>

<div class="col-md-12">
    <div class="">
        <c:forEach items="${items}" var="item">
            <h2 class="heading" id="colouredborders">${item.genericname} &nbsp;&nbsp;&nbsp;<span><font color="green">Quantity To Pick: </font></span><span style="font-size: 16px; background-color: #9a4691 !important; color: whitesmoke" class="badge">${item.quantityapproved}</span></h2>
            <div class="itemBatches">
                <table class="table table-hover table-striped table-sm picklistheadertable" id="cellCounts2">
                    <thead>
                        <tr>
                            <th class="">#</th>
                            <th class="">Cell</th>
                            <th class="">Batch</th>
                            <th class="right">Quantity To Issue</th>
                            <th class="right">Quantity Issued</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int p = 1;%>
                        <c:forEach items="${item.pick}" var="batch">
                            <tr class="${batch.cell}" id="${batch.batch}${batch.cell}">
                                <td><%=p++%></td>
                                <td>${batch.cell}</td>
                                <td>${batch.batch} <input type="hidden" value="${batch.cell}" name="${batch.batch}" class=""/></td>
                                <td class="right"><input type="hidden" id="itmpicked22${batch.batch}${batch.cell}" value="${batch.qty}"/>${batch.qty}</td>
                                <td class=""><input data-cellbatchid="${batch.batch}${batch.cell}" data-quantityapprovedtopick="${batch.qty}" max="${batch.qty}" min="0" id="itmqtypicked22${batch.batch}${batch.cell}" class="form-control col-md-5 form-control-sm orderqquantities comparePickedToIssuedStockoninput2" data-id="${batch.stockid}" data-suppliesorderitemsid="${item.suppliesorderitemsid}" data-itemcellid="${batch.cellid}" value="" type="number"/>
                        <medium id="itmerrorpickingmsgsup${batch.batch}${batch.cell}" class="form-text hidedisplaycontent">
                            <font style="margin-left: 37px" color="red"><b>Can't Issue more than what was Approved to Issue [${batch.qty}].</b>
                        </medium>
                        </td>
                        </tr>
                    </c:forEach>
                    </tbody>`
                </table>
            </div>
        </c:forEach>
    </div>
    <div class="col-md-12 right"><hr/>
        <button id="btnHandOverToRequester" class="btn btn-primary pull-right" type="button" disabled="true">
            <i class="fa fa-fw fa-lg fa-share"></i>Issue
        </button>
    </div>
</div>

<script>
    var picklisttablesizesup = parseInt(${picklisttablesize});
    var suppliesorderid = ${suppliesorderid};
    var picklistdatasup = '${jsonqtypicklist}';
    var picklistdata2sup = JSON.parse(picklistdatasup);
    
    var suppliesorderitemsid;
    var checkemptypicklistinputssetsup = new Set();
    var errorItemsPicklistsup = new Set();

    $('#btnHandOverToRequester').click(function () {
        if (picklisttablesizesup > checkemptypicklistinputssetsup.size && checkemptypicklistinputssetsup.size !== 0) {
            $.confirm({
                icon: 'fa fa-warning',
                title: '<strong><font color="red">Warning!</font></strong>',
                content: '' + '<strong style="font-size: 18px;"><font color="">Some Approved Quantities hava no values.<br> <span style="color:red; font-size: 22px"> Are you sure you want to Continue?</span></font></strong>',
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
                            document.getElementById("btnHandOverToRequester").disabled = true;
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
                                                    qtyissuedvalues: JSON.stringify(picklistdata2sup),
                                                    suppliesorderid: suppliesorderid
                                                };
                                                $.ajax({
                                                    type: "GET",
                                                    cache: false,
                                                    url: "sandriesreq/submitSuppliesRequisition.htm",
                                                    data: data,
                                                    success: function (result) {
                                                        if (result === 'success') {
                                                            $.confirm({
                                                                boxWidth: '30%',
                                                                useBootstrap: false,
                                                                title: '<strong><font color="green">Success!</font></strong>',
                                                                content: '' + '<div class="card-recieve-items-success">' +
                                                                        '<b><i class="fa fa-check" style="font-size:25px;green;"></i><span style="color: black; font-weight: bolder">  ORDER SUCCESSFULLY ISSUED!</span></b></div>',
                                                                type: 'green',
                                                                typeAnimated: true,
                                                                icon: 'fa fa-check-circle',
                                                                closeIcon: true,
                                                                buttons: {
                                                                    OK: function () {

                                                                    }
                                                                }
                                                            });
                                                            ajaxSubmitData('sandriesreq/suppliesRequisitionsHome.htm', 'workpane', '', 'GET');
                                                        } else if (result === 'error') {
                                                            document.getElementById("btnHandOverToRequester").disabled = false;
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
                                                        } else if (result === 'doesnotbelongtoanyunit') {
                                                            document.getElementById("btnHandOverToRequester").disabled = false;
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
                                                            document.getElementById("btnHandOverToRequester").disabled = false;
                                                            $.confirm({
                                                                boxWidth: '50%',
                                                                useBootstrap: false,
                                                                title: '<strong><font color="red">Alert!</font></strong>',
                                                                content: '' + '<div class="card-recieve-items-error">' +
                                                                        '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  USER DOES NOT BELOG TO THIS UNIT!</span></b></div>',
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
                                            document.getElementById("btnHandOverToRequester").disabled = false;
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

        if (picklisttablesizesup === checkemptypicklistinputssetsup.size) {
            document.getElementById("btnHandOverToRequester").disabled = true;
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
                                    qtyissuedvalues: JSON.stringify(picklistdata2sup),
                                    suppliesorderid: suppliesorderid
                                };
                                $.ajax({
                                    type: "GET",
                                    cache: false,
                                    url: "sandriesreq/submitSuppliesRequisition.htm",
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
                                            ajaxSubmitData('sandriesreq/suppliesRequisitionsHome.htm', 'workpane', '', 'GET');
                                        } else if (result === 'error') {
                                            document.getElementById("btnHandOverToRequester").disabled = false;
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
                                            document.getElementById("btnHandOverToRequester").disabled = false;
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
                                            document.getElementById("btnHandOverToRequester").disabled = false;
                                            $.confirm({
                                                boxWidth: '40%',
                                                useBootstrap: false,
                                                title: '<strong><font color="red">Alert!</font></strong>',
                                                content: '' + '<div class="card-recieve-items-error">' +
                                                        '<b><i class="fa fa-times-circle" style="font-size:25px;color:red;"></i><span style="color: black; font-weight: bolder">  USER DOES NOT BELOG TO THIS UNIT!</span></b></div>',
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
                            document.getElementById("btnHandOverToRequester").disabled = false;
                        }
                    }
                }
            });
        }

        if (checkemptypicklistinputssetsup.size === 0) {
            $.confirm({
                icon: 'fa fa-warning',
                title: '<strong>Alert: <font color="red">Can not proceed!</font></strong>',
                content: '' + '<strong style="font-size: 18px;"><font color="red">Please Fill in Item Order Quantities To Hand Over.</font></strong>',
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

    var errorItemsPicklist = new Set();
    $('.comparePickedToIssuedStockoninput2').on('input', function () {
        var cellbatchid = $(this).data('cellbatchid');
        var approvestockquantity = $(this).data('quantityapprovedtopick');
        var pickedstock = $(this).val();

        if (parseInt(pickedstock) > parseInt(approvestockquantity)) {
            $("#itmerrorpickingmsgsup" + cellbatchid).show();

            if (!errorItemsPicklist.has(cellbatchid)) {
                errorItemsPicklist.add(cellbatchid);
                document.getElementById("btnHandOverToRequester").disabled = true;
            }
        } else {
            $("#itmerrorpickingmsgsup" + cellbatchid).hide();

            if (errorItemsPicklist.has(cellbatchid)) {
                errorItemsPicklist.delete(cellbatchid);
            }
            if (errorItemsPicklist.size < 1) {
                document.getElementById("btnHandOverToRequester").disabled = false;
            }
        }

        if (pickedstock === null || pickedstock === '' || typeof pickedstock === 'undefined') {
            if (checkemptypicklistinputssetsup.has(cellbatchid)) {
                checkemptypicklistinputssetsup.delete(cellbatchid);
            }
        } else {
            if (parseInt(pickedstock) < parseInt(approvestockquantity) || parseInt(pickedstock) === parseInt(approvestockquantity)) {
                var cellid = $(this).data('itemcellid');
                var stockid = $(this).data('id');
                for (i in picklistdata2sup) {
                    if (picklistdata2sup[i].stockid === stockid && picklistdata2sup[i].cellid === cellid) {
                        picklistdata2sup[i].qtypicked = parseInt(pickedstock);
                        break;
                    }
                }
            }
            if (!checkemptypicklistinputssetsup.has(cellbatchid)) {
                checkemptypicklistinputssetsup.add(cellbatchid);
            }
        }
    });
</script>
<%--
    Document   : handOverDrugs
    Created on : Oct 6, 2018, 3:22:23 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp" %>

<div class="row">
    <div class="col-md-12">
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
                                <td class=""><input data-cellbatchid="${batch.batch}${batch.cell}" data-quantityapprovedtopick="${batch.qty}" max="${batch.qty}" min="0" id="itmqtypicked22${batch.batch}${batch.cell}" class="form-control col-md-5 form-control-sm orderqquantities comparePickedToDeliveredStockoninput2" data-id="${batch.stockid}" data-prescriptionitemsid="${item.prescriptionitemsid}" data-itemcellid="${batch.cellid}" name="${item.prescriptionissueid}" value="" type="number"/><medium id="itmerrorpickingmsg22${batch.batch}${batch.cell}" class="form-text hidedisplaycontent"><font style="margin-left: 37px" color="red"><b>Can't Issue more than what was Approved [${batch.qty}].</b></medium></td>
                        </tr>
                    </c:forEach>
                    </tbody>`
                </table>
            </div>
        </c:forEach>
    </div>
    <div class="col-md-12 right"><hr/>
        <button id="btnHandOverToPatient" class="btn btn-primary pull-right" type="button" disabled="true">
            <i class="fa fa-fw fa-lg fa-share"></i>Issue
        </button>
    </div>
</div>

<script>
    var picklisttablesize2 = parseInt(${picklisttablesize});
    var prescriptionid = ${prescriptionid};
    var prescriptionitemsid;
    var checkemptypicklistinputsset2 = new Set();
    var errorItemsPicklist22 = new Set();
    var picklistdatadis = '${jsonqtypicklist}';
    var picklistdata2dis = JSON.parse(picklistdatadis);

    $('#btnHandOverToPatient').click(function () {
        if (picklisttablesize2 > checkemptypicklistinputsset2.size && checkemptypicklistinputsset2.size !== 0) {
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
                            document.getElementById("btnHandOverToPatient").disabled = true;
                            $.ajax({
                                type: 'GET',
                                data: {prescriptionid: prescriptionid, qtyissuedvalues: JSON.stringify(picklistdata2dis)},
                                url: 'dispensing/submitPatientDispensedDrugs.htm',
                                success: function (items) {
                                    ajaxSubmitData('dispensing/dispensingmenu', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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

        if (picklisttablesize2 === checkemptypicklistinputsset2.size) {
            document.getElementById("btnHandOverToPatient").disabled = true;
            $.ajax({
                type: 'GET',
                data: {prescriptionid: prescriptionid, qtyissuedvalues: JSON.stringify(picklistdata2dis)},
                url: 'dispensing/submitPatientDispensedDrugs.htm',
                success: function (items) {
                    ajaxSubmitData('dispensing/dispensingmenu', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        }

        if (checkemptypicklistinputsset2.size === 0) {
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
    $('.comparePickedToDeliveredStockoninput2').on('input', function () {
        var cellbatchid = $(this).data('cellbatchid');
        var approvestockquantity = $(this).data('quantityapprovedtopick');
        var pickedstock = $(this).val();

        if (parseInt(pickedstock) > parseInt(approvestockquantity)) {
            $("#itmerrorpickingmsg22" + cellbatchid).show();

            if (!errorItemsPicklist.has(cellbatchid)) {
                errorItemsPicklist.add(cellbatchid);
                document.getElementById("btnHandOverToPatient").disabled = true;
            }
        } else {
            $("#itmerrorpickingmsg22" + cellbatchid).hide();

            if (errorItemsPicklist.has(cellbatchid)) {
                errorItemsPicklist.delete(cellbatchid);
            }
            if (errorItemsPicklist.size < 1) {
                document.getElementById("btnHandOverToPatient").disabled = false;
            }
        }

        if (pickedstock === null || pickedstock === '' || typeof pickedstock === 'undefined') {
            if (checkemptypicklistinputsset2.has(cellbatchid)) {
                checkemptypicklistinputsset2.delete(cellbatchid);
            }
        } else {
            if (parseInt(pickedstock) < parseInt(approvestockquantity) || parseInt(pickedstock) === parseInt(approvestockquantity)) {
                var cellid = $(this).data('itemcellid');
                var stockid = $(this).data('id');
                for (i in picklistdata2dis) {
                    if (picklistdata2dis[i].stockid === stockid && picklistdata2dis[i].cellid === cellid) {
                        picklistdata2dis[i].qtypicked = parseInt(pickedstock);
                        break;
                    }
                }
            }
            if (!checkemptypicklistinputsset2.has(cellbatchid)) {
                checkemptypicklistinputsset2.add(cellbatchid);
            }
        }
    });
</script>
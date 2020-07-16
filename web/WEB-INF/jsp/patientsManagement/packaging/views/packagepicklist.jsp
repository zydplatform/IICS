<%-- 
    Document   : picklist
    Created on : Aug 13, 2018, 9:32:46 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<!DOCTYPE html>

<div class="col-md-12" style="margin-top: 2em">
    <input type="hidden" value="${noInEachPacket}" id="noInEachPacket">
    <input type="hidden" value="${noOfPackets}" id="noOfPackets">
    <input type="hidden" value="${stockid}" id="stockid">
    <input type="hidden" value="${itemid}" id="itemid">
    <input type="hidden" value="${packageid}" id="packageid">
    <h6 style="margin-top: -2em">
        <div class="row">
            <div class="col-md-4">
                <span class="span-size-15">Generated By: </span><span class="span-size-15"><font color="blue">${logedinusernames}</font></span>

            </div>
            <div class="col-md-8">
                <span class="span-size-15">Created On: </span><span class="span-size-15" ><font color="blue" id="date"></font></span><br>
            </div>
        </div>
    </h6>
</div>
<fieldset>
    <div class="row">
        <div class="col-md-8">
            <div class="" style="margin-top: 2em">
                <span style="font-size: 16px; color: green"><b>Quantity To Pick:</b></span><span class="badge badge-info" >${pickedstock}</span>
                <input type="hidden" value="${pickedstock}" id="pickedstock">
                <c:forEach items="${cells}" var="details">
                    <table class="table table-hover col-md-12" id="cellCounts">
                        <thead>
                            <tr>
                                <th class="">#</th>
                                <th class="">Cell</th>
                                <th class="">Batch</th>
                                <th>Quantity</th>
                                <th class="centre">Quantity Picked</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% int p = 1;
                                int count = 0;%>
                            <c:forEach items="${details.pick}" var="pickitems">
                                <%count = count + p;%>
                                <tr class="${pickitems.cell}" id="${pickitems.cell}">
                                    <td><%=count%></td>
                                    <td>${pickitems.cell}</td>
                                    <td>${pickitems.batch}<input type="hidden" value="${pickitems.cell}" name="${pickitems.batch}" class="picklistcontent"/></td>
                                    <td class="centre">${pickitems.qty}</td>    
                                    <td class="center">
                                        <input id="${pickitems.cellid}" oninput="inputpackagepiclistqty(${pickitems.qty},this.id,<%=count%>)"  class="form-control form-control-sm orderqquantities comparePickedToDeliveredStockoninput" data-id="${pickitems.stockid}" data-id1="${pickitems.shelfstockid}" data-id2="${pickitems.batch}" type="number"  min="1" max="${pickitems.qty}" value="${pickitems.qty}"> 
                                        <div id="error<%=count%>"></div>
                                    </td>
                                </tr>
                            </c:forEach>
                        <span id="itemAllnumber" class="hidedisplaycontent"><%=count%></span>
                        </tbody>
                    </table>
                </c:forEach>
            </div>
        </div>
        <div class="col-md-4">
            <span style="font-size: 16px; color: green;"><b>Walk Order</b></span>
            <div id="content-walk-order">
                <!--            WALK ORDER LIST CONTENT-->

            </div>
        </div>
        <!-----Do not Delete this section Important-------->
        <div class="hidedisplaycontent">
            <div id="tablesectionxv"></div>
        </div>
    </div>
</fieldset>
<div class="col-md-12 right"><hr/>
    <button id="btnSavePickedOrders" onclick="packagepickeditems()" class="btn btn-primary" type="button"><i class="fa fa-floppy-o"></i>Pick items</button>
</div>
<script>    
    var serverDate =  '${serverdate}';
    n = new Date(serverDate);
    y = n.getFullYear();
    m = n.getMonth() + 1;
    d = n.getDate();
    document.getElementById("date").innerHTML = m + "-" + d + "-" + y;
    var checkemptypicklistinputsset = new Set();

    var picklisttablesize = parseInt(${picklisttablesize});
    $(document).ready(function () {
        var qtyorderedwalkorder = [];
        $('.picklistcontent').each(function () {
            qtyorderedwalkorder.push({value: this.value});
        });
        $('#tablesectionxv').html('');
        $.ajax({
            type: 'GET',
            dataType: 'JSON',
            url: 'ordersmanagement/generatewalkorder.htm',
            data: {qtyorderedvalues: JSON.stringify(qtyorderedwalkorder), selectedid: parseInt(1)},
            success: function (items) {
                if (items !== '') {
                    for (var x in items) {
                        var count = parseInt(x) + parseInt(1);
                        var data = items[x];

                        $('#tablesectionxv').append('<tr class="' + data + '"><td>' + count + '</td><td>' + data + '</td><td class="center"><input style="zoom:1.5;" class="walkordercheck" onclick="functionwalkorderarrangement(\'' + data + '\')" type="checkbox"></td></tr>');
                    }
                }
                var tablebodycontent = $('#tablesectionxv').html();
                $('#content-walk-order').html('<table class="table table-hover table-striped" id="table-walk-list-direction" style="margin-top:0.5em">' +
                        '<thead>' +
                        '<tr>' +
                        '<th>No</th>' +
                        '<th>Cell</th>' +
                        '<th class="center">Find Cells</th>' +
                        '</tr>' +
                        '</thead>' +
                        '<tbody>' +
                        '' + tablebodycontent +
                        '</tbody>`' +
                        '</table>');
            }
        });

    });

    function inputpackagepiclistqty(quantityshelved, positionid, position) {
        document.getElementById(positionid).style.borderColor = 'green';
        var inputqty = $('#' + positionid).val();
        if (inputqty > quantityshelved) {
            document.getElementById(positionid).style.borderColor = 'red';
            $('#error' + position).html('*Error:You cannot pick items more than the specified quantity.').css({'color': 'red', 'font-weight': '2em'});
            document.getElementById("btnSavePickedOrders").disabled = true;
        } else if (inputqty < quantityshelved) {
            var noOfPackets = $('#noOfPackets').val();
            var noInEachPacket = $('#noInEachPacket').val();
            var multiple = noOfPackets * noInEachPacket;
            var qtyforeachpacket = (inputqty * noOfPackets) / multiple;
            document.getElementById(positionid).style.borderColor = 'red';
            if (qtyforeachpacket < noInEachPacket) {
                $('#error' + position).html('*Error:This Quantity can not fit in one packet.').css({'color': 'red', 'font-weight': '2em'});
                document.getElementById("btnSavePickedOrders").disabled = true;
            } else {
                $('#error' + position).html('*Error:This Quantity only fits in ' + ' ' + qtyforeachpacket + ' ' + 'packet(s).').css({'color': 'red', 'font-weight': '2em'});
            }

        } else if (inputqty === null) {
            document.getElementById(positionid).style.borderColor = 'red';
            document.getElementById("btnSavePickedOrders").disabled = true;
        } else {
            $('#error' + position).html('');
            document.getElementById("btnSavePickedOrders").disabled = false;

        }
    }
    function functionwalkorderarrangement(celllocation) {
        $('input.walkordercheck').on('change', function () {
            $('input.walkordercheck').not(this).prop('checked', false);
            $('.' + celllocation).addClass("yellow-background-table");
        });
    }
    function packagepickeditems() {
        document.getElementById("btnSavePickedOrders").disabled = true;
        var pickedstock = $('#pickedstock').val();
        var packageid = $('#packageid').val();
        var noOfPackets = $('#noOfPackets').val();
        var noInEachPacket = $('#noInEachPacket').val();
        var qtypickedvalues = [];
        var stockid;
        var itemcellid;
        var shelfstockid;
        var batch;
        $('.comparePickedToDeliveredStockoninput').each(function () {
            stockid = $(this).data('id');
            batch = $(this).data('id2');
            shelfstockid = $(this).data('id1');
            itemcellid = $(this).attr('id');
            qtypickedvalues.push({stockid: stockid, itemcellid: itemcellid, value: this.value, shelfstockid: shelfstockid, batch: batch});
        });
        $.confirm({
            title: 'Alert!',
            content: 'Do you want to proceed with picking these items?',
            type: 'green',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {packageid: packageid, noOfPackets: noOfPackets, noInEachPacket: noInEachPacket, pickedstock: pickedstock, qtypickedvalues: JSON.stringify(qtypickedvalues)},
                            url: 'packaging/savepickedpackets.htm',
                            success: function (success) {
                                $.notify({
                                    title: "Activity complete : ",
                                    message: "Packages have sucessfully been created",
                                    icon: 'fa fa-check'
                                }, {
                                    type: "info"
                                });
                                ajaxSubmitData('packaging/picktopackets.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                            }
                        });

                    }
                },
                close: function () {
                }
            }
        });
    }

</script>

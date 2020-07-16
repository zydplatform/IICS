<%-- 
    Document   : packingItemsView
    Created on : Sep 13, 2018, 11:57:32 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<!DOCTYPE html>
<div id="packedpacketitems">
    <input type="hidden" value="${stockid}" id="stockid">
    <table class="table table-hover table-bordered col-md-12" id="packetstable">
        <thead class="col-md-12">
            <tr>
                <th>No</th>
                <th>Reference Number</th>
                <th>Batch Number</th>
                <th>Packet Quantity</th>
                <th>Add</th>
            </tr>
        </thead>
        <tbody class="col-md-12" id="tableFacilityOwner">
            <% int m = 1;
                int count = 0;%>
            <c:forEach items="${packetpacking}" var="data">
                <%count = count + m;%>
                <tr>
                    <td><%=count%></td>
                    <td>${data.referencenumber}</td>
                    <td class="center">${data.batches}</td>
                    <td class="center">
                        <input class="form-control" id="${data.readypacketsid}" type="number" oninput="packedqty(${data.packageno},this.id,<%=count%>)" value="${data.packageno}" min="${data.packageno}" max="${data.packageno}">
                        <div id="error<%=count%>"></div>
                    </td>
                    <td class="center">
                        <div id="checkbox">
                            <input class="form-check-input" id="checkitems" data-id="${data.readypacketsid}" type="checkbox" name="type" onChange="if (this.checked) {
                                        checkeditem('checked', ${data.readypacketsid}, '${data.referencenumber}');
                                    } else {
                                        checkeditem('unchecked', ${data.readypacketsid}, '${data.referencenumber}');
                                    }">
                        </div>
                    </td>
                </tr>
            </c:forEach>
        <span id="itemAllnumber" class="hidedisplaycontent"><%=count%></span>
        </tbody>
    </table>
</div>

<script>
    $('#packetstable').DataTable();
    function packedqty(packetno, positionid, position) {
        var inputqty = $('#' + positionid).val();
        if (inputqty > packetno) {
            document.getElementById(positionid).style.borderColor = 'red';
            $('#error' + position).html('*Error:Please pack the quantity predefined in the package.').css({'color': 'red', 'font-weight': '2em'});
            $('#checkbox').hide();
        }else if(inputqty===''){
            document.getElementById(positionid).style.borderColor = 'red';
            $('#error' + position).html('*Error:This field cannot be empty.').css({'color': 'red', 'font-weight': '2em'});
            $('#checkbox').hide();
        }
        else{
            document.getElementById(positionid).style.borderColor = '#ced4da';
            $('#checkbox').show();
             $('#error' + position).html('');
        }

    }
    function checkeditem(type, readypacketsid, referencenumber) {
        var stockid = $('#stockid').val();
        if (type === 'checked') {
            $.confirm({
                title: 'Alert!',
                // content: '<strong class="center">Have you copied Reference number ' + '<font color="green">' + referencenumber + '</font>' + ' to the packet?</strong>',
                content: '<strong class="center">Please mark your packet with this ' + '<font color="green">' + referencenumber + '</font>' + ' reference number.</strong>',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {readypacketsid: readypacketsid},
                                url: 'packaging/savetodispensepacket.htm',
                                success: function (res) {
                                    ajaxSubmitData('packaging/pack_to_packets.htm', 'content3', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    ajaxSubmitData('packaging/additemstopackets', 'packedpacketitems', 'packageid=${packageid}&packageno=${packageno}&stockid=${stockid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    },
                    No: function () {
                        document.getElementById("checkitems").checked = false;
                    }
                }
            });
        } else if (type === 'unchecked') {

        }
    }
</script>

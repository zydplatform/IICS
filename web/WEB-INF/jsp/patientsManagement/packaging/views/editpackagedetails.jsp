<%-- 
    Document   : editpackagedetails
    Created on : Aug 28, 2018, 12:43:04 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<!DOCTYPE html>

<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-body">
                <div class="form-group">
                    <label for="firstname" class="required">Item Name</label>
                    <input value="${stockid}" id="stockid" type="hidden">
                    <select class="form-control" id="itemselect" >
                        <c:forEach items="${stock}" var ="unititems">
                            <option id="items" value="${unititems.itemid}">${unititems.geneName}</option>
                        </c:forEach>
                    </select>                
                </div>
                <div class="form-group">
                    <label>Available Stock.</label>
                    <span class="badge badge-warning" id="stockavailable" style="height: 2em;width: 4em;font-size: 1em" >${totalqtyshelved}</span>
                    <input id="trial" type="hidden" value="${totalqtyshelved}">
                    <input id="packageid" type="hidden" value="${totalqtyshelved}">
                </div>
                <div class="form-group">
                    <label for="eachpacket" class="required">Quantity in Each Packet</label>
                    <input class="form-control numberinput" id="eachpacket" type="number" placeholder="Enter Quantity for @packet" value="${eachpacket}" >
                </div>
                <div class="form-group">
                    <label for="no-of-packets" class="required" >Number of packets</label>
                    <input class="form-control numberinput" id="noofpackets" type="number" placeholder="Enter number of packets" value="${packetno}" oninput="noOfPackets()">
                    <div id="errormsg"></div>
                </div>
            </div>
        </div> 
    </div>
</div>
<input id="itemmid" type="hidden">
<script>
//    $(document).ready(function () {
//        var itemselect = $('#itemidd').val();
//        document.getElementById('itemmid').value = itemselect;
//        $.ajax({
//            type: 'POST',
//            data: {itemselect: itemselect},
//            url: "packaging/viewitemqty.htm",
//            success: function (respose) {
//                document.getElementById('stockavailable').innerHTML = respose;
//                document.getElementById('trial').value = respose;
//            }
//        });
//    });

    function noOfPackets() {
        document.getElementById('noofpackets').style.borderColor = 'green';
        $('#errormsg').html('');
        var eachpacket = $('#eachpacket').val();
        var noofpackets = $('#noofpackets').val();
        var stockavailable = $('#trial').val();
        var multiple = eachpacket * noofpackets;
        var difference = stockavailable - multiple;
        document.getElementById('stockavailable').innerHTML = difference;
        document.getElementById('trial').innerHTML = difference;

        if (difference < 0) {
            document.getElementById('noofpackets').style.borderColor = 'red';
            $('#errormsg').html('*Packets created dont fit within available stock.').css({'color': 'red'});
        } else {
            $('#errormsg').html('');
        }
    }
    $('#itemselect').change(function () {
        var itemselect = $(this).val();
        document.getElementById('itemmid').value = itemselect;
        $.ajax({
            type: 'POST',
            data: {itemselect: itemselect},
            url: "packaging/viewitemqty.htm",
            success: function (respose) {
                document.getElementById('stockavailable').innerHTML = respose;
                document.getElementById('trial').value = respose;
            }
        });
    });
</script>


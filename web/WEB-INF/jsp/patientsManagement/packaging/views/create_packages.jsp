<%-- 
    Document   : packageitems
    Created on : Aug 10, 2018, 10:33:34 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<!DOCTYPE html>
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <div class="tile" >
            <div class="tile-body" >
                <div id="horizontalwithwords"><span class="headernamedesign">${fullname}</span></div>
                <div class="row rowspace">
                    <span style="font-size: 15px"><b>Quantity Available:</b></span><span class="badge badge-info" style="font-size:15px" id="qtyavailablle" >${Qtyshelving}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size: 15px"><b>Booked Off:</b></span><span class="badge badge-info" style="font-size:15px" id="bookedoff">${total}</span>
                    <input type="hidden" value="${Qtyshelving}" id="availableqty">
                    <input type="hidden" value="${total}" id="qtybooked">
                </div>
                <div class="row rowspace">
                    <div id="horizontalwithwords"><span class="smallerheading">Select Batch</span></div>
                    <c:forEach items="${batcheslist}" var ="batches" begin="0" end="0">
                        <div class="form-check">
                            <label class="form-check-label">
                                <input class="form-check-input" id="checkedbatch" type="radio" name="optionsRadios" value="${batches.shelvedstock}" onChange="if (this.checked)
                                        {
                                            checkeditem('checked',${batches.shelvedstock},${batches.stockid});
                                        } else {
                                            checkeditem('unchecked',${batches.shelvedstock},${batches.stockid});
                                        }

                                       ">${batches.batchnumber}<span class="badge badge-info" style="font-size:15px">${batches.shelvedstock}</span>
                            </label>
                        </div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </c:forEach>
                    <c:forEach items="${batcheslist}" var ="batches" begin="1" end="7">
                        <div class="form-check">
                            <label class="form-check-label">
                                <input class="form-check-input" id="checkedbatch" type="radio" name="optionsRadios" value="${batches.shelvedstock}" onChange="if (this.checked)
                                        {
                                            checkeditem('checked',${batches.shelvedstock},${batches.stockid});
                                            showWarning('${batcheslist[0].get("batchnumber")}');
                                        } else {
                                            checkeditem('unchecked',${batches.shelvedstock},${batches.stockid});
                                        }

                                       ">${batches.batchnumber}<span class="badge badge-info" style="font-size:15px">${batches.shelvedstock}</span>
                            </label>
                        </div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </c:forEach>
                </div>
                <form id="packageform">
                    <div class="row">
                        <div id="horizontalwithwords" style="margin-top: 3em"><span class="smallerheading">Create Package</span></div>
                        <div class="col-md-4">
                            <span style="font-size: 15px"><b>Number of Packets</b></span><input class="form-control form-control-sm" id="noOfPkts" oninput="numberofpkts()" type="number">
                        </div>
                        <div class="col-md-4">
                            <span style="font-size: 15px"><b>Quantity in each Packet</b></span><input class="form-control form-control-sm" id="eachPkt" oninput="qtyofeachpkt()"type="number">
                            <div id="errormsg"></div>
                        </div>
                        <div class="col-md-4">
                            <span style="font-size: 15px"><b>Total</b></span><input class="form-control form-control-sm" id="total" type="number" disabled="true">
                        </div>
                    </div>
                </form>
                <div class="col-md-12 right rowspace" ><hr/>
                    <button class="btn btn-container" id="closesectiom" onclick="closesection()"><i class="fa fa-remove"></i>Close</button>
                    <button class="btn btn-primary" id="savepackage" onclick="savepackage()"><i class="fa fa-save"></i>Save Package</button>
                </div>
            </div>
        </div>

    </div>
    <div class="col-md-2"></div>
</div>
<form id="checkedboxitems">
    <input type="hidden" id="stockid">
    <input type="hidden" id="shelvedstock">
</form>

<script>
    var addcheckedQns = new Set();
    $(document).ready(function () {
        document.getElementById('savepackage').disabled = true;
    });
    function checkeditem(type, shelvedstock, stockid) {
        if (type === 'checked') {
            document.getElementById("packageform").reset();
            document.getElementById('shelvedstock').value = shelvedstock;
            document.getElementById('stockid').value = stockid;
            addcheckedQns.add(shelvedstock);
        } else if (type === 'unchecked') {
            document.getElementById("checkedboxitems").reset();
            addcheckedQns.delete(shelvedstock);
        }
        if (addcheckedQns.size === 0) {
            document.getElementById('savepackage').disabled = true;
        } else {
            document.getElementById('savepackage').disabled = false;
        }
    }
    function savepackage() {
        var numberOfpackets = $('#noOfPkts').val();
        var eachPkt = $('#eachPkt').val();
        if (numberOfpackets === '') {
            document.getElementById('noOfPkts').style.borderColor = 'red';
        }
        if (eachPkt === '') {
            document.getElementById('eachPkt').style.borderColor = 'red';
        }
        if (numberOfpackets !== '' && eachPkt !== '') {
            var stockid = $('#stockid').val();
            $.confirm({
                title: 'Alert!',
                content: 'Do you want to save this package?',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {eachPkt: eachPkt, numberOfpackets: numberOfpackets, stockid: stockid},
                                url: "packaging/save_packages.htm",
                                success: function (data) {
                                    $('#ItemsearchResults').html('');
                                    $.notify({
                                        title: "Action Complete : ",
                                        message: "A package has been created!",
                                        icon: 'fa fa-check'
                                    }, {
                                        type: "info"
                                    });
                                }
                            });
                        }
                    },
                    close: function () {
                    }
                }
            });

        }

    }
    function qtyofeachpkt() {
        $('#errormsg').html('');
        document.getElementById('eachPkt').style.borderColor = 'skyblue';
        var availableqty = $('#shelvedstock').val();
        var qtybooked = $('#qtybooked').val();
        var noOfPkts = $('#noOfPkts').val();
        var eachPkt = $('#eachPkt').val();
        if (availableqty === '') {
            document.getElementById('eachPkt').style.borderColor = 'red';
            $('#errormsg').html('<small><span style="color:red;">*No Batch Selected</span></small>');
        }
        if (availableqty !== '')
        {
            document.getElementById('eachPkt').style.borderColor = 'skyblue';
            $('#errormsg').html('');
            var multiple = noOfPkts * eachPkt;
            document.getElementById('total').value = multiple;
            var allavailableqty = $('#availableqty').val();
            var balance = allavailableqty - multiple;
            var batchbalance = (availableqty - parseInt(qtybooked)) - multiple;
            var bookedoff = parseInt(qtybooked) + multiple;

            document.getElementById('bookedoff').innerHTML = bookedoff;
            document.getElementById('shelvedstock').innerHTML = batchbalance;
            document.getElementById('qtyavailablle').innerHTML = balance;

            if (batchbalance < 0) {
                document.getElementById('eachPkt').style.borderColor = 'red';
                $('#errormsg').html('<small><span style="color:red;">The total is greater than Qty available in the selected batch.</span></small>');
                document.getElementById('savepackage').disabled = true;
            } else {
                $('#errormsg').html('');
                document.getElementById('savepackage').disabled = false;
            }
        }
        if (noOfPkts === '') {
            document.getElementById('noOfPkts').style.borderColor = 'red';
        }

    }

    function numberofpkts() {
        document.getElementById('noOfPkts').style.borderColor = 'skyblue';
    }
    function closesection(){
        $('#ItemsearchResults').html('');
    }
    //
    function showWarning(batchnumber){
        $.confirm({
            title: 'WARNING',
            content: 'Batch number ' + batchnumber + ' will expire before this batch number.',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'red',
            typeAnimated: true,
            closeIcon: true,
            theme: 'modern',
            buttons:{
                OK: {
                    text: 'Ok',                       
                    btnClass: 'btn-red',
                    action: function(){}
                }
            }
        });
    }
    //
</script>

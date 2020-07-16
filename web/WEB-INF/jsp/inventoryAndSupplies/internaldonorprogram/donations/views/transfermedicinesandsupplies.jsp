<%-- 
    Document   : transfermedicinesandsupplies
    Created on : Oct 7, 2018, 3:26:48 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<style>
    .error
    {
        border:2px solid red;
    }
</style>
<div class="row">
    <div class="col-md-12">
        <form>
            <input type="hidden" value="${itemid}" id="itemid">
            <input type="hidden" value="${donationsitemsid}" id="donationsitemsid">
            <input type="hidden" value="${batchno}" id="batchno">
            <input type="hidden" value="${exiprydate}" id="exiprydate">
            <input type="hidden" value="${qtydonated}" id="qtydonated">
            <div class="form-group">
                <label class="control-label">Select Destination Unit:</label>
                <select class="form-control myform" id="selectedbuildings">
                    <c:forEach items="${facUnits}" var="U">
                        <option value="${U.facilityunitid}">${U.facilityunitname}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group row">
                <label for="itemclass" id="packsLabel">Quantity</label>
                <input class="form-control" id="quantityTransferred" type="number" oninput="checkQuantity()" placeholder="Enter Item Quantity">
                <h6 id='result'></h6>
            </div>
            <div class="form-group row">
                <button class="btn btn-primary" id="transferDonatedItems" type="button" style="float: left">
                    <i class="fa fa-fw fa-lg fa-plus"></i>
                    Save
                </button>
            </div>
        </form>
    </div>
</div>
<script>

    function checkQuantity() {
        var $result = $("#result");
        $result.text("");
        var qtydonated = $('#qtydonated').val();
        var transferamount = $('#quantityTransferred').val();
        
        console.log("transferamount---------------"+transferamount);
        if (parseInt(transferamount) <= parseInt(qtydonated)) {
            alert("transferamount");
            $result.css("color", "green");
            $('#quantityTransferred').removeClass('error');

        } else {
            alert("qtydonated");
            $('#quantityTransferred').addClass('error');
            $result.css("color", "red");
        }
    }

    $('#transferDonatedItems').click(function () {
        var itemid = $('#itemid').val();
        var donationsitemsid = $('#donationsitemsid').val();
        var qtydonated = $('#qtydonated').val().replace(/,\s?/g, "");
        var batchno = $('#batchno').val();
        var exiprydate = $('#exiprydate').val();
        var quantityTransferred = $('#quantityTransferred').val();
        var diffres = parseInt(qtydonated) - parseInt(quantityTransferred);

        var data = {
            itemid: itemid,
            donationsitemsid: donationsitemsid,
            batchno: batchno,
            exiprydate: exiprydate,
            qtydonated: qtydonated,
            quantityTransferred: quantityTransferred,
            diffres: diffres
        };

        $.ajax({
            type: 'POST',
            data: data,
            url: 'internaldonorprogram/saveDonorStock.htm',
            success: function (res) {
                if (res === 'Saved') {
                    $('#transferDonatedItems').prop('disabled', true);
                    $.toast({
                        heading: 'Success',
                        text: 'Donation Successfully Made.',
                        icon: 'success',
                        hideAfter: 2000,
                        position: 'bottom-center'
                    });
                    ajaxSubmitData('internaldonorprogram/viewDonationsToTransfer.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    window.location = '#close';
                } else {
                    $.toast({
                        heading: 'Error',
                        text: 'An unexpected error occured while trying to make donation.',
                        icon: 'error'
                    });
                    ajaxSubmitData('internaldonorprogram/viewDonationsToTransfer.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    window.location = '#close';
                }
            }
        });

    });
</script>
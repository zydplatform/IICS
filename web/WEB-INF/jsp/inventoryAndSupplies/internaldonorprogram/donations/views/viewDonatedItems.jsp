<%-- 
    Document   : viewDonatedItems
    Created on : Oct 11, 2018, 8:29:58 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<script>
    function donatedOtherItemscollapseandExapand(id) {
        if ($('#' + id).hasClass("donatedOtherItemsactiveselected")) {
            $('#' + id).toggleClass('donatedOtherItemscollapseselected donatedOtherItemsactiveselected');
            $('#donatedOtherItemsxxicon').attr('class', 'fa fa-2x fa-minus');
            document.getElementById('donatedOtherItemscollapsethistestcontent').style.display = 'block';
            $('#' + id).toggleClass('donatedMedicinesactiveselected donatedMedicinescollapseselected');
            $('#donatedMedicinesxxicon').attr('class', 'fa fa-2x fa-plus');
            document.getElementById('donatedMedicinescollapsethistestcontent').style.display = 'none';
        } else if ($('#' + id).hasClass("donatedOtherItemscollapseselected")) {
            $('#' + id).toggleClass('donatedOtherItemsactiveselected donatedOtherItemscollapseselected');
            $('#donatedOtherItemsxxicon').attr('class', 'fa fa-2x fa-plus');
            document.getElementById('donatedOtherItemscollapsethistestcontent').style.display = 'none';

        }
    }

    function donatedMedicinesCollapseandExapand(id) {
        if ($('#' + id).hasClass("donatedMedicinesactiveselected")) {
            $('#' + id).toggleClass('donatedMedicinescollapseselected donatedMedicinesactiveselected');
            $('#donatedMedicinesxxicon').attr('class', 'fa fa-2x fa-minus');
            document.getElementById('donatedMedicinescollapsethistestcontent').style.display = 'block';
        } else if ($('#' + id).hasClass("donatedMedicinescollapseselected")) {
            $('#' + id).toggleClass('donatedMedicinesactiveselected donatedMedicinescollapseselected');
            $('#donatedMedicinesxxicon').attr('class', 'fa fa-2x fa-plus');
            document.getElementById('donatedMedicinescollapsethistestcontent').style.display = 'none';
        }
    }
</script>
<style>

    #donatedMedicinescollapsethistest {
        background-color:#D8BFD8 !important;
        color: black !important;
        cursor: pointer;
    }

    #donatedMedicinescollapsethistest:hover {
        background-color: plum;
    }

    #donatedOtherItemscollapsethistest {
        background-color:#D8BFD8 !important;
        color: black !important;
        cursor: pointer;
    }

    #donatedOtherItemscollapsethistest:hover {
        background-color: plum;
    }

    .donorFont{
        font-size: 20px;
    }

    .popover{
        z-index: 999999999;
        max-width: 100% !important;
    }

</style>
<div class="row">
    <div class="col-md-12">
        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong><font size="4">Donation Ref No.:</font></strong></span>&nbsp;
        <strong>
            <span class=""><strong class="fname" style="color: green; "><font size="4">${donorrefno}</font></strong></span>
        </strong>
        <input value="${donationsid}" class="form-control" type="hidden">
    </div>
</div>
<c:if test="${not empty donatedItemsList}">
    <div class="row" style="padding-top: 10px;">
        <div class="col-md-12">
            <div class="btn btn-sm horizontalwithwordsleft donatedMedicinesactiveselected col-md-12" id="donatedMedicinescollapsethistest" onclick="donatedMedicinesCollapseandExapand(this.id);">
                <strong><span class="title badge donorFont" style="float: left"><i id="donatedMedicinesxxicon" class="fa fa-2x fa-minus"></i>&nbsp; Medicines & Supplies</span></strong>   
            </div>
        </div>
    </div>
    <div class="col-md-12" id="donatedMedicinescollapsethistestcontent">
        <div class="tile">
            <div class="tile-body">
                <div class="row" style="margin-top: 0em">
                    <div class="col-md-12">
                        <table class="table table-hover table-bordered col-md-12" id="tableviewonatedItems">
                            <thead class="col-md-12">
                                <tr>
                                    <th class="center">No</th>
                                    <th>Item Name</th>
                                    <th class="">Batch No.</th>
                                    <th class="">Expiry Date</th>
                                    <th class="right">Quantity</th>
                                    <th class="">Transfer Rounds</th>
                                </tr>
                            </thead>
                            <tbody class="col-md-12">
                                <% int i = 1;%>
                                <c:forEach items="${donatedItemsList}" var="items">
                                    <tr id="${items.donationsitemsid}">
                                        <td class=""><%=i++%></td>
                                        <td class="">${items.genericname} ${items.itemstrength}</td>
                                        <td class="">${items.batchno}</td>
                                        <td class="">${items.expirydate}</td>  
                                        <td class="right">${items.qtydonated}</td> 
                                        <td class="center">
                                            <span onclick="popOverlay('${items.batchno}')" id="pops${items.batchno}" class="btn badge span-size-i5 badge-success" data-toggle="popover"  data-animation="true" data-id="${items.batchno}" data-container="body" data-placement="right" data-original-title="More Details">
                                                ${items.donatedMedicineItemsFacUnitCount}
                                            </span>
                                        </td> 
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>	
        </div> <!-- collapse .// -->
    </div>
</c:if>
<c:if test="${not empty otherDonatedItemsList}">
    <div class="row" style="padding-top: 10px; padding-bottom: 10px">
        <div class="col-md-12">
            <div class="btn btn-sm btn-plum horizontalwithwordsleft donatedOtherItemsactiveselected col-md-12" id="donatedOtherItemscollapsethistest" onclick="donatedOtherItemscollapseandExapand(this.id);">
                <strong><span class="title badge donorFont" style="float: left"><i id="donatedOtherItemsxxicon" class="fa fa-2x fa-plus"></i>&nbsp; OTHER ITEMS</span></strong>   
            </div>
        </div>
    </div>
    <div class="col-md-12" id="donatedOtherItemscollapsethistestcontent">
        <div class="tile">
            <div class="tile-body">
                <div class="row" style="margin-top: 0em">
                    <div class="col-md-12">
                        <table class="table table-hover table-bordered col-md-12" id="tableViewOtherDonatedItems">
                            <thead class="col-md-12">
                                <tr>
                                    <th class="center">No</th>
                                    <th>Item Name</th>
                                    <th class="">Specification</th>
                                    <th class="right">Quantity</th>
                                </tr>
                            </thead>
                            <tbody class="col-md-12">
                                <% int k = 1;%>
                                <c:forEach items="${otherDonatedItemsList}" var="o">
                                    <tr id="${o.facilityassetsid}">
                                        <td class="center"><%=k++%></td>
                                        <td class="">${o.assetsname}</td>
                                        <td class="">${o.itemspecification}</td>
                                        <td class="right">${o.assetqty}</td> 
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>	
        </div> <!-- collapse .// -->
    </div>
</c:if>
<c:forEach items="${donatedItemsList}" var="item">
    <div id="details${item.batchno}" class="hide">
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <% int x = 1;%>
                        <c:forEach items="${item.comsumedAmt}" var="round">
                            <fieldset>
                                <legend><font size="4">${round.handoverdate}</font></legend>
                                <div id="horizontalwithwords">
                                    <span class="pat-form-heading">
                                        <strong><font size="4">${round.facilityunitname}</font></strong>
                                    </span>
                                </div>
                                <div class="form-group bs-component center">
                                    <span class="badge badge-info patientConfirmFont">${round.qtyhandedover}</span>
                                </div>
                            </fieldset>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
<div class="row">
    <div class="col-md-12">
        <div class="col-md-4 pull-right">
            <button class="btn btn-primary pull-right" id="printDonorInfo" onclick="printDonationDetails(${donationsid}, '${donorrefno}')" type="button">
                <i class="fa fa-fw fa-lg fa-print"></i>
                Print
            </button>
        </div>
    </div>
</div>
<script>
    $('#tableviewonatedItems').DataTable();
    $('#tableViewOtherDonatedItems').DataTable();

    function printDonationDetails(donationsid, donorrefno) {
        $.confirm({
            icon: 'fa fa-warning',
            title: 'Print Donation Details',
            content: '<div id="printDonationsBox" class="center"><i class="fa fa-spinner fa-spin fa-3x"></i></div>',
            type: 'purple',
            typeAnimated: true,
            boxWidth: '70%',
            useBootstrap: false,
            buttons: {
                close: {
                    text: 'Close',
                    action: function () {

                    }
                }
            },
            onContentReady: function () {
                var printBox = this.$content.find('#printDonationsBox');
                $.ajax({
                    type: 'GET',
                    data: {donationsid: donationsid, donorrefno: donorrefno},
                    url: 'internaldonorprogram/printDonationDetails.htm',
                    success: function (res) {
                        if (res !== '') {
                            var objbuilder = '';
                            objbuilder += ('<object width="100%" height="500px" data="data:application/pdf;base64,');
                            objbuilder += (res);
                            objbuilder += ('" type="application/pdf" class="internal">');
                            objbuilder += ('<embed src="data:application/pdf;base64,');
                            objbuilder += (res);
                            objbuilder += ('" type="application/pdf"/>');
                            objbuilder += ('</object>');
                            printBox.html(objbuilder);
                        } else {
                            printBox.html('<div class="bs-component">' +
                                    '<div class="alert alert-dismissible alert-warning">' +
                                    '<h4>Warning!</h4>' +
                                    '<p>Error generating PDF. Please <strong>Refresh</strong> & Try Again.</p></div></div>'
                                    );
                        }
                    }
                });
            }
        });
    }
    function popOverlay(id) {
        $('#pops' + id).popover({
            html: true,
            width: '100%',
            height: '100%',
            content: function () {
                var id = $(this).attr('data-id');
                var popup = $('#details' + id).html();
                return popup;
            }
        });
        $('#pops' + id).popover('show');
    }
</script>

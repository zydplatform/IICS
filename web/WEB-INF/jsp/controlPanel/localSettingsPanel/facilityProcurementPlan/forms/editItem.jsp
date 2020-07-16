<%-- 
    Document   : editItem
    Created on : Jun 6, 2018, 9:39:15 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<input id="facilityfinancialyearidupdt" value="${facilityfinancialyearid}" type="hidden">
<input id="orderperiodidupdt" value="${orderperiodid}" type="hidden">
<input id="itemidupdt" value="${itemid}" type="hidden">
<input id="orderperiodtypeupdt" value="${orderperiodtype}" type="hidden">
<input id="facilityprocurementplanidupdt" value="${facilityprocurementplanid}" type="hidden">

<input id="facilityprocurementistopdownapproach" value="${istopdownapproach}" type="hidden">

<form id="enteritemdetailsform">                 
    <div class="form-group">
        <label for="itemname">Item Name</label>
        <input class="form-control" id="itemsname" value="${genericname}" type="text"  disabled="true">
    </div>
    <div class="form-group">
        <label for="itemclass">Monthly Needed</label>
        <input class="form-control" value="${averagemonthlyconsumption}" oninput="editflagEmptyFields2('month','${orderperiodtype}')" id="EdtitemsQty" type="number">
    </div>
    <c:if test="${orderperiodtype =='Quarterly'}">
        <div class="form-group">
            <label for="itemclass">Quarterly Needed.</label>
            <input class="form-control" value="${averagequarterconsumption}" oninput="editflagEmptyFields2('quarter','${orderperiodtype}')" id="EdtquarterQty" type="number">
        </div>
    </c:if>
    <c:if test="${orderperiodtype =='Annually'}">
        <div class="form-group">
            <label for="itemclass">Annually Needed.</label>
            <input class="form-control" value="${averageannualcomsumption}" oninput="editflagEmptyFields2('annual','${orderperiodtype}')" id="EdtAnnuallyQty" type="number">
        </div> 
    </c:if>
</form>
<div class="col-md-12" align="right"  >
    <button class="btn btn-primary" onclick="saveEdittedProcurementPlanItem()">
        <i class="fa fa-check-circle"></i>
        Update
    </button>
</div>
<script>
    function editflagEmptyFields2(type, orderperiodtype) {
        if (type === 'month') {
            var monthlyneed = $('#EdtitemsQty').val();
            if (monthlyneed !== '') {
                if (orderperiodtype === 'Quarterly') {
                    document.getElementById('EdtquarterQty').value = monthlyneed * 3;
                } else {
                    document.getElementById('EdtAnnuallyQty').value = monthlyneed * 12;
                }
            }
        } else if (type === 'quarter') {
            var quarterneed = $('#EdtquarterQty').val();
            if (quarterneed !== '') {
                document.getElementById('EdtitemsQty').value = Math.round(quarterneed / 3);
            }
        } else if (type === 'annual') {
            var annualneed = $('#EdtAnnuallyQty').val();
            if (annualneed !== '') {
                document.getElementById('EdtitemsQty').value = Math.round(annualneed / 12);
            }
        } else {

        }
    }
     function saveEdittedProcurementPlanItem() {
        var facilityfinancialyearid = $('#facilityfinancialyearidupdt').val();
        var orderperiodid = $('#orderperiodidupdt').val();
        var itemid = $('#itemidupdt').val();
        var monthlyneed = $('#EdtitemsQty').val();
        var othervalue = 0;
        var ordertype = $('#orderperiodtypeupdt').val();
        
        var istopdownapproach = $('#facilityprocurementistopdownapproach').val();
        
        var facilityprocurementplanid = $('#facilityprocurementplanidupdt').val();
        if (ordertype === 'Quarterly') {
            othervalue = $('#EdtquarterQty').val();
        } else {
            othervalue = $('#EdtAnnuallyQty').val();
        }
        
        if (monthlyneed !=='' && othervalue !== '') {
            $.ajax({
                type: 'POST',
                data: {monthlyneed: monthlyneed, ordertype: ordertype, othervalue: othervalue, facilityfinancialyearid: facilityfinancialyearid, orderperiodid: orderperiodid, itemid: itemid,facilityprocurementplanid:facilityprocurementplanid},
                url: "facilityprocurementplanmanagement/saveupdatefacilityunitprocurementplanitemvalue.htm",
                success: function (data, textStatus, jqXHR) {
                    $('#edit_procurementplan_items').modal('hide');
                    ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredprocuredprocurementplansitemsview.htm', 'facilityprocuredprocuredprocurementplansitemsdiv', 'act=a&facilityfinancialyearid=' + facilityfinancialyearid + '&orderperiodtype=' + ordertype + '&orderperiodid=' + orderperiodid + '&istopdownapproach='+istopdownapproach+'&ofst=1&maxR=100&sStr=', 'GET');
                }
            });
        }
    }
</script>
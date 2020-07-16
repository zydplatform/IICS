<%-- 
    Document   : editItemValues
    Created on : Jun 8, 2018, 8:34:43 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form id="editItemDetailsForm">                 
    <div class="form-group">
        <label for="itemname">Item Name</label>
        <input class="form-control" id="itemsname" value="${genericname}" type="text"  disabled="true">
    </div>
    <div class="form-group">
        <label for="itemclass">Monthly Needed</label>
        <input class="form-control" value="${averagemonthlyconsumption}" oninput="editapprovedflagEmptyFields2('month','${type}')" id="EdtapprditemsQty" type="number">
    </div>
    <c:if test="${type =='Quarterly'}">
        <div class="form-group">
            <label for="itemclass">Quarterly Needed.</label>
            <input class="form-control" value="${quarterormonth}" oninput="editapprovedflagEmptyFields2('quarter','${type}')" id="EdtapprdquarterQty" type="number">
        </div>
    </c:if>
    <c:if test="${type =='Annually'}">
        <div class="form-group">
            <label for="itemclass">Annually Needed.</label>
            <input class="form-control" value="${quarterormonth}" oninput="editapprovedflagEmptyFields2('annual','${type}')" id="EdtapprvdAnnuallyQty" type="number">
        </div> 
    </c:if>
</form>
    <div class="col-md-12" align="right" onclick="savebtnedittedonapprovedproc(${facilityunitprocurementplanid});" >
    <button class="btn btn-primary" data-dismiss="modal">
        <i class="fa fa-check-circle"></i>
        save
    </button>
</div>
<script>
    function editapprovedflagEmptyFields2(type, ordertype) {
        if (type === 'month') {
            var month = $('#EdtapprditemsQty').val();
            var quartr = $('#EdtapprdquarterQty').val();
            if (ordertype === 'Quarterly') {
                document.getElementById('EdtapprdquarterQty').value = month * 3;
            } else {
                document.getElementById('EdtapprvdAnnuallyQty').value = month * 12;
            }
        } else if (type === 'quarter') {
            document.getElementById('EdtapprditemsQty').value = Math.round(quartr / 3);
        } else if (type === 'annual') {
            document.getElementById('EdtapprditemsQty').value = Math.round(quartr / 12);
        }
    }
</script>
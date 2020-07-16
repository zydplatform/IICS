<%-- 
    Document   : itemForm
    Created on : May 4, 2018, 6:37:29 AM
    Author     : IICS
--%>

<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form id="enteritemdetailsform">                 
    <input type="hidden" id="itemsid" value="${itemid}">
    <input type="hidden" id="ortype" value="${ordertypeperiod}">
<div class="form-group">
    <label for="itemname">Item Name</label>
    <input class="form-control" id="itemsname" value="${itemname}" type="text"  disabled="true">
</div>
<div class="form-group">
    <label for="itemclass">Monthly Needed</label>
    <input class="form-control" value="<c:if test="${monthly !=0}">${monthly}</c:if><c:if test="${monthly ==0}"></c:if>" oninput="flagEmptyFields('month')" id="itemsQty" type="number">
</div>
<c:if test="${ordertypeperiod =='Quarterly'}">
    <div class="form-group">
        <label for="itemclass">Quarterly Needed.</label>
        <input class="form-control" value="<c:if test="${quarterly !=0}">${quarterly}</c:if><c:if test="${quarterly ==0}"></c:if>" oninput="flagEmptyFields('quarter')" id="quarterQty" type="number">
    </div>
</c:if>

<c:if test="${ordertypeperiod =='Monthly'}">
    <div class="form-group">
        <label for="itemclass">Annual Needed.</label>
        <input class="form-control" value="<c:if test="${monthorannual !=0}">${monthorannual}</c:if><c:if test="${monthorannual ==0}"></c:if>" oninput="flagEmptyFields('annual')" id="quarterQty" type="number">
    </div> 
</c:if>
<c:if test="${ordertypeperiod =='Annually'}">
    <div class="form-group">
        <label for="itemclass">Annual Needed.</label>
        <input class="form-control" value="<c:if test="${monthorannual !=0}">${monthorannual}</c:if><c:if test="${monthorannual ==0}"></c:if>" oninput="flagEmptyFields('annual')" id="quarterQty" type="number">
    </div> 
</c:if>
</form>
<script>
    function flagEmptyFields(type) {
        var ortype=$('#ortype').val();
        if (type === 'month' && ortype==='Quarterly') {
            var qty = $('#itemsQty').val();
            if (qty < 1 || qty === '') {
                $('#itemsQty').css('border', '2px solid #f50808c4');
                document.getElementById('additemprocurem').disabled = true;
            } else {
                document.getElementById('additemprocurem').disabled = false;
                $('#itemsQty').css('border', '2px solid #7d047d');
                document.getElementById('quarterQty').value = parseInt(qty) * 3;
            }

        } else if (type === 'month' && ortype==='Monthly') {
            var qty = $('#quarterQty').val();
            if (qty < 1 || qty === '') {
                $('#quarterQty').css('border', '2px solid #f50808c4');
                document.getElementById('additemprocurem').disabled = true;
            } else {
                document.getElementById('additemprocurem').disabled = false;
                $('#quarterQty').css('border', '2px solid #7d047d');
                document.getElementById('itemsQty').value = parseInt(qty) * 12;
            }
        } else if(type === 'month' && ortype==='Annually'){
            var qty = $('#itemsQty').val();
            if (qty < 1 || qty === '') {
                $('#itemsQty').css('border', '2px solid #f50808c4');
                document.getElementById('additemprocurem').disabled = true;
            } else {
                document.getElementById('additemprocurem').disabled = false;
                $('#itemsQty').css('border', '2px solid #7d047d');
                document.getElementById('quarterQty').value = parseInt(qty) * 12;
            }
        }else if(type === 'quarter' && ortype==='Quarterly'){
            var qty = $('#quarterQty').val();
            if (qty < 1 || qty === '') {
                $('#quarterQty').css('border', '2px solid #f50808c4');
                document.getElementById('additemprocurem').disabled = true;
            } else {
                document.getElementById('additemprocurem').disabled = false;
                $('#quarterQty').css('border', '2px solid #7d047d');
                document.getElementById('itemsQty').value = parseInt(qty) /3;
            }
        }else if(type === 'quarter' && ortype==='Monthly'){
            var qty = $('#quarterQty').val();
            if (qty < 1 || qty === '') {
                $('#quarterQty').css('border', '2px solid #f50808c4');
                document.getElementById('additemprocurem').disabled = true;
            } else {
                document.getElementById('additemprocurem').disabled = false;
                $('#quarterQty').css('border', '2px solid #7d047d');
                document.getElementById('itemsQty').value = parseInt(qty) /12;
            }
        }else if(type === 'quarter' && ortype==='Annually'){
            var qty = $('#quarterQty').val();
            if (qty < 1 || qty === '') {
                $('#quarterQty').css('border', '2px solid #f50808c4');
                document.getElementById('additemprocurem').disabled = true;
            } else {
                document.getElementById('additemprocurem').disabled = false;
                $('#quarterQty').css('border', '2px solid #7d047d');
                document.getElementById('itemsQty').value = parseInt(qty) /12;
            }
        }

    }
</script>
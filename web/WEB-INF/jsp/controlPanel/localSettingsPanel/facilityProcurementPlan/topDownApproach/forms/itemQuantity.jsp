<%-- 
    Document   : itemQuantity
    Created on : Jun 25, 2018, 1:02:17 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<form action="" class="formName">
    <div class="form-group">
        <label>Enter Monthly Need</label>
        <input type="text" id="focusmonthlyneeded" class="monthlyneeded form-control" oninput="procuringamount(this.value,'month','${ordertype}');" required />
    </div>
    <div class="form-group">
        <label>Enter ${ordertype} Need</label>
        <input type="text" class="quarterorannualneeded form-control" oninput="procuringamount(this.value,'annualorquarter','${ordertype}');" required />
    </div>
</form>,
<script>
    document.getElementById('focusmonthlyneeded').focus();
    function procuringamount(value, type, orderperiod) {
        if (value !== '') {
            if (type === 'month') {
                if(orderperiod==='Quarterly'){
                    $('.quarterorannualneeded').val(value*3);
                }else{
                    $('.quarterorannualneeded').val(value*12);
                }
            } else {
                 if(orderperiod==='Quarterly'){
                    $('.monthlyneeded').val(Math.round(value/3));
                }else{
                    $('.monthlyneeded').val(Math.round(value/12));
                }
            }
        }
    }
</script>
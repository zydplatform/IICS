<%-- 
    Document   : approvedOrderItems
    Created on : Sep 2, 2018, 12:50:45 AM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<fieldset style="min-height:100px;">
    <table class="table table-hover table-bordered" id="approvedFacilityOrderItem">
        <thead>
            <tr>
                <th>No</th>
                <th>Item Name</th>
                <th>Quantity Ordered</th>
                <th>Quantity Approved</th>
            </tr>
        </thead>
        <tbody>
            <% int i = 1;%>
            <c:forEach items="${facilityorderitemsList}" var="a">
                <tr>
                    <td align="center"><%=i++%></td>
                    <td>${a.itemname}</td>
                    <td>${a.qtyonorder}</td>
                    <td>${a.qtyapproved}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <br>
    <div class="row">
        <div class="col-md-12 right">
            <button type="button" class="btn btn-secondary" onclick="">
                <i class="fa fa-print"></i>  Print
            </button>
        </div>
    </div> 
</fieldset>
<script>
    $('#approvedFacilityOrderItem').DataTable();
</script>
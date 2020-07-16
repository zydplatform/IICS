<%-- 
    Document   : items
    Created on : Nov 12, 2018, 10:04:12 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<table class="table table-hover table-bordered" id="facilityOrderItem">
    <thead>
        <tr>
            <th>No</th>
            <th>Item Name</th>
            <th>Quantity Ordered</th>
            <c:if test="${act=='b'}">
             <th>Quantity Approved</th>
            </c:if>
        </tr>
    </thead>
    <tbody>
        <% int i = 1;%>
        <c:forEach items="${internalordersItems}" var="a">
            <tr>
                <td align="center"><%=i++%></td>
                <td>${a.packagename}</td>
                <td>${a.qtyordered}</td>
                <c:if test="${act=='b'}">
                  <td>${a.qtyapproved}</td>  
                </c:if>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#facilityOrderItem').DataTable();
</script>
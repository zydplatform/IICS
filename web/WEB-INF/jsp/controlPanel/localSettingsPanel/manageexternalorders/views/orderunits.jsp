<%-- 
    Document   : orderunits
    Created on : Aug 23, 2018, 5:09:55 PM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp" %>
<div class="col-md-12">
    <div class="tile">
        <table class="table table-hover table-striped" id="orderUnitsTable">
            <thead>
                <tr>
                    <th class="center">#</th>
                    <th>Facility Unit</th>
                    <th>Quantity Ordered</th>
                </tr>
            </thead>
            <tbody>
                <% int i = 1;%>
                <c:forEach items="${externalFacOrderUnits}" var="v">
                    <tr id="${v.itemid}">
                        <td class="center"><%=i++%></td>
                        <td class="">${v.facilityunitname}</td>
                        <td class="">${v.qtyordered}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $('#orderUnitsTable').DataTable();
</script>

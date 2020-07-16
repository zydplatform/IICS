<%-- 
    Document   : recountedItemBatches
    Created on : 19-Jun-2018, 16:32:12
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<table class="table table-hover table-striped" id="recountedItemsTable">
    <thead>
        <tr>
            <th>#</th>
            <th class="rigght">Batch No.</th>
            <th class="rigght">Expiry Date</th>
            <th class="rigght">Quantity</th>
            <th class="rigght">Date Entered</th>
        </tr>
    </thead>
    <tbody>
        <% int k = 1;%>
        <c:forEach items="${items}" var="item">
            <tr>
                <td><%=k++%></td>
                <td class="rigght">${item.batch}</td>
                <td class="rigght">${item.expiry}</td>
                <td class="rigght">${item.count}</td>
                <td class="rigght">${item.entry}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script type="text/javascript">
    $('#recountedItemsTable').DataTable();
</script>
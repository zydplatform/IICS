<%-- 
    Document   : staffCells
    Created on : 28-May-2018, 16:26:39
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<table class="table table-hover table-striped" id="countedCellItemsTable">
    <thead>
        <tr>
            <th>#</th>
            <th>Item</th>
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
                <td class="rigght">${item.name}</td>
                <td class="rigght">${item.batch}</td>
                <td class="rigght">${item.expiry}</td>
                <td class="rigght">${item.count}</td>
                <td class="rigght">${item.entry}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script type="text/javascript">
    $('#countedCellItemsTable').DataTable();
</script>
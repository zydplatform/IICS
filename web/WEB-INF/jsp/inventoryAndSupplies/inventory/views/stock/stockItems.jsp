<%-- 
    Document   : stockItems
    Created on : 08-May-2018, 10:31:32
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<fieldset>
    <div class="row">
        <table class="table table-hover table-bordered dataTable no-footer" id="stockTable">
            <thead>
                <tr role="row">
                    <th>#</th>
                    <th>Item</th>
                    <th class="right">Opening Stock</th>
                    <th class="right">Received</th>
                    <th class="right">Closing Stock</th>
                    <th class="center">Details</th>
            </thead>
            <tbody>
                <% int i = 1;%>
                <c:forEach items="${items}" var="item">
                    <tr>
                        <td><%=i++%></td>
                        <td>${item.name}</td>
                        <td class="right">${item.opening}</td>
                        <td class="right">${item.received}</td>
                        <td class="right">${item.currstock}</td>
                        <td class="center">
                            <button class="btn btn-primary btn-sm" onclick="viewItemTransactions(${item.itemid}, '${item.name}')">
                                <i class="fa fa-dedent"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</fieldset>
<script>
    $(document).ready(function () {
        $('#stockTable').DataTable();
    });
</script>
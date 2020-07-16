<%-- 
    Document   : stockItemLocations
    Created on : 10-May-2018, 12:21:52
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div class="row invoice-info">
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <table class="table table-striped">
            <tbody>
                <tr>
                    <td>Total Shelved</td>
                    <td class="right">
                        <span class="badge badge-pill badge-info">${total}</span>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="col-md-2"></div>
</div>
<fieldset>
    <div class="row">
        <table class="table table-hover table-bordered dataTable no-footer" id="stockItemLocationTable">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Cell</th>
                    <th>Batch</th>
                    <th class="right">Item Quantity</th>
                </tr>
            </thead>
            <tbody>
                <% int y = 1;%>
                <c:forEach items="${itemLocations}" var="item">
                    <tr>
                        <td><%=y++%></td>
                        <td>${item.cell}</td>
                        <td>${item.batch}</td>
                        <td class="right">${item.qty}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</fieldset>
<script>
    $(document).ready(function () {
        $('#stockItemLocationTable').DataTable();
        $('.dataTables_length').hide();
    });
</script>
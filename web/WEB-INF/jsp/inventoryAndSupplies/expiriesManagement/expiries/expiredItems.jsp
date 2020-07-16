<%-- 
    Document   : expiredItems
    Created on : Oct 6, 2018, 5:02:58 PM
    Author     : IICS
--%>

<%@include file="../../../include.jsp" %>
<div class="col-sm-12 col-md-12">
    <table class="table table-hover table-bordered" id="expiries">
        <thead>
            <tr>
                <th>No</th>
                <th>Item</th>
                <th>Quantity Expired</th>
                <th class="center">Batches</th>
                <th class="center">Dispose</th>
            </tr>
        </thead>
        <tbody id="bodyItems">
            <% int k = 1;%>
            <c:forEach items="${items}" var="item">
                <tr>
                    <td><%=k++%></td>
                    <td>${item.itemname}</td>
                    <td>
                        <fmt:formatNumber type="number" maxFractionDigits="0" value="${item.qty/item.packsize}"/>
                    </td>
                    <td>${item.batches}</td>
                    <td class="center">
                        <button class="btn btn-primary btn-sm">
                            <i class="fa fa-trash"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script>
    $(document).ready(function () {
        $('#expiries').DataTable();
    });
</script>
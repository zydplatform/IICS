<%-- 
    Document   : capturedStock
    Created on : Apr 10, 2018, 9:59:58 AM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<div class="col-sm-12 col-md-12">
    <table class="table table-hover table-bordered" id="captured">
        <thead>
            <tr>
                <th>No.</th>
                <th>Item</th>
                <th>Item Specification</th>
                <th class="center">Remove</th>
            </tr>
        </thead>
        <tbody id="bodyItems">
            <% int k = 1;%>
            <c:forEach items="${items}" var="item">
                <tr id="itemRow${item.id}">
                    <td><%=k++%></td>
                    <td>${item.name}</td>
                    <td>${item.specification}</td>
                    <td class="center">
                        <button onclick="deleteNewCatItem(${item.id}, '${item.name}')" data-id="${item.id}" data-name="${item.name}" title="Delete Item" class="btn btn-primary btn-sm">
                            <i class="fa fa-remove"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script>
    $('#captured').dataTable();
</script>
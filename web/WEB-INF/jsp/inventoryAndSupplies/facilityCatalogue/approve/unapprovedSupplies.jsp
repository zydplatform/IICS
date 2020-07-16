<%-- 
    Document   : unapprovedItems
    Created on : Apr 30, 2018, 3:28:28 PM
    Author     : IICS
--%>

<%@include file="../../../include.jsp" %>
<fieldset>
    <div class="row">
        <div class="col-sm-12 col-md-12">
            <table class="table table-hover table-bordered" id="unapproved">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Item</th>
                        <th>Item Specification</th>
                        <th class="center">Manage</th>
                    </tr>
                </thead>
                <tbody id="bodyItems">
                    <% int k = 1;%>
                    <c:forEach items="${items}" var="item">
                        <tr id="approveItemRow${item.id}">
                            <td><%=k++%></td>
                            <td>${item.name}</td>
                            <td>${item.specification}</td>
                            <td class="center">
                                <button onclick="deleteCatItem(${item.id}, '${item.name}')" title="Delete Item" class="btn btn-danger btn-sm">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                                <button onclick="approveItem(${item.id}, '${item.name}')" title="Approve Item" class="btn btn-primary btn-sm">
                                    <i class="fa fa-check"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</fieldset>
<script>
    $('#unapproved').dataTable();
</script>

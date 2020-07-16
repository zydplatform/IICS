<%-- 
    Document   : approvedItems
    Created on : 07-May-2018, 15:03:08
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<fieldset>
    <table class="table table-hover table-bordered" id="approvedItems">
        <thead>
            <tr>
                <th>No</th>
                <th>Item</th>
                <th>Item Strength</th>
                <th>Item Form</th>
                <th class="center">Activation</th>
            </tr>
        </thead>
        <tbody id="bodyItems">
            <% int k = 1;%>
            <c:forEach items="${items}" var="item">
                <tr>
                    <td><%=k++%></td>
                    <td>${item.name}</td>
                    <td>${item.strength}</td>
                    <td>${item.form}</td>
                    <td class="center" id="switch${item.id}content">
                        <label class="switch">
                            <input id="swith${item.id}Value" type="checkbox" ${item.active}>
                            <span onclick="catItemStatus(${item.id}, '${item.name}', '${item.active}')" class="slider round"></span>
                        </label>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</fieldset>
<script>
    $('#approvedItems').dataTable();
</script>
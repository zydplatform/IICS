<%-- 
    Document   : shelfItems
    Created on : Apr 19, 2018, 12:52:04 PM
    Author     : IICS
--%>
<%@include file="../../../include.jsp" %>
<fieldset>
    <!--<div class="col-sm-12 col-md-12">-->
        <table class="table table-hover table-bordered" id="catalogueItems">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Item</th>
                    <th>Item Strength</th>
                    <th class="center">Item Form</th>
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
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    <!--</div>-->
</fieldset>
<script>
    $('#catalogueItems').dataTable();
</script>
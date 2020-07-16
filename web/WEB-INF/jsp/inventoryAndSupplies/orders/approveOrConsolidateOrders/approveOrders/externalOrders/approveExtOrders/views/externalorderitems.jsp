<%-- 
    Document   : externalorderitems
    Created on : Aug 7, 2018, 4:52:16 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../../../include.jsp" %>
<div class="col-md-12">
    <div class="tile">
        <table class="table table-hover table-striped table-cell" id="externalOrdersTables">
            <thead>
                <tr>
                    <th class="center">#</th>
                    <th>Item</th>
                    <th class="center">Quantity Ordered</th>
                </tr>
            </thead>
            <tbody>
                <% int i = 1;%>
                <c:forEach items="${externalItems}" var="i">
                    <tr id="${i.facilityorderid}">
                        <td class="center"><%=i++%></td>
                        <td class="">${i.genericname} ${i.itemstrength}</td>
                        <td class="center">${i.qtyordered}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $('#externalOrdersTables').DataTable();
</script>

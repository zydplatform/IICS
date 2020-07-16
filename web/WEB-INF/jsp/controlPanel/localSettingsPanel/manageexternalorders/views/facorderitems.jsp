<%-- 
    Document   : facorderitems
    Created on : Aug 23, 2018, 10:39:59 AM
    Author     : SAMINUNU
--%>
<%@include file="../../../../include.jsp" %>
<div class="col-md-12">
    <div class="tile">
        <table class="table table-hover table-striped" id="externalItemOrdersTables">
            <thead>
                <tr>
                    <th class="center">#</th>
                    <th>Item</th>
                </tr>
            </thead>
            <tbody>
                <% int i = 1;%>
                <c:forEach items="${externalFacOrderItems}" var="g">
                    <tr id="${g.itemid}">
                        <td class="center"><%=i++%></td>
                        <td class="">${g.genericname} ${g.itemstrength}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $('#externalItemOrdersTables').DataTable();
</script>

<%-- 
    Document   : blockfloors
    Created on : Sep 24, 2018, 3:18:40 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<fieldset>
    <table class="table table-hover table-bordered" id="filteredFloorTable">
        <thead>
            <tr>
                <th class="center">No.</th>
                <th class="center">Floor Name</th>
                <th class="center">Edit Floor</th>
            </tr>
        </thead>
        <tbody>
            <% int n = 1;%>
            <% int d = 1;%>
            <% int b = 1;%>
            <% int t = 1;%>
            <c:forEach items="${viewFloorsLists}" var="v">
                <tr id="${v.blockfloorid}">
                    <td class="center"><%=n++%></td>
                    <td class="center">${v.floorname}</td>
                    <td class="center">
                        <a href="#!" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit" onclick="editrmname(this.id);" id="editbld<%=b++%>"><i class="fa fa-edit"></i></a>
                    </td>
                </tr> 
            </c:forEach>
        </tbody>
    </table>
</fieldset>
<script>
    $('#filteredFloorTable').DataTable();
</script>
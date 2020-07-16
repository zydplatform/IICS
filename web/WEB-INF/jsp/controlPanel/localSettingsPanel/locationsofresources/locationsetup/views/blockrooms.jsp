<%-- 
    Document   : blockrooms
    Created on : Sep 24, 2018, 4:03:08 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<fieldset>
    <c:if test="${not empty viewRoomLists}">
        <table class="table table-hover table-bordered" id="filteredBlockRoomTable">
            <thead>
                <tr>
                    <th class="center">No.</th>
                    <th class="center">Room Name</th>
                    <th class="center">Edit Room</th>
                </tr>
            </thead>
            <tbody>
                <% int n = 1;%>
                <% int d = 1;%>
                <% int b = 1;%>
                <% int t = 1;%>
                <c:forEach items="${viewRoomLists}" var="r">
                    <tr id="${r.blockroomid}">
                        <td class="center"><%=n++%></td>
                        <td class="center">${r.roomname}</td>
                        <td class="center">
                            <a href="#!" class="btn btn-xs btn-teal tooltips" data-placement="top" data-original-title="Edit" onclick="editrmname(this.id);" id="editbld<%=b++%>"><i class="fa fa-edit"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty viewRoomLists}">
        <div class="row">
            <div class="col-md-12">
                <b class="center"><strong><font size="4"><b>HAS NO ROOMS </b></font></strong></b>
            </div>
        </div>
    </c:if>
</fieldset>
<script>
    $('#filteredBlockRoomTable').DataTable();
</script>

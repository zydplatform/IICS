<%-- 
    Document   : assignedrooms
    Created on : Aug 2, 2018, 12:54:19 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <table class="table table-hover table-striped" id="assignedRoomTable">
                <thead>
                    <tr>
                        <th class="center">#</th>
                        <th class="center">Block</th>
                        <th class="center">Floor</th>
                        <th class="center">Room</th>
                    </tr>
                </thead>
                <tbody>
                    <% int u = 1;%>
                    <% int j = 1;%>
                <c:forEach items="${locationLists}" var="a">
                    <tr id="${a.blockroomid}">
                        <td class="center"><%=u++%></td>
                        <td>${a.blockname}</td>
                        <td>${a.floorname}</td>
                        <td>${a.roomname}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>

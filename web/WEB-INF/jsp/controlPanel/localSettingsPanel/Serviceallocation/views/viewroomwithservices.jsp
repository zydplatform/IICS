<%-- 
    Document   : viewroomwithservices
    Created on : Jul 31, 2018, 12:42:26 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<div class="tile">
    <div class="tile-body">
        <table class="table table-hover table-bordered col-md-12" id="prescriptionlist">
            <thead class="col-md-12">
                <tr>
                    <th class="center">No</th>
                    <th>Room</th>
                    <th>Floor</th>
                    <th>Block</th>
                    <th>Building</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="tableFacilityOwner">
                <% int m = 1;%>
                <c:forEach items="${servicerooms}" var="room">
                    <tr>
                        <td><%=m++%></td>
                        <td>${room.roomname}</td>
                        <td>${room.floorname}</td>
                        <td>${room.blockname}</td>
                        <td>${room.buildingname}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $('#prescriptionlist').DataTable();
</script>
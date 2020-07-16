<%-- 
    Document   : batchdetails
    Created on : Aug 20, 2018, 9:13:53 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<!DOCTYPE html>
<div class="tile">
    <div class="tile-body">
        <table class="table table-hover table-bordered col-md-12" id="batchestable">
            <thead class="col-md-12">
                <tr>
                    <th>No</th>
                    <th>Batch Number</th>
                    <th>Days to expire</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="tableFacilityOwner">
                <% int m = 1;%>
                <c:forEach items="${batcheslist}" var="data">
                    <tr>
                        <td><%=m++%></td>
                        <td>${data.batchnumber}</td>
                        <td class="center">
                            <c:if test="${data.daystoexpire <= 0}">
                                <font color="red">Expired</font>
                            </c:if>
                            <c:if test="${data.daystoexpire > 0}">
                                ${data.daystoexpire}
                            </c:if>
                            
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#batchestable').DataTable();
    });
</script>
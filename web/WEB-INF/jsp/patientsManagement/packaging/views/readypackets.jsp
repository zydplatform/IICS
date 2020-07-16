<%-- 
    Document   : readypackets
    Created on : Sep 18, 2018, 2:22:55 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<table class="table table-hover table-bordered col-md-12" id="readypacketstable">
    <thead class="col-md-12">
        <tr>
            <th>No</th>
            <th>Reference Number</th>
            <th>Quantity</th>
            <th>Batch Number</th>
        </tr>
    </thead>
    <tbody class="col-md-12" id="tableFacilityOwner">
        <% int m = 1;%>
        <c:forEach items="${packetpacking}" var="data">
            
                <tr>
                    <td><%=m++%></td>
                    <td>${data.referencenumber}</td>
                    <td>${data.eachpacket}</td>
                    <th>${data.batchnumber}</th>
                </tr>
            <c:if test="${data.eachpacket==0}">
                
            </c:if>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#readypacketstable').DataTable();
</script>
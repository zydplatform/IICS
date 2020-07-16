<%-- 
    Document   : poststatisticstable
    Created on : Aug 14, 2019, 3:47:21 PM
    Author     : USER 1
--%>
<%@include file="../../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<table class="table table-hover table-bordered col-md-12" id="sampleTables">
    <thead>
        <tr>
            <th>No.</th>
            <th>Facility</th>
            <th>Filled</th>
        </tr>
    </thead>
    <tbody class="col-md-12" id="domaindesignation">
        <% int p = 1;%>
    <c:forEach items="${postlist}" var="ad">
        <tr id="">
            <td><%=p++%></td>
            <td>${ad.facilityname}</td>
            <td>
        <c:if test="${ad.requiredstaff == 0}">
            <a data-container="body" data-trigger="hover" data-toggle="popover" data-placement="top" href="#!" class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: red; color: white">
                <span>${ad.filledposts}</span> of
                <span>${requiredstaff}</span>
            </a>
        </c:if>
        <c:if test="${ad.filledposts > 0}">
            <a>
                <button class="btn btn-secondary btn-small center" style="border-radius: 50%; background-color: green;" id="editUniversalPosts" onclick="" >
                    <span>${ad.filledposts}</span>  of  
                    <span>${requiredstaff}</span>
                </button>
            </a>
        </c:if>
        </td>   
        </tr>
    </c:forEach>
</tbody>
</table>

                <script>
                $('#sampleTables').DataTable();
                </script>                
                

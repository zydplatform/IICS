<%-- 
    Document   : laboratoryRequestTest
    Created on : Oct 1, 2018, 4:31:28 PM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table class="table table-hover table-bordered" id="laboratoryrequestedtestsTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Test Name</th>
            <th>Update</th>
        </tr>
    </thead>
    <tbody >
        <% int j = 1;%>
        <c:forEach items="${testslist}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.testname}</td>
                <td align="center">
                    <button onclick="enterpatientlabtestresults(${a.laboratoryrequesttestid},'${a.testname}');"  title="Enter Lab Test Result" class="btn btn-primary btn-sm add-to-shelf">
                        <i class="fa fa-pencil"></i>
                    </button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#laboratoryrequestedtestsTable').DataTable();
</script>

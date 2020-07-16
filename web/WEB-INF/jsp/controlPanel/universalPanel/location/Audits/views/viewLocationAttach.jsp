<%-- 
    Document   : viewLocationAttach
    Created on : Aug 1, 2018, 12:05:19 PM
    Author     : user
--%>

<%@include file="../../../../../include.jsp"%>
<style>
    .error
    {
        border:2px solid red;
    }
</style>
<table class="table table-hover table-bordered col-md-12" id="auditsTable">
    <thead>
        <tr>
            <th class="center">No</th>
            <th>${model.category} Name</th>
      

        </tr>
    </thead>
    <tbody class="col-md-12" id="auditsTable">
        <% int c = 1;%>
        <% int bt = 1;%>
        <% int j = 1;%>
    <tbody id="tableAudits">
        <c:forEach items="${model.auditList}" var="list"  varStatus="status">
            <tr id="${list.audit}}">
                <td><%=c++%></td>
                <td>${list[1]}</td>
              </tr>
        </c:forEach>
    </tbody>
</table>
<%-- 
    Document   : dutiesLocalTable
    Created on : Aug 5, 2019, 10:14:58 AM
    Author     : USER 1
--%>

<%@include file="../../../../include.jsp"%>
<div id="config_table">

<div >
    <table class="table table-hover  col-md-12" id="sampleTables">
        <thead>
            <tr>
                <th>No.</th>
                <th>Duties and responsibilities</th>
            </tr>
        </thead>
        <tbody class="col-md-12" id="domaindesignation">
            <% int q = 1;%>
            <c:forEach items="${dutieslist}" var="ac">
                <tr id="">
                    <td><%=q++%></td>
                    <td id="${ac.designationid}">${ac.duty}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</div>            <script>
                    $('#sampleTables').DataTable();
                  </script>

<%-- 
    Document   : selectedbayrowsListing
    Created on : Jun 1, 2018, 11:16:36 AM
    Author     : user
--%>
<%@include file="../../../../include.jsp" %>
<div>
    <table class="table table-hover table-bordered" id="sampleTable2x">
        <thead>
            <tr>
                <th>No</th>
                <th>Row Label</th>
                <th>Add Cells</th>
            </tr>
        </thead>
        <tbody>
            <% int x = 1;%>
        <c:forEach items="${bayrowList}" var="b">
            <tr id="">
                <td><%=x++%></td>
                <td align="center">${b.rowlabel2}</td>                          
                <td align="center"><button  class="btn btn-secondary" data-id="${b.rowlabel}" id="${b.bayrowid}" onclick="ShowCellscapture(this.id, $(this).attr('data-id'))"><i class="fa fa-fw fa-lg fa-plus-circle"></i></button></td>
            </tr>
        </c:forEach>
        </tbody>
    </table> 
</div>
<script>
 $('#sampleTable2x').DataTable();
</script>

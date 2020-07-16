<%-- 
    Document   : transferCategories
    Created on : Sep 11, 2018, 5:01:26 PM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <div class="row">
            <div class="col-md-2">
                <label class="control-label">Transfer To</label>
            </div>
            <div class="col-md-8">
                <div class="form-group">
                    <select class="form-control">
                        <option>---select----</option>
                        <c:forEach items="${categoryFound}" var="b">
                            <option value="${b.itemclassificationid}">${b.classificationname}</option> 
                        </c:forEach>
                    </select>
                </div>  
            </div>
            <div class="col-md-2"></div>
        </div><br>

        <table class="table table-hover table-bordered" id="transferClassificationCategory">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Category Name</th>
                    <th>Select</th>
                </tr>
            </thead>
            <tbody >
                <% int j = 1;%>
                <% int p = 1;%>
                <% int k = 1;%>
                <c:forEach items="${categorysFound}" var="a">
                    <tr>
                        <td><%=j++%></td>
                        <td>${a.classificationname}</td>
                        <td align="center">
                            <input type="checkbox" value="${a.itemclassificationid}" onchange="if (this.checked) {
                                        addTransferCategory(this.value, 'checked');
                                    } else {
                                        addTransferCategory(this.value, 'unchecked');
                                    }">
                        </td>                                                  
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </fieldset>
</div>
<script>
    $('#transferClassificationCategory').DataTable();
    var transferCategory = new Set();
    function addTransferCategory(itemclassificationid, type) {
        if (type === 'checked') {
            transferCategory.add(itemclassificationid);
        } else {
            transferCategory.delete(itemclassificationid);
        }
    }
</script>
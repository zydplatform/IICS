<%-- 
    Document   : existingClassification
    Created on : Aug 8, 2018, 4:42:17 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <table class="table table-hover table-bordered" id="sampleClassificationsTable">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Classification</th>
                    <th>Select</th>
                </tr>
            </thead>
            <tbody >
                <% int p = 1;%>
                <c:forEach items="${classificationsFound}" var="a">
                    <tr>
                        <td><%=p++%></td>
                        <td>${a.classificationname}</td>
                        <td align="center"><input type="checkbox" value="${a.itemclassificationid}" onchange="if (this.checked) {
                                    checkedOrUnCheckedClassifications(this.value, 'checked');
                                } else {
                                    checkedOrUnCheckedClassifications(this.value, 'unchecked');
                                }"></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </fieldset>
</div>
<script>
    $('#sampleClassificationsTable').DataTable();
    var selecteditemclassificationid = new Set();
    function checkedOrUnCheckedClassifications(itemclassificationid, type) {
        if (type === 'checked') {
            selecteditemclassificationid.add(itemclassificationid);
        } else {
            selecteditemclassificationid.delete(itemclassificationid);
        }
    }
</script>
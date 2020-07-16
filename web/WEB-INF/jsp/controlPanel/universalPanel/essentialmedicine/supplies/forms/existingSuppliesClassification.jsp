<%-- 
    Document   : existingSuppliesClassification
    Created on : Aug 9, 2018, 5:07:07 PM
    Author     : IICS
--%>

<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div style="margin: 10px;">
    <fieldset style="min-height:100px;">
        <table class="table table-hover table-bordered" id="sampleSuppliesClassificationsTable">
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
                                    checkedOrUnCheckedSupClassifications(this.value, 'checked');
                                } else {
                                    checkedOrUnCheckedSupClassifications(this.value, 'unchecked');
                                }"></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </fieldset>
</div>
<script>
    $('#sampleSuppliesClassificationsTable').DataTable();
    var suppliesClassifications = new Set();
    function checkedOrUnCheckedSupClassifications(itemclassificationid, type) {
        if (type === 'checked') {
            suppliesClassifications.add(itemclassificationid);
        } else {
            suppliesClassifications.delete(itemclassificationid);
        }
    }
</script>

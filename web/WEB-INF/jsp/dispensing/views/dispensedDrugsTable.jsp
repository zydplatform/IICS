<%-- 
    Document   : dispensedDrugsTable
    Created on : Oct 15, 2018, 7:55:13 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../include.jsp" %>
<div class="tile">
    <div class="tile-body">
        <table class="table table-hover table-bordered col-md-12" id="table-view-items-dispensed">
            <thead class="col-md-12">
                <tr>
                    <th class="center">No</th>
                    <th>Item</th>
                    <th class="right">Quantity Issued</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="">
                <% int v = 1;%>
                <c:forEach items="${dispensingRecordList}" var="item">
                    <tr>
                        <td class="center"><%=v++%></td>
                        <td class="">${item.itempackagename}</td>
                        <td class="right">${item.quantityissued}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    $('#table-view-items-dispensed').DataTable();
</script>
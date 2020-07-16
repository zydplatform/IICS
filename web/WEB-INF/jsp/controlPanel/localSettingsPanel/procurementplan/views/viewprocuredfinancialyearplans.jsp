<%-- 
    Document   : viewprocuredfinancialyearplans
    Created on : May 7, 2018, 6:56:39 AM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp" %>
<table class="table table-hover table-bordered" id="procured_facilityunit_yrs">
    <thead>
        <tr>
            <th>No</th>
            <th>Procurement Plan</th>
            <th>Items</th>
            <th>Start Date</th>
            <th>End Date</th>
        </tr>
    </thead>
    <tbody >
        <% int j = 1;%>
        <% int i = 1;%>
        <c:forEach items="${procurementPlansFound}" var="a">
            <tr id="${a.facilityunitfinancialyearid}">
                <td><%=j++%></td>
                <td>${a.facilityunitlabel}</td>
                <td align="center">
                    <button onclick="viewfinancialyeardetailsitemsview(${a.facilityunitfinancialyearid},'${a.orderperiodtype}');"  title=" The Procurement Plan Items(s)." class="btn btn-secondary btn-sm add-to-shelf">
                        ${a.financialyunitritemsRowcount} Items(s)
                    </button>
                </td>
                <td>
                    ${a.startdate} 
                </td>
                <td>
                    ${a.enddate} 
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
        <script>
            $('#procured_facilityunit_yrs').DataTable();
        </script>

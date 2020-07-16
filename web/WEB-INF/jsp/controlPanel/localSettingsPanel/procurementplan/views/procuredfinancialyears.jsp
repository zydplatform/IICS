<%-- 
    Document   : procuredfinancialyears
    Created on : Apr 10, 2018, 10:11:46 AM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<table class="table table-hover table-bordered" id="procuredfyrs">
    <thead>
        <tr>
            <th>No</th>
            <th>Financial Year</th>
            <th>Procurement plans</th>
            <th>Details</th>
        </tr>
    </thead>
    <tbody id="tableFacilityOwner">
        <% int j = 1;%>
        <% int i = 1;%>
        <c:forEach items="${procurementplanlist}" var="a">
            <tr id="${a.facilityfinancialyearid}">
                <td><%=j++%></td>
                <td>${a.procurementplan}</td>
                <td align="center">
                    <button onclick="viewprocuredfinancialyeardetails(${a.facilityfinancialyearid})"  title=" The Procurement Plan(s)." class="btn btn-secondary btn-sm add-to-shelf">
                       ${a.financialyrprocurementsRowcount} plan(s)
                    </button>
                </td>
                <td align="center">
                    <button onclick=""  title=" The Procurement Plan(s)." class="btn btn-secondary btn-sm add-to-shelf">
                         <i class="fa fa-dedent"></i>
                    </button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<%-- 
    Document   : facilityUnitDetails
    Created on : May 21, 2018, 4:46:45 AM
    Author     : IICS-GRACE
--%>

<%@include file="../../../../include.jsp"%>

<c:forEach items="${facilityunitdetails}" var="a">
    <div><label class="text-muted">Facility Unit Name : </label><label><strong> ${a.facilityunitname}</strong></label></div>
    <div><label class="text-muted">Short Name : </label><label><strong> ${a.shortname}</strong></label></div>
    <div><label class="text-muted">Description : </label><label><strong> ${a.description}</strong></label></div>
</c:forEach>
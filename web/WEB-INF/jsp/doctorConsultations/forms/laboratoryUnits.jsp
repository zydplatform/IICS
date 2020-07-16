<%-- 
    Document   : laboratoryUnits
    Created on : Sep 25, 2018, 6:06:42 PM
    Author     : HP
--%>

<%@include file="../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="form-group">
    <label>Select Laboratory Unit</label>
    <select  class="form-control" required id="facilityLaboratoryunitid">
        <c:forEach items="${labunitsFound}" var="c">
            <option id="lab${c.facilityunitid}" value="${c.facilityunitid}">${c.facilityunitname}</option>   
        </c:forEach>
    </select>
</div>
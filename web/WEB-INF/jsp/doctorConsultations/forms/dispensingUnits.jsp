<%-- 
    Document   : dispensingUnits
    Created on : Sep 6, 2018, 7:26:42 AM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="form-group">
    <label>Select Dispensing Unit</label>
    <select  class="form-control" required id="facilitydispensingunitid">
        <c:if test="${type=='null'}"> <option  value="select">-----Select-------</option> </c:if>
        <c:if test="${type=='notnull'}">
            <option id="dispensing${facilityunitid}" value="${facilityunitid}" data-facility-unit-service-id="${facilityunitserviceid}">${facilityunitname}</option>    
        </c:if>
        <c:forEach items="${dispensingunitsFound}" var="c">
            <option id="dispensing${c.facilityunitid}" value="${c.facilityunitid}" data-facility-unit-service-id="${c.facilityunitserviceid}">${c.facilityunitname}</option>   
        </c:forEach>
    </select>
</div>

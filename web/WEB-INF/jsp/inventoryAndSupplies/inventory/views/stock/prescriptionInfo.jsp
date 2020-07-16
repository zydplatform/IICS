<%-- 
    Document   : prescriptionInfo
    Created on : Jul 4, 2019, 10:02:25 AM
    Author     : IICS TECHS
--%>

<%@include file="../../../../include.jsp"%>

<div class="row">
    <div class="col-md-12">
        <span><b>Patient</b></span>
        <span class="form-control"><c:if test="${patientname == ''}">Not Available</c:if> <c:if test="${patientname != ''}">${patientname}</c:if></span>
        <hr />
        <span><b>Prescriber</b></span>
        <span class="form-control"><c:if test="${prescribername == ''}">Not Available</c:if> <c:if test="${prescribername != ''}">${prescribername}</c:if></span>
    </div>
</div>
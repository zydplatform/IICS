<%-- 
    Document   : staffinfo
    Created on : Sep 3, 2018, 8:56:16 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<div class="form-group bs-component">
    <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Staff Number:</strong></span>&nbsp;
    <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${staffno}</strong></span>
</div>
<c:if test="${empty primaryphonecontact}">

</c:if>
<c:if test="${not empty primaryphonecontact}">
    <div class="form-group bs-component">
        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Primary Contact:</strong></span>&nbsp;
        <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${primaryphonecontact}</strong></span>
    </div>
</c:if>
<c:if test="${empty secondaryphonecontact}">

</c:if>
<c:if test="${not empty secondaryphonecontact}">
    <div class="form-group bs-component">
        <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Secondary Contact:</strong></span>&nbsp;
        <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${secondaryphonecontact}</strong></span>
    </div>
</c:if>

<div class="form-group bs-component">
    <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Email Address:</strong></span>&nbsp;
    <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${email}</strong></span>
</div>

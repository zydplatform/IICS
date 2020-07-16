<%-- 
    Document   : clientDetails
    Created on : Sep 7, 2018, 4:30:00 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<fieldset>
    <div><label class="text-muted">Client/Facility Name:</label> <label><strong> ${facilityDetails.facilityname}</strong></label></div>
    <div><label class="text-muted">Level:</label> <label><strong> ${facilityDetails.levelname}</strong></label></div>
    <div><label class="text-muted">Owner:</label> <label><strong> ${facilityDetails.ownername}</strong></label></div>
    <div><label class="text-muted">Phone Contacts:</label> <label><strong> ${facilityDetails.phonecontact} ${facilityDetails.phonecontact2}</strong></label></div>
    <div><label class="text-muted">Email Address:</label> <label><strong> ${facilityDetails.emailaddress}</strong></label></div>
    <div><label class="text-darken-3">Location</label></div>
    <div><label class="text-muted">Region Name:</label> <label><strong> ${facilityDetails.regionname}</strong></label></div>
    <div><label class="text-muted">District Name:</label> <label><strong> ${facilityDetails.districtname}</strong></label></div>
    <div><label class="text-muted">County Name:</label> <label><strong> ${facilityDetails.countyname}</strong></label></div>
    <div><label class="text-muted">Village Name:</label> <label><strong> ${facilityDetails.villagename}</strong></label></div>
</fieldset>
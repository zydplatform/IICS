<%-- 
    Document   : pausedPrescriptions
    Created on : Apr 16, 2019, 2:12:07 PM
    Author     : IICS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@include file="../../include.jsp"%>

<div class="row">
    <div class="col-md-12">
        <table id="paused-prescriptions-table" class="table table-bordred">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Name</th>
                    <th>Visit No.</th>
                    <th>Paused By</th>
                    <th>Paused</th>
                    <th>Retrieve</th>
                </tr>
            </thead>
            <tbody>
                <% int r = 1;%>
                <c:forEach items="${prescriptions}" var="prescription">
                    <tr>
                        <td><%= r++ %></td>
                        <td>${prescription.patientname}</td>
                        <td>${prescription.visitnumber}</td>
                        <td>${prescription.pausedBy}</td>
                        <td>${prescription.pausedfor}</td>
                        <td><button class="retrieve-prescription-btn btn btn-sm btn-primary" 
                                    data-patient-visit-id="${prescription.patientvisitid}"
                                    data-prescription-id="${prescription.prescriptionid}"
                                    data-pause-stage="${prescription.pausestage}"> <i class="fa fa-eye" style="font-size: larger;"></i></button></td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot></tfoot>
        </table>
    </div>
</div>
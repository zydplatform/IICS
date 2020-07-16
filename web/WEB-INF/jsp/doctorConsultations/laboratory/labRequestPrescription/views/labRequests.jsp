<%-- 
    Document   : labRequests
    Created on : Oct 26, 2018, 10:41:41 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<div class="row">
    <div class="col-md-4">
        <div class="form-group bs-component">
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Request Number:</strong></span>&nbsp;
            <strong >
                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${laboratoryrequestnumber}</strong></span>
            </strong>
        </div> 
    </div>
    <div class="col-md-4">
        <div class="form-group bs-component">
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Laboratory Unit:</strong></span>&nbsp;
            <strong >
                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${facilityunitname}</strong></span>
            </strong>
        </div>   
    </div>
    <div class="col-md-4">
        <div class="form-group bs-component">
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Requested By:</strong></span>&nbsp;
            <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${addedby}</strong></span>
        </div> 
    </div>
</div>
<hr>
<div class="row">
    <div class="col-md-12">
        <div id="laboratoryrequestedtestsdiv">
            <table class="table table-hover table-bordered" id="laboratoryrequettestsTable">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Test Name</th>
                        <th>Specimen</th>
                        <th>Tested</th>
                    </tr>
                </thead>
                <tbody >
                    <% int j = 1;%>
                    <c:forEach items="${labtestsFound}" var="a">
                        <tr>
                            <td><%=j++%></td>
                            <td>${a.testname}</td>
                            <td>${a.classification}</td>
                            <td align="center"><img src="static/images/noaccesssmall.png"></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div> 
</div>
<script>
    $('#laboratoryrequettestsTable').DataTable();
</script>
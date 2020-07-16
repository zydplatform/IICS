<%-- 
    Document   : labTestResults
    Created on : Oct 6, 2018, 7:12:54 PM
    Author     : HP
--%>
<div class="row">
    <div class="col-md-4">
        <div class="form-group bs-component">
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Request Number:</strong></span>&nbsp;
            <strong >
                <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${laboratoryrequestnumber}</strong></span>
            </strong>
        </div> 
        <div class="form-group bs-component">
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Date:</strong></span>&nbsp;
            <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${date}</strong></span>
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
            <span class="control-label pat-form-heading patientConfirmFont" for="firstname2"><strong>Collected By:</strong></span>&nbsp;
            <span class="badge badge-patientinfo patientConfirmFont"><strong class="fname">${servicedby}</strong></span>
        </div> 
    </div>
</div>
<hr>
<div class="row">
    <div class="col-md-12">
        <div id="laboratoryrequestedtestsdiv">
            <table class="table table-hover table-bordered" id="laboratoryresultstestsTable">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Test Name</th>
                        <th>Results</th>
                        <th>Units</th>
                        <th>Normal</th>
                    </tr>
                </thead>
                <tbody >
                    <% int j = 1;%>
                <c:forEach items="${labpatienttestsList}" var="a">
                    <tr>
                        <td><%=j++%></td>
                        <td>${a.testname}</td>
                        <td>${a.testresult}</td>
                        <td></td>
                        <td></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div> 
</div>

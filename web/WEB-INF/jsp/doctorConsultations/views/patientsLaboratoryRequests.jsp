<%-- 
    Document   : patientsLaboratoryRequests
    Created on : Oct 5, 2018, 11:42:48 AM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<fieldset>
    <table  class="table table-hover table-bordered" id="patientsLaboratoryRequestsTable">
        <thead>
            <tr>
                <th>No</th>
                <th>Patient Number</th>
                <th>Patient Name</th>
                <th>Visit Number</th>
                <th>Laboratory Request No.</th>
                <th>Laboratory Test(s)</th>
                <th>Laboratory Unit</th>
            </tr>
        </thead>
        <tbody>
            <% int j = 1;%>
            <c:forEach items="${laboratoryrequestsList}" var="a">
                <tr>
                    <td><%=j++%></td>
                    <td><a class="order-items-process" onclick="prescribeforpatientfromlab(${a.patientid},${a.patientvisitid},${a.visitnumber});"><font color="blue"><strong>${a.patientno}</strong></font></a></td>
                    <td>${a.patientname}</td>
                    <td>${a.visitnumber}</td>
                    <td>${a.laboratoryrequestnumber}</td>
                    <td align="center"><span class="badge badge-info icon-custom" onclick="viewPatientLabReqTests(${a.laboratoryrequestid});">${a.labrequestscount}</span></td>
                    <td>${a.facilityunitname}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>    
</fieldset>
<script>
    $('#patientsLaboratoryRequestsTable').DataTable();
    function viewPatientLabReqTests(laboratoryrequestid) {
        $.ajax({
            type: 'GET',
            data: {laboratoryrequestid: laboratoryrequestid},
            url: "doctorconsultation/viewpatientslabreqtests.htm",
            success: function (response) {
                $.confirm({
                    title: 'PATIENT LABORATORY REQUEST TEST(S)',
                    content: '' + response,
                    closeIcon: true,
                    type: 'purple',
                    boxWidth: '50%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        close: function () {

                        }
                    }
                });
            }
        });
    }
    function prescribeforpatientfromlab(patientid,patientvisitid,visitnumber){
         $.ajax({
            type: 'GET',
            data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber},
            url: "doctorconsultation/labpatientdetails.htm",
            success: function (repos) {
                ajaxSubmitData('triage/getPatientMedicalIssues.htm', 'labpatientIssuesAndAllergiesDiv', 'patientid=' + patientid + '&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                $('#patientstolaboratorysdiv').html(repos);
            }
        });
    }
</script>

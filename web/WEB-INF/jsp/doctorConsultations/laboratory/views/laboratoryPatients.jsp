<%-- 
    Document   : laboratoryPatients
    Created on : Oct 6, 2018, 9:00:01 AM
    Author     : HP
--%>

<%@include file="../../../include.jsp" %>
<table  class="table table-hover table-bordered" id="patientsLaboratoryTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Request Number</th>
            <th>Patient Visit No</th>
            <th>Patient Number</th>
            <th>Patient Name</th>
            <th>Laboratory Tests</th>
            <th>Laboratory Unit</th>
            <th>Collected By</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <c:forEach items="${labpatientsList}" var="a">
            <tr>
                <td><%=j++%></td>
                <td><a class="patient icon-custom" onclick="prescribelaboratorypatients(${a.patientvisitid},${a.patientid},${a.laboratoryrequestid}, '${a.visitnumber}', '${a.facilityunitname}', '${a.servicedby}', '${a.laboratoryrequestnumber}');"><font color="blue"><strong>${a.laboratoryrequestnumber}</strong></font></a></td>
                <td>${a.visitnumber}</td>
                <td>${a.patientno}</td>
                <td>${a.patientname}</td>
                <td align="center"><span class="badge badge-info icon-custom" onclick="viewpatientRequestedTests(${a.laboratoryrequestid});">${a.labrequestscount}</span></td>
                <td>${a.facilityunitname}</td>
                <td>${a.servicedby}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#patientsLaboratoryTable').DataTable();
    function viewpatientRequestedTests(laboratoryrequestid) {
        $.ajax({
            type: 'GET',
            url: "doctorconsultation/viewpatientslabreqtests.htm",
            data: {laboratoryrequestid: laboratoryrequestid},
            success: function (data) {
                $.confirm({
                    title: 'PATIENT REQUESTED LAB TESTS',
                    content: '' + data,
                    type: 'purple',
                    closeIcon: true,
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
    function prescribelaboratorypatients(patientvisitid, patientid, laboratoryrequestid, visitnumber, facilityunitname, servicedby, laboratoryrequestnumber) {
        $.ajax({
            type: 'GET',
            data: {patientid: patientid, patientvisitid: patientvisitid, visitnumber: visitnumber, laboratoryrequestid: laboratoryrequestid, facilityunitname: facilityunitname, servicedby: servicedby, laboratoryrequestnumber: laboratoryrequestnumber},
            url: "doctorconsultation/patientfromlaboratorydetails.htm",
            success: function (repos) {
                $('#laboratorylabpatientsdiv').html(repos);
            }
        });
    }
</script>

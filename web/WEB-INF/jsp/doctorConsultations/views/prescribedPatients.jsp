<%-- 
    Document   : prescribedPatients
    Created on : Oct 5, 2018, 2:25:41 PM
    Author     : HP
--%>

<%@include file="../../include.jsp" %>
<table  class="table table-hover table-bordered" id="patientsprescribedTable" style="width: 100% !important;">
    <thead>
        <tr>
            <th>No</th>
            <th>Patient Number</th>
            <th>Patient Name</th>
            <th>Visit Number</th>
            <!---->
<!--            <th>Prescribed Drug(s)</th>-->
            <th>Prescribed Medicine(s)</th>
            <td>Dispensary Unit</td>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <c:forEach items="${prescribedpatientsList}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.patientno}</td>
                <td>${a.patientname}</td>
                <td>${a.visitnumber}</td>
                <td align="center"><span class="badge badge-info icon-custom" onclick="viewPatientPrescribedDrugs(${a.prescriptionid});">${a.prescriptionsitemscount}</span></td>
                <td>${a.facilityunitname}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#patientsprescribedTable').DataTable();
    function viewPatientPrescribedDrugs(prescriptionid) {
        $.ajax({
            type: 'GET',
            data: {prescriptionid:prescriptionid},
            url: "doctorconsultation/viewPrescribeddrugs.htm",
            success: function (response) {
                $.confirm({
                    title: 'PRESCRIBED MEDICINE',
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
</script>
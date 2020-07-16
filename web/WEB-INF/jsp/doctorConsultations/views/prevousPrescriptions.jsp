<%-- 
    Document   : prevousPrescriptions
    Created on : Sep 21, 2018, 3:43:25 PM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<hr>
<table  class="table table-hover table-bordered" id="previousPrescriptionsTable">
    <thead>
        <tr>
            <th>No</th>
            <th>Facility</th>
            <th>Visit Number</th>
            <!---->
<!--            <th>Drugs(s)</th>-->
            <th>Medicine(s)</th>
            <th>Date Prescribed</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <c:forEach items="${prescriptionsFound}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.facilityname}</td>
                <td>${a.visitnumber}</td>
                <td align="center"><span class="badge badge-info icon-custom" onclick="viewPrescribeddrugs(${a.prescriptionid});">${a.prescriptionitemsCount}</span></td>
                <td>${a.dateprescribed}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#previousPrescriptionsTable').DataTable();
    function viewPrescribeddrugs(prescriptionid) {
        $.ajax({
            type: 'GET',
            data: {prescriptionid: prescriptionid},
            url: "doctorconsultation/viewPrescribeddrugs.htm",
            success: function (data) {
                $.confirm({
                    title: 'PRESCRIBED MEDICINE',
                    content: ''+data,
                    type: 'purple',
                    boxWidth:'60%',
                    useBootstrap:false,
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
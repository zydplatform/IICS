<%-- 
    Document   : previousLaboratoryTests
    Created on : Sep 26, 2018, 4:19:40 PM
    Author     : HP
--%>
<%@include file="../../include.jsp" %>
<table class="table table-hover table-bordered " id="tablePatientsPreviousTests">
    <thead>
        <tr>
            <th>No</th>
            <th>Facility</th>
            <th>Patient Visit No.</th>
            <th>Visit Date</th>
            <th>Lab Request No.</th>
            <th>Lab Request Tests.</th>
            <th>Serviced</th>
        </tr>
    </thead>
    <tbody id="">
        <% int x = 1;%>
        <c:forEach items="${laboratorytestsList}" var="des">
            <tr>
                <td><%=x++%></td>
                <td>${des.facilityname}</td>
                <td>${des.visitnumber}</td>
                <td>${des.dateadded}</td>
                <td>${des.laboratoryrequestnumber}</td>
                <td align="center"><span onclick="viewrequestedlabtest(${des.laboratoryrequestid});" class="badge badge-info icon-custom">${des.count}</span></td>
                <td align="center"><c:if test="${des.status=='SERVICED'}"><img src="static/images/authorisedsmall.png"></c:if> <c:if test="${des.status=='SENT'}"><img src="static/images/noaccesssmall.png"></c:if></td>
                </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#tablePatientsPreviousTests').DataTable();
    function viewrequestedlabtest(laboratoryrequestid) {
        $.ajax({
            type: 'GET',
            data: {laboratoryrequestid: laboratoryrequestid},
            url: "doctorconsultation/viewpatientslabreqtests.htm",
            success: function (data) {
                $.confirm({
                    title: 'LABARATORY REQUEST TESTS',
                    content: ''+data,
                    type: 'purple',
                    boxWidth:'60%',
                    closeIcon:true,
                    useBootstrap:false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Ok',
                            btnClass: 'btn-purple',
                            action: function () {
                                
                            }
                        },
                        close: function () {
                        }
                    }
                });
            }
        });
    }
</script>

<%-- 
    Document   : patientHistory
    Created on : Nov 1, 2018, 7:28:10 AM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<div id="previousPatientHistoryDiv">
    <fieldset>
        <div class="row">
            <div class="col-md-12">
                <div >
                    <table class="table table-hover table-bordered" id="patienthistoryTable">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Visit Number</th>
                                <th>Facility</th>
                                <th>Date</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody >
                            <% int j = 1;%>
                            <c:forEach items="${previoushistoryList}" var="a">
                                <tr>
                                    <td><%=j++%></td>
                                    <td>
                                        <a class="order-items-process"><font color="blue"><strong>${a.visitnumber}</strong></font></a>
                                    </td>
                                    <td>${a.facilityname}</td>
                                    <td>${a.date}</td>
                                    <td align="center">
                                        <button onclick="viewpreviouspatientvisitdetails(${a.patientvisitid},'${a.facilityname}','${a.date}','${a.visitnumber}',${a.facilityid});"  title="Details of this Visit" class="btn btn-primary btn-sm add-to-shelf">
                                            <i class="fa fa-dedent"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div> 
        </div>
    </fieldset>
</div>
<script>
    $('#patienthistoryTable').DataTable();
    function viewpreviouspatientvisitdetails(patientvisitid,facilityname,date,visitnumber,facilityid) {
        $.ajax({
            type: 'GET',
            data: {patientvisitid: patientvisitid,facilityname:facilityname,date:date,visitnumber:visitnumber,facilityid:facilityid},
            url: "doctorconsultation/previouspatientvisit.htm",
            success: function (data) {
                $('#previousPatientHistoryDiv').html(data);
            }
        });
    }
</script>

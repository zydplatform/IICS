<%-- 
    Document   : patientVisits
    Created on : Feb 27, 2019, 11:08:39 AM
    Author     : IICS
--%>

<%@ include file="../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <table id="patient-visit-details" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Name</th>
                    <th>Visit Number</th>
                    <th>Visit Type</th>
                    <th>Visit Priority</th>
                    <th>Registered By</th>
                    <th>Registered On</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${patientVisitDetails}" var="details">
                    <tr>
                        <td></td>
                        <td class="patient-name">
                            ${details.name}
                        </td>
                        <td>${details.visitnumber}</td>
                        <td>
                            <c:if test="${details.visittype == 'NEWVISIT'}">
                                New Visit
                            </c:if>
                            <c:if test="${details.visittype == 'REVISIT'}">
                                Re-visit
                            </c:if>
                        </td>
                        <td><span class="capitalize">${details.visitpriority}</span></td>
                        <td>${details.addedby}</td>
                        <td>${details.dateadded}</td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot></tfoot>
</table>
    </div>
</div>
<script>
    $(function(){
        var table = $('#patient-visit-details').DataTable();
        table.on( 'order.dt search.dt', function () {
            table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
                cell.innerHTML = i+1;
            } );
        } ).draw();
    });
</script>
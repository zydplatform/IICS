<%-- 
    Document   : unResolvedPrescriptions
    Created on : Jun 17, 2019, 9:33:41 AM
    Author     : IICS TECHS
--%>
<%@include file="../../include.jsp" %>

<div class="row">
    <div class="col-md-12">
        <table id="unresolved-prescriptions-table" class="table table-bordered">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Patient</th>
                    <th>Added By</th>
                    <th>Review</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${unresolvedprescriptions}" var="item">
                    <tr>
                        <td></td>
                        <td>${item.patientname}</td>
                        <td>${item.addedby}</td>
                        <td>
                            <button class="btn btn-sm btn-primary fa fa-list-ul review-prescription" 
                                    data-patient-visit-id="${item.patientvisitid}"></button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot></tfoot>
        </table>
    </div>
</div>

<script>
    $(function(){
        if (!$.fn.DataTable.isDataTable('#unresolved-prescriptions-table')) {
            var table = $('#unresolved-prescriptions-table').DataTable({
                "lengthMenu": [5, 10, 25, 50, 100],
                "pageLength": 5
            });
            table.on('order.dt search.dt', function () {
                table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                    cell.innerHTML = i + 1;
                });
            }).draw();
        }
    });
    $('#unresolved-prescriptions-table').on('click', '.review-prescription', function(e){
        var patientVisitId = $(this).data('patient-visit-id');
        navigateTo('view-prescription-items', patientVisitId);
    });
</script>
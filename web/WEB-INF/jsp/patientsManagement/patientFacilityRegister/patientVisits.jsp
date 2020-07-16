<%-- 
    Document   : patientVisits
    Created on : Feb 27, 2019, 1:54:41 PM
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
                    <td>${details.name}</td>
                    <td>${details.visitnumber}</td>
                    <td>
                        <c:if test="${details.visittype == 'NEWVISIT'}">
                            New Visit
                        </c:if>
                        <c:if test="${details.visittype == 'REVISIT'}">
                            Re-visit
                        </c:if>
                    </td>
                    <td>${details.visitpriority}</td>
                    <td><a href="#" class="registerar" style="color: #007bff;" 
                           data-person-id="${details.personid}"
                           data-patient-visit-id="${details.patientvisitid}">
                            ${details.addedby}</a>
                    </td>
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
    $('#patient-visit-details').on('click', 'a.registerar', function(e){
        var personId = $(this).data('person-id');
        var patientvisitid = $(this).data('patient-visit-id');
        $.ajax({
            type: 'GET',
            data: { personid: personId, patientvisitid: patientvisitid },
            url: 'patient/registrardetails.htm',
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    icon: '',
                    title: 'Staff Details',
                    content: '' + data,
                    boxWidth: '35%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    buttons: {
                        OK: {
                            text: 'OK',
                            btnClass: 'btn-purple',
                            action: function () {

                            }
                        }
                    }
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);        
            }
        });
    });
</script>
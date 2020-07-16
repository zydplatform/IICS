<%-- 
    Document   : patients
    Created on : Sep 6, 2018, 6:10:24 PM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<style>
    .modal {
        left: -15%;
    }
    th, td {
        text-align: center;
    }
</style>

<c:choose>
    <c:when test="${patientsTotal == 0}">
        <h3 class="center">No reported Patients on: <font color="blue">${date}</font> </h3>
        </c:when>
        <c:otherwise>
        <div class="col-md-12 right"><h5 class=""> Total: <span class="badge badge-info">${patientsTotal}</span></h5></div>
        <div class="row">
            <div class="col-sm-12 col-md-12">
            <input type="hidden" name="_reportDate" value="${date}" id="_reportDate" />
                <table class="table table-hover table-bordered" id="tableRegisteredPatients">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Names</th>
                            <th>Gender</th>
                            <th>Age</th>
                            <th>Parish</th>
                            <th>Village</th>
                            <c:if test="${patientlist[0].containsKey('visittype') == true}">
                            	<th>Visit Type</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody id="">
                        <% int k = 1;%>
                        <c:forEach items="${patientlist}" var="visit">
                            <tr>
                                <td><%=k++%></td>
                                <td>
                                    <a href="#" class="fetch-patient-visit-details" 
                                       style="color: #007bff;">${visit.names}</a>
                                    <input type="hidden" name="_patientid" value="${visit.patientid}" id="_patientid" />
                                </td>
                                <td>${visit.gender}</td>
                                <td class="">
                                    <c:if test="${visit.age > 0}">
                                        <c:if test="${visit.age >= 365}">
                                            <fmt:parseNumber var="years" integerOnly="true" type="number" value="${visit.age/365}"/>
                                            ${years} Years
                                        </c:if>
                                        <c:if test="${visit.age < 365}">
                                            <c:if test="${visit.age >= 30}">
                                                <fmt:parseNumber var="months" integerOnly="true" type="number" value="${visit.age/30}"/>
                                                ${months} Months
                                            </c:if>
                                            <c:if test="${visit.age < 30}">
                                                <c:if test="${visit.age >= 1}">
                                                    ${visit.age} Days
                                                </c:if>
                                                <c:if test="${visit.age < 1}">
                                                    0 Days
                                                </c:if>
                                            </c:if>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${visit.age < 1}">
                                        0 Days
                                    </c:if>
                                </td>
                                <td>${visit.parish}</td>
                                <td class="">
                                    ${visit.village}
                                </td>
                                <c:if test="${visit.containsKey('visittype') == true}">
	                                <td>
	                                    <c:if test="${visit.visittype == 'NEWVISIT'}">
	                                        New Visit
	                                    </c:if>
	                                    <c:if test="${visit.visittype == 'REVISIT'}">
	                                        Re-visit
	                                    </c:if>
	                                </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:otherwise>
</c:choose>
<div class="modal fade" id="patient-details-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 170%;">
            <div class="modal-header">
                <h3 class="modal-title" id="modalTitle" style="color: purple;">Patient Visits</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true" style="color: purple; font-size: 1.25em; font-weight: bold;">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="tile-body" id="content-placeholder">

                </div>
            </div>
        </div>
    </div>
</div>
<!---->
<script>
    $(document).ready(function () {
        $('#tableRegisteredPatients').DataTable();
    });    
    $('#tableRegisteredPatients').on('click', 'a.fetch-patient-visit-details', function(e){
        e.preventDefault();
        e.stopPropagation();          
        var patientid = $(this).parent('td').children('input[name=_patientid]').val();            
        var date = $('input[name=_reportDate]').val();
        fetchFacilityPatientVisitDetails(patientid, date);
    });
    function fetchFacilityPatientVisitDetails(patientid, date){
        console.log(patientid);
        console.log(date);
        ajaxSubmitData('patient/facilitypatientvisitdetails.htm', 'content-placeholder', 'patientid='+ patientid +'&date=' + date + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');        
        $('#patient-details-modal').modal('show');
    }
</script>

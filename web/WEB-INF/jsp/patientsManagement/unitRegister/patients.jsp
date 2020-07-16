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
<c:if test="${not empty visits}">
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-content">
                            <div style="padding: 4px !important;  font-weight: bolder;" class="card-body">
                                <div class="row">
                                    <div class="col-md-4 border-right-blue-grey border-right-lighten-4">
                                        <div class="float-left pl-2">
                                            <span class="font-large-3 text-bold-300">${revisits + newvisits}</span>
                                        </div>
                                        <div style="font-weight: bold; font-size: 100%; padding-top: 6% !important; padding-left: 2% !important;" class="float-left mt-2 ml-1">
                                            <span class="blue-grey darken-1 block">
                                                <c:if test="${revisits + newvisits < 1}">
                                                    Visits
                                                </c:if>
                                                <c:if test="${revisits + newvisits == 1}">
                                                    Visit
                                                </c:if>
                                                <c:if test="${revisits + newvisits > 1}">
                                                    Total Visits
                                                </c:if>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-4 border-right-blue-grey border-right-lighten-4">
                                        <div class="float-left pl-2">
                                            <span class="font-large-3 text-bold-300">${newvisits}</span>
                                        </div>
                                        <div style="font-weight: bold; font-size: 100%; padding-top: 6% !important; padding-left: 2% !important;" class="float-left mt-2 ml-1">
                                            <span class="blue-grey darken-1 block">
                                                <c:if test="${newvisits < 1}">
                                                    New Visits
                                                </c:if>
                                                <c:if test="${newvisits == 1}">
                                                    New Visit
                                                </c:if>
                                                <c:if test="${newvisits > 1}">
                                                    New Visits
                                                </c:if>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="float-left pl-2">
                                            <span class="font-large-3 text-bold-300">${revisits}</span>
                                        </div>
                                        <div style="font-weight: bold; font-size: 100%; padding-top: 6% !important; padding-left: 2% !important;" class="float-left mt-2 ml-1">
                                            <span class="blue-grey darken-1 block">
                                                <c:if test="${revisits < 1}">
                                                    Re-Visits
                                                </c:if>
                                                <c:if test="${revisits == 1}">
                                                    Re-Visit
                                                </c:if>
                                                <c:if test="${revisits > 1}">
                                                    Re-Visits
                                                </c:if>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-1"></div>
    </div>
    <div class="row">
        <div class="col-sm-12 col-md-12">
            <input type="hidden" name="_reportDate" value="${date}" id="_reportDate" />
            <table class="table table-hover table-bordered table-striped" id="patients">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Names</th>
                        <!--<th>Visit No.</th>-->
                        <th>Gender</th>
                        <th>Age</th>
                        <th>Parish</th>
                        <th>Village</th>
                    </tr>
                </thead>
                <tbody id="bodyItems">
                    <% int k = 1;%>
                    <c:forEach items="${visits}" var="visit">
                        <tr>
                            <td><%=k++%></td>
                            <td>
                                <a href="#" class="fetch-patient-visit-details" 
                                   style="color: #007bff;">${visit.names}</a>                                
                                <input type="hidden" name="_patientid" value="${visit.patientid}" id="_patientid" />
                            </td>
                            <!--<td>${visit.visitno}</td>-->
                            <td>${visit.gender}</td>
                            <td class="center">
                                <c:if test="${visit.age < 1}">
                                    -
                                </c:if>
                                <c:if test="${visit.age > 0}">
                                    <c:if test="${visit.age < 365}">
                                        <c:if test="${visit.age < 30}">
                                            <c:if test="${visit.age < 1}">
                                                -
                                            </c:if>
                                            <c:if test="${visit.age == 1}">
                                                ${visit.age} Day
                                            </c:if>
                                            <c:if test="${visit.age > 1}">
                                                ${visit.age} Days
                                            </c:if>
                                        </c:if>
                                        <c:if test="${visit.age == 30}">
                                            <fmt:parseNumber var="months" integerOnly="true" type="number" value="${visit.age/30}"/>
                                            ${months} Month.
                                        </c:if>
                                        <c:if test="${visit.age > 30}">
                                            <fmt:parseNumber var="months" integerOnly="true" type="number" value="${visit.age/30}"/>
                                            ${months} Months
                                        </c:if>
                                    </c:if>
                                    <c:if test="${visit.age == 365}">
                                        <fmt:parseNumber var="years" integerOnly="true" type="number" value="${visit.age/365}"/>
                                        ${years} Year.
                                    </c:if>
                                    <c:if test="${visit.age >= 365}">
                                        <fmt:parseNumber var="years" integerOnly="true" type="number" value="${visit.age/365}"/>
                                        ${years} Years
                                    </c:if>
                                </c:if>
                            </td>
                            <td>${visit.parish}</td>
                            <td>
                                ${visit.village}
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 right">
            <button class="btn btn-primary btn-sm" onclick="printUnitRegister()" type="button">
                <i class="fa fa-lg fa-fw fa-print"></i>&nbsp;Print Register
            </button>
        </div>
    </div>
    <br />

</c:if>
<c:if test="${empty visits}">
    <div class="row">
        <div class="col-md-12 center">
            <h3>No Patients were Registered on ${date}.</h3>
        </div>
    </div>
</c:if>
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
        $('#patients').DataTable();
    });
    $('#patients').on('click', 'a.fetch-patient-visit-details', function(e){
        e.preventDefault();
        e.stopPropagation();          
        var patientid = $(this).parent('td').children('input[name=_patientid]').val();            
        var date = $('input[name=_reportDate]').val();
        fetchUnitPatientVisitDetails(patientid, date);
    }); 
    function fetchUnitPatientVisitDetails(patientid, date){
        console.log(patientid);
        console.log(date);
        ajaxSubmitData('patient/unitpatientvisitdetails.htm', 'content-placeholder', 'patientid='+ patientid +'&date=' + date + '&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');        
        $('#patient-details-modal').modal('show');
    }
</script>
<%-- 
    Document   : Register
    Created on : Nov 13, 2018, 11:06:39 AM
    Author     : IICS
--%>
<%@include file="../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<fieldset>
    <div class="row">
        <div class="col-sm-12 col-md-12">
            <table class="table table-hover table-bordered table-striped" id="clinicianspatients">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Names</th>
                        <th>Visit No.</th>
                        <th>Gender</th>
                        <th>Age</th>
                        <th>Village</th>
                        <th>Vitals</th>
                        <th>Notes</th>
                        <th>Lab</th>
                        <th>Referral</th>
                        <th>Prescription</th>
                        <th>Serviced By</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody id="bodyItems">
                    <% int k = 1;%>
                    <c:forEach items="${patientsFound}" var="visit">
                        <tr>
                            <td><%=k++%></td>
                            <td>${visit.fullname}</td>
                            <td>${visit.visitnumber}</td>
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
                            <td>
                                ${visit.villagename}
                            </td>
                            <td align="center">
                                <c:if test="${visit.vitals==0}"><img src="static/images/noaccesssmall.png"></c:if><c:if test="${visit.vitals>0}"><img src="static/images/authorisedsmall.png"></c:if>  
                                </td>
                                <td align="center">
                                <c:if test="${visit.clinicalnotes==0}"><img src="static/images/noaccesssmall.png"></c:if><c:if test="${visit.clinicalnotes>0}"><img src="static/images/authorisedsmall.png"></c:if>  
                                </td>
                                <td align="center">
                                <c:if test="${visit.labrequests==0}"><img src="static/images/noaccesssmall.png"></c:if><c:if test="${visit.labrequests>0}"><img src="static/images/authorisedsmall.png"></c:if>  
                                </td>
                                <td align="center">
                                <c:if test="${visit.internalreferral==0}"><img src="static/images/noaccesssmall.png"></c:if><c:if test="${visit.internalreferral>0}"><img src="static/images/authorisedsmall.png"></c:if>  
                                </td>
                                <td align="center">
                                <c:if test="${visit.prescriptions==0}"><img src="static/images/noaccesssmall.png"></c:if><c:if test="${visit.prescriptions>0}"><img src="static/images/authorisedsmall.png"></c:if>  
                                </td>
                                <td>
                                ${visit.servicedby}
                            </td>
                            <td align="center">
                                <button onclick="viewpatientvisitdetails(${visit.patientvisitid}, '${visit.visitnumber}',${visit.patientid},${visit.vitals},${visit.clinicalnotes},${visit.labrequests},${visit.internalreferral},${visit.prescriptions});"  title="Details of this Patient" class="btn btn-primary btn-sm add-to-shelf">
                                    <i class="fa fa-dedent"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>  
</fieldset>
<script>
    $('#clinicianspatients').DataTable();
    function viewpatientvisitdetails(patientvisitid, visitnumber, patientid, vitals, clinicalnotes, labrequests, internalreferral, prescriptions) {
        if (vitals === 0 && clinicalnotes === 0 && labrequests === 0 && internalreferral === 0 && prescriptions === 0) {
            $.confirm({
                title: 'Patient',
                content: 'Nothing To Show On This Patient!',
                type: 'purple',
                typeAnimated: true,
                buttons: {
                    close: function () {
                        
                    }
                }
            });
            return false;
        }
        window.location = '#servicedpatients';
        ajaxSubmitData('doctorconsultation/patientvisitdetails.htm', 'servicedprescribediv', 'patientvisitid=' + patientvisitid + '&visitnumber=' + visitnumber + '&patientid=' + patientid + '&d=0&ofst=1&maxR=100&sStr=', 'GET');
        initDialog('servicedprescribedpatient');
    }
</script>
<%-- 
    Document   : todayPatients
    Created on : Oct 6, 2018, 11:08:00 PM
    Author     : HP
--%>
<%@include file="../../../include.jsp" %>
<c:if test="${not empty labpatientsFound}">
    <div class="row">
        <div class="col-sm-12 col-md-12">
            <table class="table table-hover table-bordered table-striped" id="labpatients">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Names</th>
                        <th>Visit No.</th>
                        <th>Gender</th>
                        <th>Age</th>
                        <th>Parish</th>
                        <th>Village</th>
                    </tr>
                </thead>
                <tbody id="bodyItems">
                    <% int k = 1;%>
                    <c:forEach items="${labpatientsFound}" var="visit">
                        <tr>
                            <td><%=k++%></td>
                            <td>${visit.names}</td>
                            <td>${visit.visitno}</td>
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
            <button class="btn btn-primary btn-sm" onclick="printUnitLabRegister()" type="button">
                <i class="fa fa-lg fa-fw fa-print"></i>&nbsp;Print Register
            </button>
        </div>
    </div>

</c:if>
<c:if test="${empty labpatientsFound}">
    <div class="row">
        <div class="col-md-12 center">
            <h3>No Patients were Received on ${date}.</h3>
        </div>
    </div>
</c:if>
<script>
    $(document).ready(function () {
        $('#labpatients').DataTable();
    });
</script>

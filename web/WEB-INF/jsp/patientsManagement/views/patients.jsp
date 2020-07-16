<%-- 
    Document   : patients
    Created on : Apr 10, 2018, 6:25:26 PM
    Author     : Grace-K
--%>
<%@include file="../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="row" id="patientmanagement">
    <div class="col-md-12">
        <p class="pull-right">
            <a class="btn btn-primary icon-btn" href="">
                <i class="fa fa-plus"></i>
                Register New Patient
            </a>
        </p>
    </div>
</div>
<fieldset>
    <table class="table table-hover table-bordered" id="patientsTable">
        <thead>
            <tr>
                <th>No</th>
                <th>Name</th>
                <th class="center">Update</th>
            </tr>
        </thead>
        <tbody id="">
            <% int n = 1;%>
            <c:forEach items="${patientList}" var="a">
                <tr>
                    <td><%=n++%></td>
                    <td>${a.personname}</td>
                    <td class="center">
                        <a href="#"<i class="fa fa-fw fa-lg fa-edit"></i></a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</fieldset>

<script>
    $(document).ready(function () {
        breadCrumb();
        $('#patientsTable').DataTable();
    });
</script>
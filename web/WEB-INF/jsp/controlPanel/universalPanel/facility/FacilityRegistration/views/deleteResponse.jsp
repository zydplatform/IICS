<%-- 
    Document   : deleteResponse
    Created on : Nov 29, 2017, 9:07:18 AM
    Author     : samuelWam
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="panel-body">
    <table class="table table-striped table-bordered table-hover table-full-width" id="delOrg_1">
        <thead>
            <tr>
                <th>No</th>
                <th class="hidden-xs">Facility Name</th>
                <th class="hidden-xs">Code</th>
                <th>Attachments</th> 
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${model.customList}" var="list" varStatus="status" begin="0" end="${model.size}">
                <c:choose>
                    <c:when test="${status.count % 2 != 0}">
                        <tr>
                        </c:when>
                        <c:otherwise>
                        <tr bgcolor="white">
                        </c:otherwise>
                    </c:choose>
                    <td>${status.count}</td>
                    <td align="center">${list.facilityname}</td>
                    <td align="center">${list.facilitycode}</td>
                    <td align="center">${list.description}</td>                                            
                    <td align="center"><c:if test="${list.active==true}">Deleted</c:if><c:if test="${list.active==false}">Failed!</c:if></td>
                    </tr>
            </c:forEach>
        </tbody>
    </table>
</div>